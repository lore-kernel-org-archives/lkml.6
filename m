Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tpovIhjrGFuwZwAAmS7hNA
	; Thu, 07 Jun 2018 08:21:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 495D3607F7; Thu,  7 Jun 2018 08:21:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6BB7360115;
	Thu,  7 Jun 2018 08:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BB7360115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932572AbeFGIVw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:21:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932198AbeFGIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:21:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578LdNb2126252
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:21:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578LcsX2126249;
        Thu, 7 Jun 2018 01:21:38 -0700
Date: Thu, 7 Jun 2018 01:21:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-ec1e6e6a681815e4d02a54eed92edec6fa4128ee@git.kernel.org>
Cc: namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mpe@ellerman.id.au,
        ravi.bangoria@linux.ibm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
Reply-To: tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com,
          namhyung@kernel.org, hpa@zytor.com, mpe@ellerman.id.au,
          alexander.shishkin@linux.intel.com, ravi.bangoria@linux.ibm.com,
          naveen.n.rao@linux.vnet.ibm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180605124801.17210-1-ravi.bangoria@linux.ibm.com>
References: <20180605124801.17210-1-ravi.bangoria@linux.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script powerpc: Python script for hypervisor
 call statistics
Git-Commit-ID: ec1e6e6a681815e4d02a54eed92edec6fa4128ee
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

Commit-ID:  ec1e6e6a681815e4d02a54eed92edec6fa4128ee
Gitweb:     https://git.kernel.org/tip/ec1e6e6a681815e4d02a54eed92edec6fa4128ee
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Tue, 5 Jun 2018 18:18:01 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:06 -0300

perf script powerpc: Python script for hypervisor call statistics

Add python script to show hypervisor call statistics. Ex,

  # perf record -a -e "{powerpc:hcall_entry,powerpc:hcall_exit}"
  # perf script -s scripts/python/powerpc-hcalls.py
    hcall                            count   min(ns)   max(ns)   avg(ns)
    --------------------------------------------------------------------
    H_RANDOM                            82       838      1164       904
    H_PUT_TCE                           47      1078      5928      2003
    H_EOI                              266      1336      3546      1654
    H_ENTER                             28      1646      4038      1952
    H_PUT_TCE_INDIRECT                 230      2166     18168      6109
    H_IPI                              238      1072      3232      1688
    H_SEND_LOGICAL_LAN                  42      5488     21366      7694
    H_STUFF_TCE                        294       986      6210      3591
    H_XIRR                             266      2286      6990      3783
    H_PROTECT                           10      2196      3556      2555
    H_VIO_SIGNAL                       294      1028      2784      1311
    H_ADD_LOGICAL_LAN_BUFFER            53      1978      3450      2600
    H_SEND_CRQ                          77      1762      7240      2447

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180605124801.17210-1-ravi.bangoria@linux.ibm.com
[ Fixup typo: table_loockup -> table_lookup ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/scripts/python/bin/powerpc-hcalls-record  |   2 +
 .../perf/scripts/python/bin/powerpc-hcalls-report  |   2 +
 tools/perf/scripts/python/powerpc-hcalls.py        | 200 +++++++++++++++++++++
 3 files changed, 204 insertions(+)

diff --git a/tools/perf/scripts/python/bin/powerpc-hcalls-record b/tools/perf/scripts/python/bin/powerpc-hcalls-record
new file mode 100644
index 000000000000..b7402aa9147d
--- /dev/null
+++ b/tools/perf/scripts/python/bin/powerpc-hcalls-record
@@ -0,0 +1,2 @@
+#!/bin/bash
+perf record -e "{powerpc:hcall_entry,powerpc:hcall_exit}" $@
diff --git a/tools/perf/scripts/python/bin/powerpc-hcalls-report b/tools/perf/scripts/python/bin/powerpc-hcalls-report
new file mode 100644
index 000000000000..dd32ad7465f6
--- /dev/null
+++ b/tools/perf/scripts/python/bin/powerpc-hcalls-report
@@ -0,0 +1,2 @@
+#!/bin/bash
+perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/powerpc-hcalls.py
diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
new file mode 100644
index 000000000000..00e0e7476e55
--- /dev/null
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -0,0 +1,200 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2018 Ravi Bangoria, IBM Corporation
+#
+# Hypervisor call statisics
+
+import os
+import sys
+
+sys.path.append(os.environ['PERF_EXEC_PATH'] + \
+	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+
+from perf_trace_context import *
+from Core import *
+from Util import *
+
+# output: {
+#	opcode: {
+#		'min': minimum time nsec
+#		'max': maximum time nsec
+#		'time': average time nsec
+#		'cnt': counter
+#	} ...
+# }
+output = {}
+
+# d_enter: {
+#	cpu: {
+#		opcode: nsec
+#	} ...
+# }
+d_enter = {}
+
+hcall_table = {
+	4: 'H_REMOVE',
+	8: 'H_ENTER',
+	12: 'H_READ',
+	16: 'H_CLEAR_MOD',
+	20: 'H_CLEAR_REF',
+	24: 'H_PROTECT',
+	28: 'H_GET_TCE',
+	32: 'H_PUT_TCE',
+	36: 'H_SET_SPRG0',
+	40: 'H_SET_DABR',
+	44: 'H_PAGE_INIT',
+	48: 'H_SET_ASR',
+	52: 'H_ASR_ON',
+	56: 'H_ASR_OFF',
+	60: 'H_LOGICAL_CI_LOAD',
+	64: 'H_LOGICAL_CI_STORE',
+	68: 'H_LOGICAL_CACHE_LOAD',
+	72: 'H_LOGICAL_CACHE_STORE',
+	76: 'H_LOGICAL_ICBI',
+	80: 'H_LOGICAL_DCBF',
+	84: 'H_GET_TERM_CHAR',
+	88: 'H_PUT_TERM_CHAR',
+	92: 'H_REAL_TO_LOGICAL',
+	96: 'H_HYPERVISOR_DATA',
+	100: 'H_EOI',
+	104: 'H_CPPR',
+	108: 'H_IPI',
+	112: 'H_IPOLL',
+	116: 'H_XIRR',
+	120: 'H_MIGRATE_DMA',
+	124: 'H_PERFMON',
+	220: 'H_REGISTER_VPA',
+	224: 'H_CEDE',
+	228: 'H_CONFER',
+	232: 'H_PROD',
+	236: 'H_GET_PPP',
+	240: 'H_SET_PPP',
+	244: 'H_PURR',
+	248: 'H_PIC',
+	252: 'H_REG_CRQ',
+	256: 'H_FREE_CRQ',
+	260: 'H_VIO_SIGNAL',
+	264: 'H_SEND_CRQ',
+	272: 'H_COPY_RDMA',
+	276: 'H_REGISTER_LOGICAL_LAN',
+	280: 'H_FREE_LOGICAL_LAN',
+	284: 'H_ADD_LOGICAL_LAN_BUFFER',
+	288: 'H_SEND_LOGICAL_LAN',
+	292: 'H_BULK_REMOVE',
+	304: 'H_MULTICAST_CTRL',
+	308: 'H_SET_XDABR',
+	312: 'H_STUFF_TCE',
+	316: 'H_PUT_TCE_INDIRECT',
+	332: 'H_CHANGE_LOGICAL_LAN_MAC',
+	336: 'H_VTERM_PARTNER_INFO',
+	340: 'H_REGISTER_VTERM',
+	344: 'H_FREE_VTERM',
+	348: 'H_RESET_EVENTS',
+	352: 'H_ALLOC_RESOURCE',
+	356: 'H_FREE_RESOURCE',
+	360: 'H_MODIFY_QP',
+	364: 'H_QUERY_QP',
+	368: 'H_REREGISTER_PMR',
+	372: 'H_REGISTER_SMR',
+	376: 'H_QUERY_MR',
+	380: 'H_QUERY_MW',
+	384: 'H_QUERY_HCA',
+	388: 'H_QUERY_PORT',
+	392: 'H_MODIFY_PORT',
+	396: 'H_DEFINE_AQP1',
+	400: 'H_GET_TRACE_BUFFER',
+	404: 'H_DEFINE_AQP0',
+	408: 'H_RESIZE_MR',
+	412: 'H_ATTACH_MCQP',
+	416: 'H_DETACH_MCQP',
+	420: 'H_CREATE_RPT',
+	424: 'H_REMOVE_RPT',
+	428: 'H_REGISTER_RPAGES',
+	432: 'H_DISABLE_AND_GETC',
+	436: 'H_ERROR_DATA',
+	440: 'H_GET_HCA_INFO',
+	444: 'H_GET_PERF_COUNT',
+	448: 'H_MANAGE_TRACE',
+	468: 'H_FREE_LOGICAL_LAN_BUFFER',
+	472: 'H_POLL_PENDING',
+	484: 'H_QUERY_INT_STATE',
+	580: 'H_ILLAN_ATTRIBUTES',
+	592: 'H_MODIFY_HEA_QP',
+	596: 'H_QUERY_HEA_QP',
+	600: 'H_QUERY_HEA',
+	604: 'H_QUERY_HEA_PORT',
+	608: 'H_MODIFY_HEA_PORT',
+	612: 'H_REG_BCMC',
+	616: 'H_DEREG_BCMC',
+	620: 'H_REGISTER_HEA_RPAGES',
+	624: 'H_DISABLE_AND_GET_HEA',
+	628: 'H_GET_HEA_INFO',
+	632: 'H_ALLOC_HEA_RESOURCE',
+	644: 'H_ADD_CONN',
+	648: 'H_DEL_CONN',
+	664: 'H_JOIN',
+	676: 'H_VASI_STATE',
+	688: 'H_ENABLE_CRQ',
+	696: 'H_GET_EM_PARMS',
+	720: 'H_SET_MPP',
+	724: 'H_GET_MPP',
+	748: 'H_HOME_NODE_ASSOCIATIVITY',
+	756: 'H_BEST_ENERGY',
+	764: 'H_XIRR_X',
+	768: 'H_RANDOM',
+	772: 'H_COP',
+	788: 'H_GET_MPP_X',
+	796: 'H_SET_MODE',
+	61440: 'H_RTAS',
+}
+
+def hcall_table_lookup(opcode):
+	if (hcall_table.has_key(opcode)):
+		return hcall_table[opcode]
+	else:
+		return opcode
+
+print_ptrn = '%-28s%10s%10s%10s%10s'
+
+def trace_end():
+	print print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)')
+	print '-' * 68
+	for opcode in output:
+		h_name = hcall_table_lookup(opcode)
+		time = output[opcode]['time']
+		cnt = output[opcode]['cnt']
+		min_t = output[opcode]['min']
+		max_t = output[opcode]['max']
+
+		print print_ptrn % (h_name, cnt, min_t, max_t, time/cnt)
+
+def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
+			opcode, retval):
+	if (d_enter.has_key(cpu) and d_enter[cpu].has_key(opcode)):
+		diff = nsecs(sec, nsec) - d_enter[cpu][opcode]
+
+		if (output.has_key(opcode)):
+			output[opcode]['time'] += diff
+			output[opcode]['cnt'] += 1
+			if (output[opcode]['min'] > diff):
+				output[opcode]['min'] = diff
+			if (output[opcode]['max'] < diff):
+				output[opcode]['max'] = diff
+		else:
+			output[opcode] = {
+				'time': diff,
+				'cnt': 1,
+				'min': diff,
+				'max': diff,
+			}
+
+		del d_enter[cpu][opcode]
+#	else:
+#		print "Can't find matching hcall_enter event. Ignoring sample"
+
+def powerpc__hcall_entry(event_name, context, cpu, sec, nsec, pid, comm,
+			 callchain, opcode):
+		if (d_enter.has_key(cpu)):
+			d_enter[cpu][opcode] = nsecs(sec, nsec)
+		else:
+			d_enter[cpu] = {opcode: nsecs(sec, nsec)}
