Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeDZFzW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:55:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47517 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753190AbeDZFzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:55:19 -0400
Date: Wed, 25 Apr 2018 22:55:12 -0700
From: tip-bot for Sangwon Hong <tipbot@zytor.com>
Message-ID: <tip-3138a2ef62667b6ac8eb5fb33a9e0b84ec3ab165@git.kernel.org>
Cc: jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        acme@redhat.com, qpakzk@gmail.com, treeze.taeung@gmail.com
Reply-To: namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        qpakzk@gmail.com, treeze.taeung@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com
In-Reply-To: <1524382146-19609-1-git-send-email-qpakzk@gmail.com>
References: <1524382146-19609-1-git-send-email-qpakzk@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mem: Document incorrect and missing options
Git-Commit-ID: 3138a2ef62667b6ac8eb5fb33a9e0b84ec3ab165
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

Commit-ID:  3138a2ef62667b6ac8eb5fb33a9e0b84ec3ab165
Gitweb:     https://git.kernel.org/tip/3138a2ef62667b6ac8eb5fb33a9e0b84ec3ab165
Author:     Sangwon Hong <qpakzk@gmail.com>
AuthorDate: Sun, 22 Apr 2018 16:29:06 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 23 Apr 2018 11:59:18 -0300

perf mem: Document incorrect and missing options

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
