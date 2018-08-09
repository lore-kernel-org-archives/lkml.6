Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E9C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F42A2183D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE72MtwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F42A2183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbeHIRZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIRZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:00 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B0A21E21;
        Thu,  9 Aug 2018 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826783;
        bh=+UHF9rxzC4DplcL0gdoq5F/iPcZ8XQkrJihgOEm+reY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fE72MtwVyzOqOan54OEpObPIRQ5HGbNCirQDo+Ps12F2OJGn9wd0tB7is04Orf2gg
         iN9kehGjF0QIKxzwWYLnMqZjohWsDwU4Z3X+KSOBgIe0pDNEBKoQwaCxemRs0WwDdd
         72D8RQtSQ3cUx3Damb0tz5/HcMo2R7ch6dEAAybA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/44] perf annotate: Make annotation_line__max_percent static
Date:   Thu,  9 Aug 2018 11:57:52 -0300
Message-Id: <20180809145822.21391-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no outside user of it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 ++-
 tools/perf/util/annotate.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b6e7d0d56622..956c9b19d81c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2441,7 +2441,8 @@ bool ui__has_annotation(void)
 }
 
 
-double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes)
+static double annotation_line__max_percent(struct annotation_line *al,
+					   struct annotation *notes)
 {
 	double percent_max = 0.0;
 	int i;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5f24fc9dcc7c..a93502d0c582 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -169,7 +169,6 @@ struct annotation_write_ops {
 	void (*write_graph)(void *obj, int graph);
 };
 
-double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes);
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
 			    struct annotation_write_ops *ops);
 
-- 
2.14.4

