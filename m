Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754666AbeEaKdX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754631AbeEaKdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:33:00 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, He Kuang <hekuang@huawei.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Lakshman Annadorai <lakshmana@google.com>,
        Namhyung Kim <namhyung@kernel.org>, Simon Que <sque@chromium.org>,
        Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 7/7] perf tools: Fix perf.data format description of NRCPUS header
Date: Thu, 31 May 2018 07:32:20 -0300
Message-Id: <20180531103220.24684-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180531103220.24684-1-acme@kernel.org>
References: <20180531103220.24684-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In the perf.data HEADER_CPUDESC feadure header we store first the number
of available CPUs in the system, then the number of CPUs at the time of
writing the header, not the other way around.

Reported-by: Thomas-Mich Richter <tmricht@linux.ibm.com>
Acked-by: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Lakshman Annadorai <lakshmana@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-j7o92acm2vnxjv70y4o3swoc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index c57904a526ce..dfb218feaad9 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -111,8 +111,8 @@ A perf_header_string with the CPU architecture (uname -m)
 A structure defining the number of CPUs.
 
 struct nr_cpus {
-       uint32_t nr_cpus_online;
        uint32_t nr_cpus_available; /* CPUs not yet onlined */
+       uint32_t nr_cpus_online;
 };
 
 	HEADER_CPUDESC = 8,
-- 
2.14.3
