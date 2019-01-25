Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5449BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ADE20844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458386;
	bh=ZRmJ7epUSBKl0GYk1ToTekljwVbtbwmEjHX7N0qO8R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YrdmAouOCmzHrkEi/LYxo1bKmvaBrUbznLbh4dRpmK0B9nSksYPfP8UoOYrY5eGrj
	 DijePzFb7uKh5xRicFnsGdpVVNODdrAtE/TanlDQMS5Mjqrmf255AnDeOgBs5eIFag
	 HZprSt1xhGJlfYuDGpP2VPRNxdt0+GLACNtrhlLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfAYXTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbfAYXTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:39 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93125218FC;
        Fri, 25 Jan 2019 23:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458378;
        bh=ZRmJ7epUSBKl0GYk1ToTekljwVbtbwmEjHX7N0qO8R0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ig+c4vRpDmhib/RYOkSl/q7v25pSXQCIDco3+9hzvaNFrJU0qUNZ2gO9eTl14J71t
         NBwKu1+ShMeFPAUUqYf5gSOzM3LzuwLj0rqz87ycxgV4SX6/CFUN6wPrFdOXl4xSSy
         BOELPt/m8k3ArdNEko9NmDrtP0Fsf3eGN3nZTGk8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/29] perf script python: Remove explicit shebang from Python scripts
Date:   Sat, 26 Jan 2019 00:18:36 +0100
Message-Id: <20190125231843.2895-23-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

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
-- 
2.20.1

