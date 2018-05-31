Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeEaKq0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:46:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48299 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754562AbeEaKqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:46:23 -0400
Date: Thu, 31 May 2018 03:46:06 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-j7o92acm2vnxjv70y4o3swoc@git.kernel.org>
Cc: kim.phillips@arm.com, dsahern@gmail.com, wangnan0@huawei.com,
        tmricht@linux.ibm.com, lakshmana@google.com, mingo@kernel.org,
        namhyung@kernel.org, eranian@google.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, sque@chromium.org, jolsa@kernel.org,
        brueckner@linux.vnet.ibm.com, acme@redhat.com, hekuang@huawei.com,
        yao.jin@linux.intel.com, ak@linux.intel.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: dsahern@gmail.com, kim.phillips@arm.com, tmricht@linux.ibm.com,
        lakshmana@google.com, wangnan0@huawei.com, eranian@google.com,
        mingo@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, sque@chromium.org, jolsa@kernel.org,
        brueckner@linux.vnet.ibm.com, acme@redhat.com, hekuang@huawei.com,
        yao.jin@linux.intel.com, ak@linux.intel.com, hpa@zytor.com,
        tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix perf.data format description of
 NRCPUS header
Git-Commit-ID: 18a7057420f8b67f15d17087bf5c0863db752c8b
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

Commit-ID:  18a7057420f8b67f15d17087bf5c0863db752c8b
Gitweb:     https://git.kernel.org/tip/18a7057420f8b67f15d17087bf5c0863db752c8b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 25 May 2018 16:37:36 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 30 May 2018 15:40:26 -0300

perf tools: Fix perf.data format description of NRCPUS header

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
