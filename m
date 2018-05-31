Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754653AbeEaKdH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754622AbeEaKc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:32:56 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Walker <robert.walker@arm.com>, Tor Jeremiassen <tor@ti.com>,
        coresight@lists.linaro.org, kim.phillips@arm.co,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/7] perf script python: Add addr into perf sample dict
Date: Thu, 31 May 2018 07:32:19 -0300
Message-Id: <20180531103220.24684-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180531103220.24684-1-acme@kernel.org>
References: <20180531103220.24684-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

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
 
-- 
2.14.3
