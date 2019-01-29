Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C1BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B28720989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXp+fS9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfA2E4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:56:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55620 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfA2E4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:56:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so16184061wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=f9RRfEkXE77pz83n7acsj2941ekty87S490EyLGXvZg=;
        b=UXp+fS9TOO4n9krRgp8esKxH+Ul+PXMyCPbeH/VFxsOGrgY9RvxlmU9he+OUUZZjNC
         KtcRD8Ee18SdQq9s5SRS4emcgc+fRcHCi7kCcAVdIRSFPygfzLxmRU4+bYZFUOMq2Dxx
         AAtPcwwIg8g+Fk/yAQMQJnLDDSf/rceRRQ7PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f9RRfEkXE77pz83n7acsj2941ekty87S490EyLGXvZg=;
        b=pnlfy2Wn2VGAVBn/eDm4MFRUNvNS4JsQeuTa6FwYs9CiukZrejkY+C0iyLsToUPJMR
         UW9tva551Rq+/vEuuZDiJ0/yOfSx7mhmOLATISHJRSdQihmR5dWPCLkc+sF1f9do8HUW
         1mylnnqVVlTyPQefTx/dJ5QzUYltGU6x5bWSLfq3n1sntmanaPIKUWWfnLFcwuSaOWh1
         8nf44Z1GlrvrGWk51WIhaqzo56jxz0vCg55M4gZ9wSgFFpCHcJBsRdYGe4lwK0W5Y3Wp
         kWvRpJYh+/00mVaKzvTptPgwBK98d3mo8tRk1vd0pgo17vrB0uufaF5Y/PfpOCmSVdSH
         UtiA==
X-Gm-Message-State: AJcUukdpetruarqPxYWkL2pRPhffBisQQN+y/x9QHR2EW2OZWrG7rBpx
        3OBax8FGFx2CMiAo2L9PUWwmD4DCEbE=
X-Google-Smtp-Source: ALg8bN7IEPZantKVO8jCdaXIo5aqtdwMoXDpT21hNxD97hEq3HnweXrFKxwzfGU03+6MlLveFCGsQw==
X-Received: by 2002:a1c:8d12:: with SMTP id p18mr20946052wmd.31.1548737779758;
        Mon, 28 Jan 2019 20:56:19 -0800 (PST)
Received: from localhost ([49.248.171.30])
        by smtp.gmail.com with ESMTPSA id h184sm2351806wmf.0.2019.01.28.20.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:56:18 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Taniya Das <tdas@codeaurora.org>,
        Anson Huang <anson.huang@nxp.com>, linux-pm@vger.kernel.org
Subject: [PATCH v5 1/9] thermal: cpu_cooling: Require thermal core to be compiled in
Date:   Tue, 29 Jan 2019 10:25:07 +0530
Message-Id: <0d63ca44cff5f47ef0102b2c86b4fe9eca9b658b.1548737236.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU cooling driver (cpu_cooling.c) allows the platform's cpufreq
driver to register as a cooling device and cool down the platform by
throttling the CPU frequency. In order to be able to auto-register a
cpufreq driver as a cooling device from the cpufreq core, we need access
to code inside cpu_cooling.c which, in turn, accesses code inside
thermal core.

CPU_FREQ is a bool while THERMAL is tristate.  In some configurations
(e.g. allmodconfig), CONFIG_THERMAL ends up as a module while
CONFIG_CPU_FREQ is compiled in. This leads to following error:

drivers/cpufreq/cpufreq.o: In function `cpufreq_offline':
cpufreq.c:(.text+0x407c): undefined reference to `cpufreq_cooling_unregister'
drivers/cpufreq/cpufreq.o: In function `cpufreq_online':
cpufreq.c:(.text+0x70c0): undefined reference to `of_cpufreq_cooling_register'

Given that platforms using CPU_THERMAL usually want it compiled-in so it
is available early in boot, make CPU_THERMAL depend on THERMAL being
compiled-in instead of allowing it to be a module.

As a result of this change, get rid of the ugly (!CPU_THERMAL ||
THERMAL) dependency in all cpufreq drivers using CPU_THERMAL.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig     | 3 ---
 drivers/cpufreq/Kconfig.arm | 5 -----
 drivers/thermal/Kconfig     | 1 +
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 608af20a3494..b22e6bba71f1 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -207,8 +207,6 @@ comment "CPU frequency scaling drivers"
 config CPUFREQ_DT
 	tristate "Generic DT based cpufreq driver"
 	depends on HAVE_CLK && OF
-	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
-	depends on !CPU_THERMAL || THERMAL
 	select CPUFREQ_DT_PLATDEV
 	select PM_OPP
 	help
@@ -327,7 +325,6 @@ endif
 config QORIQ_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
 	depends on OF && COMMON_CLK && (PPC_E500MC || ARM || ARM64)
-	depends on !CPU_THERMAL || THERMAL
 	select CLK_QORIQ
 	help
 	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 688f10227793..ca8567c3152c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -29,8 +29,6 @@ config ARM_ARMADA_37XX_CPUFREQ
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
 	depends on ARM_CPU_TOPOLOGY && HAVE_CLK
-	# if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
-	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
@@ -38,7 +36,6 @@ config ARM_BIG_LITTLE_CPUFREQ
 config ARM_SCPI_CPUFREQ
 	tristate "SCPI based CPUfreq driver"
 	depends on ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
-	depends on !CPU_THERMAL || THERMAL
 	help
 	  This adds the CPUfreq driver support for ARM platforms using SCPI
 	  protocol for CPU power management.
@@ -93,7 +90,6 @@ config ARM_KIRKWOOD_CPUFREQ
 config ARM_MEDIATEK_CPUFREQ
 	tristate "CPU Frequency scaling support for MediaTek SoCs"
 	depends on ARCH_MEDIATEK && REGULATOR
-	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This adds the CPUFreq driver support for MediaTek SoCs.
@@ -233,7 +229,6 @@ config ARM_SA1110_CPUFREQ
 config ARM_SCMI_CPUFREQ
 	tristate "SCMI based CPUfreq driver"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
-	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This adds the CPUfreq driver support for ARM platforms using SCMI
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 30323426902e..58bb7d72dc2b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -152,6 +152,7 @@ config CPU_THERMAL
 	bool "generic cpu cooling support"
 	depends on CPU_FREQ
 	depends on THERMAL_OF
+	depends on THERMAL=y
 	help
 	  This implements the generic cpu cooling mechanism through frequency
 	  reduction. An ACPI version of this already exists
-- 
2.17.1

