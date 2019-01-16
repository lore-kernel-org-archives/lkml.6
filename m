Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD710C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915D020651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405534AbfAPQYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:24:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730473AbfAPQY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:24:29 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GGKQWl062101
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:28 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q25b40dcc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:24:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Wed, 16 Jan 2019 16:24:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 16:24:22 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GGOLOB43778230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 16:24:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59C7242047;
        Wed, 16 Jan 2019 16:24:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B60342045;
        Wed, 16 Jan 2019 16:24:19 +0000 (GMT)
Received: from oc1548405160.ibm.com (unknown [9.85.72.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 16:24:18 +0000 (GMT)
From:   Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     s1seetee@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com
Subject: [PATCH] perf scripts python: Add Python 3 support to netdev-times.py
Date:   Wed, 16 Jan 2019 21:53:37 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011616-0028-0000-0000-0000033A0BF1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011616-0029-0000-0000-000023F733BD
Message-Id: <1547655825-28754-9-git-send-email-s1seetee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in netdev-times.py. ``print``
is now a function rather than a statement. This should have no
functional change.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/netdev-times.py | 76 +++++++++++++++----------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts/python/netdev-times.py
index 9b2050f..65cf276 100644
--- a/tools/perf/scripts/python/netdev-times.py
+++ b/tools/perf/scripts/python/netdev-times.py
@@ -61,12 +61,12 @@ def diff_msec(src, dst):
 def print_transmit(hunk):
 	if dev != 0 and hunk['dev'].find(dev) < 0:
 		return
-	print "%7s %5d %6d.%06dsec %12.3fmsec      %12.3fmsec" % \
+	print("%7s %5d %6d.%06dsec %12.3fmsec      %12.3fmsec" % \
 		(hunk['dev'], hunk['len'],
 		nsecs_secs(hunk['queue_t']),
 		nsecs_nsecs(hunk['queue_t'])/1000,
 		diff_msec(hunk['queue_t'], hunk['xmit_t']),
-		diff_msec(hunk['xmit_t'], hunk['free_t']))
+		diff_msec(hunk['xmit_t'], hunk['free_t'])))
 
 # Format for displaying rx packet processing
 PF_IRQ_ENTRY= "  irq_entry(+%.3fmsec irq=%d:%s)"
@@ -98,55 +98,55 @@ def print_receive(hunk):
 	if show_hunk == 0:
 		return
 
-	print "%d.%06dsec cpu=%d" % \
-		(nsecs_secs(base_t), nsecs_nsecs(base_t)/1000, cpu)
+	print("%d.%06dsec cpu=%d" % \
+		(nsecs_secs(base_t), nsecs_nsecs(base_t)/1000, cpu))
 	for i in range(len(irq_list)):
-		print PF_IRQ_ENTRY % \
+		print(PF_IRQ_ENTRY % \
 			(diff_msec(base_t, irq_list[i]['irq_ent_t']),
-			irq_list[i]['irq'], irq_list[i]['name'])
-		print PF_JOINT
+			irq_list[i]['irq'], irq_list[i]['name']))
+		print(PF_JOINT)
 		irq_event_list = irq_list[i]['event_list']
 		for j in range(len(irq_event_list)):
 			irq_event = irq_event_list[j]
 			if irq_event['event'] == 'netif_rx':
-				print PF_NET_RX % \
+				print(PF_NET_RX % \
 					(diff_msec(base_t, irq_event['time']),
-					irq_event['skbaddr'])
-				print PF_JOINT
-	print PF_SOFT_ENTRY % \
-		diff_msec(base_t, hunk['sirq_ent_t'])
-	print PF_JOINT
+					irq_event['skbaddr']))
+				print(PF_JOINT)
+	print(PF_SOFT_ENTRY % \
+		diff_msec(base_t, hunk['sirq_ent_t']))
+	print(PF_JOINT)
 	event_list = hunk['event_list']
 	for i in range(len(event_list)):
 		event = event_list[i]
 		if event['event_name'] == 'napi_poll':
-			print PF_NAPI_POLL % \
-			    (diff_msec(base_t, event['event_t']), event['dev'])
+			print(PF_NAPI_POLL % \
+			    (diff_msec(base_t, event['event_t']), event['dev']))
 			if i == len(event_list) - 1:
-				print ""
+				print("")
 			else:
-				print PF_JOINT
+				print(PF_JOINT)
 		else:
-			print PF_NET_RECV % \
+			print(PF_NET_RECV % \
 			    (diff_msec(base_t, event['event_t']), event['skbaddr'],
-				event['len'])
+				event['len']))
 			if 'comm' in event.keys():
-				print PF_WJOINT
-				print PF_CPY_DGRAM % \
+				print(PF_WJOINT)
+				print(PF_CPY_DGRAM % \
 					(diff_msec(base_t, event['comm_t']),
-					event['pid'], event['comm'])
+					event['pid'], event['comm']))
 			elif 'handle' in event.keys():
-				print PF_WJOINT
+				print(PF_WJOINT)
 				if event['handle'] == "kfree_skb":
-					print PF_KFREE_SKB % \
+					print(PF_KFREE_SKB % \
 						(diff_msec(base_t,
 						event['comm_t']),
-						event['location'])
+						event['location']))
 				elif event['handle'] == "consume_skb":
-					print PF_CONS_SKB % \
+					print(PF_CONS_SKB % \
 						diff_msec(base_t,
-							event['comm_t'])
-			print PF_JOINT
+							event['comm_t']))
+			print(PF_JOINT)
 
 def trace_begin():
 	global show_tx
@@ -210,19 +210,19 @@ def trace_end():
 			print_receive(receive_hunk_list[i])
 	# display transmit hunks
 	if show_tx:
-		print "   dev    len      Qdisc        " \
-			"       netdevice             free"
+		print("   dev    len      Qdisc        " \
+			"       netdevice             free")
 		for i in range(len(tx_free_list)):
 			print_transmit(tx_free_list[i])
 	if debug:
-		print "debug buffer status"
-		print "----------------------------"
-		print "xmit Qdisc:remain:%d overflow:%d" % \
-			(len(tx_queue_list), of_count_tx_queue_list)
-		print "xmit netdevice:remain:%d overflow:%d" % \
-			(len(tx_xmit_list), of_count_tx_xmit_list)
-		print "receive:remain:%d overflow:%d" % \
-			(len(rx_skb_list), of_count_rx_skb_list)
+		print("debug buffer status")
+		print("----------------------------")
+		print("xmit Qdisc:remain:%d overflow:%d" % \
+			(len(tx_queue_list), of_count_tx_queue_list))
+		print("xmit netdevice:remain:%d overflow:%d" % \
+			(len(tx_xmit_list), of_count_tx_xmit_list))
+		print("receive:remain:%d overflow:%d" % \
+			(len(rx_skb_list), of_count_rx_skb_list))
 
 # called from perf, when it finds a correspoinding event
 def irq__softirq_entry(name, context, cpu, sec, nsec, pid, comm, callchain, vec):
-- 
1.8.3.1

