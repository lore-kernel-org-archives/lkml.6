Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE88C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9DE206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9DE206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeJANL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:11:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:10738 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbeJANLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:11:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2018 23:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,326,1534834800"; 
   d="scan'208";a="77466510"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2018 23:31:10 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] perf scripts python: call-graph-from-sql.py: Rename to exported-sql-viewer.py
Date:   Mon,  1 Oct 2018 09:28:46 +0300
Message-Id: <20181001062853.28285-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001062853.28285-1-adrian.hunter@intel.com>
References: <20181001062853.28285-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional reports will be added to the script so rename to reflect the
more general purpose.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/intel-pt.txt                       | 2 +-
 tools/perf/scripts/python/export-to-postgresql.py           | 2 +-
 tools/perf/scripts/python/export-to-sqlite.py               | 2 +-
 .../{call-graph-from-sql.py => exported-sql-viewer.py}      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename tools/perf/scripts/python/{call-graph-from-sql.py => exported-sql-viewer.py} (98%)
 mode change 100644 => 100755

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
index efcaf6cac2eb..ff1e8cc72938 100644
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
index f827bf77e9d2..709f67d89e46 100644
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
-- 
2.17.1

