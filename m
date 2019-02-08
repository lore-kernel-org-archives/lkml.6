Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D1EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4FC20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a90jVT+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfBHL5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:57:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54673 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHL5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:57:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so3122347wmh.4;
        Fri, 08 Feb 2019 03:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DzVnqPXyVg+Pufd2lEosTVnu8jqUvGdDuzGKaMOVroY=;
        b=a90jVT+haVKT+6u3v1/lk275nRBEv8jwyHz9ztBGza33YJrp4q4vH7evOd5c0EmP0D
         B8socboLYSR+IZi6+ROEGuNYvWgLm5heIm7UCS8jUhHzDViRAiA6HjQVXrLGYr3VE0Nu
         fihBpGz8z18MneCApUlZfyioIJtaLxPW68lC0TnusM0zgVqri5ZkvMZUd8FLQXpw4DeK
         qAsvPZcwUzclM6InqCXkAFGdV8cH1quvMRIEJ15GdL6Y07xCIGf3q1+JRE8Jq7Y2b/RA
         yKJaoVzctjeQoMJTX3jw/iqv2pi+AivJekQp5wBta7KUp5RtXCfIp/rmwqLh/SH+HjKF
         ZoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DzVnqPXyVg+Pufd2lEosTVnu8jqUvGdDuzGKaMOVroY=;
        b=sGrjQEvuSjflFTza9YTLkrvX/RB0Jp2srVYFb5Ka1HGaN4Mn/yUKGBn2D6iaot7/0v
         Bf8OvNNUaY3SPDJRvklZngzL5pbRE4O9XAWigfQfX2brJfcZql2ZHKQ5UUwFD9qHwAy8
         vIVED1p4SCFQ9f6rXrUTpCEYNkPUmkvFHw08SWdSBxKNKNXhJPawRtB+HkN/ZUoURD5f
         ajakEYpckKwn7ZVnpS/Ueznt+sD1vOsoKKPcStuQEVK0M7W2kqfk3/SSb7GI6yuUkbEF
         IIFr7oWaKZ+FGRgmWbMIPU/P0ij5w4e18XieXU+1G0iqEt74IYuz8tx7139tHeONvb0L
         MXRA==
X-Gm-Message-State: AHQUAuY0zptt8cwxvH1/RwoFt4h3Hi+L9jj593EYIr3OarKhATkMEK4Q
        VDV9oeRaz6ZitiIgByFxUqRojrVkHsg=
X-Google-Smtp-Source: AHgI3Ia1gpzSgNo2SbgN5j0mm4Ezaf6d49plaXotqKexwxpVj4ekIHb28sxpkQe6RBCScyrW0iIqCg==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr3896247wml.49.1549627031874;
        Fri, 08 Feb 2019 03:57:11 -0800 (PST)
Received: from laptop.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id p10sm1396889wrt.25.2019.02.08.03.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 03:57:11 -0800 (PST)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     e.velu@criteo.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org (open list:INTEL PSTATE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] cpufreq: intel_pstate: Reporting reasons why driver prematurely exit
Date:   Fri,  8 Feb 2019 12:56:58 +0100
Message-Id: <20190208115658.723-1-e.velu@criteo.com>
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
 drivers/cpufreq/intel_pstate.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd66decf2087..635049095dde 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2592,8 +2592,10 @@ static int __init intel_pstate_init(void)
 	const struct x86_cpu_id *id;
 	int rc;
 
-	if (no_load)
+	if (no_load) {
+		pr_info("disabling as per user-request\n");
 		return -ENODEV;
+	}
 
 	id = x86_match_cpu(hwp_support_ids);
 	if (id) {
@@ -2606,31 +2608,41 @@ static int __init intel_pstate_init(void)
 		}
 	} else {
 		id = x86_match_cpu(intel_pstate_cpu_ids);
-		if (!id)
+		if (!id) {
+			pr_warn("CPU doesn't support P-states\n");
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

