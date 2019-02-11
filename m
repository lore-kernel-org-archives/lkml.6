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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13582C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AC420823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU0H4rt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBKJbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:31:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37219 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBKJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:31:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so10405655wmg.2;
        Mon, 11 Feb 2019 01:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtN5TpTq4iwM1pPfzvGUrEDcplUZre+748yHJSDQqI4=;
        b=VU0H4rt18sHwL+e0dAbnD4mb04s6ZG0pOri7Mh7q5esVgWy+AFg5RqYlvOQG5OEROY
         fcobB+7jHz49XLhtV6VmNMtEz2fco0qnEEjtzABDOTmPUVbUoZOHpR+0nUkN/hpU1XcI
         9+7xxF6CkrOApQ6KDOSAXVCD1jxbgt7VFQSOBZ8SQNeHqapkWnJpEVdGh1XkW9gGvAu7
         OujDJMWyy/DydBNxAvOG+bgQcIGgAoi0m6qkrTuZj6nkeMDZc3cjtd0jNUcA3u/JN9TD
         G5WbXys54Fe0J79Auo6Ltl4W6AGPkPdfVW78wfnLyKlV/jPdY7Xnbgq294IJudnD8z2Q
         Ge/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtN5TpTq4iwM1pPfzvGUrEDcplUZre+748yHJSDQqI4=;
        b=pJC+my7CWERP0eE7oXWU7kZikr9Icrlv+y0WLxdSZ4jrT4F/0cnRA3tQJYj7hoPd9w
         RBuLllPD6SZMGHTrb1nHnpN2Hxp128KbAyWRq1LHSUQif6q+73pG7H+/fgadnzNH6zQv
         Iq75GIi+74Mh+z9WS45G8t5w0KBA09NptBFMzt7BCA1BoZMJ0EMFbeXQz8FyFZ9SqOB0
         Y38vJb9/rOHVyOV85ubXvDblChoE2DSUtoIQ436TqpCuH+hMi0DYmHQ/18b2kLfvB1nP
         oEg6JU70fdZt31z+Cb9ZUVDrJtx65hFiGToDSRXfssBT5NGVc8TIS72czxwLvMuqxRJG
         muQQ==
X-Gm-Message-State: AHQUAuZfRhRtbKjVF1lAAOQ7Xz2LiM5Ip2DXN+kJEZytBXlNE9jvin6q
        QI+Xok5qvARbGXO2X9d0/ww=
X-Google-Smtp-Source: AHgI3IZslDaGz8jXpmFhwWf/B+Y9xxhC3cUIvKq5X0xNjjUn0kejU61mJ+85TxuyXtwfLiuHg1YYAA==
X-Received: by 2002:a1c:c303:: with SMTP id t3mr7721825wmf.94.1549877508629;
        Mon, 11 Feb 2019 01:31:48 -0800 (PST)
Received: from laptop.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id v4sm9362447wme.6.2019.02.11.01.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 01:31:47 -0800 (PST)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     e.velu@criteo.com, Liam.Howlett@oracle.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org (open list:INTEL PSTATE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] cpufreq: intel_pstate: Reporting reasons why driver prematurely exit
Date:   Mon, 11 Feb 2019 10:31:40 +0100
Message-Id: <20190211093140.23608-1-e.velu@criteo.com>
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
 drivers/cpufreq/intel_pstate.c | 36 ++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd66decf2087..ba2e2aee6c20 100644
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
@@ -2502,6 +2509,7 @@ static bool __init intel_pstate_has_acpi_ppc(void)
 		if (acpi_has_method(pr->handle, "_PPC"))
 			return true;
 	}
+	pr_info("Cannot detect ACPI PPC");
 	return false;
 }
 
@@ -2592,8 +2600,10 @@ static int __init intel_pstate_init(void)
 	const struct x86_cpu_id *id;
 	int rc;
 
-	if (no_load)
+	if (no_load) {
+		pr_info("disabling as per user-request\n");
 		return -ENODEV;
+	}
 
 	id = x86_match_cpu(hwp_support_ids);
 	if (id) {
@@ -2606,31 +2616,41 @@ static int __init intel_pstate_init(void)
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

