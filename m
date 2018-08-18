Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F682C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CA820676
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CA820676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeHROl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:41:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44297 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:41:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBXEFh1286714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:33:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBXDD01286711;
        Sat, 18 Aug 2018 04:33:13 -0700
Date:   Sat, 18 Aug 2018 04:33:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d4265b1a1b9b58df9c3bc0a3a7aa5b72c079c77a@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, acme@redhat.com,
        mingo@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org
Reply-To: alexander.shishkin@linux.intel.com, peterz@infradead.org,
          eranian@google.com, namhyung@kernel.org, dsahern@gmail.com,
          mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20180804130521.11408-16-jolsa@kernel.org>
References: <20180804130521.11408-16-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Pass browser percent_type in
 annotate_browser__calc_percent()
Git-Commit-ID: d4265b1a1b9b58df9c3bc0a3a7aa5b72c079c77a
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

Commit-ID:  d4265b1a1b9b58df9c3bc0a3a7aa5b72c079c77a
Gitweb:     https://git.kernel.org/tip/d4265b1a1b9b58df9c3bc0a3a7aa5b72c079c77a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:16 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:51 -0300

perf annotate: Pass browser percent_type in annotate_browser__calc_percent()

Pass browser percent_type in annotate_browser__calc_percent().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index cfe611c28987..2a3a34d450d5 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -318,7 +318,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			double percent;
 
 			percent = annotation_data__percent(&pos->al.data[i],
-							   PERCENT_HITS_LOCAL);
+							   browser->opts->percent_type);
 
 			if (max_percent < percent)
 				max_percent = percent;
