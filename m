Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D80C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCE021E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpBR0Gf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCE021E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbeHIRZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIRZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:19 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE26B21EA2;
        Thu,  9 Aug 2018 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826802;
        bh=5B9X8R3rpEr32AbUcJ3g/XNTs1CAZ964YP6BKf9ZxCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpBR0Gf9DrxcoOkB4JqLiH2N1Ol5u7TYYKQ2LYj7UN0abLy8LEulX6N1VN3Axd7y9
         8UYBNPsRUbm8+PiFHchZWzQw/5sniVrw11fZcNZd9Pe8myxHJBnqePy4mPsymng60Q
         DBv4mlsmnoJTTEtpvUaQYHGgwII0kqYRjfAec2WA=
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
Subject: [PATCH 18/44] perf annotate: Rename hist to sym_hist in annotation__calc_percent
Date:   Thu,  9 Aug 2018 11:57:56 -0300
Message-Id: <20180809145822.21391-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We will need to bring in 'struct hists' variable in this scope, so it's
better we do this rename first.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 8bd278a71004..728603636adc 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1753,7 +1753,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	goto out_free_command;
 }
 
-static void calc_percent(struct sym_hist *hist,
+static void calc_percent(struct sym_hist *sym_hist,
 			 struct annotation_data *data,
 			 s64 offset, s64 end)
 {
@@ -1761,15 +1761,15 @@ static void calc_percent(struct sym_hist *hist,
 	u64 period = 0;
 
 	while (offset < end) {
-		hits   += hist->addr[offset].nr_samples;
-		period += hist->addr[offset].period;
+		hits   += sym_hist->addr[offset].nr_samples;
+		period += sym_hist->addr[offset].period;
 		++offset;
 	}
 
-	if (hist->nr_samples) {
+	if (sym_hist->nr_samples) {
 		data->he.period     = period;
 		data->he.nr_samples = hits;
-		data->percent = 100.0 * hits / hist->nr_samples;
+		data->percent = 100.0 * hits / sym_hist->nr_samples;
 	}
 }
 
@@ -1790,12 +1790,12 @@ static void annotation__calc_percent(struct annotation *notes,
 
 		for (i = 0; i < al->data_nr; i++) {
 			struct annotation_data *data;
-			struct sym_hist *hist;
+			struct sym_hist *sym_hist;
 
-			hist = annotation__histogram(notes, evsel->idx + i);
+			sym_hist = annotation__histogram(notes, evsel->idx + i);
 			data = &al->data[i];
 
-			calc_percent(hist, data, al->offset, end);
+			calc_percent(sym_hist, data, al->offset, end);
 		}
 	}
 }
-- 
2.14.4

