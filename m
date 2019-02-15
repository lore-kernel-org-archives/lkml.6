Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503CD2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393490AbfBOJvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:51:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfBOJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:51:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9p5WF1121903
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:51:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9p45H1121900;
        Fri, 15 Feb 2019 01:51:04 -0800
Date:   Fri, 15 Feb 2019 01:51:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a9aeb87b98badb55ec28dfcae8a8ce127d6208f5@git.kernel.org>
Cc:     acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, jolsa@kernel.org
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          acme@redhat.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          hpa@zytor.com, jolsa@kernel.org, tglx@linutronix.de
In-Reply-To: <20190213123246.4015-8-jolsa@kernel.org>
References: <20190213123246.4015-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf header: Get rid of write_it label
Git-Commit-ID: a9aeb87b98badb55ec28dfcae8a8ce127d6208f5
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

Commit-ID:  a9aeb87b98badb55ec28dfcae8a8ce127d6208f5
Gitweb:     https://git.kernel.org/tip/a9aeb87b98badb55ec28dfcae8a8ce127d6208f5
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 13 Feb 2019 13:32:43 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:09 -0300

perf header: Get rid of write_it label

Simplifying the code a bit.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dec6d218c31c..f1508adefc16 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1042,11 +1042,9 @@ static int write_cpuid(struct feat_fd *ff,
 	int ret;
 
 	ret = get_cpuid(buffer, sizeof(buffer));
-	if (!ret)
-		goto write_it;
+	if (ret)
+		return -1;
 
-	return -1;
-write_it:
 	return do_write_string(ff, buffer);
 }
 
