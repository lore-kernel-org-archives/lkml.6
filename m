Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF29DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751E62075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOJ0WL7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBKJ24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:28:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50284 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfBKJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:28:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so348221wmj.0;
        Mon, 11 Feb 2019 01:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaNreW58cC7bET/z1Woq033nPda8ZYwq19ygbMNxE58=;
        b=vOJ0WL7q2rXyufNG1i/IWHtZXw2cXoWMPdxE7qQBsXn0Dh2AabrTJR7wSrpY94SJy+
         E0+Z1zCYOHRbVfwLlVNpUwto3USa90MvAlqXUQVovIysuP5Q1EO4cB5qzLV+wmN7lhyA
         ppKf3djTYxCYF2d1lMwvUIKrSa+5FTG7y7YQQO8QrZb6lXinuwxkcutGtBKGqM8kr2LV
         Sg84x4AWbnS+JzaJ/KvJQt4M4RkSm8map7/QZU/HCNVoXejytHQZRTiPNw/678YHL+zo
         Xjo2EsNz1UaJoT038jwLvttb0uT59MU7mbQMUAT8Z5NQ/YIfOK1CreBc5NrBeySBxTg5
         JihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaNreW58cC7bET/z1Woq033nPda8ZYwq19ygbMNxE58=;
        b=DEari9Uy/3EFGfSoRavEvJT8pc1jbqL97DrL+KkMFTqTALNcL5HIxyrSj/fT2iEBf1
         WT1eyhcOsll/kVSSsgGJ2vimXlae/xg3dIUcj7p+IIXsT7YaOdzmb6SPzQTwGmj4JeXl
         OQBIRZMqDS7T0qoGFos9LYQ7dG0mQydBB8Rmdz8KyNKn1y81ugTN1xlnAPWwJLeecG29
         7zbOVvtJ6EJlziOVxpR4/okKBBr5TbwwoHE2Rm9oAL+LEFiUpHnN4mf8xlJt5VlVHpT9
         fY6Cj11nTjt1Ok0pyJH354py1Gw3aqthg6pqV12ZmD78+TA8yOSqS56+3SboYbbpFs9q
         07AQ==
X-Gm-Message-State: AHQUAuYTuUPiEbcHKcIylUXnafmqrB4n6lztykzwOL8BD6+krcZlEXpb
        J+X/uNbGFF1MlOKilWEP38k=
X-Google-Smtp-Source: AHgI3IbgPA16trD4+gaiBLwJUgBglshAFdmspx8ivJ2gx7R3tLhsNdijbvx+nNdKymUkHM6+XrTTtw==
X-Received: by 2002:adf:f7c9:: with SMTP id a9mr697225wrq.39.1549877333582;
        Mon, 11 Feb 2019 01:28:53 -0800 (PST)
Received: from laptop.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id 62sm23620770wra.46.2019.02.11.01.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 01:28:52 -0800 (PST)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     e.velu@criteo.com, Liam.Howlett@oracle.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org (open list:INTEL PSTATE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] cpufreq: intel_pstate: Reporting reasons why driver prematurely exit
Date:   Mon, 11 Feb 2019 10:28:26 +0100
Message-Id: <20190211092827.23188-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init code path have several execeptions where the module can decide not to load.
As CONFIG_X86_INTEL_PSTATE is generally set to Y, the return code is not reachable.
The initialisation code is neither verbose of the reason why it did choose to prematurely exit.

This situation leads to situation where its difficult for a user to determine,
on a given platform, why the driver didn't loaded properly.

This patch is about reporting to the user the reason/context why the driver failed to load.
That is a precious hint when debugging a platform.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/cpufreq/intel_pstate.c | 39 ++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd66decf2087..2b10f8864898 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2475,6 +2475,7 @@ static bool __init intel_pstate_no_acpi_pss(void)
 		kfree(pss);
 	}
 
+	pr_info("Cannot detect ACPI PSS");
 	return true;
 }
 
@@ -2484,10 +2485,16 @@ static bool __init intel_pstate_no_acpi_pcch(void)
 	acpi_handle handle;
 
 	status = acpi_get_handle(NULL, "\\_SB", &handle);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		pr_info("Cannot detect ACPI SB");
 		return true;
+	}
 
-	return !acpi_has_method(handle, "PCCH");
+	status = acpi_has_method(handle, "PCCH");
+	if (!status) {
+		pr_info("Cannot detect ACPI PCCH");
+	}
+	return !status;
 }
 
 static bool __init intel_pstate_has_acpi_ppc(void)
@@ -2499,9 +2506,11 @@ static bool __init intel_pstate_has_acpi_ppc(void)
 
 		if (!pr)
 			continue;
-		if (acpi_has_method(pr->handle, "_PPC"))
+		if (acpi_has_method(pr->handle, "_PPC")) {
 			return true;
+		}
 	}
+	pr_info("Cannot detect ACPI PPC");
 	return false;
 }
 
@@ -2592,8 +2601,10 @@ static int __init intel_pstate_init(void)
 	const struct x86_cpu_id *id;
 	int rc;
 
-	if (no_load)
+	if (no_load) {
+		pr_info("disabling as per user-request\n");
 		return -ENODEV;
+	}
 
 	id = x86_match_cpu(hwp_support_ids);
 	if (id) {
@@ -2606,31 +2617,41 @@ static int __init intel_pstate_init(void)
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
 
-	if (!hwp_active && hwp_only)
+	if (!hwp_active && hwp_only) {
+		pr_warn("HWP not present\n");
 		return -ENOTSUPP;
+	}
 
 	pr_info("Intel P-state driver initializing\n");
 
 	all_cpu_data = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
-	if (!all_cpu_data)
+	if (!all_cpu_data) {
+		pr_warn("Cannot allocate memory\n");
 		return -ENOMEM;
+	}
 
 	intel_pstate_request_control_from_smm();
 
-- 
2.20.1

