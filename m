Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id plc1FyPmGFvgMgAAmS7hNA
	; Thu, 07 Jun 2018 08:02:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ED5F6607E7; Thu,  7 Jun 2018 08:02:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 526A460452;
	Thu,  7 Jun 2018 08:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 526A460452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeFGICq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:02:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34269 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeFGICn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:02:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5782UvK2122165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:02:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5782Uds2122162;
        Thu, 7 Jun 2018 01:02:30 -0700
Date: Thu, 7 Jun 2018 01:02:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-i9wycjdxh0fwhryu55lmafks@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, jolsa@kernel.org, kjlx@templeofstupid.com,
        hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
        wangnan0@huawei.com, adrian.hunter@intel.com, dsahern@gmail.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, kjlx@templeofstupid.com,
          dsahern@gmail.com, adrian.hunter@intel.com, acme@redhat.com,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: No need to check if the argument to
 __get() function is NULL
Git-Commit-ID: 362379aad56fdc627a49e30d12c3ece900221898
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

Commit-ID:  362379aad56fdc627a49e30d12c3ece900221898
Gitweb:     https://git.kernel.org/tip/362379aad56fdc627a49e30d12c3ece900221898
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 11:20:39 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:50 -0300

perf tools: No need to check if the argument to __get() function is NULL

Those functions always check if the argument is NULL before trying to
grab a reference count, and also will return the received object, so, to
make code more compact, no need to check for NULL.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-i9wycjdxh0fwhryu55lmafks@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c | 3 +--
 tools/perf/util/hist.c     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index c0065923a525..99de91698de1 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -81,8 +81,7 @@ static int parse_probe_event(const char *str)
 		params.target_used = true;
 	}
 
-	if (params.nsi)
-		pev->nsi = nsinfo__get(params.nsi);
+	pev->nsi = nsinfo__get(params.nsi);
 
 	/* Parse a perf-probe command into event */
 	ret = parse_perf_probe_command(str, pev);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 4d602fba40b2..95333b068109 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1039,7 +1039,7 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	int err, err2;
 	struct map *alm = NULL;
 
-	if (al && al->map)
+	if (al)
 		alm = map__get(al->map);
 
 	err = sample__resolve_callchain(iter->sample, &callchain_cursor, &iter->parent,
