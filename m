Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B45C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9FC20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9FC20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeLMBvc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:51:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:26754 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbeLMBvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:51:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 17:51:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="101117260"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2018 17:51:31 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 12 Dec 2018 17:51:31 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 12 Dec 2018 17:51:30 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.201]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.222]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 09:51:23 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: [PATCH V2] kernel/hung_task.c: Force console verbose before panic
Thread-Topic: [PATCH V2] kernel/hung_task.c: Force console verbose before
 panic
Thread-Index: AdSShhwe/J2NW1mVShKTRNOT+kjUIA==
Date:   Thu, 13 Dec 2018 01:51:22 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A6015B675@SHSMSX101.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTIxOGY2NDItYzhkMC00ODFmLWFhNjMtYTkzYjBlNDc5ODQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQlFrSU9lSmxmT3lWXC9nSnVZa2xBRHJ0TW85RlBIMGxHdEFZeW93Y2pKZHhXYUhoNDI5U2FrSEIrZzgyR2MzTDgifQ==
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

V2: Petr suggests to make 2 patches:
    One is addressing console_verbose() only, which is
    this patch's aim.
    The other is about forcing sched_show_task() during
    panic, which needs more discussion yet.

Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
---
 kernel/hung_task.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index cb8e3e8..85af0cd 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -112,8 +112,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)

        trace_sched_process_hang(t);

-       if (!sysctl_hung_task_warnings && !sysctl_hung_task_panic)
-               return;
+       if (sysctl_hung_task_panic) {
+               console_verbose();
+               hung_task_show_lock = true;
+               hung_task_call_panic = true;
+       }

        /*
         * Ok, the task did not get scheduled for more than 2 minutes,
@@ -135,11 +138,6 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
        }

        touch_nmi_watchdog();
-
-       if (sysctl_hung_task_panic) {
-               hung_task_show_lock = true;
-               hung_task_call_panic = true;
-       }
 }

 /*
--
2.7.4
