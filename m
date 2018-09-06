Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4100FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F9F206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F9F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeIFSUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:20:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44011 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbeIFSUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:20:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86Dinuh310646
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:44:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86Din4x310643;
        Thu, 6 Sep 2018 06:44:49 -0700
Date:   Thu, 6 Sep 2018 06:44:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Benjamin Peterson <tipbot@zytor.com>
Message-ID: <tip-3de3e8bbf302545ef9acebb9f900939ac5c3820f@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, jolsa@redhat.com,
        benjamin@python.org, peterz@infradead.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
          jolsa@redhat.com, benjamin@python.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20180828035344.31500-1-benjamin@python.org>
References: <20180828035344.31500-1-benjamin@python.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Alias 'umount' to 'umount2'
Git-Commit-ID: 3de3e8bbf302545ef9acebb9f900939ac5c3820f
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

Commit-ID:  3de3e8bbf302545ef9acebb9f900939ac5c3820f
Gitweb:     https://git.kernel.org/tip/3de3e8bbf302545ef9acebb9f900939ac5c3820f
Author:     Benjamin Peterson <benjamin@python.org>
AuthorDate: Mon, 27 Aug 2018 20:53:44 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:25 -0300

perf trace beauty: Alias 'umount' to 'umount2'

Before:

  # perf trace -e *mount* umount /dev/mapper/fedora-home /s
    11.576 ( 0.004 ms) umount/3138 umount2(arg0: 94501956754656, arg1: 0, arg2: 1, arg3: 140051050083104, arg4: 4, arg5: 94501956755136) = -1 EINVAL Invalid argument
  #

After:

  # perf trace -e *mount* umount /s
     0.000 ( 9.241 ms): umount/5251 umount2(name: 0x55f74a986480) = 0

Signed-off-by: Benjamin Peterson <benjamin@python.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180828035344.31500-1-benjamin@python.org
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 97ace635bed8..c106189f4066 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -825,6 +825,7 @@ static struct syscall_fmt {
 	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "tkill",
 	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
+	{ .name     = "umount2", .alias = "umount", },
 	{ .name	    = "uname", .alias = "newuname", },
 	{ .name	    = "unlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
