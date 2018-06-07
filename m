Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lJiqIWPnGFswRwAAmS7hNA
	; Thu, 07 Jun 2018 08:05:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 68E5F607F7; Thu,  7 Jun 2018 08:05:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D0002607DC;
	Thu,  7 Jun 2018 08:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0002607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeFGIFu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:05:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbeFGIFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:05:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5785dY12123961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:05:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5785dfq2123958;
        Thu, 7 Jun 2018 01:05:39 -0700
Date: Thu, 7 Jun 2018 01:05:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2se2v7rrjil0kwqywks04ey2@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        acme@redhat.com, mingo@kernel.org, dsahern@gmail.com,
        adrian.hunter@intel.com, namhyung@kernel.org, wangnan0@huawei.com,
        hpa@zytor.com
Reply-To: mingo@kernel.org, acme@redhat.com, dsahern@gmail.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, adrian.hunter@intel.com,
          namhyung@kernel.org, wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: __symbol__inc_addr_samples() needs
 just annotated_source
Git-Commit-ID: e1a91a834d6e1b6616b76b0ba22e7e11d5592c3b
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

Commit-ID:  e1a91a834d6e1b6616b76b0ba22e7e11d5592c3b
Gitweb:     https://git.kernel.org/tip/e1a91a834d6e1b6616b76b0ba22e7e11d5592c3b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 16:28:29 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:51 -0300

perf annotate: __symbol__inc_addr_samples() needs just annotated_source

It only operates on the histograms, so no need for the encompassing
'struct annotation'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2se2v7rrjil0kwqywks04ey2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 +++---
 tools/perf/util/annotate.h | 8 ++++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a6fa49bf879b..a5a6d686004e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -819,7 +819,7 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
 }
 
 static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
-				      struct annotation *notes, int evidx, u64 addr,
+				      struct annotated_source *src, int evidx, u64 addr,
 				      struct perf_sample *sample)
 {
 	unsigned offset;
@@ -835,7 +835,7 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	}
 
 	offset = addr - sym->start;
-	h = annotation__histogram(notes, evidx);
+	h = annotated_source__histogram(src, evidx);
 	h->nr_samples++;
 	h->addr[offset].nr_samples++;
 	h->period += sample->period;
@@ -874,7 +874,7 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	notes = symbol__get_annotation(sym, false);
 	if (notes == NULL)
 		return -ENOMEM;
-	return __symbol__inc_addr_samples(sym, map, notes, evsel->idx, addr, sample);
+	return __symbol__inc_addr_samples(sym, map, notes->src, evsel->idx, addr, sample);
 }
 
 static int symbol__account_cycles(u64 addr, u64 start,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 94b60e34c3a7..2a73f9084930 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -267,10 +267,14 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 void annotation__update_column_widths(struct annotation *notes);
 void annotation__init_column_widths(struct annotation *notes, struct symbol *sym);
 
+static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src, int idx)
+{
+	return ((void *)src->histograms) + (src->sizeof_sym_hist * idx);
+}
+
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
-	return (((void *)notes->src->histograms) +
-	 	(notes->src->sizeof_sym_hist * idx));
+	return annotated_source__histogram(notes->src, idx);
 }
 
 static inline struct annotation *symbol__annotation(struct symbol *sym)
