Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeBPTed (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:34:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753721AbeBPTT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA87217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jaecheol Shin <jcgod413@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/41] perf annotate: Add missing arguments in Man page
Date: Fri, 16 Feb 2018 16:17:29 -0300
Message-Id: <20180216191746.11095-25-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaecheol Shin <jcgod413@gmail.com>

Some options must require an argument. But input, stdio-color, cpu have
no them.  So I added it.

Signed-off-by: Jaecheol Shin <jcgod413@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/20180207095205.62715-1-jcgod413@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index c635eab6af54..292809c3c0ca 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -21,7 +21,7 @@ If there is no debug info in the object, then annotated assembly is displayed.
 OPTIONS
 -------
 -i::
---input=::
+--input=<file>::
         Input file name. (default: perf.data unless stdin is a fifo)
 
 -d::
@@ -69,7 +69,7 @@ OPTIONS
 
 --stdio:: Use the stdio interface.
 
---stdio-color::
+--stdio-color=<mode>::
 	'always', 'never' or 'auto', allowing configuring color output
 	via the command line, in addition to via "color.ui" .perfconfig.
 	Use '--stdio-color always' to generate color even when redirecting
@@ -84,7 +84,7 @@ OPTIONS
 --gtk:: Use the GTK interface.
 
 -C::
---cpu:: Only report samples for the list of CPUs provided. Multiple CPUs can
+--cpu=<cpu>:: Only report samples for the list of CPUs provided. Multiple CPUs can
 	be provided as a comma-separated list with no space: 0,1. Ranges of
 	CPUs are specified with -: 0-2. Default is to report samples on all
 	CPUs.
-- 
2.14.3
