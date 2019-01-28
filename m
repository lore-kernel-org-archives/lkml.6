Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4A0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3E620989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDGCcrIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfA1Gn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:43:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46084 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfA1Gn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:43:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so16626445wrt.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=M5tXVSorWIxjyx2W+vXR4nkHOdqq0FYsZWQiwd4C6lQ=;
        b=HDGCcrIKjsFqllqVCMfmgAui7VM90zxEd39qH7JNChB1fhl3BPl93D1PkaYbyzWyFL
         ziHRHeePH2hdf+dPwUufA6WrDg8M0fRWHpuWDNTbwlAy499uKAH1oaEuyyK7az0kv39K
         3C19AaZfCp9ia3YKICXmEYKxMj9+djzrp8aDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=M5tXVSorWIxjyx2W+vXR4nkHOdqq0FYsZWQiwd4C6lQ=;
        b=Ma299Mys8g3nQMkjXo7U7nBYc56HJ8AdSG1GOGYdMNxmjeUSj3zbo5Wbivyf3yf/MR
         tPH8HNZer48j4HpTk5ougiA4XQFUhueeB5yjg20smdRFuMd4vb3zpuwkGATFJ/sCGkV6
         2zzrCFCxpj6hIMkvJTiaJOAUMtGEYSmc2ueN5Ib4d32AIZQm2wVoX32lhrfUrp5GFGAM
         1GnsLl0huVoNxRF9vv6ofsKtt2NZRyFD4saz2jr0cijGdiwJX+BnoxItB+RgJMoUYQXz
         T1rU7Gc97hjeZbLoHbCV3RscZGRnRasgQO7mw3LGGPh1u/Jldeue546Vt7pz/U1lK4Lt
         bOFg==
X-Gm-Message-State: AJcUukdwGznw7KEj4Gl7PZfuEqmzdAoXI5bAruhbIS74wF3PApVgmfTe
        Bgh2iOUVY4N4GYrAykKhL3FyGrCASHo=
X-Google-Smtp-Source: ALg8bN41gTTlAwE1L26ZcGD2WJZbjedTrlBbrrnIbu9oXDXRgw7WMAaCqOIcaBv1JEw2se1ITGLJyA==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr19997425wrr.155.1548657804332;
        Sun, 27 Jan 2019 22:43:24 -0800 (PST)
Received: from localhost ([49.248.191.44])
        by smtp.gmail.com with ESMTPSA id 125sm133521514wmm.26.2019.01.27.22.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:43:23 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Taniya Das <tdas@codeaurora.org>,
        Ilia Lin <ilialin@codeaurora.org>,
        Anson Huang <anson.huang@nxp.com>, linux-pm@vger.kernel.org
Subject: [PATCH v4 1/9] thermal: cpu_cooling: Require thermal core to be compiled in
Date:   Mon, 28 Jan 2019 12:11:26 +0530
Message-Id: <0d63ca44cff5f47ef0102b2c86b4fe9eca9b658b.1548654899.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
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

