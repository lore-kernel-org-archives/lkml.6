Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FA620700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQSTOIEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfBVTfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:35:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46334 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVTfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:35:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so1528179pfh.13;
        Fri, 22 Feb 2019 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FgOYxchHGlJHFmyyLBfbI94R8PKLM3DDEZqKom9TK2g=;
        b=LQSTOIEVpCycnBnVFTGzDZy2oq5Q4gymcQHesjT0EFkQM3UeGupDz+JVmdqT7tGgvD
         Mz9sPmEkQndNpPNgKGs4HE9a/qxYQeGT5VD3wcwlLJlch446BahDBzc/RIB6ay3DrUFn
         5+wcH7cN3aOQMq/eNDhtkbvTzJbjw6dd0qjmzdyLeAJ58FsGos+mtvm0ZY9nme8sgh0v
         cerjrC4ApQ2b7mRV5CgECDhpcMvfqRS5RWbN2j5vXfilPaKRygoA+cL4I5bV5k5K6pKS
         +tJjt2ks8e61tyD8crrGW2JJZfvk2UTOstaWQMosa04cnKpC1oM01Aa0PP4+DuqSYuoC
         vxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FgOYxchHGlJHFmyyLBfbI94R8PKLM3DDEZqKom9TK2g=;
        b=S/9QDX+tN2qvCtiJ5pMM5itU0thj6cy1dde4Pa/TbIHPlBitPoZM1xfGWm04s9qYh6
         U0mbPdGeUOi7JhsBfDOBVTFn8rSx6tblRYmmov+jAcAS7X0FwVduQrzWpl/LBfP1AQn9
         RBMdui89CHf1gklQhIgIoBhrHm8GFg2TrKVHq/aEXqLqEcqxMLpNTp1eBnb+Iw4VrhxR
         MTIcIN1J5JryFc06IY5wlaUyHdikmdpUoHM2N1hV28yki05QjnnkrGgcya2Xlw2hh/F8
         at8GdxFXuwbswyZ9L2EYqzjgKdQGuF0VgtadfLce7z14OGdRpPtvskuFXFQAPlPPw1xe
         jBDA==
X-Gm-Message-State: AHQUAuZ/C5FVHKwLYQGGNAzYKeXwC3szOWP7oMUwGne0g115MCBZ5ERd
        52qYGcpyVkW28QQhVW+n6Ps=
X-Google-Smtp-Source: AHgI3IaU16gryTzWR/vuqPmm1olJoyDg7cwK95e9EBb2/r0KeYwOWl7k+Zuq+vGzaCOssSDLbmffoQ==
X-Received: by 2002:a63:104e:: with SMTP id 14mr1590390pgq.185.1550864142612;
        Fri, 22 Feb 2019 11:35:42 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:35:41 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/7] ARM: trusted_foundations: Make prepare_idle call to take mode argument
Date:   Fri, 22 Feb 2019 22:34:21 +0300
Message-Id: <20190222193426.10747-3-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Trusted Foundations firmware call varies depending on the required
suspend-mode. Make the firmware API to take the mode argument in order
to expose all of the modes to firmware user.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c    | 29 ++++++++++++++++++++--
 arch/arm/include/asm/firmware.h            |  2 +-
 arch/arm/include/asm/trusted_foundations.h |  6 +++++
 arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 ++-
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 3bf61a5933b9..c496f4cc49cb 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -67,9 +67,34 @@ static int tf_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	return 0;
 }
 
-static int tf_prepare_idle(void)
+static int tf_prepare_idle(unsigned long mode)
 {
-	tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S1_NOFLUSH_L2, cpu_boot_addr);
+	switch (mode) {
+	case TF_PM_MODE_LP0:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S3, cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP1:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S2, cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP1_NO_MC_CLK:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S2_NO_MC_CLK,
+			       cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP2:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S1, cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP2_NOFLUSH_L2:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S1_NOFLUSH_L2,
+			       cpu_boot_addr);
+		break;
+
+	default:
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
index 34c1d96ef46d..6698272bbcbf 100644
--- a/arch/arm/include/asm/firmware.h
+++ b/arch/arm/include/asm/firmware.h
@@ -24,7 +24,7 @@ struct firmware_ops {
 	/*
 	 * Inform the firmware we intend to enter CPU idle mode
 	 */
-	int (*prepare_idle)(void);
+	int (*prepare_idle)(unsigned long mode);
 	/*
 	 * Enters CPU idle mode
 	 */
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index 00748350cf72..cdd48ab7d191 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -32,6 +32,12 @@
 #include <linux/cpu.h>
 #include <linux/smp.h>
 
+#define TF_PM_MODE_LP0			0
+#define TF_PM_MODE_LP1			1
+#define TF_PM_MODE_LP1_NO_MC_CLK	2
+#define TF_PM_MODE_LP2			3
+#define TF_PM_MODE_LP2_NOFLUSH_L2	4
+
 struct trusted_foundations_platform_data {
 	unsigned int version_major;
 	unsigned int version_minor;
diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index e3fbcfedf845..3b9af4766cdf 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -24,6 +24,7 @@
 #include <asm/cpuidle.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
+#include <asm/trusted_foundations.h>
 #include <asm/psci.h>
 
 #include "cpuidle.h"
@@ -46,7 +47,7 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
 	tegra_set_cpu_in_lp2();
 	cpu_pm_enter();
 
-	call_firmware_op(prepare_idle);
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
 
 	/* Do suspend by ourselves if the firmware does not implement it */
 	if (call_firmware_op(do_idle, 0) == -ENOSYS)
-- 
2.20.1

