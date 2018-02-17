Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbeBQLbd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:31:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47313 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeBQLbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:31:31 -0500
Date: Sat, 17 Feb 2018 03:31:23 -0800
From: tip-bot for Sangwon Hong <tipbot@zytor.com>
Message-ID: <tip-577980a00063935815a55f461601579fd5e61f59@git.kernel.org>
Cc: qpakzk@gmail.com, treeze.taeung@gmail.com, jolsa@kernel.org,
        acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Reply-To: qpakzk@gmail.com, jolsa@kernel.org, acme@redhat.com,
        treeze.taeung@gmail.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org
In-Reply-To: <1518381517-30766-1-git-send-email-qpakzk@gmail.com>
References: <1518381517-30766-1-git-send-email-qpakzk@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kmem: Document a missing option & an argument
Git-Commit-ID: 577980a00063935815a55f461601579fd5e61f59
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

Commit-ID:  577980a00063935815a55f461601579fd5e61f59
Gitweb:     https://git.kernel.org/tip/577980a00063935815a55f461601579fd5e61f59
Author:     Sangwon Hong <qpakzk@gmail.com>
AuthorDate: Mon, 12 Feb 2018 05:38:36 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:42 -0300

perf kmem: Document a missing option & an argument

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
index 479fc32..85b8ac6 100644
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
