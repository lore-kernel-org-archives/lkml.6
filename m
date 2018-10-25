Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243DDECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D785220847
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8jxNpYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D785220847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeJYToU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbeJYToT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:19 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEA1A20840;
        Thu, 25 Oct 2018 11:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465921;
        bh=QIse9ZX8d/8j4+2E+uk2NURwda2ByK8NKaRnV0SDfmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8jxNpYLjgB+Bk5xWVNUN9Q0XewF/6rzRrM71mddVStxsHxR8yZH0IlfvAaNpB1Id
         Gq12r02mv6P61SzgXv+U2R7/U11yg655dQ+gjq50NOEjJQ9F1xTTXc1qd3bfWYYag9
         Jcd7BtvAGMmTZW53E/T2NfxH+JmC7SulgU3wlq1M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/37] perf scripts python: call-graph-from-sql.py: Rename to exported-sql-viewer.py
Date:   Thu, 25 Oct 2018 08:10:21 -0300
Message-Id: <20181025111031.3440-28-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
-- 
2.14.4

