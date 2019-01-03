Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E3DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEAF2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfACNTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:19:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48799 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfACNTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:19:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DIq2f1384863
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:18:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DIqHL1384860;
        Thu, 3 Jan 2019 05:18:52 -0800
Date:   Thu, 3 Jan 2019 05:18:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-423701a0c8d754d9a39547f6c48904347e4f1eca@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        jmario@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org
Reply-To: jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          acme@redhat.com, jmario@redhat.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20181228101820.28010-1-jolsa@kernel.org>
References: <20181228101820.28010-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf c2c: Change the default coalesce setup
Git-Commit-ID: 423701a0c8d754d9a39547f6c48904347e4f1eca
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

Commit-ID:  423701a0c8d754d9a39547f6c48904347e4f1eca
Gitweb:     https://git.kernel.org/tip/423701a0c8d754d9a39547f6c48904347e4f1eca
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 28 Dec 2018 11:18:19 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:06 -0300

perf c2c: Change the default coalesce setup

Joe suggested to have the coalesce default set just to 'iaddr', because
it's easier to read on the default 'perf c2c report' output.

By removing the "pid" field from the default -c/--coalesce option, the
'perf c2c' report will group all the relevant PIDs under the instruction
address ('iaddr') bucket. User can always run "-c pid,iaddr" for a more
fine grained output on particular PIDs.

Suggested-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181228101820.28010-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f3aa9d02a5ab..964f3f5ef420 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -68,7 +68,7 @@ struct c2c_hist_entry {
 	struct hist_entry	he;
 };
 
-static char const *coalesce_default = "pid,iaddr";
+static char const *coalesce_default = "iaddr";
 
 struct perf_c2c {
 	struct perf_tool	tool;
