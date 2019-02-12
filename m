Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AD6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E811321773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBDD7WUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfBLHJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:09:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34678 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLHJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:09:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so607416wmd.1;
        Mon, 11 Feb 2019 23:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RK17yPikc5ZaBcf36SjRnAfgZWJRrQ9IX5AkjHkfLsI=;
        b=GBDD7WUHuidlf6GeT4mzPuQ71QEHyGCzlFJ3+dDaOhhr2S/tTwGLC9hxEvVeHFa0eK
         0W2xzHwk4yoag9iimIgJa0b01G2CDHvK8k5asp/0ogHqM+/Ckz6/hWCrxohd/GvRRUj+
         Lv+qM/Fu0C2MNeR4tiURSSBR8ksXOAsZiUZOQpyHC7x7uX+hbQEVBMz+zak1dJlNC+Yu
         j2Cu+Y6bxtJxb6pD3op5ksJpG3fiFnZPsqlIsNglNhwXP58dxoCH4KEuyE2hp6bX+A+i
         X5W4Y7tyl5Ao9nLzskToT+aJI9On7M3H5ZdhxjbVvZJDXgWJxX/sTY3iFtCX1Y4wG01z
         tO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RK17yPikc5ZaBcf36SjRnAfgZWJRrQ9IX5AkjHkfLsI=;
        b=TARfRwHYcYUcj2le0FueIcoVWtEA/5qsuiI7d50gbdME7Q9cf+g1ZCx97rib2uhHb6
         XOZcUOcFNzok0sqixY7oCE6JLh0yPeHckth42kLcZ9t1ssKouu62OCQlwi9jaETZC2Bo
         VPK+hhuopM4RuoWRY95PUjYpNdgk3+Nh/f3Pgfl3kQikeqBCQ8i2RLaKVkh0E8QVJQLv
         1qy8mEzO9GsMwDViJ7KIYCLp5qQq70VBaqIEb2RFou00D8d56G/5elRiBTF0WCF1LsBS
         1cpXfGhzNmB6nP9w89gj8hINsaxHbm7mXnockZn5ebWvrSJ8Zkz2bW+8CQVtIrQ8YeAC
         zD6g==
X-Gm-Message-State: AHQUAuZvXRTd0NMoeF1aHLn9dW3wk40GrlBPbN54kWJlpoHgBhDMiChl
        BiqUdwwKFpTGP+/pHSeefeQ=
X-Google-Smtp-Source: AHgI3IbCeBCNQYO4RGHd/s/B7Dt6cECQKBOBqRAhCyn5mdWPET6WSIOfp4Stlrhr6J2AFrqBSEnLoA==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr1568049wme.134.1549955346806;
        Mon, 11 Feb 2019 23:09:06 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-136-188.adsl.proxad.net. [82.252.136.188])
        by smtp.gmail.com with ESMTPSA id y185sm875760wmg.34.2019.02.11.23.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 23:09:05 -0800 (PST)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org (open list:INTEL PSTATE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] cpufreq: intel_pstate: Reporting reasons why driver prematurely exit
Date:   Tue, 12 Feb 2019 08:08:39 +0100
Message-Id: <20190212070839.25981-1-e.velu@criteo.com>
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
index dd66decf2087..eb62e5555dcc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2475,6 +2475,7 @@ static bool __init intel_pstate_no_acpi_pss(void)
 		kfree(pss);
 	}
 
+	pr_debug("Cannot detect ACPI PSS");
 	return true;
 }
 
@@ -2484,10 +2485,15 @@ static bool __init intel_pstate_no_acpi_pcch(void)
 	acpi_handle handle;
 
 	status = acpi_get_handle(NULL, "\\_SB", &handle);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		pr_debug("Cannot detect ACPI SB");
 		return true;
+	}
 
-	return !acpi_has_method(handle, "PCCH");
+	status = acpi_has_method(handle, "PCCH");
+	if (!status)
+		pr_debug("Cannot detect ACPI PCCH");
+	return !status;
 }
 
 static bool __init intel_pstate_has_acpi_ppc(void)
@@ -2502,6 +2508,7 @@ static bool __init intel_pstate_has_acpi_ppc(void)
 		if (acpi_has_method(pr->handle, "_PPC"))
 			return true;
 	}
+	pr_debug("Cannot detect ACPI PPC");
 	return false;
 }
 
@@ -2539,8 +2546,10 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
 	if (id) {
 		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
-		if ( misc_pwr & (1 << 8))
+		if (misc_pwr & (1 << 8)) {
+			pr_debug("MSR_MISC_PWR_MGMT reports enabled HW coordination");
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

