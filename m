Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8C72083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131559;
	bh=Q6Lh/qpNU4BL9BBaJ5s+7FVSGLDM/zawWwTB6jj8g+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lqbLDf20q0ScoMCafklokJJytF/ATs+CP9D5hmwkwvX1pJ1aXEGLlIBhuf5+Af7Nl
	 Sm8tIIlGW0dvRhwsKmz9tuBDQheehOqo1Be9hh24SVE1s3gbTRtaAm0sYpSUBxGkUd
	 iSmifsQDzZmYRcYqD6tltmSgNpToRRLvKzOg4gTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfBYVWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730930AbfBYVWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:40 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03BED21848;
        Mon, 25 Feb 2019 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129759;
        bh=Q6Lh/qpNU4BL9BBaJ5s+7FVSGLDM/zawWwTB6jj8g+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWy61dtCQnVUHjzr4dQ81AfEYC7miKqkv0hIkes0UdmC3TRMZgyws0zH/0VLmADdy
         uXK4THFydTpodc7FLeLq02zTVS4pmT0TURAdQHKxFTpM7042iTj77m2QJH/8TKGk1D
         l4jnCGatARprHMHi02K+PHo61s0Z/00muLkRDBLg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/37] perf script python: Add Python3 support to mem-phys-addr.py
Date:   Mon, 25 Feb 2019 18:20:28 -0300
Message-Id: <20190225212035.24781-31-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python2 and Python3 in the mem-phys-addr.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Link: http://lkml.kernel.org/r/20190222230619.17887-8-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/mem-phys-addr.py | 24 +++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index ebee2c5ae496..fb0bbcbfa0f0 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -4,6 +4,8 @@
 # Copyright (c) 2018, Intel Corporation.
 
 from __future__ import division
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -31,21 +33,23 @@ def parse_iomem():
 	for i, j in enumerate(f):
 		m = re.split('-|:',j,2)
 		if m[2].strip() == 'System RAM':
-			system_ram.append(long(m[0], 16))
-			system_ram.append(long(m[1], 16))
+			system_ram.append(int(m[0], 16))
+			system_ram.append(int(m[1], 16))
 		if m[2].strip() == 'Persistent Memory':
-			pmem.append(long(m[0], 16))
-			pmem.append(long(m[1], 16))
+			pmem.append(int(m[0], 16))
+			pmem.append(int(m[1], 16))
 
 def print_memory_type():
-	print "Event: %s" % (event_name)
-	print "%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"),
-	print "%-40s  %10s  %10s\n" % ("----------------------------------------", \
+	print("Event: %s" % (event_name))
+	print("%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"), end='')
+	print("%-40s  %10s  %10s\n" % ("----------------------------------------",
 					"-----------", "-----------"),
+                                        end='');
 	total = sum(load_mem_type_cnt.values())
 	for mem_type, count in sorted(load_mem_type_cnt.most_common(), \
-					key = lambda(k, v): (v, k), reverse = True):
-		print "%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total),
+					key = lambda kv: (kv[1], kv[0]), reverse = True):
+		print("%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total),
+                        end='')
 
 def trace_begin():
 	parse_iomem()
@@ -80,7 +84,7 @@ def find_memory_type(phys_addr):
 	f.seek(0, 0)
 	for j in f:
 		m = re.split('-|:',j,2)
-		if long(m[0], 16) <= phys_addr <= long(m[1], 16):
+		if int(m[0], 16) <= phys_addr <= int(m[1], 16):
 			return m[2]
 	return "N/A"
 
-- 
2.20.1

