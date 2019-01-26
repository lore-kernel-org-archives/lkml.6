Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E00C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED31217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfAZKJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:09:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:09:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QA91dO513460
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:09:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QA915i513457;
        Sat, 26 Jan 2019 02:09:01 -0800
Date:   Sat, 26 Jan 2019 02:09:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-a38352de4495a6a4662609a560b2db4b03d6b352@git.kernel.org>
Cc:     corbet@lwn.net, tglx@linutronix.de, hpa@zytor.com,
        jolsa@kernel.org, ravi.bangoria@linux.ibm.com, fweisbec@gmail.com,
        adrian.hunter@intel.com, tonyj@suse.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, s1seetee@linux.vnet.ibm.com,
        acme@redhat.com
Reply-To: s1seetee@linux.vnet.ibm.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, tonyj@suse.de,
          adrian.hunter@intel.com, fweisbec@gmail.com,
          ravi.bangoria@linux.ibm.com, jolsa@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, corbet@lwn.net
In-Reply-To: <20190124005229.16146-6-tonyj@suse.de>
References: <20190124005229.16146-6-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script python: Remove explicit shebang from
 Python scripts
Git-Commit-ID: a38352de4495a6a4662609a560b2db4b03d6b352
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

Commit-ID:  a38352de4495a6a4662609a560b2db4b03d6b352
Gitweb:     https://git.kernel.org/tip/a38352de4495a6a4662609a560b2db4b03d6b352
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Wed, 23 Jan 2019 16:52:28 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:10 +0100

perf script python: Remove explicit shebang from Python scripts

The scripts in scripts/python are intended to be run from 'perf script'
and the Python version used is dictated by how perf was built (PYTHON=).

Also most distros follow pep-0394 which recommends that /usr/bin/python
refer to Python2 and so may not exist on the system (if PYTHON=python3).

- Remove the explicit shebang
- Install the scripts as mode 644

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190124005229.16146-6-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                         | 4 ++--
 tools/perf/scripts/python/exported-sql-viewer.py | 1 -
 tools/perf/scripts/python/sched-migration.py     | 2 --
 tools/perf/scripts/python/stat-cpi.py            | 1 -
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0ee6795d82cc..09df1c8a4ec9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -863,8 +863,8 @@ ifndef NO_LIBPYTHON
 	$(call QUIET_INSTALL, python-scripts) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/Trace'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/bin'; \
-		$(INSTALL) scripts/python/Perf-Trace-Util/lib/Perf/Trace/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/Trace'; \
-		$(INSTALL) scripts/python/*.py -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
+		$(INSTALL) scripts/python/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/Trace'; \
+		$(INSTALL) scripts/python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
 		$(INSTALL) scripts/python/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/bin'
 endif
 	$(call QUIET_INSTALL, perf_completion-script) \
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index f278ce5ebab7..c3091401df91 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1,4 +1,3 @@
-#!/usr/bin/python2
 # SPDX-License-Identifier: GPL-2.0
 # exported-sql-viewer.py: view data from sql database
 # Copyright (c) 2014-2018, Intel Corporation.
diff --git a/tools/perf/scripts/python/sched-migration.py b/tools/perf/scripts/python/sched-migration.py
index 3473e7f66081..3984bf51f3c5 100644
--- a/tools/perf/scripts/python/sched-migration.py
+++ b/tools/perf/scripts/python/sched-migration.py
@@ -1,5 +1,3 @@
-#!/usr/bin/python
-#
 # Cpu task migration overview toy
 #
 # Copyright (C) 2010 Frederic Weisbecker <fweisbec@gmail.com>
diff --git a/tools/perf/scripts/python/stat-cpi.py b/tools/perf/scripts/python/stat-cpi.py
index 8410672efb8b..a81ad8835a74 100644
--- a/tools/perf/scripts/python/stat-cpi.py
+++ b/tools/perf/scripts/python/stat-cpi.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0
 
 data    = {}
