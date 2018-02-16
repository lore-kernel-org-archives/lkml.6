Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbeBPTTl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:19:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753744AbeBPTT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110B9217D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sangwon Hong <qpakzk@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/41] perf kmem: Document a missing option & an argument
Date: Fri, 16 Feb 2018 16:17:30 -0300
Message-Id: <20180216191746.11095-26-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sangwon Hong <qpakzk@gmail.com>

First, 'perf kmem' has a '--force' option, but didn't document it on the
man page. So add it.

Second, the '--time' option has to get a value, but isn't documented on
the man page. Describe it.

Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: http://lkml.kernel.org/r/1518381517-30766-1-git-send-email-qpakzk@gmail.com
[ Add blank like after --force block, as requested by Namhyung ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-kmem.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-kmem.txt b/tools/perf/Documentation/perf-kmem.txt
index 479fc3261a50..85b8ac695c87 100644
--- a/tools/perf/Documentation/perf-kmem.txt
+++ b/tools/perf/Documentation/perf-kmem.txt
@@ -25,6 +25,10 @@ OPTIONS
 --input=<file>::
 	Select the input file (default: perf.data unless stdin is a fifo)
 
+-f::
+--force::
+	Don't do ownership validation
+
 -v::
 --verbose::
         Be more verbose. (show symbol address, etc)
@@ -61,7 +65,7 @@ OPTIONS
 	default, but this option shows live (currently allocated) pages
 	instead.  (This option works with --page option only)
 
---time::
+--time=<start>,<stop>::
 	Only analyze samples within given time window: <start>,<stop>. Times
 	have the format seconds.microseconds. If start is not given (i.e., time
 	string is ',x.y') then analysis starts at the beginning of the file. If
-- 
2.14.3
