Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeEUIxz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:53:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33087 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbeEUIxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:53:48 -0400
X-Google-Smtp-Source: AB8JxZpwxUD2cElAfq6PTAKRCXowDQc8bopKRd6oACbRojga41/2yROXVDPzlwgMyW43yVzcfJahjQ==
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tor Jeremiassen <tor@ti.com>,
        mike.leach@linaro.org, kim.phillips@arm.com,
        Robert Walker <Robert.Walker@arm.com>, coresight@lists.linaro.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [RFT v2 2/4] perf script python: Add addr into perf sample dict
Date: Mon, 21 May 2018 16:52:26 +0800
Message-Id: <1526892748-326-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526892748-326-1-git-send-email-leo.yan@linaro.org>
References: <1526892748-326-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM CoreSight auxtrace uses 'sample->addr' to record the target address
for branch instructions, so the data of 'sample->addr' is required for
tracing data analysis.

This commit collects data of 'sample->addr' into perf sample dict,
finally can be used for python script for parsing event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 10dd5fc..7f8afac 100644
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
2.7.4
