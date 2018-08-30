Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C844C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC05020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHqW8Kwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC05020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeH3Wk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:40:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44163 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbeH3Wk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:40:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so8074676ljq.11;
        Thu, 30 Aug 2018 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3PQDP3sj+EsCa4vHjzGBzaaDd7aJ91D6cDDaj1ZbtFg=;
        b=hHqW8KwgyKu7D/hWU3wp7T5fJBGClLzE2sgt50+drDx2ZriTs97Fskp0+4bmOmf/Gh
         /z7uUXIclKAZQ819B6R4CUqe19Hef1/jn/TadfYQ8gi7gkWyHCVXZqH9izVDA4XPwSuG
         S6MAQmLRZuy6V/JJXp7aLM4RX96vEK2SOjZuhLChAnu9TvVGupxh6uLWmhe4kdgDZMlU
         9uE1vl3ZLhZBRW+TU81WTHglcqI/U0FnOOnnax2gvAtDfQyYUEwWI8EwHpWObkxcEl+S
         5lXqDMY/bE+eLeOTm5cQn4B4bjdf99wSXSjAOVeQ7v//wSyB07/dTlF7KrketPhpwMfE
         6YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3PQDP3sj+EsCa4vHjzGBzaaDd7aJ91D6cDDaj1ZbtFg=;
        b=e72hTXcQNTf0d6SuzrYENMy2ZPvtB/q2XYxNM37T0HDHczulmAU36vDjUeTK4m7iqj
         acDBPgeHyVsCYUnPs4oXLlLi1V7XTMM1+x1uCq4XUSReqyut/b/JFxkcv7+rnsfGqgT5
         KmmrwREM778xVaY36axyeqsZb+ixpAc18fa5ZMm+mnTAGm0aTq9muNS7J1A82L1t8gnR
         QF68EMNP4SZt9YU0Cirej86cM8FTFcuI5WlHaRFvVEOC1bXMw29ZF65jd7rbJW9fSJVB
         +kPB8HMdmGjfGdzilD92+qapV8H/JIa9v6Vyewl/NguC0UlJ5zvR8Adxod8uNMyi21XD
         5ydA==
X-Gm-Message-State: APzg51DUlgpb4VmJAGw7+Zrs2gDcNlWpTXeHyiEkeMTowrHugqSfeRK4
        jQI/LfNPERHNeEiY13M1NV8=
X-Google-Smtp-Source: ANB0VdbyT9i4Hc/eI56r/aNpJ6SaJo1vlUryubpUgzC5Xktry/mpeQ925lkIoJBZ884+LXDmZejyNw==
X-Received: by 2002:a2e:5d9d:: with SMTP id v29-v6mr7861592lje.137.1535654217047;
        Thu, 30 Aug 2018 11:36:57 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id n26-v6sm1325727ljc.7.2018.08.30.11.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:36:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] soc/tegra: pmc: Make readx_poll_timeout atomic
Date:   Thu, 30 Aug 2018 21:36:35 +0300
Message-Id: <20180830183635.4474-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830183635.4474-1-digetx@gmail.com>
References: <20180830183635.4474-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes splat like the one below if CONFIG_DEBUG_ATOMIC_SLEEP=y on
Tegra30.

 BUG: sleeping function called from invalid context at drivers/soc/tegra/pmc.c:301
 in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-next-20180821-00176-g7a0f73ae4245 #824
 Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
 [<c01134f4>] (unwind_backtrace) from [<c010db2c>] (show_stack+0x20/0x24)
 [<c010db2c>] (show_stack) from [<c0bd0f3c>] (dump_stack+0x94/0xa8)
 [<c0bd0f3c>] (dump_stack) from [<c0151df8>] (___might_sleep+0x13c/0x174)
 [<c0151df8>] (___might_sleep) from [<c0151ea0>] (__might_sleep+0x70/0xa8)
 [<c0151ea0>] (__might_sleep) from [<c0588264>] (tegra_powergate_set+0xb0/0x1e8)
 [<c0588264>] (tegra_powergate_set) from [<c05899f4>] (tegra_pmc_cpu_power_on+0x44/0x50)
 [<c05899f4>] (tegra_pmc_cpu_power_on) from [<c0122554>] (tegra_boot_secondary+0x20c/0x288)
 [<c0122554>] (tegra_boot_secondary) from [<c011051c>] (__cpu_up+0xb8/0x14c)
 [<c011051c>] (__cpu_up) from [<c01282a0>] (bringup_cpu+0x30/0xfc)
 [<c01282a0>] (bringup_cpu) from [<c01276bc>] (cpuhp_invoke_callback+0xd0/0x98c)
 [<c01276bc>] (cpuhp_invoke_callback) from [<c0128b3c>] (_cpu_up+0xe0/0x1c0)
 [<c0128b3c>] (_cpu_up) from [<c0128e04>] (do_cpu_up+0x70/0xa4)
 [<c0128e04>] (do_cpu_up) from [<c0128e54>] (cpu_up+0x1c/0x20)
 [<c0128e54>] (cpu_up) from [<c12112e0>] (smp_init+0xb0/0x100)
 [<c12112e0>] (smp_init) from [<c12010d0>] (kernel_init_freeable+0x16c/0x398)
 [<c12010d0>] (kernel_init_freeable) from [<c0be76e4>] (kernel_init+0x18/0x124)
 [<c0be76e4>] (kernel_init) from [<c01010f0>] (ret_from_fork+0x14/0x24)

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index d6bc9f66f1cd..2d5d4b0c211a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -297,8 +297,8 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
 
 	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
 
-	err = readx_poll_timeout(tegra_powergate_state, id, status,
-				 status == new_state, 10, 100000);
+	err = readx_poll_timeout_atomic(tegra_powergate_state, id, status,
+					status == new_state, 10, 100000);
 
 	spin_unlock(&pmc->powergates_lock);
 
-- 
2.18.0

