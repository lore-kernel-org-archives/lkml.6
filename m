Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755827AbeDYQAp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755768AbeDYQAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:00:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EFC217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Sangwon Hong <qpakzk@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/12] perf mem: Document incorrect and missing options
Date: Wed, 25 Apr 2018 13:00:03 -0300
Message-Id: <20180425160008.3407-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425160008.3407-1-acme@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sangwon Hong <qpakzk@gmail.com>

Several options were incorrectly described, some lacked describing
required arguments while others were simply not documented, fix it.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1524382146-19609-1-git-send-email-qpakzk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt | 41 +++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 8806ed5f3802..f8d2167cf3e7 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -28,29 +28,46 @@ OPTIONS
 <command>...::
 	Any command you can specify in a shell.
 
+-i::
+--input=<file>::
+	Input file name.
+
 -f::
 --force::
 	Don't do ownership validation
 
 -t::
---type=::
+--type=<type>::
 	Select the memory operation type: load or store (default: load,store)
 
 -D::
---dump-raw-samples=::
+--dump-raw-samples::
 	Dump the raw decoded samples on the screen in a format that is easy to parse with
 	one sample per line.
 
 -x::
---field-separator::
+--field-separator=<separator>::
 	Specify the field separator used when dump raw samples (-D option). By default,
 	The separator is the space character.
 
 -C::
---cpu-list::
-	Restrict dump of raw samples to those provided via this option. Note that the same
-	option can be passed in record mode. It will be interpreted the same way as perf
-	record.
+--cpu=<cpu>::
+	Monitor only on the list of CPUs provided. Multiple CPUs can be provided as a
+        comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-2. Default
+        is to monitor all CPUS.
+-U::
+--hide-unresolved::
+	Only display entries resolved to a symbol.
+
+-p::
+--phys-data::
+	Record/Report sample physical addresses
+
+RECORD OPTIONS
+--------------
+-e::
+--event <event>::
+	Event selector. Use 'perf mem record -e list' to list available events.
 
 -K::
 --all-kernel::
@@ -60,12 +77,12 @@ OPTIONS
 --all-user::
 	Configure all used events to run in user space.
 
---ldload::
-	Specify desired latency for loads event.
+-v::
+--verbose::
+	Be more verbose (show counter open errors, etc)
 
--p::
---phys-data::
-	Record/Report sample physical addresses
+--ldlat <n>::
+	Specify desired latency for loads event.
 
 In addition, for report all perf report options are valid, and for record
 all perf record options.
-- 
2.14.3
