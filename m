Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF55C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C519245B1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C519245B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755785AbeFZAIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:08:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934609AbeFZAHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03vw9119417
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:06 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96p2vj4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:06 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:02 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06whZ59703522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B2EBB206B;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D79EB2076;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 98AA216CA0AB; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 30/40] doc: Update memory-ordering documentation for ->gp-seq
Date:   Mon, 25 Jun 2018 17:08:49 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0060-0000-0000-000002826664
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0061-0000-0000-0000459336B7
Message-Id: <20180626000859.23572-30-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../Tree-RCU-Memory-Ordering.html             |  22 +-
 .../Memory-Ordering/TreeRCU-gp-cleanup.svg    | 123 ++++-----
 .../Memory-Ordering/TreeRCU-gp-init-1.svg     |  16 +-
 .../Memory-Ordering/TreeRCU-gp-init-3.svg     |  56 +++--
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg | 237 +++++++++---------
 .../RCU/Design/Memory-Ordering/TreeRCU-qs.svg |  12 +-
 6 files changed, 243 insertions(+), 223 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
index 8651b0b4fd79..a346ce0116eb 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
@@ -357,7 +357,7 @@ parts, starting in this section with the various phases of
 grace-period initialization.
 
 <p>The first ordering-related grace-period initialization action is to
-increment the <tt>rcu_state</tt> structure's <tt>-&gt;gpnum</tt>
+advance the <tt>rcu_state</tt> structure's <tt>-&gt;gp_seq</tt>
 grace-period-number counter, as shown below:
 
 </p><p><img src="TreeRCU-gp-init-1.svg" alt="TreeRCU-gp-init-1.svg" width="75%">
@@ -388,7 +388,7 @@ its last CPU and if the next <tt>rcu_node</tt> structure has no online CPUs).
 
 <p>The final <tt>rcu_gp_init()</tt> pass through the <tt>rcu_node</tt>
 tree traverses breadth-first, setting each <tt>rcu_node</tt> structure's
-<tt>-&gt;gpnum</tt> field to the newly incremented value from the
+<tt>-&gt;gp_seq</tt> field to the newly advanced value from the
 <tt>rcu_state</tt> structure, as shown in the following diagram.
 
 </p><p><img src="TreeRCU-gp-init-3.svg" alt="TreeRCU-gp-init-1.svg" width="75%">
@@ -398,9 +398,9 @@ tree traverses breadth-first, setting each <tt>rcu_node</tt> structure's
 to notice that a new grace period has started, as described in the next
 section.
 But because the grace-period kthread started the grace period at the
-root (with the increment of the <tt>rcu_state</tt> structure's
-<tt>-&gt;gpnum</tt> field) before setting each leaf <tt>rcu_node</tt>
-structure's <tt>-&gt;gpnum</tt> field, each CPU's observation of
+root (with the advancing of the <tt>rcu_state</tt> structure's
+<tt>-&gt;gp_seq</tt> field) before setting each leaf <tt>rcu_node</tt>
+structure's <tt>-&gt;gp_seq</tt> field, each CPU's observation of
 the start of the grace period will happen after the actual start
 of the grace period.
 
@@ -466,7 +466,7 @@ section that the grace period must wait on.
 <tr><td>
 	But a RCU read-side critical section might have started
 	after the beginning of the grace period
-	(the <tt>-&gt;gpnum++</tt> from earlier), so why should
+	(the advancing of <tt>-&gt;gp_seq</tt> from earlier), so why should
 	the grace period wait on such a critical section?
 </td></tr>
 <tr><th align="left">Answer:</th></tr>
@@ -609,10 +609,8 @@ states outstanding from other CPUs.
 <h4><a name="Grace-Period Cleanup">Grace-Period Cleanup</a></h4>
 
 <p>Grace-period cleanup first scans the <tt>rcu_node</tt> tree
-breadth-first setting all the <tt>-&gt;completed</tt> fields equal
-to the number of the newly completed grace period, then it sets
-the <tt>rcu_state</tt> structure's <tt>-&gt;completed</tt> field,
-again to the number of the newly completed grace period.
+breadth-first advancing all the <tt>-&gt;gp_seq</tt> fields, then it
+advances the <tt>rcu_state</tt> structure's <tt>-&gt;gp_seq</tt> field.
 The ordering effects are shown below:
 
 </p><p><img src="TreeRCU-gp-cleanup.svg" alt="TreeRCU-gp-cleanup.svg" width="75%">
@@ -634,7 +632,7 @@ grace-period cleanup is complete, the next grace period can begin.
 	CPU has reported its quiescent state, but it may be some
 	milliseconds before RCU becomes aware of this.
 	The latest reasonable candidate is once the <tt>rcu_state</tt>
-	structure's <tt>-&gt;completed</tt> field has been updated,
+	structure's <tt>-&gt;gp_seq</tt> field has been updated,
 	but it is quite possible that some CPUs have already completed
 	phase two of their updates by that time.
 	In short, if you are going to work with RCU, you need to
@@ -647,7 +645,7 @@ grace-period cleanup is complete, the next grace period can begin.
 <h4><a name="Callback Invocation">Callback Invocation</a></h4>
 
 <p>Once a given CPU's leaf <tt>rcu_node</tt> structure's
-<tt>-&gt;completed</tt> field has been updated, that CPU can begin
+<tt>-&gt;gp_seq</tt> field has been updated, that CPU can begin
 invoking its RCU callbacks that were waiting for this grace period
 to end.
 These callbacks are identified by <tt>rcu_advance_cbs()</tt>,
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-cleanup.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-cleanup.svg
index 754f426b297a..bf84fbab27ee 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-cleanup.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-cleanup.svg
@@ -384,11 +384,11 @@
      inkscape:window-height="1144"
      id="namedview208"
      showgrid="true"
-     inkscape:zoom="0.70710678"
-     inkscape:cx="617.89017"
-     inkscape:cy="542.52419"
-     inkscape:window-x="86"
-     inkscape:window-y="28"
+     inkscape:zoom="0.78716603"
+     inkscape:cx="513.06403"
+     inkscape:cy="623.1214"
+     inkscape:window-x="102"
+     inkscape:window-y="38"
      inkscape:window-maximized="0"
      inkscape:current-layer="g3188-3"
      fit-margin-top="5"
@@ -417,13 +417,15 @@
      id="g3188">
     <text
        xml:space="preserve"
-       x="3199.1516"
+       x="3145.9592"
        y="13255.592"
        font-style="normal"
        font-weight="bold"
        font-size="192"
        id="text202"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;font-family:Courier"><tspan
+         style="font-size:172.87567139px"
+         id="tspan3143">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
     <g
        id="g3107"
        transform="translate(947.90548,11584.029)">
@@ -502,13 +504,15 @@
     </g>
     <text
        xml:space="preserve"
-       x="5324.5371"
-       y="15414.598"
+       x="5264.4731"
+       y="15428.84"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       id="text202-753"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
+       id="text202-36-7"
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+         style="font-size:172.87567139px"
+         id="tspan3166-5">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
   </g>
   <g
      style="fill:none;stroke-width:0.025in"
@@ -547,15 +551,6 @@
        sodipodi:linespacing="125%"><tspan
          style="font-size:159.57754517px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:start;line-height:125%;writing-mode:lr-tb;text-anchor:start;font-family:Liberation Sans;-inkscape-font-specification:Liberation Sans"
          id="tspan3104-6-5-6-0">Leaf</tspan></text>
-    <text
-       xml:space="preserve"
-       x="7479.5796"
-       y="17699.943"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       id="text202-9"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
     <path
        sodipodi:nodetypes="cc"
        inkscape:connector-curvature="0"
@@ -566,15 +561,6 @@
        style="fill:none;stroke-width:0.025in"
        transform="translate(-737.93887,7732.6672)"
        id="g3188-3">
-      <text
-         xml:space="preserve"
-         x="3225.7478"
-         y="13175.802"
-         font-style="normal"
-         font-weight="bold"
-         font-size="192"
-         id="text202-60"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;font-family:Courier">rsp-&gt;completed =</text>
       <g
          id="g3107-62"
          transform="translate(947.90548,11584.029)">
@@ -607,15 +593,6 @@
          sodipodi:linespacing="125%"><tspan
            style="font-size:159.57754517px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:start;line-height:125%;writing-mode:lr-tb;text-anchor:start;font-family:Liberation Sans;-inkscape-font-specification:Liberation Sans"
            id="tspan3104-6-5-7">Root</tspan></text>
-      <text
-         xml:space="preserve"
-         x="3225.7478"
-         y="13390.038"
-         font-style="normal"
-         font-weight="bold"
-         font-size="192"
-         id="text202-60-3"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">       rnp-&gt;completed</text>
       <flowRoot
          xml:space="preserve"
          id="flowRoot3356"
@@ -627,7 +604,18 @@
              height="63.63961"
              x="332.34018"
              y="681.87292" /></flowRegion><flowPara
-           id="flowPara3362" /></flowRoot>    </g>
+           id="flowPara3362" /></flowRoot>      <text
+         xml:space="preserve"
+         x="3156.6121"
+         y="13317.754"
+         font-style="normal"
+         font-weight="bold"
+         font-size="192"
+         id="text202-36-6"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+           style="font-size:172.87567139px"
+           id="tspan3166-0">rcu_seq_end(&amp;rsp-&gt;gp_seq)</tspan></text>
+    </g>
     <g
        style="fill:none;stroke-width:0.025in"
        transform="translate(-858.40227,7769.0342)"
@@ -859,6 +847,17 @@
        id="path3414-8-3-6-6"
        inkscape:connector-curvature="0"
        sodipodi:nodetypes="cc" />
+    <text
+       xml:space="preserve"
+       x="7418.769"
+       y="17646.104"
+       font-style="normal"
+       font-weight="bold"
+       font-size="192"
+       id="text202-36-70"
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+         style="font-size:172.87567139px"
+         id="tspan3166-93">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
   </g>
   <g
      transform="translate(-1642.5377,-11611.245)"
@@ -887,13 +886,15 @@
     </g>
     <text
        xml:space="preserve"
-       x="5327.3057"
+       x="5274.1133"
        y="15428.84"
        font-style="normal"
        font-weight="bold"
        font-size="192"
        id="text202-36"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+         style="font-size:172.87567139px"
+         id="tspan3166">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
   </g>
   <g
      transform="translate(-151.71746,-11647.612)"
@@ -972,13 +973,15 @@
          id="tspan3104-6-5-6-0-92">Leaf</tspan></text>
     <text
        xml:space="preserve"
-       x="7486.4907"
-       y="17670.119"
+       x="7408.5918"
+       y="17619.504"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       id="text202-6"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
+       id="text202-36-2"
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+         style="font-size:172.87567139px"
+         id="tspan3166-9">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
   </g>
   <g
      transform="translate(-6817.1997,-11647.612)"
@@ -1019,13 +1022,15 @@
          id="tspan3104-6-5-6-0-1">Leaf</tspan></text>
     <text
        xml:space="preserve"
-       x="7474.1382"
-       y="17688.926"
+       x="7416.8003"
+       y="17619.504"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       id="text202-5"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
+       id="text202-36-3"
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+         style="font-size:172.87567139px"
+         id="tspan3166-56">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
   </g>
   <path
      style="fill:none;stroke:#000000;stroke-width:13.29812908px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow2Lend)"
@@ -1059,15 +1064,6 @@
      id="path3414-8-3-6"
      inkscape:connector-curvature="0"
      sodipodi:nodetypes="cc" />
-  <text
-     xml:space="preserve"
-     x="7318.9653"
-     y="6031.6353"
-     font-style="normal"
-     font-weight="bold"
-     font-size="192"
-     id="text202-2"
-     style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
   <g
      style="fill:none;stroke-width:0.025in"
      id="g4504-3-9"
@@ -1123,4 +1119,15 @@
      id="path3134-9-0-3-5"
      d="m 6875.6003,15833.906 1595.7755,0"
      style="fill:none;stroke:#969696;stroke-width:53.19251633;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;marker-end:url(#Arrow1Send-36)" />
+  <text
+     xml:space="preserve"
+     x="7275.2612"
+     y="5971.8916"
+     font-style="normal"
+     font-weight="bold"
+     font-size="192"
+     id="text202-36-1"
+     style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+       style="font-size:172.87567139px"
+       id="tspan3166-2">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
 </svg>
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-init-1.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-init-1.svg
index 0161262904ec..8c207550818f 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-init-1.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-init-1.svg
@@ -272,13 +272,13 @@
      inkscape:window-height="1144"
      id="namedview208"
      showgrid="true"
-     inkscape:zoom="0.70710678"
-     inkscape:cx="617.89019"
-     inkscape:cy="636.57143"
-     inkscape:window-x="697"
+     inkscape:zoom="2.6330492"
+     inkscape:cx="524.82797"
+     inkscape:cy="519.31194"
+     inkscape:window-x="79"
      inkscape:window-y="28"
      inkscape:window-maximized="0"
-     inkscape:current-layer="svg2"
+     inkscape:current-layer="g3188"
      fit-margin-top="5"
      fit-margin-right="5"
      fit-margin-left="5"
@@ -305,13 +305,15 @@
      id="g3188">
     <text
        xml:space="preserve"
-       x="3305.5364"
+       x="3119.363"
        y="13255.592"
        font-style="normal"
        font-weight="bold"
        font-size="192"
        id="text202"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;font-family:Courier">rsp-&gt;gpnum++</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;font-family:Courier"><tspan
+         style="font-size:172.87567139px"
+         id="tspan3071">rcu_seq_start(rsp-&gt;gp_seq)</tspan></text>
     <g
        id="g3107"
        transform="translate(947.90548,11584.029)">
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-init-3.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-init-3.svg
index de6ecc51b00e..d24d7d555dbc 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-init-3.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-init-3.svg
@@ -19,7 +19,7 @@
    id="svg2"
    version="1.1"
    inkscape:version="0.48.4 r9939"
-   sodipodi:docname="TreeRCU-gp-init-2.svg">
+   sodipodi:docname="TreeRCU-gp-init-3.svg">
   <metadata
      id="metadata212">
     <rdf:RDF>
@@ -257,18 +257,22 @@
      inkscape:window-width="1087"
      inkscape:window-height="1144"
      id="namedview208"
-     showgrid="false"
-     inkscape:zoom="0.70710678"
+     showgrid="true"
+     inkscape:zoom="0.68224756"
      inkscape:cx="617.89019"
      inkscape:cy="625.84293"
-     inkscape:window-x="697"
+     inkscape:window-x="54"
      inkscape:window-y="28"
      inkscape:window-maximized="0"
-     inkscape:current-layer="svg2"
+     inkscape:current-layer="g3153"
      fit-margin-top="5"
      fit-margin-right="5"
      fit-margin-left="5"
-     fit-margin-bottom="5" />
+     fit-margin-bottom="5">
+    <inkscape:grid
+       type="xygrid"
+       id="grid3090" />
+  </sodipodi:namedview>
   <path
      sodipodi:nodetypes="cccccccccccccccccccccccc"
      inkscape:connector-curvature="0"
@@ -281,13 +285,13 @@
      id="g3188">
     <text
        xml:space="preserve"
-       x="3305.5364"
+       x="3145.9592"
        y="13255.592"
        font-style="normal"
        font-weight="bold"
        font-size="192"
        id="text202"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
     <g
        id="g3107"
        transform="translate(947.90548,11584.029)">
@@ -366,13 +370,13 @@
     </g>
     <text
        xml:space="preserve"
-       x="5392.3345"
-       y="15407.104"
+       x="5253.6904"
+       y="15407.032"
        font-style="normal"
        font-weight="bold"
        font-size="192"
        id="text202-6"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
   </g>
   <g
      style="fill:none;stroke-width:0.025in"
@@ -413,13 +417,13 @@
          id="tspan3104-6-5-6-0">Leaf</tspan></text>
     <text
        xml:space="preserve"
-       x="7536.4883"
-       y="17640.934"
+       x="7415.4365"
+       y="17670.572"
        font-style="normal"
        font-weight="bold"
        font-size="192"
        id="text202-9"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
   </g>
   <g
      transform="translate(-1642.5375,-11610.962)"
@@ -448,13 +452,13 @@
     </g>
     <text
        xml:space="preserve"
-       x="5378.4146"
-       y="15436.927"
+       x="5258.0688"
+       y="15412.313"
        font-style="normal"
        font-weight="bold"
        font-size="192"
        id="text202-3"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
   </g>
   <g
      transform="translate(-151.71726,-11647.329)"
@@ -533,13 +537,13 @@
          id="tspan3104-6-5-6-0-92">Leaf</tspan></text>
     <text
        xml:space="preserve"
-       x="7520.1294"
-       y="17673.639"
+       x="7405.2607"
+       y="17670.572"
        font-style="normal"
        font-weight="bold"
        font-size="192"
        id="text202-35"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
   </g>
   <g
      transform="translate(-6817.1998,-11647.329)"
@@ -580,13 +584,13 @@
          id="tspan3104-6-5-6-0-1">Leaf</tspan></text>
     <text
        xml:space="preserve"
-       x="7521.4663"
-       y="17666.062"
+       x="7413.4688"
+       y="17670.566"
        font-style="normal"
        font-weight="bold"
        font-size="192"
        id="text202-75"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
   </g>
   <path
      style="fill:none;stroke:#000000;stroke-width:13.29812908px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow2Lend)"
@@ -622,11 +626,11 @@
      sodipodi:nodetypes="cc" />
   <text
      xml:space="preserve"
-     x="7370.856"
-     y="5997.5972"
+     x="7271.9297"
+     y="6023.2412"
      font-style="normal"
      font-weight="bold"
      font-size="192"
      id="text202-62"
-     style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+     style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
 </svg>
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index b13b7b01bb3a..acd73c7ad0f4 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -1070,13 +1070,13 @@
      inkscape:window-height="1144"
      id="namedview208"
      showgrid="true"
-     inkscape:zoom="0.6004608"
-     inkscape:cx="826.65969"
-     inkscape:cy="483.3047"
-     inkscape:window-x="66"
-     inkscape:window-y="28"
+     inkscape:zoom="0.81932583"
+     inkscape:cx="840.45848"
+     inkscape:cy="5052.4242"
+     inkscape:window-x="787"
+     inkscape:window-y="24"
      inkscape:window-maximized="0"
-     inkscape:current-layer="svg2"
+     inkscape:current-layer="g4"
      fit-margin-top="5"
      fit-margin-right="5"
      fit-margin-left="5"
@@ -1543,15 +1543,6 @@
        style="fill:none;stroke-width:0.025in"
        transform="translate(1749.0282,658.72243)"
        id="g3188">
-      <text
-         xml:space="preserve"
-         x="3305.5364"
-         y="13255.592"
-         font-style="normal"
-         font-weight="bold"
-         font-size="192"
-         id="text202-5"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;font-family:Courier">rsp-&gt;gpnum++</text>
       <g
          id="g3107-62"
          transform="translate(947.90548,11584.029)">
@@ -1584,6 +1575,17 @@
          sodipodi:linespacing="125%"><tspan
            style="font-size:159.57754517px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:start;line-height:125%;writing-mode:lr-tb;text-anchor:start;font-family:Liberation Sans;-inkscape-font-specification:Liberation Sans"
            id="tspan3104-6-5-7">Root</tspan></text>
+      <text
+         xml:space="preserve"
+         x="3137.9988"
+         y="13271.316"
+         font-style="normal"
+         font-weight="bold"
+         font-size="192"
+         id="text202-626"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+           style="font-size:172.87567139px"
+           id="tspan3071">rcu_seq_start(rsp-&gt;gp_seq)</tspan></text>
     </g>
     <rect
        ry="0"
@@ -2318,15 +2320,6 @@
        style="fill:none;stroke-width:0.025in"
        transform="translate(1739.0986,17188.625)"
        id="g3188-6">
-      <text
-         xml:space="preserve"
-         x="3305.5364"
-         y="13255.592"
-         font-style="normal"
-         font-weight="bold"
-         font-size="192"
-         id="text202-1"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
       <g
          id="g3107-5"
          transform="translate(947.90548,11584.029)">
@@ -2359,6 +2352,15 @@
          sodipodi:linespacing="125%"><tspan
            style="font-size:159.57754517px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:start;line-height:125%;writing-mode:lr-tb;text-anchor:start;font-family:Liberation Sans;-inkscape-font-specification:Liberation Sans"
            id="tspan3104-6-5-1">Root</tspan></text>
+      <text
+         xml:space="preserve"
+         x="3147.9268"
+         y="13240.524"
+         font-style="normal"
+         font-weight="bold"
+         font-size="192"
+         id="text202-1"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
     </g>
     <g
        style="fill:none;stroke-width:0.025in"
@@ -2387,13 +2389,13 @@
       </g>
       <text
          xml:space="preserve"
-         x="5392.3345"
-         y="15407.104"
+         x="5263.1094"
+         y="15411.646"
          font-style="normal"
          font-weight="bold"
          font-size="192"
-         id="text202-6-7"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+         id="text202-92"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
     </g>
     <g
        style="fill:none;stroke-width:0.025in"
@@ -2434,13 +2436,13 @@
            id="tspan3104-6-5-6-0-94">Leaf</tspan></text>
       <text
          xml:space="preserve"
-         x="7536.4883"
-         y="17640.934"
+         x="7417.4053"
+         y="17655.502"
          font-style="normal"
          font-weight="bold"
          font-size="192"
-         id="text202-9"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+         id="text202-759"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
     </g>
     <g
        transform="translate(-2353.8462,17224.992)"
@@ -2469,13 +2471,13 @@
       </g>
       <text
          xml:space="preserve"
-         x="5378.4146"
-         y="15436.927"
+         x="5246.1548"
+         y="15411.648"
          font-style="normal"
          font-weight="bold"
          font-size="192"
-         id="text202-3"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+         id="text202-87"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
     </g>
     <g
        transform="translate(-863.02613,17188.625)"
@@ -2554,13 +2556,13 @@
            id="tspan3104-6-5-6-0-92-6">Leaf</tspan></text>
       <text
          xml:space="preserve"
-         x="7520.1294"
-         y="17673.639"
+         x="7433.8257"
+         y="17682.098"
          font-style="normal"
          font-weight="bold"
          font-size="192"
-         id="text202-35"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+         id="text202-2"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
     </g>
     <g
        transform="translate(-7528.5085,17188.625)"
@@ -2601,13 +2603,13 @@
            id="tspan3104-6-5-6-0-1-8">Leaf</tspan></text>
       <text
          xml:space="preserve"
-         x="7521.4663"
-         y="17666.062"
+         x="7415.4404"
+         y="17682.098"
          font-style="normal"
          font-weight="bold"
          font-size="192"
-         id="text202-75-1"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
+         id="text202-0"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
     </g>
     <path
        style="fill:none;stroke:#000000;stroke-width:13.29812813px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow2Lend)"
@@ -2641,15 +2643,6 @@
        id="path3414-8-3-6-4"
        inkscape:connector-curvature="0"
        sodipodi:nodetypes="cc" />
-    <text
-       xml:space="preserve"
-       x="6659.5469"
-       y="34833.551"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       id="text202-62"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gpnum = rsp-&gt;gpnum</text>
     <path
        sodipodi:nodetypes="ccc"
        inkscape:connector-curvature="0"
@@ -3844,7 +3837,7 @@
          font-weight="bold"
          font-size="192"
          id="text202-6-6-5"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rdp-&gt;gpnum</text>
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rdp-&gt;gp_seq</text>
       <text
          xml:space="preserve"
          x="5035.4155"
@@ -4284,15 +4277,6 @@
        style="fill:none;stroke-width:0.025in"
        transform="translate(1874.038,53203.538)"
        id="g3188-7">
-      <text
-         xml:space="preserve"
-         x="3199.1516"
-         y="13255.592"
-         font-style="normal"
-         font-weight="bold"
-         font-size="192"
-         id="text202-82"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
       <g
          id="g3107-53"
          transform="translate(947.90548,11584.029)">
@@ -4325,6 +4309,17 @@
          sodipodi:linespacing="125%"><tspan
            style="font-size:159.57754517px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:start;line-height:125%;writing-mode:lr-tb;text-anchor:start;font-family:Liberation Sans;-inkscape-font-specification:Liberation Sans"
            id="tspan3104-6-5-19">Root</tspan></text>
+      <text
+         xml:space="preserve"
+         x="3175.896"
+         y="13240.11"
+         font-style="normal"
+         font-weight="bold"
+         font-size="192"
+         id="text202-36-3"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+           style="font-size:172.87567139px"
+           id="tspan3166">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
     </g>
     <rect
        ry="0"
@@ -4371,13 +4366,15 @@
       </g>
       <text
          xml:space="preserve"
-         x="5324.5371"
-         y="15414.598"
+         x="5264.4829"
+         y="15411.231"
          font-style="normal"
          font-weight="bold"
          font-size="192"
-         id="text202-753"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
+         id="text202-36-7"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+           style="font-size:172.87567139px"
+           id="tspan3166-5">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
     </g>
     <g
        style="fill:none;stroke-width:0.025in"
@@ -4412,30 +4409,12 @@
        sodipodi:linespacing="125%"><tspan
          style="font-size:159.57754517px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:start;line-height:125%;writing-mode:lr-tb;text-anchor:start;font-family:Liberation Sans;-inkscape-font-specification:Liberation Sans"
          id="tspan3104-6-5-6-0-4">Leaf</tspan></text>
-    <text
-       xml:space="preserve"
-       x="10084.225"
-       y="70903.312"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       id="text202-9-0"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
     <path
        sodipodi:nodetypes="ccc"
        inkscape:connector-curvature="0"
        id="path3134-9-0-3-9"
        d="m 6315.6122,72629.054 -20.9533,8108.684 1648.968,0"
        style="fill:none;stroke:#969696;stroke-width:53.19251251;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;marker-end:url(#Arrow1Send)" />
-    <text
-       xml:space="preserve"
-       x="5092.4683"
-       y="74111.672"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       id="text202-60"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rsp-&gt;completed =</text>
     <g
        style="fill:none;stroke-width:0.025in"
        id="g3107-62-6"
@@ -4469,15 +4448,6 @@
        sodipodi:linespacing="125%"><tspan
          style="font-size:159.57754517px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:start;line-height:125%;writing-mode:lr-tb;text-anchor:start;font-family:Liberation Sans;-inkscape-font-specification:Liberation Sans"
          id="tspan3104-6-5-7-7">Root</tspan></text>
-    <text
-       xml:space="preserve"
-       x="5092.4683"
-       y="74325.906"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       id="text202-60-3"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">       rnp-&gt;completed</text>
     <g
        style="fill:none;stroke-width:0.025in"
        transform="translate(1746.2528,60972.572)"
@@ -4736,13 +4706,15 @@
       </g>
       <text
          xml:space="preserve"
-         x="5327.3057"
-         y="15428.84"
+         x="5274.1216"
+         y="15411.231"
          font-style="normal"
          font-weight="bold"
          font-size="192"
          id="text202-36"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+           style="font-size:172.87567139px"
+           id="tspan3166-6">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
     </g>
     <g
        transform="translate(-728.08545,53203.538)"
@@ -4821,13 +4793,15 @@
            id="tspan3104-6-5-6-0-92-5">Leaf</tspan></text>
       <text
          xml:space="preserve"
-         x="7486.4907"
-         y="17670.119"
+         x="7435.1987"
+         y="17708.281"
          font-style="normal"
          font-weight="bold"
          font-size="192"
-         id="text202-6-2"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
+         id="text202-36-9"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+           style="font-size:172.87567139px"
+           id="tspan3166-1">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
     </g>
     <g
        transform="translate(-7393.5687,53203.538)"
@@ -4868,13 +4842,15 @@
            id="tspan3104-6-5-6-0-1-5">Leaf</tspan></text>
       <text
          xml:space="preserve"
-         x="7474.1382"
-         y="17688.926"
+         x="7416.8125"
+         y="17708.281"
          font-style="normal"
          font-weight="bold"
          font-size="192"
-         id="text202-5-1"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
+         id="text202-36-35"
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+           style="font-size:172.87567139px"
+           id="tspan3166-62">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
     </g>
     <path
        style="fill:none;stroke:#000000;stroke-width:13.29812813px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow2Lend)"
@@ -4908,15 +4884,6 @@
        id="path3414-8-3-6-67"
        inkscape:connector-curvature="0"
        sodipodi:nodetypes="cc" />
-    <text
-       xml:space="preserve"
-       x="6742.6001"
-       y="70882.617"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       id="text202-2"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;completed = -&gt;gpnum</text>
     <g
        style="fill:none;stroke-width:0.025in"
        id="g4504-3-9-6"
@@ -5131,5 +5098,47 @@
        font-size="192"
        id="text202-7-9-6-6-7"
        style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_do_batch()</text>
+    <text
+       xml:space="preserve"
+       x="6698.9019"
+       y="70885.211"
+       font-style="normal"
+       font-weight="bold"
+       font-size="192"
+       id="text202-36-2"
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+         style="font-size:172.87567139px"
+         id="tspan3166-7">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
+    <text
+       xml:space="preserve"
+       x="10023.457"
+       y="70885.234"
+       font-style="normal"
+       font-weight="bold"
+       font-size="192"
+       id="text202-36-0"
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+         style="font-size:172.87567139px"
+         id="tspan3166-9">rcu_seq_end(&amp;rnp-&gt;gp_seq)</tspan></text>
+    <text
+       xml:space="preserve"
+       x="5023.3389"
+       y="74209.773"
+       font-style="normal"
+       font-weight="bold"
+       font-size="192"
+       id="text202-36-36"
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"><tspan
+         style="font-size:172.87567139px"
+         id="tspan3166-0">rcu_seq_end(&amp;rsp-&gt;gp_seq)</tspan></text>
+    <text
+       xml:space="preserve"
+       x="6562.5884"
+       y="34870.727"
+       font-style="normal"
+       font-weight="bold"
+       font-size="192"
+       id="text202-3"
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">-&gt;gp_seq = rsp-&gt;gp_seq</text>
   </g>
 </svg>
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
index de3992f4cbe1..149bec2a4493 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
@@ -300,13 +300,13 @@
      inkscape:window-height="1144"
      id="namedview208"
      showgrid="true"
-     inkscape:zoom="0.70710678"
-     inkscape:cx="616.47598"
-     inkscape:cy="595.41964"
-     inkscape:window-x="813"
+     inkscape:zoom="0.96484375"
+     inkscape:cx="507.0191"
+     inkscape:cy="885.62207"
+     inkscape:window-x="47"
      inkscape:window-y="28"
      inkscape:window-maximized="0"
-     inkscape:current-layer="g4405"
+     inkscape:current-layer="g3115"
      fit-margin-top="5"
      fit-margin-right="5"
      fit-margin-left="5"
@@ -710,7 +710,7 @@
          font-weight="bold"
          font-size="192"
          id="text202-6-6"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rdp-&gt;gpnum</text>
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rdp-&gt;gp_seq</text>
       <text
          xml:space="preserve"
          x="5035.4155"
-- 
2.17.1

