Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A754C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631272083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131563;
	bh=ZSNKnMqhC3kurlL5Fo1E5edOdMSwyT3B43tYetWSRQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x8v8KTK0D55pnpQmbN3SqFNfccajR8gs99m1x0LhMwkedonwswkSq8YlTv/7YdUjj
	 nlHjab9uUNKZM1cNkIST6dSmb2sA5DvenadZ8yVPa6TSgWpryAqxCPzIHZPkq4kHN+
	 SZT389z+htktJ6IAwVO2KTvlRE5j6dibA8X+AUS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfBYVwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730942AbfBYVWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:42 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6B4721873;
        Mon, 25 Feb 2019 21:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129762;
        bh=ZSNKnMqhC3kurlL5Fo1E5edOdMSwyT3B43tYetWSRQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxqTxUiWQ5qg4fsnRHEocXFOlIn28DUZMcIJ7ID60vPd3ScwFvvCqnVu7+O6K3o+H
         QPrFCeeBGMWRfIHO07seFVwSdWW0VbVly2nF8e8WtD4ubH1WE6kj4a9WGovL1CKn/f
         0lvaNvHyz8Ts2PLVppGRmWKCltydxHKNwelUcQtM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Neil Horman <nhorman@tuxdriver.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/37] perf script python: Add Python3 support to net_dropmonitor.py
Date:   Mon, 25 Feb 2019 18:20:29 -0300
Message-Id: <20190225212035.24781-32-acme@kernel.org>
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

Support both Python2 and Python3 in the net_dropmonitor.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-9-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

