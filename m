Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACA4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B5D20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B5D20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeLJFkI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:40:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:64479 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbeLJFkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:40:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2018 21:40:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="300801643"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2018 21:40:07 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 9 Dec 2018 21:40:07 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 9 Dec 2018 21:40:06 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.201]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.182]) with mapi id 14.03.0415.000;
 Mon, 10 Dec 2018 13:40:05 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@I-love.SAKURA.ne.jp>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Thread-Topic: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Thread-Index: AdSQSf5rRH8ZTwaTR0Kl+UXxB6vgiA==
Date:   Mon, 10 Dec 2018 05:40:04 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjIxODhlYjAtM2RiNi00NGYxLWE3MTAtNTkyMzkxZDI2Y2IyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRWlWdkZWcGxwYUdBQ1lOQjFqc2ZMaTc4ckNsM2pwbnRMT3g0ak1wbmNWSDFOU1RGNjZ2XC9OaE9Za0FnbGhybm4ifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Based on patch commit 401c636a0eeb ("kernel/hung_task.c:
show all hung tasks before panic"), we could get the
call stack of hung task.

However, if the console loglevel is not high, we still
can not get the useful information in practice, and
in most cases users don't set console loglevel to
high level.

This patch is to force ignore_loglevel before system
panic, so that the real useful information can be seen
in the console, instead of being like the following,
which doesn't have hung task information.

[  246.916600] INFO: task init:1 blocked for more than 120 seconds.
[  246.922320]       Tainted: G     U  W         4.19.0-quilt-2e5dc0ac-g51b6c21d76cc #1
[  246.926790] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.932553] Kernel panic - not syncing: hung_task: blocked tasks
[  246.938503] CPU: 2 PID: 479 Comm: khungtaskd Tainted: G     U  W         4.19.0-quilt-2e5dc0ac-g51b6c21d76cc #1
[  246.990266] Call Trace:
[  246.991707]  dump_stack+0x4f/0x65
[  246.993710]  panic+0xde/0x231
[  246.995445]  watchdog+0x290/0x410
[  246.997390]  kthread+0x12c/0x150
[  246.999301]  ? reset_hung_task_detector+0x20/0x20
[  247.004825]  ? kthread_create_worker_on_cpu+0x70/0x70
[  247.007735]  ret_from_fork+0x35/0x40
[  247.010280] reboot: panic mode set: p,w
[  247.012619] Kernel Offset: 0x34000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
---
 include/linux/printk.h | 2 +-
 kernel/hung_task.c     | 7 +++++++
 kernel/printk/printk.c | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccf..24748c1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -59,8 +59,8 @@ static inline const char *printk_skip_headers(const char *buffer)
  */
 #define CONSOLE_LOGLEVEL_DEFAULT CONFIG_CONSOLE_LOGLEVEL_DEFAULT
 #define CONSOLE_LOGLEVEL_QUIET  CONFIG_CONSOLE_LOGLEVEL_QUIET
-
 extern int console_printk[];
+extern bool ignore_loglevel;

 #define console_loglevel (console_printk[0])
 #define default_message_loglevel (console_printk[1])
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index cb8e3e8..7d942d1 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -130,6 +130,13 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
                        init_utsname()->version);
                pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
                        " disables this message.\n");
+               /* When sysctl_hung_task_panic is set, we have to force
+                * ignore_loglevel to get really useful hung task
+                * information.
+                */
+               if (sysctl_hung_task_panic && !ignore_loglevel)
+                       ignore_loglevel = true;
+
                sched_show_task(t);
                hung_task_show_lock = true;
        }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b2a029..31a7a56 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1135,7 +1135,7 @@ void __init setup_log_buf(int early)
                free, (free * 100) / __LOG_BUF_LEN);
 }

-static bool __read_mostly ignore_loglevel;
+bool __read_mostly ignore_loglevel;

 static int __init ignore_loglevel_setup(char *str)
 {
--
2.7.4

