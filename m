Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18B8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81917222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7+pg75D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404066AbfBMMV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:21:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39711 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfBMMVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:21:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so1176249wrw.6;
        Wed, 13 Feb 2019 04:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZVeGuMqU2ln0SSUG8St9yqg7DCqVA1jw2z5imVoNog=;
        b=I7+pg75D2GWMmN6ajXyyxqQxBwMnpm8Dfs/7sKorUarDohcFVlbquYuEoWosSQ6dYD
         i20rinVfI0mIkA2FiaEpPfkf30B+vQhIRFqkk/D9PuPnE+OC1N7v0/ZvuMhzvfp6B2uq
         OZHVVpSMi2QgKgz1d2Fue+Hholzo1M+PR3GxORuhWWKwK8aY4C090VprHVAr4QcF2POj
         k6Si2kOWiCoe1zTU3i1n166Jp/24uXL4kKSSuDrrRxGF7Chg6BB4gmQ0wK92kSmIxXq2
         Uj98ULttp4h+QpFfPSh+hk/pcpruTjV/l3EW7VVI8vIwKMAIUUKXmhoSnlx3lQnh+HPB
         cEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZVeGuMqU2ln0SSUG8St9yqg7DCqVA1jw2z5imVoNog=;
        b=VLwOu/5jrcSAJZKDGOX0x6Jq6XbnKaJL2lP6+iwSd8OPHCjlplJ7v18NxPpE35xcnR
         lgUZRW9buYk0SSH+ienOtlnLbjY79dhUTe8JiXGNiDJCtUjyJvReQ7e5v5ihlB82u9t8
         zBOEQQkCFRvvgYa+eY20an9laPbu/KM2OiaQbl+CQdDBTfBHdFudVKmpGlUy8iVkXkJG
         UqXBfJ2u8yMuk1h4Qa6APMIC5mSbgZXvZDAR8iAuf7tGSnB3Q3gUNNwUPivgwMfnlPff
         pCfI6i8D0B6Mn3bf1Jb7br3pPqVkjrxs+qj0OCtpa4WiCXp89SKAFD2s2V8grCB/460b
         rHDA==
X-Gm-Message-State: AHQUAuY6FgheVFJ7O8tSDLUh+RwL1qMfX9bKcF3tbufUu2LypSR8/o6z
        FhNmwIifeoHYQEY/Gf/UEaM=
X-Google-Smtp-Source: AHgI3IYfjUKfPbnwzH8/X3Yk/8vPE+z/V0P8bmnpNRqISUzKcKP1Cc/dQziUkiurd6qSlO2JbhRaJw==
X-Received: by 2002:a5d:4412:: with SMTP id z18mr177374wrq.111.1550060481395;
        Wed, 13 Feb 2019 04:21:21 -0800 (PST)
Received: from laptop.criteo.prod ([91.199.242.238])
        by smtp.gmail.com with ESMTPSA id n11sm10591435wrw.60.2019.02.13.04.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 04:21:20 -0800 (PST)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     rafael@kernel.org, Erwan Velu <e.velu@criteo.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org (open list:INTEL PSTATE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6] cpufreq: intel_pstate: Reporting reasons why driver prematurely exit
Date:   Wed, 13 Feb 2019 13:21:05 +0100
Message-Id: <20190213122105.14270-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init code path has several exceptions where the module can decide not to load.
As CONFIG_X86_INTEL_PSTATE is generally set to Y, the return code is not reachable.
The initialization code is neither verbose of the reason why it did choose to prematurely exit.

This situation leads to a situation where its difficult for a user to determine,
on a given platform, why the driver didn't load properly.

This patch is about reporting to the user the reason/context of why the driver failed to load.
That is a precious hint when debugging a platform.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/cpufreq/intel_pstate.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd66decf2087..e1ae309923bf 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2475,6 +2475,7 @@ static bool __init intel_pstate_no_acpi_pss(void)
 		kfree(pss);
 	}
 
+	pr_debug("ACPI _PSS not found\n");
 	return true;
 }
 
@@ -2484,10 +2485,15 @@ static bool __init intel_pstate_no_acpi_pcch(void)
 	acpi_handle handle;
 
 	status = acpi_get_handle(NULL, "\\_SB", &handle);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		pr_debug("ACPI PCCH not found\n");
 		return true;
+	}
 
-	return !acpi_has_method(handle, "PCCH");
+	status = acpi_has_method(handle, "PCCH");
+	if (!status)
+		pr_debug("ACPI PCCH not found\n");
+	return !status;
 }
 
 static bool __init intel_pstate_has_acpi_ppc(void)
@@ -2502,6 +2508,7 @@ static bool __init intel_pstate_has_acpi_ppc(void)
 		if (acpi_has_method(pr->handle, "_PPC"))
 			return true;
 	}
+	pr_debug("ACPI _PPC not found\n");
 	return false;
 }
 
@@ -2539,8 +2546,10 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
 	if (id) {
 		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
-		if ( misc_pwr & (1 << 8))
+		if (misc_pwr & (1 << 8)) {
+			pr_debug("MSR_MISC_PWR_MGMT enabled\n");
 			return true;
+		}
 	}
 
 	idx = acpi_match_platform_list(plat_info);
@@ -2606,22 +2615,28 @@ static int __init intel_pstate_init(void)
 		}
 	} else {
 		id = x86_match_cpu(intel_pstate_cpu_ids);
-		if (!id)
+		if (!id) {
+			pr_info("CPU ID is not in the list of supported devices\n");
 			return -ENODEV;
+		}
 
 		copy_cpu_funcs((struct pstate_funcs *)id->driver_data);
 	}
 
-	if (intel_pstate_msrs_not_valid())
+	if (intel_pstate_msrs_not_valid()) {
+		pr_warn("Cannot enable driver as per invalid MSRs\n");
 		return -ENODEV;
+	}
 
 hwp_cpu_matched:
 	/*
 	 * The Intel pstate driver will be ignored if the platform
 	 * firmware has its own power management modes.
 	 */
-	if (intel_pstate_platform_pwr_mgmt_exists())
+	if (intel_pstate_platform_pwr_mgmt_exists()) {
+		pr_info("Platform already taking care of power management\n");
 		return -ENODEV;
+	}
 
 	if (!hwp_active && hwp_only)
 		return -ENOTSUPP;
-- 
2.20.1

