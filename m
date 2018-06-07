Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zuQoF13sGFtzcAAAmS7hNA
	; Thu, 07 Jun 2018 08:27:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4DCCC607F7; Thu,  7 Jun 2018 08:27:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B8D856063F;
	Thu,  7 Jun 2018 08:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8D856063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932768AbeFGI1E (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:27:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44451 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932626AbeFGI03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:26:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578P9Hw2128028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:25:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578P9Au2128025;
        Thu, 7 Jun 2018 01:25:09 -0700
Date: Thu, 7 Jun 2018 01:25:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-5f9e0f3158a5cd0ef7bb205b9f1826b2ec1893a9@git.kernel.org>
Cc: ak@linux.intel.com, hpa@zytor.com, acme@redhat.com,
        kan.liang@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, peterz@infradead.org, jolsa@kernel.org,
        mingo@kernel.org
Reply-To: peterz@infradead.org, jolsa@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          kan.liang@linux.intel.com, yao.jin@linux.intel.com,
          ak@linux.intel.com, hpa@zytor.com
In-Reply-To: <1527843663-32288-2-git-send-email-yao.jin@linux.intel.com>
References: <1527843663-32288-2-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Move dsoname code to a new
 function
Git-Commit-ID: 5f9e0f3158a5cd0ef7bb205b9f1826b2ec1893a9
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

Commit-ID:  5f9e0f3158a5cd0ef7bb205b9f1826b2ec1893a9
Gitweb:     https://git.kernel.org/tip/5f9e0f3158a5cd0ef7bb205b9f1826b2ec1893a9
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 1 Jun 2018 17:01:01 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:09 -0300

perf script python: Move dsoname code to a new function

This patch creates a new function get_dsoname() and move the code which
gets the dsoname string to this function.

That's because in next patch, when we process LBR data, we will also
need get_dsoname() to return dsoname for branch from/to.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1527843663-32288-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/scripting-engines/trace-event-python.c    | 23 ++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 7f8afacd08ee..f863e96fb7bc 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -372,6 +372,19 @@ static PyObject *get_field_numeric_entry(struct event_format *event,
 	return obj;
 }
 
+static const char *get_dsoname(struct map *map)
+{
+	const char *dsoname = "[unknown]";
+
+	if (map && map->dso) {
+		if (symbol_conf.show_kernel_path && map->dso->long_name)
+			dsoname = map->dso->long_name;
+		else
+			dsoname = map->dso->name;
+	}
+
+	return dsoname;
+}
 
 static PyObject *python_process_callchain(struct perf_sample *sample,
 					 struct perf_evsel *evsel,
@@ -427,14 +440,8 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 		}
 
 		if (node->map) {
-			struct map *map = node->map;
-			const char *dsoname = "[unknown]";
-			if (map && map->dso) {
-				if (symbol_conf.show_kernel_path && map->dso->long_name)
-					dsoname = map->dso->long_name;
-				else
-					dsoname = map->dso->name;
-			}
+			const char *dsoname = get_dsoname(node->map);
+
 			pydict_set_item_string_decref(pyelem, "dso",
 					_PyUnicode_FromString(dsoname));
 		}
