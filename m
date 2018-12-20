Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AB7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E064218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbeLTSRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:17:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39115 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbeLTSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:17:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIGs2H3683049
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:16:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIGr1L3683046;
        Thu, 20 Dec 2018 10:16:53 -0800
Date:   Thu, 20 Dec 2018 10:16:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3452xgatncpil7v22minkwbo@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, lclaudio@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        acme@redhat.com, wangnan0@huawei.com
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
          jolsa@kernel.org, wangnan0@huawei.com, lclaudio@redhat.com,
          adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Do not include stdio.h
Git-Commit-ID: 4623ce405d0871e648ba72fdb9c561016e2cc41d
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

Commit-ID:  4623ce405d0871e648ba72fdb9c561016e2cc41d
Gitweb:     https://git.kernel.org/tip/4623ce405d0871e648ba72fdb9c561016e2cc41d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 13 Dec 2018 15:05:43 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:24:00 -0300

perf augmented_raw_syscalls: Do not include stdio.h

We're not using that puts() thing, and thus we don't need to define the
__bpf_stdout__ map, reducing the setup time.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-3452xgatncpil7v22minkwbo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index a91c5874433e..6c5db6baeb3a 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -14,7 +14,6 @@
  * code that will combine entry/exit in a strace like way.
  */
 
-#include <stdio.h>
 #include <unistd.h>
 #include <pid_filter.h>
 
