Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08173C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4B9222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLsKyaqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390979AbfBMI74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:59:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50308 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfBMI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:59:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so1532279wmj.0;
        Wed, 13 Feb 2019 00:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWw5lJ9+kh41jox+ubMmJ9OPsQa3mRr4k+HWEoUMqZE=;
        b=kLsKyaqNEbPEIjkZ1t9IJ+5UwImGjELUAkYbgqpfAphqKKNDMdVzV3lgwa6jfTgQPp
         8bq9bXxMZxGsuUoVLgQnH9KtpDe1gyGFlItc81wEYPPJLAziqyAJCKofm2X61sjrTkeY
         QWWAVaHloPg08dSwLBxUqDjtvg+dZVehpUOkltCEFujwK+KgDa1vGrzLX2QOHixKZLgv
         fxhtXp34GbaXn4CgT9osjF/TGlWaHsvAExIof1JPZzic3lYKJhK4kWK7tGS18lP2OdLj
         A+pGRj8JN3pr9qrnDZifGEwCtMefLTkpJfAuikYmy1oHmZu9UBgs74S7QjvZBsYq1hBC
         bpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWw5lJ9+kh41jox+ubMmJ9OPsQa3mRr4k+HWEoUMqZE=;
        b=qopwS3GnEYSWo5LqPOM0pkUSXtn/oy+uS4Kn+mjapJ08UWunPprM1jolkR2/8C7BYS
         heZJei5Lb4kJ5MIHiVbTVk5o0eenICupz+X848DAcynQPwJqJN0sIvGIl37D7p8hcEar
         zO1GvMNe6sPYkjcD4yFK9lTg1UZRRkvyU+ezvnFcMTp9qxZCH6LWYHw4z2Wx4rq59Rgu
         WVND2miOw1fEOYFqDOjZk9NWwww9yuq5UacQOM9/GDA0M1J5zBVW7GszJMB8K9qzUFOe
         HSxN8oiU1O3tSbGzIWnz07yqkUkMF8hpVFnqEgVKzthyWGyT78KJSY+MaovnB6hcF9/z
         M+Xg==
X-Gm-Message-State: AHQUAua9/x/KLCIa/NAgvmuRfN42oRXesAjmYp/ndh8fnxZ9aQFacsjR
        3RqzcUAA4n0Z45JzIehKWoU=
X-Google-Smtp-Source: AHgI3IapmzASCvuj+YvlvZvT4Ld1/hgPqnkDEHWJb3bPTuLJfs4/8lgRpnN4MivIo40007tArc2RqQ==
X-Received: by 2002:a1c:f406:: with SMTP id z6mr1066887wma.107.1550048388043;
        Wed, 13 Feb 2019 00:59:48 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-136-188.adsl.proxad.net. [82.252.136.188])
        by smtp.gmail.com with ESMTPSA id r12sm19409087wrt.76.2019.02.13.00.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 00:59:47 -0800 (PST)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     rafael@kernel.org, Erwan Velu <e.velu@criteo.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org (open list:INTEL PSTATE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5] cpufreq: intel_pstate: Reporting reasons why driver prematurely exit
Date:   Wed, 13 Feb 2019 09:58:35 +0100
Message-Id: <20190213085835.4705-1-e.velu@criteo.com>
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
index dd66decf2087..c6220261a87f 100644
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
+		pr_debug("ACPI _SB not found\n");
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
+			pr_warn("CPU ID is not in the list of supported devices\n");
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
+		pr_warn("Platform already taking care of power management\n");
 		return -ENODEV;
+	}
 
 	if (!hwp_active && hwp_only)
 		return -ENOTSUPP;
-- 
2.20.1

