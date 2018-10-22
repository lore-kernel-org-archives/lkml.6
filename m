Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9E9C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068FB207E5
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EI2qS340"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068FB207E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeJWEw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:52:28 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36984 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeJWEw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:52:27 -0400
Received: by mail-qk1-f202.google.com with SMTP id z10-v6so6248908qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qBkcULrk24lGYqTEeJPSqpxDS/GL/T8SH7WD8YBNpus=;
        b=EI2qS340NBQET5Mg5nPhP4aVB2ya2DI6ZnTdAQBQRROnGzihSXYVl9NGcOp51g+w1Q
         16wCHIv1TtcHHFUzffZP0mrcMsomH02bIUPQM4cd4IWH1/EpoyQPCUNYybTQLt9UOtBk
         WFjhk6o50sbI43ObRR9uS/krPjeQNKJjIV3lAztiDMZYTFP0ofxj/gkG9dy5bZpxdTDT
         x7BjhrlJpAakuVwUHNXQBkSl2LmRgSrtHnbSg9As62BFNsc9CFbhRq/BIRNKSWKLjpL3
         9EwiWk+WKYQVAAuTvbyCt+UTiwAyEsewQ58XZo1+VoYAvVauyHu4uByEqWR6vIpYE2KW
         BX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qBkcULrk24lGYqTEeJPSqpxDS/GL/T8SH7WD8YBNpus=;
        b=lgJCRqkIizXxTkuoxD4+6LPE4Up0wnYs7akLyaFAEEPHEVTjWtxmUOuKOV05YT9g1m
         8hAiaV4GyhQhdwJFtmLx2vGeEXzSWdc/VEqiWoLmA93yHV3VUAFXnbI3howwaWWqdvNw
         8vEAgqRJEUuokcypheVav9hwYPXqFwyfBBXU5jUmNYShTh8dzNJa85bFtUa+x8n8GrTA
         CqJKjEQDaDiQjeObarqlAynXp74zBeMVUwLLG8AtV3bdun4qcecRoA9sRwBHI1Ab1ySv
         qtKPYlFgc3mHkUf9xuoTxqTQZRvF/dIME6mmvm9zHds4LOOU/1DHD8/NTDwKf/7koOpa
         5tJw==
X-Gm-Message-State: ABuFfojNizev+xphW+bixmaITtSbxy2P6mCnZaxRa6IfKMrLRAy9NBbk
        00wlPscuJvdRN/IoUVOB6c3Ct08A1SNjenO7iSRep6uYMggmKR1qvt2V97vTtvMV/T63QI/+Z6W
        G8UmGuDZ6JJWBKh0H4zj66omgL4xW9YXX4HUaX1u0X91V4VljEQVeA3udpd20+xhj4Gt3e03O
X-Google-Smtp-Source: ACcGV61oElCFzWpPPkjREg2GM1wmlI1Gbr81pf8+hAHR1llM3hQRmpJ9y8EnQ6g/yPd7uYRlDqzL4DDYdNLx
X-Received: by 2002:ac8:6993:: with SMTP id o19-v6mr11319241qtq.35.1540240345255;
 Mon, 22 Oct 2018 13:32:25 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:32:18 -0600
In-Reply-To: <20181022203218.7007-1-zwisler@google.com>
Message-Id: <20181022203218.7007-2-zwisler@google.com>
Mime-Version: 1.0
References: <20181022203218.7007-1-zwisler@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH 2/2] gsmi: Log event for critical thermal thresholds
From:   Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Duncan Laurie <dlaurie@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@chromium.org>

This registers a notifier for the new thermal notifier
introduced in a previous commit and logs a kernel shutdown
event when the notifier is called for crossing the
THERMAL_TRIP_CRITICAL threshold.

To test:
1) Modify critical shutdown threshold in the BIOS
2) Generate a load on the system to increase temperature
3) Wait until system powers off
4) Power back on and read the event log:

4 | 2012-07-18 10:47:02 | Kernel Event | Critical Thermal Threshold
5 | 2012-07-18 10:47:06 | Kernel Event | Clean Shutdown
6 | 2012-07-18 10:47:06 | ACPI Enter | S5

Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
[ rez: updated changelog for upstream ]
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 drivers/firmware/google/gsmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index c8f169bf2e27d..ee0c611b83e99 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -29,6 +29,7 @@
 #include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/ucs2_string.h>
+#include <linux/thermal.h>
 
 #define GSMI_SHUTDOWN_CLEAN	0	/* Clean Shutdown */
 /* TODO(mikew@google.com): Tie in HARDLOCKUP_DETECTOR with NMIWDT */
@@ -40,6 +41,7 @@
 #define GSMI_SHUTDOWN_SOFTWDT	6	/* Software Watchdog */
 #define GSMI_SHUTDOWN_MBE	7	/* Uncorrected ECC */
 #define GSMI_SHUTDOWN_TRIPLE	8	/* Triple Fault */
+#define GSMI_SHUTDOWN_THERMAL	9	/* Critical Thermal Threshold */
 
 #define DRIVER_VERSION		"1.0"
 #define GSMI_GUID_SIZE		16
@@ -670,6 +672,18 @@ static struct notifier_block gsmi_panic_notifier = {
 	.notifier_call = gsmi_panic_callback,
 };
 
+static int gsmi_thermal_callback(struct notifier_block *nb,
+				 unsigned long reason, void *arg)
+{
+	if (reason == THERMAL_TRIP_CRITICAL)
+		gsmi_shutdown_reason(GSMI_SHUTDOWN_THERMAL);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block gsmi_thermal_notifier = {
+	.notifier_call = gsmi_thermal_callback
+};
+
 /*
  * This hash function was blatantly copied from include/linux/hash.h.
  * It is used by this driver to obfuscate a board name that requires a
@@ -892,6 +906,7 @@ static __init int gsmi_init(void)
 		goto out_remove_sysfs_files;
 	}
 
+	register_thermal_notifier(&gsmi_thermal_notifier);
 	register_reboot_notifier(&gsmi_reboot_notifier);
 	register_die_notifier(&gsmi_die_notifier);
 	atomic_notifier_chain_register(&panic_notifier_list,
@@ -918,6 +933,7 @@ static __init int gsmi_init(void)
 
 static void __exit gsmi_exit(void)
 {
+	unregister_thermal_notifier(&gsmi_thermal_notifier);
 	unregister_reboot_notifier(&gsmi_reboot_notifier);
 	unregister_die_notifier(&gsmi_die_notifier);
 	atomic_notifier_chain_unregister(&panic_notifier_list,
-- 
2.19.1.568.g152ad8e336-goog

