Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4B7C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8762E21878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8762E21878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeHROmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:42:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57459 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:42:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBYK4L1286792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:34:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBYK1S1286789;
        Sat, 18 Aug 2018 04:34:20 -0700
Date:   Sat, 18 Aug 2018 04:34:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-addba8b66f9101b0e55a151fc543ff35990bc8ef@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, hpa@zytor.com,
        mingo@kernel.org, eranian@google.com, peterz@infradead.org,
        jolsa@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, dsahern@gmail.com
Reply-To: peterz@infradead.org, eranian@google.com, mingo@kernel.org,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          dsahern@gmail.com, tglx@linutronix.de, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org
In-Reply-To: <20180804130521.11408-18-jolsa@kernel.org>
References: <20180804130521.11408-18-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Make local period the default
 percent type
Git-Commit-ID: addba8b66f9101b0e55a151fc543ff35990bc8ef
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

Commit-ID:  addba8b66f9101b0e55a151fc543ff35990bc8ef
Gitweb:     https://git.kernel.org/tip/addba8b66f9101b0e55a151fc543ff35990bc8ef
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:18 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:52 -0300

perf annotate: Make local period the default percent type

Currently we display the percentages in annotation output based on
number of samples hits. Switching it to period based percentage by
default, because it corresponds more to the time spent on the line.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 850958bb613a..05d15629afd0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -49,7 +49,7 @@ struct annotation_options annotation__default_options = {
 	.jump_arrows    = true,
 	.annotate_src	= true,
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
-	.percent_type	= PERCENT_HITS_LOCAL,
+	.percent_type	= PERCENT_PERIOD_LOCAL,
 };
 
 static regex_t	 file_lineno;
