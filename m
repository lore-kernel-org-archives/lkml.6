Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32047C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006FE20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405510AbfAPQYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:24:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731504AbfAPQYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:24:21 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGMnCF180000
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:19 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2832g2kt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:19 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:24:17 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:24:15 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGOEdS65732618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:24:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40EDA42045;
        Wed, 16 Jan 2019 16:24:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 241E842049;
        Wed, 16 Jan 2019 16:24:12 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.85.72.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 16:24:11 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf scripts python: Add Python 3 support to intel-pt-events.py
Date:   Wed, 16 Jan 2019 21:53:35 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011616-0028-0000-0000-0000033A0BEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0029-0000-0000-000023F733BA
Message-Id: <1547655825-28754-7-git-send-email-s1seetee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in intel-pt-events.py.``print``
is now a function rather than a statement. This should have no
functional change.

Fixes indentation issue, replace spaces with tab.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/intel-pt-events.py | 56 ++++++++++++++--------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index b19172d..a02a810 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -22,34 +22,34 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 #from Core import *
 
 def trace_begin():
-	print "Intel PT Power Events and PTWRITE"
+	print("Intel PT Power Events and PTWRITE")
 
 def trace_end():
-	print "End"
+	print("End")
 
 def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
+		print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
 
 def print_ptwrite(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
 	flags = data[0]
 	payload = data[1]
 	exact_ip = flags & 1
-	print "IP: %u payload: %#x" % (exact_ip, payload),
+	print("IP: %u payload: %#x" % (exact_ip, payload)),
 
 def print_cbr(raw_buf):
 	data = struct.unpack_from("<BBBBII", raw_buf)
 	cbr = data[0]
 	f = (data[4] + 500) / 1000
 	p = ((cbr * 1000 / data[2]) + 5) / 10
-	print "%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p),
+	print("%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p)),
 
 def print_mwait(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
 	payload = data[1]
 	hints = payload & 0xff
 	extensions = (payload >> 32) & 0x3
-	print "hints: %#x extensions: %#x" % (hints, extensions),
+	print("hints: %#x extensions: %#x" % (hints, extensions)),
 
 def print_pwre(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
@@ -57,13 +57,13 @@ def print_pwre(raw_buf):
 	hw = (payload >> 7) & 1
 	cstate = (payload >> 12) & 0xf
 	subcstate = (payload >> 8) & 0xf
-	print "hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
+	print("hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate)),
 
 def print_exstop(raw_buf):
 	data = struct.unpack_from("<I", raw_buf)
 	flags = data[0]
 	exact_ip = flags & 1
-	print "IP: %u" % (exact_ip),
+	print("IP: %u" % (exact_ip)),
 
 def print_pwrx(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
@@ -71,37 +71,37 @@ def print_pwrx(raw_buf):
 	deepest_cstate = payload & 0xf
 	last_cstate = (payload >> 4) & 0xf
 	wake_reason = (payload >> 8) & 0xf
-	print "deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason),
+	print("deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason)),
 
 def print_common_start(comm, sample, name):
 	ts = sample["time"]
 	cpu = sample["cpu"]
 	pid = sample["pid"]
 	tid = sample["tid"]
-	print "%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
+	print("%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name)),
 
 def print_common_ip(sample, symbol, dso):
 	ip = sample["ip"]
-	print "%16x %s (%s)" % (ip, symbol, dso)
+	print("%16x %s (%s)" % (ip, symbol, dso))
 
 def process_event(param_dict):
-        event_attr = param_dict["attr"]
-        sample     = param_dict["sample"]
-        raw_buf    = param_dict["raw_buf"]
-        comm       = param_dict["comm"]
-        name       = param_dict["ev_name"]
-
-        # Symbol and dso info are not always resolved
-        if (param_dict.has_key("dso")):
-                dso = param_dict["dso"]
-        else:
-                dso = "[unknown]"
-
-        if (param_dict.has_key("symbol")):
-                symbol = param_dict["symbol"]
-        else:
-                symbol = "[unknown]"
-
+	event_attr = param_dict["attr"]
+	sample     = param_dict["sample"]
+	raw_buf    = param_dict["raw_buf"]
+	comm       = param_dict["comm"]
+	name       = param_dict["ev_name"]
+
+	# Symbol and dso info are not always resolved
+	if ('dso' in param_dict):
+		dso = param_dict["dso"]
+	else:
+		dso = "[unknown]"
+
+	if ('symbol' in param_dict):
+		symbol = param_dict["symbol"]
+	else:
+		symbol = "[unknown]"
+
 	if name == "ptwrite":
 		print_common_start(comm, sample, name)
 		print_ptwrite(raw_buf)
-- 
1.8.3.1

