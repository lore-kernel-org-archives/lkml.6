Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F6AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D0020866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D0020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404987AbeKVRqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:46:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54687 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389253AbeKVRqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:46:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM77j1O3691367
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:07:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM77jtG3691364;
        Wed, 21 Nov 2018 23:07:45 -0800
Date:   Wed, 21 Nov 2018 23:07:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-88vh02cnkam0vv5f9vp02o3h@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        wangnan0@huawei.com, acme@redhat.com, dsahern@gmail.com,
        hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, tglx@linutronix.de, namhyung@kernel.org,
          jolsa@kernel.org, hpa@zytor.com, dsahern@gmail.com,
          wangnan0@huawei.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] Revert "perf augmented_syscalls: Drop 'write',
 'poll' for testing without self pid filter"
Git-Commit-ID: 4aa792de0b136edbde777d3d69c6fe8cdd8cda72
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4aa792de0b136edbde777d3d69c6fe8cdd8cda72
Gitweb:     https://git.kernel.org/tip/4aa792de0b136edbde777d3d69c6fe8cdd8cda72
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 7 Nov 2018 10:54:06 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

Revert "perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter"

Now that we have the "filtered_pids" logic in place, no need to do this
rough filter to avoid the feedback loop from 'perf trace's own syscalls,
revert it.

This reverts commit 7ed71f124284359676b6496ae7db724fee9da753.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-88vh02cnkam0vv5f9vp02o3h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 3f26e705b86c..74ce7574073d 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -44,9 +44,7 @@ struct augmented_filename {
 	char		value[256];
 };
 
-#define SYS_WRITE 1
 #define SYS_OPEN 2
-#define SYS_POLL 7
 #define SYS_OPENAT 257
 
 pid_filter(pids_filtered);
@@ -106,8 +104,6 @@ int sys_enter(struct syscall_enter_args *args)
 	 * 	 after the ctx memory access to prevent their down stream merging.
 	 */
 	switch (augmented_args.args.syscall_nr) {
-	case SYS_WRITE:
-	case SYS_POLL:	 return 0;
 	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
 			__asm__ __volatile__("": : :"memory");
 			 break;
