Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D675C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70442077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70442077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJNXLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35631 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbeJNXLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:41 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0004cd-KG; Sun, 14 Oct 2018 16:30:18 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-00009J-CU; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jiri Olsa" <jolsa@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "David Ahern" <dsahern@gmail.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.798531679@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 012/366] perf record: Put new line after target
 override warning
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit c3dec27b7f70a9ad5f777d943d51ecdfcd9824d0 upstream.

There's no new-line after target-override warning, now:

  $ perf record -a --per-thread
  Warning:
  SYSTEM/CPU switch overriding PER-THREAD^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.705 MB perf.data (2939 samples) ]

with patch:

  $ perf record -a --per-thread
  Warning:
  SYSTEM/CPU switch overriding PER-THREAD
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.705 MB perf.data (2939 samples) ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 16ad2ffb822c ("perf tools: Introduce perf_target__strerror()")
Link: http://lkml.kernel.org/r/20180206181813.10943-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -942,7 +942,7 @@ int cmd_record(int argc, const char **ar
 	err = target__validate(&rec->opts.target);
 	if (err) {
 		target__strerror(&rec->opts.target, err, errbuf, BUFSIZ);
-		ui__warning("%s", errbuf);
+		ui__warning("%s\n", errbuf);
 	}
 
 	err = target__parse_uid(&rec->opts.target);

