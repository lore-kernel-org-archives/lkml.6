Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE5DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BC52146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BC52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeLKByt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:54:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:19281 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeLKBys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:54:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 17:54:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,340,1539673200"; 
   d="scan'208";a="282558745"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2018 17:54:47 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 10 Dec 2018 17:54:47 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.201]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.203]) with mapi id 14.03.0415.000;
 Tue, 11 Dec 2018 09:54:45 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
        "'sergey.senozhatsky@gmail.com'" <sergey.senozhatsky@gmail.com>,
        "'dvyukov@google.com'" <dvyukov@google.com>,
        "'penguin-kernel@I-love.SAKURA.ne.jp'" 
        <penguin-kernel@I-love.SAKURA.ne.jp>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: [PATCH V1] kernel/hung_task.c: Force console verbose before panic
Thread-Topic: [PATCH V1] kernel/hung_task.c: Force console verbose before
 panic
Thread-Index: AdSQ9AvMP4cc4O7IS6+xvm4BbQadDA==
Date:   Tue, 11 Dec 2018 01:54:45 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A6015ABFC@SHSMSX101.ccr.corp.intel.com>
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
can not see the useful panic information in practice,
and in most cases users don't set console loglevel to
high level.

This patch is to force console verbose before system
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

V1: console_verbose() is used instead of ignore_loglevel,
    suggested by Sergey.
    Tweak the function check_hung_task() suggested by
    Tetsuo to make code more readable.

Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
---
 kernel/hung_task.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index cb8e3e8..8db421f 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -112,14 +112,16 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)

        trace_sched_process_hang(t);

-       if (!sysctl_hung_task_warnings && !sysctl_hung_task_panic)
-               return;
-
        /*
         * Ok, the task did not get scheduled for more than 2 minutes,
         * complain:
         */
-       if (sysctl_hung_task_warnings) {
+       if (sysctl_hung_task_panic || sysctl_hung_task_warnings) {
+               if (sysctl_hung_task_panic) {
+                       console_verbose();
+                       hung_task_call_panic = true;
+               }
+
                if (sysctl_hung_task_warnings > 0)
                        sysctl_hung_task_warnings--;
                pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
@@ -132,13 +134,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
                        " disables this message.\n");
                sched_show_task(t);
                hung_task_show_lock = true;
-       }
-
-       touch_nmi_watchdog();

-       if (sysctl_hung_task_panic) {
-               hung_task_show_lock = true;
-               hung_task_call_panic = true;
+               touch_nmi_watchdog();
        }
 }

--
2.7.4
