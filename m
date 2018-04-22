Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbeDVH3V (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 03:29:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41347 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeDVH3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 03:29:19 -0400
X-Google-Smtp-Source: AIpwx48FSsXSj7kkWi8AebtAGRzx/YSP6MPAXbise5KPBe9xiUWv+RjqCEgrNLshNtY7LFe5kaRW4A==
From: Sangwon Hong <qpakzk@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, Sangwon Hong <qpakzk@gmail.com>
Subject: [PATCH] perf mem: Document uncorrect and missing options
Date: Sun, 22 Apr 2018 16:29:06 +0900
Message-Id: <1524382146-19609-1-git-send-email-qpakzk@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
---
 tools/perf/Documentation/perf-mem.txt | 41 +++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index b021141..139f30f 100644
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
 
 SEE ALSO
 --------
-- 
2.7.4
