Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF27C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C156A20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmDww0mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C156A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeH3Wk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:40:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38663 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbeH3Wk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:40:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id i7-v6so8002561lfh.5;
        Thu, 30 Aug 2018 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lgqnBz8Sd4utRBwj3GQtVoWXeG2CSLAzFsG9ONPpTzg=;
        b=XmDww0mk/ulcnQdeo8sHvGKJM6oF1oBEREKMsxD/esZ6QaQvtwz9jic4EkFScgJxiy
         UJc2/hyQVD3zO2n7mVooATLxT7O17EANJyXZpNs8xHyJlQaum379Aq3uPlO8j4r52EKi
         O5WGYC6S7foGxH2ptSA8rNhcLr5SSb0JzaV9vwSuTTzot/7MtRV8Xh6BGHmv+2zDEesb
         fpVkwLygy+D8OPSKYhARX6UZhrpgvRmd5OPqvUBr71ZOADEhxwpl9Nf4Q38ji4yE1web
         PEmIwq69Ddp9RNXv8P08V+cLDcoohNLkURc2EuIxQ4XRGg/Y1sfOiC8e7u9EYQi992IF
         DtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lgqnBz8Sd4utRBwj3GQtVoWXeG2CSLAzFsG9ONPpTzg=;
        b=jfqNr0UoyiL19HVJgbWoYCQVn4t2Q0coGlWrWo9aFOEXBqywzojsKKO+Hdl9otUylN
         0LCE5zYxa2hK03WK4Ue/rKudRzPtfEgMdoDPJGplcCAXqOMaxPxKuLO3mQ+tb/cH9z+J
         IsNi/ilMGzGPZum/hygVGssX8TaC7F8rEvFYh2jXrKh3dXQT94fQWfBk6uKA6H+AeWtD
         e564WswyinXjqLqdF2PAI10jjNHPzKbi9/bCPulhv7AEV3pswZBvr5O4zo0GUy9tGqmX
         VFvsqmT/i0SvXyPcjBmBL89ON24rfLDEAkZRMsXQiLcXGtEtqDR9OVWNKfxf7mIMBfV1
         /cEg==
X-Gm-Message-State: APzg51BG6PW4SmZf67Clo3vKVu3E6lEkfjrlceTcOU8MKL3cmNiz/TlO
        29Z5+arJL3FV2pHMadw9hao=
X-Google-Smtp-Source: ANB0VdZKY2zyLG1WN30L71sborKcV90RBR5tK9nbboJhPSPOBQfAWSZTFmfkmYkAjTVYgzOS+Jkmwg==
X-Received: by 2002:a19:cb93:: with SMTP id b141-v6mr7939497lfg.119.1535654216045;
        Thu, 30 Aug 2018 11:36:56 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id n26-v6sm1325727ljc.7.2018.08.30.11.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:36:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] soc/tegra: pmc: Turn powergates_lock into spinlock
Date:   Thu, 30 Aug 2018 21:36:34 +0300
Message-Id: <20180830183635.4474-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes splats like the one below if CONFIG_DEBUG_ATOMIC_SLEEP=y
and machine (Tegra30) booted with SMP=n or all secondary CPU's are put
offline.

 BUG: sleeping function called from invalid context at kernel/locking/mutex.c:254
 in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
 CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C        4.18.0-next-20180821-00180-gc3ebb6544e44-dirty #823
 Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
 [<c01134f4>] (unwind_backtrace) from [<c010db2c>] (show_stack+0x20/0x24)
 [<c010db2c>] (show_stack) from [<c0bd0f3c>] (dump_stack+0x94/0xa8)
 [<c0bd0f3c>] (dump_stack) from [<c0151df8>] (___might_sleep+0x13c/0x174)
 [<c0151df8>] (___might_sleep) from [<c0151ea0>] (__might_sleep+0x70/0xa8)
 [<c0151ea0>] (__might_sleep) from [<c0bec2b8>] (mutex_lock+0x2c/0x70)
 [<c0bec2b8>] (mutex_lock) from [<c0589844>] (tegra_powergate_is_powered+0x44/0xa8)
 [<c0589844>] (tegra_powergate_is_powered) from [<c0581a60>] (tegra30_cpu_rail_off_ready+0x30/0x74)
 [<c0581a60>] (tegra30_cpu_rail_off_ready) from [<c0122244>] (tegra30_idle_lp2+0xa0/0x108)
 [<c0122244>] (tegra30_idle_lp2) from [<c0853438>] (cpuidle_enter_state+0x140/0x540)
 [<c0853438>] (cpuidle_enter_state) from [<c08538a4>] (cpuidle_enter+0x40/0x4c)
 [<c08538a4>] (cpuidle_enter) from [<c01595e0>] (call_cpuidle+0x30/0x48)
 [<c01595e0>] (call_cpuidle) from [<c01599f8>] (do_idle+0x238/0x28c)
 [<c01599f8>] (do_idle) from [<c0159d28>] (cpu_startup_entry+0x28/0x2c)
 [<c0159d28>] (cpu_startup_entry) from [<c0be76c8>] (rest_init+0xd8/0xdc)
 [<c0be76c8>] (rest_init) from [<c1200f50>] (start_kernel+0x41c/0x430)

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 2d6f3fcf3211..d6bc9f66f1cd 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -186,7 +186,7 @@ struct tegra_pmc_soc {
  * @lp0_vec_phys: physical base address of the LP0 warm boot code
  * @lp0_vec_size: size of the LP0 warm boot code
  * @powergates_available: Bitmap of available power gates
- * @powergates_lock: mutex for power gate register access
+ * @powergates_lock: lock for power gate register access
  */
 struct tegra_pmc {
 	struct device *dev;
@@ -215,7 +215,7 @@ struct tegra_pmc {
 	u32 lp0_vec_size;
 	DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
 
-	struct mutex powergates_lock;
+	spinlock_t powergates_lock;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -288,10 +288,10 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
 	if (id == TEGRA_POWERGATE_3D && pmc->soc->has_gpu_clamps)
 		return -EINVAL;
 
-	mutex_lock(&pmc->powergates_lock);
+	spin_lock(&pmc->powergates_lock);
 
 	if (tegra_powergate_state(id) == new_state) {
-		mutex_unlock(&pmc->powergates_lock);
+		spin_unlock(&pmc->powergates_lock);
 		return 0;
 	}
 
@@ -300,7 +300,7 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
 	err = readx_poll_timeout(tegra_powergate_state, id, status,
 				 status == new_state, 10, 100000);
 
-	mutex_unlock(&pmc->powergates_lock);
+	spin_unlock(&pmc->powergates_lock);
 
 	return err;
 }
@@ -309,7 +309,7 @@ static int __tegra_powergate_remove_clamping(unsigned int id)
 {
 	u32 mask;
 
-	mutex_lock(&pmc->powergates_lock);
+	spin_lock(&pmc->powergates_lock);
 
 	/*
 	 * On Tegra124 and later, the clamps for the GPU are controlled by a
@@ -336,7 +336,7 @@ static int __tegra_powergate_remove_clamping(unsigned int id)
 	tegra_pmc_writel(mask, REMOVE_CLAMPING);
 
 out:
-	mutex_unlock(&pmc->powergates_lock);
+	spin_unlock(&pmc->powergates_lock);
 
 	return 0;
 }
@@ -529,9 +529,9 @@ int tegra_powergate_is_powered(unsigned int id)
 	if (!tegra_powergate_is_valid(id))
 		return -EINVAL;
 
-	mutex_lock(&pmc->powergates_lock);
+	spin_lock(&pmc->powergates_lock);
 	status = tegra_powergate_state(id);
-	mutex_unlock(&pmc->powergates_lock);
+	spin_unlock(&pmc->powergates_lock);
 
 	return status;
 }
@@ -998,7 +998,7 @@ int tegra_io_pad_power_enable(enum tegra_io_pad id)
 	u32 mask;
 	int err;
 
-	mutex_lock(&pmc->powergates_lock);
+	spin_lock(&pmc->powergates_lock);
 
 	err = tegra_io_pad_prepare(id, &request, &status, &mask);
 	if (err < 0) {
@@ -1017,7 +1017,7 @@ int tegra_io_pad_power_enable(enum tegra_io_pad id)
 	tegra_io_pad_unprepare();
 
 unlock:
-	mutex_unlock(&pmc->powergates_lock);
+	spin_unlock(&pmc->powergates_lock);
 	return err;
 }
 EXPORT_SYMBOL(tegra_io_pad_power_enable);
@@ -1034,7 +1034,7 @@ int tegra_io_pad_power_disable(enum tegra_io_pad id)
 	u32 mask;
 	int err;
 
-	mutex_lock(&pmc->powergates_lock);
+	spin_lock(&pmc->powergates_lock);
 
 	err = tegra_io_pad_prepare(id, &request, &status, &mask);
 	if (err < 0) {
@@ -1053,7 +1053,7 @@ int tegra_io_pad_power_disable(enum tegra_io_pad id)
 	tegra_io_pad_unprepare();
 
 unlock:
-	mutex_unlock(&pmc->powergates_lock);
+	spin_unlock(&pmc->powergates_lock);
 	return err;
 }
 EXPORT_SYMBOL(tegra_io_pad_power_disable);
@@ -1071,7 +1071,7 @@ int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 	if (pad->voltage == UINT_MAX)
 		return -ENOTSUPP;
 
-	mutex_lock(&pmc->powergates_lock);
+	spin_lock(&pmc->powergates_lock);
 
 	/* write-enable PMC_PWR_DET_VALUE[pad->voltage] */
 	value = tegra_pmc_readl(PMC_PWR_DET);
@@ -1088,7 +1088,7 @@ int tegra_io_pad_set_voltage(enum tegra_io_pad id,
 
 	tegra_pmc_writel(value, PMC_PWR_DET_VALUE);
 
-	mutex_unlock(&pmc->powergates_lock);
+	spin_unlock(&pmc->powergates_lock);
 
 	usleep_range(100, 250);
 
@@ -1436,10 +1436,10 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	mutex_lock(&pmc->powergates_lock);
+	spin_lock(&pmc->powergates_lock);
 	iounmap(pmc->base);
 	pmc->base = base;
-	mutex_unlock(&pmc->powergates_lock);
+	spin_unlock(&pmc->powergates_lock);
 
 	return 0;
 }
@@ -1919,7 +1919,7 @@ static int __init tegra_pmc_early_init(void)
 	struct resource regs;
 	bool invert;
 
-	mutex_init(&pmc->powergates_lock);
+	spin_lock_init(&pmc->powergates_lock);
 
 	np = of_find_matching_node_and_match(NULL, tegra_pmc_match, &match);
 	if (!np) {
-- 
2.18.0

