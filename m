Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JWOgJpvoGFvuUAAAmS7hNA
	; Thu, 07 Jun 2018 08:11:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 88AD9608B8; Thu,  7 Jun 2018 08:11:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E88EB607E7;
	Thu,  7 Jun 2018 08:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E88EB607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbeFGILF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:11:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57023 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeFGILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:11:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578ApiO2124744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:10:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578Apdj2124741;
        Thu, 7 Jun 2018 01:10:51 -0700
Date: Thu, 7 Jun 2018 01:10:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-irhzpfmgdaf6cyk0uqqexoh9@git.kernel.org>
Cc: mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
        tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com
Reply-To: wangnan0@huawei.com, hpa@zytor.com, tglx@linutronix.de,
          adrian.hunter@intel.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, dsahern@gmail.com, acme@redhat.com,
          mingo@kernel.org, jolsa@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf srcline: Make hist_entry srcline helper
 consistent with map's
Git-Commit-ID: 6a53da05c433284252c9363043bf3d8a5789cfca
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

Commit-ID:  6a53da05c433284252c9363043bf3d8a5789cfca
Gitweb:     https://git.kernel.org/tip/6a53da05c433284252c9363043bf3d8a5789cfca
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 11:06:58 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:53 -0300

perf srcline: Make hist_entry srcline helper consistent with map's

No need to have "get_srcline", plain hist_entry__srcline() is enough and
shorter.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-irhzpfmgdaf6cyk0uqqexoh9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 tools/perf/util/sort.c   | 8 ++++----
 tools/perf/util/sort.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 2126bfbcb385..307b3594525f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1976,7 +1976,7 @@ static int filter_cb(struct hist_entry *he)
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
 	if (c2c.show_src && !he->srcline)
-		he->srcline = hist_entry__get_srcline(he);
+		he->srcline = hist_entry__srcline(he);
 
 	calc_width(c2c_he);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 4ab0b4ab24e4..fed2952ab45a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -331,7 +331,7 @@ struct sort_entry sort_sym = {
 
 /* --sort srcline */
 
-char *hist_entry__get_srcline(struct hist_entry *he)
+char *hist_entry__srcline(struct hist_entry *he)
 {
 	return map__srcline(he->ms.map, he->ip, he->ms.sym);
 }
@@ -340,9 +340,9 @@ static int64_t
 sort__srcline_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->srcline)
-		left->srcline = hist_entry__get_srcline(left);
+		left->srcline = hist_entry__srcline(left);
 	if (!right->srcline)
-		right->srcline = hist_entry__get_srcline(right);
+		right->srcline = hist_entry__srcline(right);
 
 	return strcmp(right->srcline, left->srcline);
 }
@@ -351,7 +351,7 @@ static int hist_entry__srcline_snprintf(struct hist_entry *he, char *bf,
 					size_t size, unsigned int width)
 {
 	if (!he->srcline)
-		he->srcline = hist_entry__get_srcline(he);
+		he->srcline = hist_entry__srcline(he);
 
 	return repsep_snprintf(bf, size, "%-.*s", width, he->srcline);
 }
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 9e6896293bbd..f007a26d6f6d 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -292,5 +292,5 @@ int64_t
 sort__daddr_cmp(struct hist_entry *left, struct hist_entry *right);
 int64_t
 sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right);
-char *hist_entry__get_srcline(struct hist_entry *he);
+char *hist_entry__srcline(struct hist_entry *he);
 #endif	/* __PERF_SORT_H */
