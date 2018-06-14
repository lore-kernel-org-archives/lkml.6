Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 69987C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29591208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29591208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeFNGW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:22:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51493 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbeFNGWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:22:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6MGk8763769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:22:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6MGun763766;
        Wed, 13 Jun 2018 23:22:16 -0700
Date:   Wed, 13 Jun 2018 23:22:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b37d33edbf41b532ddd156707c037c6f4784e40b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, milian.wolff@kdab.com,
        jolsa@kernel.org, peterz@infradead.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, frederic@kernel.org,
        namhyung@kernel.org, andi@firstfloor.org, acme@redhat.com,
        dsahern@gmail.com
Reply-To: dsahern@gmail.com, acme@redhat.com, andi@firstfloor.org,
          namhyung@kernel.org, frederic@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, eranian@google.com,
          peterz@infradead.org, jolsa@kernel.org, milian.wolff@kdab.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180606221513.11302-5-jolsa@kernel.org>
References: <20180606221513.11302-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Use only color_fprintf call in
 print_metric_only
Git-Commit-ID: b37d33edbf41b532ddd156707c037c6f4784e40b
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

Commit-ID:  b37d33edbf41b532ddd156707c037c6f4784e40b
Gitweb:     https://git.kernel.org/tip/b37d33edbf41b532ddd156707c037c6f4784e40b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 7 Jun 2018 00:15:07 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 7 Jun 2018 15:58:13 -0300

perf stat: Use only color_fprintf call in print_metric_only

We can call color_fprintf also for non color case, it's handled
properly. This change simplifies following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f1532e3ac7d7..9e7b6f108956 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1008,10 +1008,7 @@ static void print_metric_only(void *ctx, const char *color, const char *fmt,
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(buf, os->evsel, unit);
-	if (color)
-		n = color_fprintf(out, color, fmt, val);
-	else
-		n = fprintf(out, fmt, val);
+	n = color_fprintf(out, color ?: "", fmt, val);
 	if (n > METRIC_ONLY_LEN)
 		n = METRIC_ONLY_LEN;
 	if (mlen < strlen(unit))
