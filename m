Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4MJ9DUnmGFtIQgAAmS7hNA
	; Thu, 07 Jun 2018 08:01:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 91CC36089E; Thu,  7 Jun 2018 08:01:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C49496063F;
	Thu,  7 Jun 2018 08:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C49496063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeFGIBL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:01:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50049 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeFGIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:01:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5780rnp2122046
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:00:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5780r3s2122043;
        Thu, 7 Jun 2018 01:00:53 -0700
Date: Thu, 7 Jun 2018 01:00:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mgnzqbi46gucs48d7bzfwr55@git.kernel.org>
Cc: dsahern@gmail.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, wangnan0@huawei.com, namhyung@kernel.org,
        adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, wangnan0@huawei.com, tglx@linutronix.de,
          namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com,
          dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Remove dead quote.[ch] code
Git-Commit-ID: 4f5aeecd0d1233cbd0ccd60f4d6701404884471a
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

Commit-ID:  4f5aeecd0d1233cbd0ccd60f4d6701404884471a
Gitweb:     https://git.kernel.org/tip/4f5aeecd0d1233cbd0ccd60f4d6701404884471a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 10:49:25 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:50 -0300

perf tools: Remove dead quote.[ch] code

In c68677014bac ("perf tools: Remove support for command aliases") we
removed the only remaining use of a function provided by these files, so
ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mgnzqbi46gucs48d7bzfwr55@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.c       |  1 -
 tools/perf/util/Build   |  1 -
 tools/perf/util/quote.c | 62 -------------------------------------------------
 tools/perf/util/quote.h | 31 -------------------------
 4 files changed, 95 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 51c81509a315..a11cb006f968 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -12,7 +12,6 @@
 #include "util/env.h"
 #include <subcmd/exec-cmd.h>
 #include "util/config.h"
-#include "util/quote.h"
 #include <subcmd/run-command.h>
 #include "util/parse-events.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 5d4c45b76895..b604ef334dc9 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -24,7 +24,6 @@ libperf-y += libstring.o
 libperf-y += bitmap.o
 libperf-y += hweight.o
 libperf-y += smt.o
-libperf-y += quote.o
 libperf-y += strbuf.o
 libperf-y += string.o
 libperf-y += strlist.o
diff --git a/tools/perf/util/quote.c b/tools/perf/util/quote.c
deleted file mode 100644
index 22eaa201aa27..000000000000
--- a/tools/perf/util/quote.c
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-#include <stdlib.h>
-#include "strbuf.h"
-#include "quote.h"
-#include "util.h"
-
-/* Help to copy the thing properly quoted for the shell safety.
- * any single quote is replaced with '\'', any exclamation point
- * is replaced with '\!', and the whole thing is enclosed in a
- *
- * E.g.
- *  original     sq_quote     result
- *  name     ==> name      ==> 'name'
- *  a b      ==> a b       ==> 'a b'
- *  a'b      ==> a'\''b    ==> 'a'\''b'
- *  a!b      ==> a'\!'b    ==> 'a'\!'b'
- */
-static inline int need_bs_quote(char c)
-{
-	return (c == '\'' || c == '!');
-}
-
-static int sq_quote_buf(struct strbuf *dst, const char *src)
-{
-	char *to_free = NULL;
-	int ret;
-
-	if (dst->buf == src)
-		to_free = strbuf_detach(dst, NULL);
-
-	ret = strbuf_addch(dst, '\'');
-	while (!ret && *src) {
-		size_t len = strcspn(src, "'!");
-		ret = strbuf_add(dst, src, len);
-		src += len;
-		while (!ret && need_bs_quote(*src))
-			ret = strbuf_addf(dst, "'\\%c\'", *src++);
-	}
-	if (!ret)
-		ret = strbuf_addch(dst, '\'');
-	free(to_free);
-
-	return ret;
-}
-
-int sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
-{
-	int i, ret;
-
-	/* Copy into destination buffer. */
-	ret = strbuf_grow(dst, 255);
-	for (i = 0; !ret && argv[i]; ++i) {
-		ret = strbuf_addch(dst, ' ');
-		if (ret)
-			break;
-		ret = sq_quote_buf(dst, argv[i]);
-		if (maxlen && dst->len > maxlen)
-			return -ENOSPC;
-	}
-	return ret;
-}
diff --git a/tools/perf/util/quote.h b/tools/perf/util/quote.h
deleted file mode 100644
index 274bf26d3511..000000000000
--- a/tools/perf/util/quote.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_QUOTE_H
-#define __PERF_QUOTE_H
-
-#include <stddef.h>
-
-/* Help to copy the thing properly quoted for the shell safety.
- * any single quote is replaced with '\'', any exclamation point
- * is replaced with '\!', and the whole thing is enclosed in a
- * single quote pair.
- *
- * For example, if you are passing the result to system() as an
- * argument:
- *
- * sprintf(cmd, "foobar %s %s", sq_quote(arg0), sq_quote(arg1))
- *
- * would be appropriate.  If the system() is going to call ssh to
- * run the command on the other side:
- *
- * sprintf(cmd, "git-diff-tree %s %s", sq_quote(arg0), sq_quote(arg1));
- * sprintf(rcmd, "ssh %s %s", sq_util/quote.host), sq_quote(cmd));
- *
- * Note that the above examples leak memory!  Remember to free result from
- * sq_quote() in a real application.
- */
-
-struct strbuf;
-
-int sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
-
-#endif /* __PERF_QUOTE_H */
