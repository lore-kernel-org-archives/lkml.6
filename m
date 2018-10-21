Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CECCECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A56205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx6GKzAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A56205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJVC7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:59:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35604 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeJVC7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:59:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so6787562pgu.2;
        Sun, 21 Oct 2018 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aBB85u5iUC5sECQ+ikjOvp2WMdGw+TjqTuRNqBclXE=;
        b=Cx6GKzAPimCP1TPzN2JGCBgP0hZP8MxV0+reEyN92+P1t1oUNBwSeY6ezEg+z3nw6L
         IpwdpJnGTKjSEOotQAe36r0/jqw2mpNHeAIV0uPvsqvt3DDSQ/E9E5K+WGkVMS9+lH6M
         Ay0glgzErw2yvYtJyUpim8hCAam9nyTy1ui6EyvicYpxUDpG2UpQG4n4S0foks5+ECJE
         M1fnSy65g9WdPS8QsteUFz24JzY6GCoGZqtgnrPBDQJXUI7gO/rnXfc6nW+6tvZobYDj
         yE8EBlmJkFq/hA70wunD//hudKrpaRHsxVdsI9DL/KGHDxYSL/1fRTZ/iIrEGPs1KED0
         Ig9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aBB85u5iUC5sECQ+ikjOvp2WMdGw+TjqTuRNqBclXE=;
        b=Nb1AGjEDyL2cK7SSY03AULFRhD1bN/mRrNK98a4P7wbWVRwq8sLgpaZlR//HLGN6fv
         wE7xf2utgMQfGEyj+Xc88Oam5Ubu5xt6uu7LhRb7+pE63P5T6CfITlTseZ4KLM2C6ETH
         uhQD2Y+OdJuFoRWcuEDk7EFMdq9WOUa5yaQ2yTgfbLzSWZNBppD98UbBOnXwTuLax9/9
         AMJgeMWM3y8u+gwL5KVng5ILPloHwioFmc4MQV6SP2ucXeMggpt0rh/SN0DaOCFpBj92
         rkuDXaz45AKVNvPZZN03urQE29L0dm+H/WA/ck7zuhswuYKvX6i5Hc/5nb1EB3oc5GX8
         4ZcQ==
X-Gm-Message-State: ABuFfojU3SAL3Rl9ahuTktexaqgcxBTpgGUQhfophDbrgC9iJzPnB/c2
        9zSjLq3Bg3Pc88XN2/qC28M=
X-Google-Smtp-Source: ACcGV61r0x2gX77P3f6Ek46lboNp7ZWFxlYLiFmAMNUIjxuWKW9Ds0usbUCO0kRFnKtoJi7Aznh0XQ==
X-Received: by 2002:a63:d00b:: with SMTP id z11-v6mr40834293pgf.317.1540147036887;
        Sun, 21 Oct 2018 11:37:16 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.118])
        by smtp.gmail.com with ESMTPSA id g88-v6sm41737275pfd.181.2018.10.21.11.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 11:37:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] soc/tegra: pmc: Drop locking from tegra_powergate_is_powered()
Date:   Sun, 21 Oct 2018 21:36:14 +0300
Message-Id: <20181021183614.454-1-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes splats like the one below if CONFIG_DEBUG_ATOMIC_SLEEP=y
and machine (Tegra30) booted with SMP=n or all secondary CPU's are put
offline. Locking isn't needed because it protects atomic operation.

# echo 0 | tee /sys/devices/system/cpu/cpu[1-3]/online

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
 drivers/soc/tegra/pmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 1fa840e3d930..1714cd818d69 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -543,9 +543,7 @@ int tegra_powergate_is_powered(unsigned int id)
 	if (!tegra_powergate_is_valid(id))
 		return -EINVAL;
 
-	mutex_lock(&pmc->powergates_lock);
 	status = tegra_powergate_state(id);
-	mutex_unlock(&pmc->powergates_lock);
 
 	return status;
 }
-- 
2.19.0

