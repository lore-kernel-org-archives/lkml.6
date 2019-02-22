Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11781C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE57920700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfBVXHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:07:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:52496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727531AbfBVXG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:06:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D100B017;
        Fri, 22 Feb 2019 23:06:55 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 08/15] perf script python: add Python3 support to net_dropmonitor.py
Date:   Fri, 22 Feb 2019 15:06:12 -0800
Message-Id: <20190222230619.17887-9-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the net_dropmonitor.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
---
 tools/perf/scripts/python/net_dropmonitor.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
index a150164b44a3..212557a02c50 100755
--- a/tools/perf/scripts/python/net_dropmonitor.py
+++ b/tools/perf/scripts/python/net_dropmonitor.py
@@ -1,6 +1,8 @@
 # Monitor the system for dropped packets and proudce a report of drop locations and counts
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -50,19 +52,19 @@ def get_sym(sloc):
 		return (None, 0)
 
 def print_drop_table():
-	print "%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT")
+	print("%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT"))
 	for i in drop_log.keys():
 		(sym, off) = get_sym(i)
 		if sym == None:
 			sym = i
-		print "%25s %25s %25s" % (sym, off, drop_log[i])
+		print("%25s %25s %25s" % (sym, off, drop_log[i]))
 
 
 def trace_begin():
-	print "Starting trace (Ctrl-C to dump results)"
+	print("Starting trace (Ctrl-C to dump results)")
 
 def trace_end():
-	print "Gathering kallsyms data"
+	print("Gathering kallsyms data")
 	get_kallsyms_table()
 	print_drop_table()
 
-- 
2.20.1

