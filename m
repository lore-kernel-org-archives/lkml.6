Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95D3ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A08720665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A08720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJZQST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:18:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeJZQSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:18:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7gEgs139308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:42:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7gErP139305;
        Fri, 26 Oct 2018 00:42:14 -0700
Date:   Fri, 26 Oct 2018 00:42:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-031c2a004ba75a4f8f2a6d0a7ca6f2fe5912de22@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, jolsa@redhat.com, hpa@zytor.com,
        acme@redhat.com, linux-kernel@vger.kernel.org
Reply-To: jolsa@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
          mingo@kernel.org, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com
In-Reply-To: <20181001062853.28285-13-adrian.hunter@intel.com>
References: <20181001062853.28285-13-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: call-graph-from-sql.py:
 Rename to exported-sql-viewer.py
Git-Commit-ID: 031c2a004ba75a4f8f2a6d0a7ca6f2fe5912de22
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  031c2a004ba75a4f8f2a6d0a7ca6f2fe5912de22
Gitweb:     https://git.kernel.org/tip/031c2a004ba75a4f8f2a6d0a7ca6f2fe5912de22
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 1 Oct 2018 09:28:46 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Oct 2018 14:26:44 -0300

perf scripts python: call-graph-from-sql.py: Rename to exported-sql-viewer.py

Additional reports will be added to the script so rename to reflect the
more general purpose.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-13-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/intel-pt.txt                               | 2 +-
 tools/perf/scripts/python/export-to-postgresql.py                   | 2 +-
 tools/perf/scripts/python/export-to-sqlite.py                       | 2 +-
 .../python/{call-graph-from-sql.py => exported-sql-viewer.py}       | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 76971d2e4164..115eaacc455f 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -106,7 +106,7 @@ in transaction, respectively.
 While it is possible to create scripts to analyze the data, an alternative
 approach is available to export the data to a sqlite or postgresql database.
 Refer to script export-to-sqlite.py or export-to-postgresql.py for more details,
-and to script call-graph-from-sql.py for an example of using the database.
+and to script exported-sql-viewer.py for an example of using the database.
 
 There is also script intel-pt-events.py which provides an example of how to
 unpack the raw data for power events and PTWRITE.
diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index e46f51b17513..0564dd7377f2 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -59,7 +59,7 @@ import datetime
 #	pt_example=# \q
 #
 # An example of using the database is provided by the script
-# call-graph-from-sql.py.  Refer to that script for details.
+# exported-sql-viewer.py.  Refer to that script for details.
 #
 # Tables:
 #
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index e4bb82c8aba9..245caf2643ed 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -40,7 +40,7 @@ import datetime
 #	sqlite> .quit
 #
 # An example of using the database is provided by the script
-# call-graph-from-sql.py.  Refer to that script for details.
+# exported-sql-viewer.py.  Refer to that script for details.
 #
 # The database structure is practically the same as created by the script
 # export-to-postgresql.py. Refer to that script for details.  A notable
diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/exported-sql-viewer.py
old mode 100644
new mode 100755
similarity index 98%
rename from tools/perf/scripts/python/call-graph-from-sql.py
rename to tools/perf/scripts/python/exported-sql-viewer.py
index ee1085169a3e..03e7a1de7f31
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -10,12 +10,12 @@
 # Following on from the example in the export scripts, a
 # call-graph can be displayed for the pt_example database like this:
 #
-#	python tools/perf/scripts/python/call-graph-from-sql.py pt_example
+#	python tools/perf/scripts/python/exported-sql-viewer.py pt_example
 #
 # Note that for PostgreSQL, this script supports connecting to remote databases
 # by setting hostname, port, username, password, and dbname e.g.
 #
-#	python tools/perf/scripts/python/call-graph-from-sql.py "hostname=myhost username=myuser password=mypassword dbname=pt_example"
+#	python tools/perf/scripts/python/exported-sql-viewer.py "hostname=myhost username=myuser password=mypassword dbname=pt_example"
 #
 # The result is a GUI window with a tree representing a context-sensitive
 # call-graph.  Expanding a couple of levels of the tree and adjusting column
@@ -365,7 +365,7 @@ class DBRef():
 
 def Main():
 	if (len(sys.argv) < 2):
-		print >> sys.stderr, "Usage is: call-graph-from-sql.py <database name>"
+		print >> sys.stderr, "Usage is: exported-sql-viewer.py <database name>"
 		raise Exception("Too few arguments")
 
 	dbname = sys.argv[1]
