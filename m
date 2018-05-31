Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbeEaKqP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:46:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55265 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754521AbeEaKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:46:13 -0400
Date: Thu, 31 May 2018 03:45:37 -0700
From: tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-943f32a0e8a4ea513dc68b00720a6c65842135e8@git.kernel.org>
Cc: mathieu.poirier@linaro.org, mike.leach@linaro.org, hpa@zytor.com,
        tglx@linutronix.de, robert.walker@arm.com, tor@ti.com,
        peterz@infradead.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@redhat.com,
        leo.yan@linaro.org, corbet@lwn.net, alexander.shishkin@linux.intel.com,
        acme@redhat.com
Reply-To: mingo@kernel.org, jolsa@redhat.com, leo.yan@linaro.org,
        corbet@lwn.net, acme@redhat.com, alexander.shishkin@linux.intel.com,
        tor@ti.com, robert.walker@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mathieu.poirier@linaro.org, mike.leach@linaro.org
In-Reply-To: <1527497103-3593-3-git-send-email-leo.yan@linaro.org>
References: <1527497103-3593-3-git-send-email-leo.yan@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Add addr into perf sample
 dict
Git-Commit-ID: 943f32a0e8a4ea513dc68b00720a6c65842135e8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  943f32a0e8a4ea513dc68b00720a6c65842135e8
Gitweb:     https://git.kernel.org/tip/943f32a0e8a4ea513dc68b00720a6c65842135e8
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Mon, 28 May 2018 16:45:01 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 30 May 2018 15:39:31 -0300

perf script python: Add addr into perf sample dict

ARM CoreSight auxtrace uses 'sample->addr' to record the target address
for branch instructions, so the data of 'sample->addr' is required for
tracing data analysis.

This commit collects data of 'sample->addr' into perf sample dict,
finally can be used for python script for parsing event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Tor Jeremiassen <tor@ti.com>
Cc: coresight@lists.linaro.org
Cc: kim.phillips@arm.co
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/1527497103-3593-3-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 10dd5fce082b..7f8afacd08ee 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -531,6 +531,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyLong_FromUnsignedLongLong(sample->period));
 	pydict_set_item_string_decref(dict_sample, "phys_addr",
 			PyLong_FromUnsignedLongLong(sample->phys_addr));
+	pydict_set_item_string_decref(dict_sample, "addr",
+			PyLong_FromUnsignedLongLong(sample->addr));
 	set_sample_read_in_dict(dict_sample, sample, evsel);
 	pydict_set_item_string_decref(dict, "sample", dict_sample);
 
