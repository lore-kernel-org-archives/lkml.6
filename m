Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F7FC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B72421D62
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F07Gt1s1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B72421D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbeHIRY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeHIRY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:56 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD8D21DEC;
        Thu,  9 Aug 2018 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826779;
        bh=mTyjPRiAvVI8vwFMdKu7Kt6lQeLHMeGgidyXOyqFrok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F07Gt1s1JhUz5mzmiVn03SpDLQCaEJOCm5KCi+2byfi+ka0n5MfrR278mr8KOFTdB
         5rlOF0U2J5mcegtByAfPxcMQ6BRw3Bm2Udjw2AGgymhiuq2CHHvOaK/8RB2oTNdGx7
         IUlqo/hjeGTTr1RZmOLyuiUt/Od60H0N7BkIAOBg=
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
Subject: [PATCH 13/44] perf annotate: Make symbol__annotate_fprintf2() local
Date:   Thu,  9 Aug 2018 11:57:51 -0300
Message-Id: <20180809145822.21391-14-acme@kernel.org>
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
Link: https://lkml.kernel.org/r/20180804130521.11408-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 tools/perf/util/annotate.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f91775b4bc3c..b6e7d0d56622 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2129,7 +2129,7 @@ static void FILE__write_graph(void *fp, int graph)
 	fputs(s, fp);
 }
 
-int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
+static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotation_write_ops ops = {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index a4c0d91907e6..5f24fc9dcc7c 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -340,7 +340,6 @@ int symbol__strerror_disassemble(struct symbol *sym, struct map *map,
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
 			    struct perf_evsel *evsel,
 			    struct annotation_options *options);
-int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
 void annotated_source__purge(struct annotated_source *as);
-- 
2.14.4

