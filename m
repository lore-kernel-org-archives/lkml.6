Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F56C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F414214E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F414214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=supermicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLCTqL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:46:11 -0500
Received: from mga.supermicro.com ([207.212.57.84]:33650 "EHLO
        MGA.supermicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeLCTqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:46:11 -0500
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2018 14:46:11 EST
Received: from pps.filterd (MGA.supermicro.com [127.0.0.1])
        by MGA.supermicro.com (8.16.0.22/8.16.0.22) with SMTP id wB3JYejD028919;
        Mon, 3 Dec 2018 11:37:33 -0800
Received: from ex2013-mbx3.supermicro.com (EX2013-MBX3.supermicro.com [10.2.1.46])
        by MGA.supermicro.com with ESMTP id 2p3tsvsmv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 03 Dec 2018 11:37:33 -0800
Received: from EX2013-MBX2.supermicro.com (10.2.1.38) by
 EX2013-MBX3.supermicro.com (10.2.1.46) with Microsoft SMTP Server (TLS) id
 15.0.1236.3; Mon, 3 Dec 2018 11:37:24 -0800
Received: from EX2013-MBX2.supermicro.com ([::1]) by
 Ex2013-MBX2.supermicro.com ([fe80::80ad:66c2:9e01:4b74%18]) with mapi id
 15.00.1236.000; Mon, 3 Dec 2018 11:37:24 -0800
From:   Patrick Geary <patrickg@supermicro.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "Du, Alek" <alek.du@intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Tang, Feng" <feng.tang@intel.com>
Subject: Re: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration
 sequences
Thread-Topic: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration
 sequences
Thread-Index: AQHUGt5AveUKS9tr5UqDaitbRIV+waSOd8AAgApENgCABhwFAIADHfUAgCDhbYCAbf6ZAIAAgwoA//+e3wCAPVDI8w==
Date:   Mon, 3 Dec 2018 19:37:24 +0000
Message-ID: <1543865843219.51523@supermicro.com>
References: <fdf96605-a4a0-049b-51c9-1e68cc2a9b93@supermicro.com>
 <1A7043D5F58CCB44A599DFD55ED4C94849A1AACF@FMSMSX126.amr.corp.intel.com>
 <c7582a8c-8cc1-eff3-2452-a8d42d23fea1@supermicro.com>
 <cb798dcd-8cd6-8a92-9f6c-50bec0afe204@supermicro.com>
 <94bebaa1-992b-572b-0d24-e08037611358@supermicro.com>
 <70cdf321-cef7-aa26-1ca8-33378b3afdd9@supermicro.com>
 <18d873f6-a911-200b-7bc7-8f4b4f3c5161@supermicro.com>
 <6e40fea8-9b42-3785-7d4d-36f120980d66@redhat.com>,<f718c935-d5b4-111d-abe1-e7a61d08237b@supermicro.com>
In-Reply-To: <f718c935-d5b4-111d-abe1-e7a61d08237b@supermicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.2.0.41]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry; I'm OoO and this is all I have for a mailer.


---Copypasta of first RFC patch---

---
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9..5a07d12 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -47,6 +47,13 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);

 int tsc_clocksource_reliable;

+/*
+ * TSC calibration sequence disablement
+ */
+int calibrate_cpuid_khz_disabled = 0;
+int calibrate_msr_disabled = 0;
+int calibrate_quick_disabled = 0;
+
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
@@ -281,6 +288,32 @@ static int __init tsc_setup(char *str)

 __setup("tsc=", tsc_setup);

+static int __init setup_tsc_calibration_order(char *str)
+{
+        if (!str)
+                return -EINVAL;
+
+        while (*str) {
+                if (!strncmp(str, "nocpuid", 7)) {
+                        calibrate_cpuid_khz_disabled = 1;
+                        pr_info("TSC CPUID khz calibrate disabled\n");
+                } else if (!strncmp(str, "nomsr", 5)) {
+                        calibrate_msr_disabled = 1;
+                        pr_info("TSC msr calibrate disabled\n");
+                } else if (!strncmp(str, "noquick", 7)) {
+                        calibrate_quick_disabled = 1;
+                        pr_info("TSC quick calibrate disabled\n");
+                }
+
+                str += strcspn(str, ",");
+                while (*str == ',')
+                        str++;
+        }
+        return 1;
+}
+
+__setup("tsc_calibrate=", setup_tsc_calibration_order);
+
 #define MAX_RETRIES     5
 #define SMI_TRESHOLD    50000

@@ -675,19 +708,25 @@ unsigned long native_calibrate_cpu(void)
         unsigned long flags, latch, ms, fast_calibrate;
         int hpet = is_hpet_enabled(), i, loopmin;

-        fast_calibrate = cpu_khz_from_cpuid();
-        if (fast_calibrate)
-                return fast_calibrate;
+        if (!calibrate_cpuid_khz_disabled) {
+                fast_calibrate = cpu_khz_from_cpuid();
+                if (fast_calibrate)
+                        return fast_calibrate;
+        }

-        fast_calibrate = cpu_khz_from_msr();
-        if (fast_calibrate)
-                return fast_calibrate;
+        if (!calibrate_msr_disabled) {
+                fast_calibrate = cpu_khz_from_msr();
+                if (fast_calibrate)
+                        return fast_calibrate;
+        }

-        local_irq_save(flags);
-        fast_calibrate = quick_pit_calibrate();
-        local_irq_restore(flags);
-        if (fast_calibrate)
-                return fast_calibrate;
+        if (!calibrate_quick_disabled) {
+                local_irq_save(flags);
+                fast_calibrate = quick_pit_calibrate();
+                local_irq_restore(flags);
+                if (fast_calibrate)
+                        return fast_calibrate;
+        }

         /*
          * Run 5 calibration loops to get the lowest frequency value
---

________________________________________
From: patrickg <patrickg@supermicro.com>
Sent: Thursday, October 25, 2018 12:13 PM
To: Prarit Bhargava; Brown, Len; linux-kernel@vger.kernel.org
Cc: mingo@kernel.org; Du, Alek; arjan@linux.intel.com; Tang, Feng
Subject: Re: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration sequences

Sorry for the delay; lkml folder sorting gone wrong.

On 10/25/18 11:01 AM, Prarit Bhargava wrote:
> Patrick can you reply back with the entire patch

Yes; watch the editor bork it even more than it originally did, though.


---Copypasta of first RFC patch---

---
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9..5a07d12 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -47,6 +47,13 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);

 int tsc_clocksource_reliable;

+/*
+ * TSC calibration sequence disablement
+ */
+int calibrate_cpuid_khz_disabled = 0;
+int calibrate_msr_disabled = 0;
+int calibrate_quick_disabled = 0;
+
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
@@ -281,6 +288,32 @@ static int __init tsc_setup(char *str)

 __setup("tsc=", tsc_setup);

+static int __init setup_tsc_calibration_order(char *str)
+{
+        if (!str)
+                return -EINVAL;
+
+        while (*str) {
+                if (!strncmp(str, "nocpuid", 7)) {
+                        calibrate_cpuid_khz_disabled = 1;
+                        pr_info("TSC CPUID khz calibrate disabled\n");
+                } else if (!strncmp(str, "nomsr", 5)) {
+                        calibrate_msr_disabled = 1;
+                        pr_info("TSC msr calibrate disabled\n");
+                } else if (!strncmp(str, "noquick", 7)) {
+                        calibrate_quick_disabled = 1;
+                        pr_info("TSC quick calibrate disabled\n");
+                }
+
+                str += strcspn(str, ",");
+                while (*str == ',')
+                        str++;
+        }
+        return 1;
+}
+
+__setup("tsc_calibrate=", setup_tsc_calibration_order);
+
 #define MAX_RETRIES     5
 #define SMI_TRESHOLD    50000

@@ -675,19 +708,25 @@ unsigned long native_calibrate_cpu(void)
         unsigned long flags, latch, ms, fast_calibrate;
         int hpet = is_hpet_enabled(), i, loopmin;

-        fast_calibrate = cpu_khz_from_cpuid();
-        if (fast_calibrate)
-                return fast_calibrate;
+        if (!calibrate_cpuid_khz_disabled) {
+                fast_calibrate = cpu_khz_from_cpuid();
+                if (fast_calibrate)
+                        return fast_calibrate;
+        }

-        fast_calibrate = cpu_khz_from_msr();
-        if (fast_calibrate)
-                return fast_calibrate;
+        if (!calibrate_msr_disabled) {
+                fast_calibrate = cpu_khz_from_msr();
+                if (fast_calibrate)
+                        return fast_calibrate;
+        }

-        local_irq_save(flags);
-        fast_calibrate = quick_pit_calibrate();
-        local_irq_restore(flags);
-        if (fast_calibrate)
-                return fast_calibrate;
+        if (!calibrate_quick_disabled) {
+                local_irq_save(flags);
+                fast_calibrate = quick_pit_calibrate();
+                local_irq_restore(flags);
+                if (fast_calibrate)
+                        return fast_calibrate;
+        }

         /*
          * Run 5 calibration loops to get the lowest frequency value
---
