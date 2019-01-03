Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC0EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FF521479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfACNTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:19:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfACNTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:19:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DJS3S1384913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:19:28 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DJSdn1384910;
        Thu, 3 Jan 2019 05:19:28 -0800
Date:   Thu, 3 Jan 2019 05:19:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c4a75bb9488a9f7b3c7e79017609529d1aa5deab@git.kernel.org>
Cc:     peterz@infradead.org, jolsa@kernel.org, tglx@linutronix.de,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, jmario@redhat.com, hpa@zytor.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, jolsa@kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          mingo@kernel.org, jmario@redhat.com, hpa@zytor.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20181228101820.28010-2-jolsa@kernel.org>
References: <20181228101820.28010-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf c2c: Increase the HITM ratio limit for
 displayed cachelines
Git-Commit-ID: c4a75bb9488a9f7b3c7e79017609529d1aa5deab
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

Commit-ID:  c4a75bb9488a9f7b3c7e79017609529d1aa5deab
Gitweb:     https://git.kernel.org/tip/c4a75bb9488a9f7b3c7e79017609529d1aa5deab
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 28 Dec 2018 11:18:20 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:07 -0300

perf c2c: Increase the HITM ratio limit for displayed cachelines

The cachelines being reported are the ones with percentages all the way
down to 0.05%.  That makes for very long output files. Raising that to
0.1%.  The user can always specify --show-all if they want all the
cachelines with hits.

Suggested-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181228101820.28010-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 964f3f5ef420..d340d2e42776 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1878,7 +1878,7 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
 	return hpp_list__parse(&c2c_hists->list, output, sort);
 }
 
-#define DISPLAY_LINE_LIMIT  0.0005
+#define DISPLAY_LINE_LIMIT  0.001
 
 static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 {
