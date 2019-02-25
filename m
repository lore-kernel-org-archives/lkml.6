Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D091C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF112083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131546;
	bh=iGbDoRokz5JHvpU7g8cKuqfu4yLG0mr8dw0IFwgZ5o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CsTkCpO9Figb61AlSaDJDOVXsMoYnqxjsizgzqiC0wYoPNV5UHCQnPWkeSp9HkbBj
	 Z1WJ0S/HBbUXLkP9bslAG5Ed/kgMs3innn0XISRTCp1vXhKTbJeHFDHeWQkDKbzl8x
	 KPCFm0pIhzl+n94zUd7LawHgtDaFGMjC63/dsyrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfBYVwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730963AbfBYVWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:48 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B7221850;
        Mon, 25 Feb 2019 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129767;
        bh=iGbDoRokz5JHvpU7g8cKuqfu4yLG0mr8dw0IFwgZ5o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUL0g4908t5p7UORZ6JXGqXKI4r2b6VTnF8RoBKqFEbx+EdxoZWYhhlO6TzBkiyiD
         xXiqdZ8UgPo3BhYeBBUb4RbbXL3g7HBFd2JwJqlqnODyiMSlwRUUBZPrM31odiNINx
         oFFLdypJj6TH21eAFxemKG/a3+FLoESnnluCX3jg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 32/37] perf script python: Add Python3 support to powerpc-hcalls.py
Date:   Mon, 25 Feb 2019 18:20:30 -0300
Message-Id: <20190225212035.24781-33-acme@kernel.org>
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

Support both Python2 and Python3 in the powerpc-hcalls.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-10-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/powerpc-hcalls.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 00e0e7476e55..8b78dc790adb 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -4,6 +4,8 @@
 #
 # Hypervisor call statisics
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -149,7 +151,7 @@ hcall_table = {
 }
 
 def hcall_table_lookup(opcode):
-	if (hcall_table.has_key(opcode)):
+	if (opcode in hcall_table):
 		return hcall_table[opcode]
 	else:
 		return opcode
@@ -157,8 +159,8 @@ def hcall_table_lookup(opcode):
 print_ptrn = '%-28s%10s%10s%10s%10s'
 
 def trace_end():
-	print print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)')
-	print '-' * 68
+	print(print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)'))
+	print('-' * 68)
 	for opcode in output:
 		h_name = hcall_table_lookup(opcode)
 		time = output[opcode]['time']
@@ -166,14 +168,14 @@ def trace_end():
 		min_t = output[opcode]['min']
 		max_t = output[opcode]['max']
 
-		print print_ptrn % (h_name, cnt, min_t, max_t, time/cnt)
+		print(print_ptrn % (h_name, cnt, min_t, max_t, time//cnt))
 
 def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
 			opcode, retval):
-	if (d_enter.has_key(cpu) and d_enter[cpu].has_key(opcode)):
+	if (cpu in d_enter and opcode in d_enter[cpu]):
 		diff = nsecs(sec, nsec) - d_enter[cpu][opcode]
 
-		if (output.has_key(opcode)):
+		if (opcode in output):
 			output[opcode]['time'] += diff
 			output[opcode]['cnt'] += 1
 			if (output[opcode]['min'] > diff):
@@ -190,11 +192,11 @@ def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
 
 		del d_enter[cpu][opcode]
 #	else:
-#		print "Can't find matching hcall_enter event. Ignoring sample"
+#		print("Can't find matching hcall_enter event. Ignoring sample")
 
 def powerpc__hcall_entry(event_name, context, cpu, sec, nsec, pid, comm,
 			 callchain, opcode):
-		if (d_enter.has_key(cpu)):
+		if (cpu in d_enter):
 			d_enter[cpu][opcode] = nsecs(sec, nsec)
 		else:
 			d_enter[cpu] = {opcode: nsecs(sec, nsec)}
-- 
2.20.1

