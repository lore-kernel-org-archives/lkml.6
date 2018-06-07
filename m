Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mvxtA2jmGFs/QgAAmS7hNA
	; Thu, 07 Jun 2018 08:01:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F0DBE607E7; Thu,  7 Jun 2018 08:01:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9D02260452;
	Thu,  7 Jun 2018 08:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D02260452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeFGIBk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:01:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34245 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbeFGIBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:01:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5781RQV2122099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:01:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5781R6u2122096;
        Thu, 7 Jun 2018 01:01:27 -0700
Date: Thu, 7 Jun 2018 01:01:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ds6vdm7clh070512rpydidsc@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
        namhyung@kernel.org, mingo@kernel.org, wangnan0@huawei.com,
        hpa@zytor.com, mhiramat@kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, dsahern@gmail.com
Reply-To: acme@redhat.com, namhyung@kernel.org, mingo@kernel.org,
          wangnan0@huawei.com, hpa@zytor.com, mhiramat@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, adrian.hunter@intel.com, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf probe: Use return of map__get() to make code
 more compact
Git-Commit-ID: f622df5ed768ce7c049af99196c1b7b0a2c0d385
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

Commit-ID:  f622df5ed768ce7c049af99196c1b7b0a2c0d385
Gitweb:     https://git.kernel.org/tip/f622df5ed768ce7c049af99196c1b7b0a2c0d385
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 11:17:34 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:50 -0300

perf probe: Use return of map__get() to make code more compact

The __get() idiom returns a reference count for the object passed, i.e.
all functions of this type return the object passed, so take advantage
of that to make the code more compact.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ds6vdm7clh070512rpydidsc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 3094f11e7d81..f119eb628dbb 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -165,8 +165,7 @@ static struct map *kernel_get_module_map(const char *module)
 		if (strncmp(pos->dso->short_name + 1, module,
 			    pos->dso->short_name_len - 2) == 0 &&
 		    module[pos->dso->short_name_len - 2] == '\0') {
-			map__get(pos);
-			return pos;
+			return map__get(pos);
 		}
 	}
 	return NULL;
