Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965C3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C053820871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C053820871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeKLFq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:46:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbeKLFqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:46:25 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJs3L2140020
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:56 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdcu1xqv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:55 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:56:54 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:56:48 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJul4S42139684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:56:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF7BDB206B;
        Sun, 11 Nov 2018 19:56:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34710B2066;
        Sun, 11 Nov 2018 19:56:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:56:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 037B116C5D9C; Sun, 11 Nov 2018 11:56:47 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        kernel-team@android.com,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 06/20] doc: rcu: Update Data-Structures for RCU flavor consolidation
Date:   Sun, 11 Nov 2018 11:56:31 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111195619.GA6958@linux.ibm.com>
References: <20181111195619.GA6958@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0068-0000-0000-0000035E48D0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116023; UDB=6.00578735; IPR=6.00896124;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:56:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0069-0000-0000-00004664501F
Message-Id: <20181111195645.9205-6-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This patch updates all Data-Structures document figures and text and
removes some unwanted figures, to reflect the recent work Paul has been
doing with consolidating all flavors of RCU.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: <kernel-team@android.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../Data-Structures/BigTreeClassicRCUBH.svg   | 499 -----------
 .../BigTreePreemptRCUBHdyntick.svg            | 741 ----------------
 .../BigTreePreemptRCUBHdyntickCB.svg          | 834 +++++++-----------
 .../Data-Structures/Data-Structures.html      |  49 +-
 .../RCU/Design/Data-Structures/blkd_task.svg  | 676 +++++---------
 5 files changed, 559 insertions(+), 2240 deletions(-)
 delete mode 100644 Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBH.svg
 delete mode 100644 Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntick.svg

diff --git a/Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBH.svg b/Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBH.svg
deleted file mode 100644
index 9bbb1944f962..000000000000
--- a/Documentation/RCU/Design/Data-Structures/BigTreeClassicRCUBH.svg
+++ /dev/null
@@ -1,499 +0,0 @@
-<?xml version="1.0" encoding="UTF-8" standalone="no"?>
-<!-- Creator: fig2dev Version 3.2 Patchlevel 5e -->
-
-<!-- CreationDate: Wed Dec  9 17:26:09 2015 -->
-
-<!-- Magnification: 2.000 -->
-
-<svg
-   xmlns:dc="http://purl.org/dc/elements/1.1/"
-   xmlns:cc="http://creativecommons.org/ns#"
-   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
-   xmlns:svg="http://www.w3.org/2000/svg"
-   xmlns="http://www.w3.org/2000/svg"
-   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
-   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
-   width="5.7in"
-   height="6.6in"
-   viewBox="-44 -44 6838 7888"
-   id="svg2"
-   version="1.1"
-   inkscape:version="0.48.4 r9939"
-   sodipodi:docname="BigTreeClassicRCUBH.fig">
-  <metadata
-     id="metadata110">
-    <rdf:RDF>
-      <cc:Work
-         rdf:about="">
-        <dc:format>image/svg+xml</dc:format>
-        <dc:type
-           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
-        <dc:title></dc:title>
-      </cc:Work>
-    </rdf:RDF>
-  </metadata>
-  <defs
-     id="defs108">
-    <marker
-       inkscape:stockid="Arrow1Mend"
-       orient="auto"
-       refY="0.0"
-       refX="0.0"
-       id="Arrow1Mend"
-       style="overflow:visible;">
-      <path
-         id="path3868"
-         d="M 0.0,0.0 L 5.0,-5.0 L -12.5,0.0 L 5.0,5.0 L 0.0,0.0 z "
-         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.0pt;"
-         transform="scale(0.4) rotate(180) translate(10,0)" />
-    </marker>
-    <marker
-       inkscape:stockid="Arrow2Mend"
-       orient="auto"
-       refY="0.0"
-       refX="0.0"
-       id="Arrow2Mend"
-       style="overflow:visible;">
-      <path
-         id="path3886"
-         style="fill-rule:evenodd;stroke-width:0.62500000;stroke-linejoin:round;"
-         d="M 8.7185878,4.0337352 L -2.2072895,0.016013256 L 8.7185884,-4.0017078 C 6.9730900,-1.6296469 6.9831476,1.6157441 8.7185878,4.0337352 z "
-         transform="scale(0.6) rotate(180) translate(0,0)" />
-    </marker>
-  </defs>
-  <sodipodi:namedview
-     pagecolor="#ffffff"
-     bordercolor="#666666"
-     borderopacity="1"
-     objecttolerance="10"
-     gridtolerance="10"
-     guidetolerance="10"
-     inkscape:pageopacity="0"
-     inkscape:pageshadow="2"
-     inkscape:window-width="878"
-     inkscape:window-height="1148"
-     id="namedview106"
-     showgrid="false"
-     inkscape:zoom="1.3547758"
-     inkscape:cx="256.5"
-     inkscape:cy="297"
-     inkscape:window-x="45"
-     inkscape:window-y="24"
-     inkscape:window-maximized="0"
-     inkscape:current-layer="g4" />
-  <g
-     style="stroke-width:.025in; fill:none"
-     id="g4">
-    <!-- Line: box -->
-    <rect
-       x="450"
-       y="0"
-       width="6300"
-       height="7350"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
-       id="rect6" />
-    <!-- Line: box -->
-    <rect
-       x="4950"
-       y="4950"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect8" />
-    <!-- Line: box -->
-    <rect
-       x="750"
-       y="600"
-       width="5700"
-       height="3750"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
-       id="rect10" />
-    <!-- Line: box -->
-    <rect
-       x="0"
-       y="450"
-       width="6300"
-       height="7350"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
-       id="rect12" />
-    <!-- Line: box -->
-    <rect
-       x="300"
-       y="1050"
-       width="5700"
-       height="3750"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
-       id="rect14" />
-    <!-- Circle -->
-    <circle
-       cx="2850"
-       cy="3900"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle16" />
-    <!-- Circle -->
-    <circle
-       cx="3150"
-       cy="3900"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle18" />
-    <!-- Circle -->
-    <circle
-       cx="3450"
-       cy="3900"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle20" />
-    <!-- Circle -->
-    <circle
-       cx="1350"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle22" />
-    <!-- Circle -->
-    <circle
-       cx="1650"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle24" />
-    <!-- Circle -->
-    <circle
-       cx="1950"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle26" />
-    <!-- Circle -->
-    <circle
-       cx="4350"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle28" />
-    <!-- Circle -->
-    <circle
-       cx="4650"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle30" />
-    <!-- Circle -->
-    <circle
-       cx="4950"
-       cy="5100"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle32" />
-    <!-- Line -->
-    <polyline
-       points="1350,3450 2350,2590 "
-       style="stroke:#00d1d1;stroke-width:30.0045575;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline34" />
-    <!-- Arrowhead on XXXpoint 1350 3450 - 2444 2510-->
-    <!-- Line -->
-    <polyline
-       points="4950,3450 3948,2590 "
-       style="stroke:#00d1d1;stroke-width:30.0045575;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline38" />
-    <!-- Arrowhead on XXXpoint 4950 3450 - 3854 2510-->
-    <!-- Line: box -->
-    <rect
-       x="750"
-       y="3450"
-       width="1800"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
-       id="rect42" />
-    <!-- Line -->
-    <polyline
-       points="2250,5400 2250,4414 "
-       style="stroke:#00d1d1;stroke-width:30.0045575;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline44" />
-    <!-- Arrowhead on XXXpoint 2250 5400 - 2250 4290-->
-    <!-- Line: box -->
-    <rect
-       x="1500"
-       y="5400"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect48" />
-    <!-- Line: box -->
-    <rect
-       x="300"
-       y="6600"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect50" />
-    <!-- Line: box -->
-    <rect
-       x="3750"
-       y="3450"
-       width="1800"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
-       id="rect52" />
-    <!-- Line: box -->
-    <rect
-       x="4500"
-       y="5400"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect54" />
-    <!-- Line: box -->
-    <rect
-       x="3300"
-       y="6600"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect56" />
-    <!-- Line: box -->
-    <rect
-       x="2250"
-       y="1650"
-       width="1800"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
-       id="rect58" />
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="6450"
-       y="300"
-       fill="#000000"
-       font-family="Helvetica"
-       font-style="normal"
-       font-weight="normal"
-       font-size="192"
-       text-anchor="end"
-       id="text60">rcu_bh</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="3150"
-       y="1950"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text62">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="3150"
-       y="2250"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text64">rcu_node</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1650"
-       y="3750"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text66">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1650"
-       y="4050"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text68">rcu_node</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4650"
-       y="4050"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text70">rcu_node</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4650"
-       y="3750"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text72">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2250"
-       y="5700"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text74">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2250"
-       y="6000"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text76">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="6900"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text78">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="7200"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text80">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5250"
-       y="5700"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text82">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5250"
-       y="6000"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text84">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="6900"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text86">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="7200"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text88">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="450"
-       y="1350"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="start"
-       id="text90">struct rcu_state</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="6000"
-       y="750"
-       fill="#000000"
-       font-family="Helvetica"
-       font-style="normal"
-       font-weight="normal"
-       font-size="192"
-       text-anchor="end"
-       id="text92">rcu_sched</text>
-    <!-- Line -->
-    <polyline
-       points="5250,5400 5250,4414 "
-       style="stroke:#00d1d1;stroke-width:30.0045575;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline94" />
-    <!-- Arrowhead on XXXpoint 5250 5400 - 5250 4290-->
-    <!-- Line -->
-    <polyline
-       points="4050,6600 4050,4414 "
-       style="stroke:#00d1d1;stroke-width:30.0045575;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline98" />
-    <!-- Arrowhead on XXXpoint 4050 6600 - 4050 4290-->
-    <!-- Line -->
-    <polyline
-       points="1050,6600 1050,4414 "
-       style="stroke:#00d1d1;stroke-width:30.0045575;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline102" />
-    <!-- Arrowhead on XXXpoint 1050 6600 - 1050 4290-->
-  </g>
-</svg>
diff --git a/Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntick.svg b/Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntick.svg
deleted file mode 100644
index 15adcac036c7..000000000000
--- a/Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntick.svg
+++ /dev/null
@@ -1,741 +0,0 @@
-<?xml version="1.0" encoding="UTF-8" standalone="no"?>
-<!-- Creator: fig2dev Version 3.2 Patchlevel 5e -->
-
-<!-- CreationDate: Wed Dec  9 17:32:59 2015 -->
-
-<!-- Magnification: 2.000 -->
-
-<svg
-   xmlns:dc="http://purl.org/dc/elements/1.1/"
-   xmlns:cc="http://creativecommons.org/ns#"
-   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
-   xmlns:svg="http://www.w3.org/2000/svg"
-   xmlns="http://www.w3.org/2000/svg"
-   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
-   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
-   width="6.1in"
-   height="8.9in"
-   viewBox="-44 -44 7288 10738"
-   id="svg2"
-   version="1.1"
-   inkscape:version="0.48.4 r9939"
-   sodipodi:docname="BigTreePreemptRCUBHdyntick.fig">
-  <metadata
-     id="metadata182">
-    <rdf:RDF>
-      <cc:Work
-         rdf:about="">
-        <dc:format>image/svg+xml</dc:format>
-        <dc:type
-           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
-        <dc:title></dc:title>
-      </cc:Work>
-    </rdf:RDF>
-  </metadata>
-  <defs
-     id="defs180">
-    <marker
-       inkscape:stockid="Arrow1Mend"
-       orient="auto"
-       refY="0.0"
-       refX="0.0"
-       id="Arrow1Mend"
-       style="overflow:visible;">
-      <path
-         id="path3940"
-         d="M 0.0,0.0 L 5.0,-5.0 L -12.5,0.0 L 5.0,5.0 L 0.0,0.0 z "
-         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.0pt;"
-         transform="scale(0.4) rotate(180) translate(10,0)" />
-    </marker>
-  </defs>
-  <sodipodi:namedview
-     pagecolor="#ffffff"
-     bordercolor="#666666"
-     borderopacity="1"
-     objecttolerance="10"
-     gridtolerance="10"
-     guidetolerance="10"
-     inkscape:pageopacity="0"
-     inkscape:pageshadow="2"
-     inkscape:window-width="874"
-     inkscape:window-height="1148"
-     id="namedview178"
-     showgrid="false"
-     inkscape:zoom="1.2097379"
-     inkscape:cx="274.5"
-     inkscape:cy="400.49997"
-     inkscape:window-x="946"
-     inkscape:window-y="24"
-     inkscape:window-maximized="0"
-     inkscape:current-layer="g4" />
-  <g
-     style="stroke-width:.025in; fill:none"
-     id="g4">
-    <!-- Line: box -->
-    <rect
-       x="900"
-       y="0"
-       width="6300"
-       height="7350"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
-       id="rect6" />
-    <!-- Line: box -->
-    <rect
-       x="1200"
-       y="600"
-       width="5700"
-       height="3750"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
-       id="rect8" />
-    <!-- Line: box -->
-    <rect
-       x="5400"
-       y="4950"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect10" />
-    <!-- Line: box -->
-    <rect
-       x="450"
-       y="450"
-       width="6300"
-       height="7350"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
-       id="rect12" />
-    <!-- Line: box -->
-    <rect
-       x="750"
-       y="1050"
-       width="5700"
-       height="3750"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
-       id="rect14" />
-    <!-- Line: box -->
-    <rect
-       x="4950"
-       y="5400"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect16" />
-    <!-- Line -->
-    <polyline
-       points="5250,8550 5688,6362 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline18" />
-    <!-- Arrowhead on XXXpoint 5250 8550 - 5710 6240-->
-    <polyline
-       points="5714 6518 5704 6272 5598 6494 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline20" />
-    <!-- Line -->
-    <polyline
-       points="4050,9750 4486,7712 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline22" />
-    <!-- Arrowhead on XXXpoint 4050 9750 - 4512 7590-->
-    <polyline
-       points="4514 7868 4506 7622 4396 7844 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline24" />
-    <!-- Line -->
-    <polyline
-       points="1040,9750 1476,7712 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline26" />
-    <!-- Arrowhead on XXXpoint 1040 9750 - 1502 7590-->
-    <polyline
-       points="1504 7868 1496 7622 1386 7844 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline28" />
-    <!-- Line -->
-    <polyline
-       points="2240,8550 2676,6512 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline30" />
-    <!-- Arrowhead on XXXpoint 2240 8550 - 2702 6390-->
-    <polyline
-       points="2704 6668 2696 6422 2586 6644 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline32" />
-    <!-- Line -->
-    <polyline
-       points="4050,9750 5682,6360 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline34" />
-    <!-- Arrowhead on XXXpoint 4050 9750 - 5736 6246-->
-    <polyline
-       points="5672 6518 5722 6276 5562 6466 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline36" />
-    <!-- Line -->
-    <polyline
-       points="1010,9750 2642,6360 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline38" />
-    <!-- Arrowhead on XXXpoint 1010 9750 - 2696 6246-->
-    <polyline
-       points="2632 6518 2682 6276 2522 6466 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline40" />
-    <!-- Line: box -->
-    <rect
-       x="0"
-       y="900"
-       width="6300"
-       height="7350"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
-       id="rect42" />
-    <!-- Line: box -->
-    <rect
-       x="300"
-       y="1500"
-       width="5700"
-       height="3750"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
-       id="rect44" />
-    <!-- Line -->
-    <polyline
-       points="1350,3900 2350,3040 "
-       style="stroke:#00d1d1;stroke-width:30.00205472;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline46" />
-    <!-- Arrowhead on XXXpoint 1350 3900 - 2444 2960-->
-    <!-- Line -->
-    <polyline
-       points="4950,3900 3948,3040 "
-       style="stroke:#00d1d1;stroke-width:30.00205472;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline50" />
-    <!-- Arrowhead on XXXpoint 4950 3900 - 3854 2960-->
-    <!-- Line -->
-    <polyline
-       points="4050,7050 4050,4864 "
-       style="stroke:#00d1d1;stroke-width:30.00205472;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline54" />
-    <!-- Arrowhead on XXXpoint 4050 7050 - 4050 4740-->
-    <!-- Line -->
-    <polyline
-       points="1050,7050 1050,4864 "
-       style="stroke:#00d1d1;stroke-width:30.00205472;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline58" />
-    <!-- Arrowhead on XXXpoint 1050 7050 - 1050 4740-->
-    <!-- Line -->
-    <polyline
-       points="2250,5850 2250,4864 "
-       style="stroke:#00d1d1;stroke-width:30.00205472;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline62" />
-    <!-- Arrowhead on XXXpoint 2250 5850 - 2250 4740-->
-    <!-- Line -->
-    <polyline
-       points="2250,8550 2250,6814 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline66" />
-    <!-- Arrowhead on XXXpoint 2250 8550 - 2250 6690-->
-    <!-- Line -->
-    <polyline
-       points="1050,9750 1050,8014 "
-       style="stroke:#00ff00;stroke-width:30.00205472;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline70" />
-    <!-- Arrowhead on XXXpoint 1050 9750 - 1050 7890-->
-    <!-- Line -->
-    <polyline
-       points="4050,9750 4050,8014 "
-       style="stroke:#00ff00;stroke-width:30.00205472;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline74" />
-    <!-- Arrowhead on XXXpoint 4050 9750 - 4050 7890-->
-    <!-- Line -->
-    <polyline
-       points="5250,8550 5250,6814 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline78" />
-    <!-- Arrowhead on XXXpoint 5250 8550 - 5250 6690-->
-    <!-- Circle -->
-    <circle
-       cx="2850"
-       cy="4350"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle82" />
-    <!-- Circle -->
-    <circle
-       cx="3150"
-       cy="4350"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle84" />
-    <!-- Circle -->
-    <circle
-       cx="3450"
-       cy="4350"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle86" />
-    <!-- Circle -->
-    <circle
-       cx="1350"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle88" />
-    <!-- Circle -->
-    <circle
-       cx="1650"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle90" />
-    <!-- Circle -->
-    <circle
-       cx="1950"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle92" />
-    <!-- Circle -->
-    <circle
-       cx="4350"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle94" />
-    <!-- Circle -->
-    <circle
-       cx="4650"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle96" />
-    <!-- Circle -->
-    <circle
-       cx="4950"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle98" />
-    <!-- Line: box -->
-    <rect
-       x="750"
-       y="3900"
-       width="1800"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
-       id="rect100" />
-    <!-- Line: box -->
-    <rect
-       x="300"
-       y="7050"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect102" />
-    <!-- Line: box -->
-    <rect
-       x="3750"
-       y="3900"
-       width="1800"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
-       id="rect104" />
-    <!-- Line: box -->
-    <rect
-       x="4500"
-       y="5850"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect106" />
-    <!-- Line: box -->
-    <rect
-       x="3300"
-       y="7050"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect108" />
-    <!-- Line: box -->
-    <rect
-       x="2250"
-       y="2100"
-       width="1800"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
-       id="rect110" />
-    <!-- Line: box -->
-    <rect
-       x="0"
-       y="9750"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect112" />
-    <!-- Line: box -->
-    <rect
-       x="1350"
-       y="8550"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect114" />
-    <!-- Line: box -->
-    <rect
-       x="3000"
-       y="9750"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect116" />
-    <!-- Line: box -->
-    <rect
-       x="4350"
-       y="8550"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect118" />
-    <!-- Line: box -->
-    <rect
-       x="1500"
-       y="5850"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect120" />
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="6450"
-       y="750"
-       fill="#000000"
-       font-family="Helvetica"
-       font-style="normal"
-       font-weight="normal"
-       font-size="192"
-       text-anchor="end"
-       id="text122">rcu_bh</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="3150"
-       y="2400"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text124">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="3150"
-       y="2700"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text126">rcu_node</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1650"
-       y="4200"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text128">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1650"
-       y="4500"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text130">rcu_node</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4650"
-       y="4500"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text132">rcu_node</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4650"
-       y="4200"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text134">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2250"
-       y="6150"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text136">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2250"
-       y="6450"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text138">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="7350"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text140">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="7650"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text142">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5250"
-       y="6150"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text144">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5250"
-       y="6450"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text146">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="7350"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text148">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="7650"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text150">rcu_data</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="450"
-       y="1800"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="start"
-       id="text152">struct rcu_state</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="10050"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text154">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="10350"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text156">rcu_dynticks</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="10050"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text158">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="10350"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text160">rcu_dynticks</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2400"
-       y="8850"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text162">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2400"
-       y="9150"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text164">rcu_dynticks</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5400"
-       y="8850"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text166">struct</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5400"
-       y="9150"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text168">rcu_dynticks</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="6900"
-       y="300"
-       fill="#000000"
-       font-family="Helvetica"
-       font-style="normal"
-       font-weight="normal"
-       font-size="192"
-       text-anchor="end"
-       id="text170">rcu_preempt</text>
-    <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="6000"
-       y="1200"
-       fill="#000000"
-       font-family="Helvetica"
-       font-style="normal"
-       font-weight="normal"
-       font-size="192"
-       text-anchor="end"
-       id="text172">rcu_sched</text>
-    <!-- Line -->
-    <polyline
-       points="5250,5850 5250,4864 "
-       style="stroke:#00d1d1;stroke-width:30.00205472;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline174" />
-    <!-- Arrowhead on XXXpoint 5250 5850 - 5250 4740-->
-  </g>
-</svg>
diff --git a/Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntickCB.svg b/Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntickCB.svg
index bbc3801470d0..3a1a4f85dc3a 100644
--- a/Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntickCB.svg
+++ b/Documentation/RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntickCB.svg
@@ -13,12 +13,12 @@
    xmlns="http://www.w3.org/2000/svg"
    xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
    xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
-   width="7.4in"
-   height="9.9in"
-   viewBox="-44 -44 8938 11938"
+   width="7.4000001in"
+   height="7.9000001in"
+   viewBox="-44 -44 8938 9526.283"
    id="svg2"
    version="1.1"
-   inkscape:version="0.48.4 r9939"
+   inkscape:version="0.92.2pre0 (973e216, 2017-07-25)"
    sodipodi:docname="BigTreePreemptRCUBHdyntickCB.svg">
   <metadata
      id="metadata212">
@@ -37,15 +37,46 @@
     <marker
        inkscape:stockid="Arrow1Mend"
        orient="auto"
-       refY="0.0"
-       refX="0.0"
+       refY="0"
+       refX="0"
+       id="marker1177"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path897"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;stroke-opacity:1"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Lend"
+       orient="auto"
+       refY="0"
+       refX="0"
+       id="Arrow1Lend"
+       style="overflow:visible"
+       inkscape:isstock="true">
+      <path
+         id="path891"
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt;stroke-opacity:1"
+         transform="matrix(-0.8,0,0,-0.8,-10,0)"
+         inkscape:connector-curvature="0" />
+    </marker>
+    <marker
+       inkscape:stockid="Arrow1Mend"
+       orient="auto"
+       refY="0"
+       refX="0"
        id="Arrow1Mend"
-       style="overflow:visible;">
+       style="overflow:visible">
       <path
          id="path3970"
-         d="M 0.0,0.0 L 5.0,-5.0 L -12.5,0.0 L 5.0,5.0 L 0.0,0.0 z "
-         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.0pt;"
-         transform="scale(0.4) rotate(180) translate(10,0)" />
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
     </marker>
   </defs>
   <sodipodi:namedview
@@ -57,802 +88,575 @@
      guidetolerance="10"
      inkscape:pageopacity="0"
      inkscape:pageshadow="2"
-     inkscape:window-width="881"
-     inkscape:window-height="1128"
+     inkscape:window-width="1920"
+     inkscape:window-height="1019"
      id="namedview208"
      showgrid="false"
      inkscape:zoom="1.0195195"
-     inkscape:cx="333"
-     inkscape:cy="445.49997"
-     inkscape:window-x="936"
-     inkscape:window-y="24"
-     inkscape:window-maximized="0"
+     inkscape:cx="166.25478"
+     inkscape:cy="362.18693"
+     inkscape:window-x="0"
+     inkscape:window-y="0"
+     inkscape:window-maximized="1"
      inkscape:current-layer="g4" />
   <g
-     style="stroke-width:.025in; fill:none"
-     id="g4">
+     style="fill:none;stroke-width:0.025in"
+     id="g4"
+     transform="translate(0,-2415.6743)">
     <!-- Line: box -->
-    <rect
-       x="900"
-       y="0"
-       width="6300"
-       height="7350"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
-       id="rect6" />
     <!-- Line: box -->
-    <rect
-       x="1200"
-       y="600"
-       width="5700"
-       height="3750"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
-       id="rect8" />
     <!-- Line: box -->
-    <rect
-       x="5400"
-       y="4950"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect10" />
     <!-- Line: box -->
-    <rect
-       x="450"
-       y="450"
-       width="6300"
-       height="7350"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
-       id="rect12" />
     <!-- Line: box -->
-    <rect
-       x="750"
-       y="1050"
-       width="5700"
-       height="3750"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
-       id="rect14" />
     <!-- Line: box -->
-    <rect
-       x="4950"
-       y="5400"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect16" />
     <!-- Line -->
-    <polyline
-       points="5250,8550 5688,6362 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline18" />
     <!-- Arrowhead on XXXpoint 5250 8550 - 5710 6240-->
     <polyline
        points="5714 6518 5704 6272 5598 6494 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline20" />
+       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8"
+       id="polyline20"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Line -->
-    <polyline
-       points="4050,9750 4486,7712 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline22" />
     <!-- Arrowhead on XXXpoint 4050 9750 - 4512 7590-->
     <polyline
        points="4514 7868 4506 7622 4396 7844 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline24" />
+       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8"
+       id="polyline24"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Line -->
-    <polyline
-       points="1040,9750 1476,7712 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline26" />
     <!-- Arrowhead on XXXpoint 1040 9750 - 1502 7590-->
     <polyline
        points="1504 7868 1496 7622 1386 7844 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline28" />
+       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8"
+       id="polyline28"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Line -->
-    <polyline
-       points="2240,8550 2676,6512 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline30" />
     <!-- Arrowhead on XXXpoint 2240 8550 - 2702 6390-->
     <polyline
        points="2704 6668 2696 6422 2586 6644 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline32" />
+       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8"
+       id="polyline32"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Line -->
-    <polyline
-       points="4050,9600 5692,6062 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline34" />
     <!-- Arrowhead on XXXpoint 4050 9600 - 5744 5948-->
     <polyline
        points="5682 6220 5730 5978 5574 6170 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline36" />
+       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8"
+       id="polyline36"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Line -->
-    <polyline
-       points="1086,9600 2728,6062 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline38" />
     <!-- Arrowhead on XXXpoint 1086 9600 - 2780 5948-->
     <polyline
        points="2718 6220 2766 5978 2610 6170 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline40" />
+       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8"
+       id="polyline40"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Line: box -->
     <rect
-       x="0"
-       y="900"
+       x="12.340758"
+       y="2442.5947"
        width="6300"
-       height="7350"
+       height="7045.3135"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
+       style="fill:#ffffff;stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect42" />
     <!-- Line: box -->
     <rect
-       x="300"
-       y="1500"
+       x="312.34076"
+       y="3017.7224"
        width="5700"
-       height="3750"
+       height="3594.5476"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
+       style="fill:#ffff00;stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect44" />
     <!-- Line -->
     <polyline
        points="1350,3900 2350,3040 "
-       style="stroke:#00d1d1;stroke-width:29.99463964;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline46" />
+       style="stroke:#00d1d1;stroke-width:29.99464035;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline46"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Arrowhead on XXXpoint 1350 3900 - 2444 2960-->
     <!-- Line -->
     <polyline
        points="4950,3900 3948,3040 "
-       style="stroke:#00d1d1;stroke-width:29.99463964;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline50" />
+       style="stroke:#00d1d1;stroke-width:29.99464035;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline50"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Arrowhead on XXXpoint 4950 3900 - 3854 2960-->
     <!-- Line -->
     <polyline
        points="4050,7050 4050,4864 "
-       style="stroke:#00d1d1;stroke-width:29.99463964;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline54" />
+       style="stroke:#00d1d1;stroke-width:29.99464035;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline54"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Arrowhead on XXXpoint 4050 7050 - 4050 4740-->
     <!-- Line -->
     <polyline
        points="1050,7050 1050,4864 "
-       style="stroke:#00d1d1;stroke-width:29.99463964;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline58" />
+       style="stroke:#00d1d1;stroke-width:29.99464035;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline58"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Arrowhead on XXXpoint 1050 7050 - 1050 4740-->
     <!-- Line -->
     <polyline
        points="2250,5850 2250,4864 "
-       style="stroke:#00d1d1;stroke-width:29.99463964;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline62" />
+       style="stroke:#00d1d1;stroke-width:29.99464035;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline62"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Arrowhead on XXXpoint 2250 5850 - 2250 4740-->
     <!-- Line -->
-    <polyline
-       points="2250,8550 2250,6814 "
-       style="stroke:#00ff00;stroke-width:29.99463964;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline66" />
     <!-- Arrowhead on XXXpoint 2250 8550 - 2250 6690-->
     <!-- Line -->
-    <polyline
-       points="1050,9750 1050,8014 "
-       style="stroke:#00ff00;stroke-width:29.99463964;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline70" />
     <!-- Arrowhead on XXXpoint 1050 9750 - 1050 7890-->
     <!-- Line -->
-    <polyline
-       points="4050,9750 4050,8014 "
-       style="stroke:#00ff00;stroke-width:29.99463964;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline74" />
     <!-- Arrowhead on XXXpoint 4050 9750 - 4050 7890-->
     <!-- Line -->
-    <polyline
-       points="5250,8550 5250,6814 "
-       style="stroke:#00ff00;stroke-width:29.99463964;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline78" />
     <!-- Arrowhead on XXXpoint 5250 8550 - 5250 6690-->
     <!-- Line -->
-    <polyline
-       points="6000,6300 8048,7910 "
-       style="stroke:#87cfff;stroke-width:30;stroke-linejoin:miter;stroke-linecap:butt;marker-end:url(#Arrow1Mend)"
-       id="polyline82" />
     <!-- Arrowhead on XXXpoint 6000 6300 - 8146 7986-->
     <!-- Circle -->
-    <circle
-       cx="2850"
-       cy="4350"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle86" />
+    <ellipse
+       cx="2862.3408"
+       cy="5749.5786"
+       style="fill:#000000;stroke:#000000;stroke-width:13.70675087"
+       id="circle86"
+       rx="76"
+       ry="72.849495" />
     <!-- Circle -->
-    <circle
-       cx="3150"
-       cy="4350"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle88" />
+    <ellipse
+       cx="3162.3408"
+       cy="5749.5786"
+       style="fill:#000000;stroke:#000000;stroke-width:13.70675087"
+       id="circle88"
+       rx="76"
+       ry="72.849495" />
     <!-- Circle -->
-    <circle
-       cx="3450"
-       cy="4350"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle90" />
+    <ellipse
+       cx="3462.3408"
+       cy="5749.5786"
+       style="fill:#000000;stroke:#000000;stroke-width:13.70675087"
+       id="circle90"
+       rx="76"
+       ry="72.849495" />
     <!-- Circle -->
-    <circle
-       cx="1350"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle92" />
+    <ellipse
+       cx="1362.3407"
+       cy="6899.834"
+       style="fill:#000000;stroke:#000000;stroke-width:13.70675087"
+       id="circle92"
+       rx="76"
+       ry="72.849495" />
     <!-- Circle -->
-    <circle
-       cx="1650"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle94" />
+    <ellipse
+       cx="1662.3407"
+       cy="6899.834"
+       style="fill:#000000;stroke:#000000;stroke-width:13.70675087"
+       id="circle94"
+       rx="76"
+       ry="72.849495" />
     <!-- Circle -->
-    <circle
-       cx="1950"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle96" />
+    <ellipse
+       cx="1962.3407"
+       cy="6899.834"
+       style="fill:#000000;stroke:#000000;stroke-width:13.70675087"
+       id="circle96"
+       rx="76"
+       ry="72.849495" />
     <!-- Circle -->
-    <circle
-       cx="4350"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle98" />
+    <ellipse
+       cx="4362.3408"
+       cy="6899.834"
+       style="fill:#000000;stroke:#000000;stroke-width:13.70675087"
+       id="circle98"
+       rx="76"
+       ry="72.849495" />
     <!-- Circle -->
-    <circle
-       cx="4650"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle100" />
+    <ellipse
+       cx="4662.3408"
+       cy="6899.834"
+       style="fill:#000000;stroke:#000000;stroke-width:13.70675087"
+       id="circle100"
+       rx="76"
+       ry="72.849495" />
     <!-- Circle -->
-    <circle
-       cx="4950"
-       cy="5550"
-       r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
-       id="circle102" />
+    <ellipse
+       cx="4962.3408"
+       cy="6899.834"
+       style="fill:#000000;stroke:#000000;stroke-width:13.70675087"
+       id="circle102"
+       rx="76"
+       ry="72.849495" />
     <!-- Line: box -->
     <rect
-       x="7350"
-       y="7950"
+       x="6745.3027"
+       y="8146.0654"
        width="1500"
-       height="900"
+       height="862.69141"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
+       style="stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect104" />
     <!-- Line: box -->
     <rect
-       x="7350"
-       y="9450"
+       x="6745.3027"
+       y="9583.8857"
        width="1500"
-       height="900"
+       height="862.69141"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
+       style="stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect106" />
     <!-- Line -->
     <polyline
        points="8100,8850 8100,9384 "
-       style="stroke:#000000;stroke-width:30;stroke-linejoin:miter;stroke-linecap:butt;marker-end:url(#Arrow1Mend)"
-       id="polyline108" />
+       style="stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter;marker-end:url(#Arrow1Mend)"
+       id="polyline108"
+       transform="matrix(1,0,0,0.95854605,-604.69715,525.62477)" />
     <!-- Arrowhead on XXXpoint 8100 8850 - 8100 9510-->
     <!-- Line: box -->
     <rect
-       x="7350"
-       y="10950"
+       x="6745.3027"
+       y="11021.704"
        width="1500"
-       height="900"
+       height="862.69141"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
+       style="stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect112" />
     <!-- Line -->
     <polyline
        points="8100,10350 8100,10884 "
-       style="stroke:#000000;stroke-width:30;stroke-linejoin:miter;stroke-linecap:butt;marker-end:url(#Arrow1Mend)"
-       id="polyline114" />
+       style="stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter;marker-end:url(#Arrow1Mend)"
+       id="polyline114"
+       transform="matrix(1,0,0,0.95854605,-604.69715,525.62477)" />
     <!-- Arrowhead on XXXpoint 8100 10350 - 8100 11010-->
     <!-- Line: box -->
     <rect
-       x="750"
-       y="3900"
+       x="762.34076"
+       y="5318.2324"
        width="1800"
-       height="900"
+       height="862.69141"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
+       style="fill:#ffbfbf;stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect118" />
     <!-- Line: box -->
     <rect
-       x="300"
-       y="7050"
+       x="312.34076"
+       y="8337.6533"
        width="1500"
-       height="900"
+       height="862.69141"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
+       style="fill:#87cfff;stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect120" />
     <!-- Line: box -->
     <rect
-       x="3750"
-       y="3900"
+       x="3762.3408"
+       y="5318.2324"
        width="1800"
-       height="900"
+       height="862.69141"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
+       style="fill:#ffbfbf;stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect122" />
     <!-- Line: box -->
     <rect
-       x="4500"
-       y="5850"
+       x="4512.3408"
+       y="7187.3975"
        width="1500"
-       height="900"
+       height="862.69141"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
+       style="fill:#87cfff;stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect124" />
     <!-- Line: box -->
     <rect
-       x="3300"
-       y="7050"
+       x="3312.3408"
+       y="8337.6533"
        width="1500"
-       height="900"
+       height="862.69141"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
+       style="fill:#87cfff;stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect126" />
     <!-- Line: box -->
     <rect
-       x="2250"
-       y="2100"
+       x="2262.3408"
+       y="3592.8503"
        width="1800"
-       height="900"
+       height="862.69141"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
+       style="fill:#ffbfbf;stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect128" />
     <!-- Line: box -->
-    <rect
-       x="0"
-       y="9750"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect130" />
     <!-- Line: box -->
-    <rect
-       x="1350"
-       y="8550"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect132" />
     <!-- Line: box -->
-    <rect
-       x="3000"
-       y="9750"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect134" />
     <!-- Line: box -->
-    <rect
-       x="4350"
-       y="8550"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect136" />
     <!-- Line: box -->
     <rect
-       x="1500"
-       y="5850"
+       x="1512.3407"
+       y="7187.3975"
        width="1500"
-       height="900"
+       height="862.69141"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
+       style="fill:#87cfff;stroke:#000000;stroke-width:29.37160873;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect138" />
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="8100"
-       y="8250"
-       fill="#000000"
-       font-family="Courier"
+       x="7338.3037"
+       y="8614.0625"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text140">struct</text>
+       id="text140"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="8100"
-       y="8550"
-       fill="#000000"
-       font-family="Courier"
+       x="7338.3037"
+       y="8907.7783"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text142">rcu_head</text>
+       id="text142"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_head</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="8100"
-       y="9750"
-       fill="#000000"
-       font-family="Courier"
+       x="7338.3037"
+       y="10082.644"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text144">struct</text>
+       id="text144"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="8100"
-       y="10050"
-       fill="#000000"
-       font-family="Courier"
+       x="7338.3037"
+       y="10376.36"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text146">rcu_head</text>
+       id="text146"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_head</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="8100"
-       y="11250"
-       fill="#000000"
-       font-family="Courier"
+       x="7338.3037"
+       y="11551.224"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text148">struct</text>
+       id="text148"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="8100"
-       y="11550"
-       fill="#000000"
-       font-family="Courier"
+       x="7338.3037"
+       y="11844.94"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text150">rcu_head</text>
+       id="text150"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_head</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="6000"
-       y="1200"
-       fill="#000000"
-       font-family="Helvetica"
+       x="5886.4043"
+       y="2788.5688"
        font-style="normal"
        font-weight="normal"
        font-size="192"
-       text-anchor="end"
-       id="text152">rcu_sched</text>
+       id="text152"
+       style="font-style:normal;font-weight:normal;font-size:187.978302px;font-family:Helvetica;text-anchor:end;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_state</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="6450"
-       y="750"
-       fill="#000000"
-       font-family="Helvetica"
-       font-style="normal"
-       font-weight="normal"
-       font-size="192"
-       text-anchor="end"
-       id="text154">rcu_bh</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="3150"
-       y="2400"
-       fill="#000000"
-       font-family="Courier"
+       x="3096.1016"
+       y="3963.4336"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text156">struct</text>
+       id="text156"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="3150"
-       y="2700"
-       fill="#000000"
-       font-family="Courier"
+       x="3096.1016"
+       y="4257.1494"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text158">rcu_node</text>
+       id="text158"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_node</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="1650"
-       y="4200"
-       fill="#000000"
-       font-family="Courier"
+       x="1627.5209"
+       y="5725.7305"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text160">struct</text>
+       id="text160"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="1650"
-       y="4500"
-       fill="#000000"
-       font-family="Courier"
+       x="1627.5209"
+       y="6019.4463"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text162">rcu_node</text>
+       id="text162"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_node</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="4650"
-       y="4500"
-       fill="#000000"
-       font-family="Courier"
+       x="4564.6821"
+       y="6019.4463"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text164">rcu_node</text>
+       id="text164"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_node</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="4650"
-       y="4200"
-       fill="#000000"
-       font-family="Courier"
+       x="4564.6821"
+       y="5725.7305"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text166">struct</text>
+       id="text166"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="2250"
-       y="6150"
-       fill="#000000"
-       font-family="Courier"
+       x="2214.9531"
+       y="7634.8848"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text168">struct</text>
+       id="text168"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="2250"
-       y="6450"
-       fill="#000000"
-       font-family="Courier"
+       x="2214.9531"
+       y="7928.6011"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text170">rcu_data</text>
+       id="text170"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_data</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="1050"
-       y="7350"
-       fill="#000000"
-       font-family="Courier"
+       x="1040.0886"
+       y="8809.749"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text172">struct</text>
+       id="text172"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="1050"
-       y="7650"
-       fill="#000000"
-       font-family="Courier"
+       x="1040.0886"
+       y="9103.4648"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text174">rcu_data</text>
+       id="text174"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_data</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="5250"
-       y="6150"
-       fill="#000000"
-       font-family="Courier"
+       x="5152.1138"
+       y="7634.8848"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text176">struct</text>
+       id="text176"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="5250"
-       y="6450"
-       fill="#000000"
-       font-family="Courier"
+       x="5152.1138"
+       y="7928.6011"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text178">rcu_data</text>
+       id="text178"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_data</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="4050"
-       y="7350"
-       fill="#000000"
-       font-family="Courier"
+       x="3977.2495"
+       y="8809.749"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text180">struct</text>
+       id="text180"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="4050"
-       y="7650"
-       fill="#000000"
-       font-family="Courier"
+       x="3977.2495"
+       y="9103.4648"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text182">rcu_data</text>
+       id="text182"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:middle;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">rcu_data</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="450"
-       y="1800"
-       fill="#000000"
-       font-family="Courier"
+       x="452.6564"
+       y="3376.0012"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="start"
-       id="text184">struct rcu_state</text>
+       id="text184"
+       style="font-style:normal;font-weight:bold;font-size:187.978302px;font-family:Courier;text-anchor:start;fill:#000000;stroke-width:0.02447634in"
+       transform="scale(1.0213945,0.97905363)">struct rcu_state</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="10050"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text186">struct</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="10350"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text188">rcu_dynticks</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="10050"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text190">struct</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="10350"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text192">rcu_dynticks</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2400"
-       y="8850"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text194">struct</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2400"
-       y="9150"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text196">rcu_dynticks</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5400"
-       y="8850"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text198">struct</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5400"
-       y="9150"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text200">rcu_dynticks</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="6900"
-       y="300"
-       fill="#000000"
-       font-family="Helvetica"
-       font-style="normal"
-       font-weight="normal"
-       font-size="192"
-       text-anchor="end"
-       id="text202">rcu_preempt</text>
     <!-- Line -->
     <polyline
        points="5250,5850 5250,4864 "
-       style="stroke:#00d1d1;stroke-width:29.99463964;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline204" />
+       style="stroke:#00d1d1;stroke-width:29.99464035;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline204"
+       transform="matrix(1,0,0,0.95854605,12.340758,1579.9033)" />
     <!-- Arrowhead on XXXpoint 5250 5850 - 5250 4740-->
+    <path
+       style="fill:none;stroke:#000000;stroke-width:34.24744034;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;marker-end:url(#marker1177)"
+       d="m 6000.1472,7564.2558 c 1498.5508,0 1498.5508,0 1498.5508,0 v 520.0252"
+       id="path886"
+       inkscape:connector-curvature="0" />
   </g>
 </svg>
diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index 4eb603e3a005..28b241074c86 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -154,36 +154,9 @@ on that root <tt>rcu_node</tt> structure remains acceptably low.
 keeping lock contention under control at all tree levels regardless
 of the level of loading on the system.
 
-</p><p>The Linux kernel actually supports multiple flavors of RCU
-running concurrently, so RCU builds separate data structures for each
-flavor.
-For example, for <tt>CONFIG_TREE_RCU=y</tt> kernels, RCU provides
-rcu_sched and rcu_bh, as shown below:
-
-</p><p><img src="BigTreeClassicRCUBH.svg" alt="BigTreeClassicRCUBH.svg" width="33%">
-
-</p><p>Energy efficiency is increasingly important, and for that
-reason the Linux kernel provides <tt>CONFIG_NO_HZ_IDLE</tt>, which
-turns off the scheduling-clock interrupts on idle CPUs, which in
-turn allows those CPUs to attain deeper sleep states and to consume
-less energy.
-CPUs whose scheduling-clock interrupts have been turned off are
-said to be in <i>dyntick-idle mode</i>.
-RCU must handle dyntick-idle CPUs specially
-because RCU would otherwise wake up each CPU on every grace period,
-which would defeat the whole purpose of <tt>CONFIG_NO_HZ_IDLE</tt>.
-RCU uses the dynticks related fields in the <tt>rcu_data</tt> structure
-to track which CPUs are in dyntick idle mode.
-
-</p><p>Kernels built with <tt>CONFIG_PREEMPT_RCU</tt> support
-rcu_preempt in addition to rcu_sched and rcu_bh, as shown below:
-
-</p><p><img src="BigTreePreemptRCUBHdyntick.svg" alt="BigTreePreemptRCUBHdyntick.svg" width="35%">
-
 </p><p>RCU updaters wait for normal grace periods by registering
 RCU callbacks, either directly via <tt>call_rcu()</tt> and
 friends (namely <tt>call_rcu_bh()</tt> and <tt>call_rcu_sched()</tt>),
-there being a separate interface per flavor of RCU)
 or indirectly via <tt>synchronize_rcu()</tt> and friends.
 RCU callbacks are represented by <tt>rcu_head</tt> structures,
 which are queued on <tt>rcu_data</tt> structures while they are
@@ -278,7 +251,7 @@ structures.
 The <tt>rcu_state</tt> Structure</a></h3>
 
 <p>The <tt>rcu_state</tt> structure is the base structure that
-represents a flavor of RCU.
+represents the state of RCU in the system.
 This structure forms the interconnection between the
 <tt>rcu_node</tt> and <tt>rcu_data</tt> structures,
 tracks grace periods, contains the lock used to
@@ -373,7 +346,7 @@ sequence number.
 The bottom two bits are the state of the current grace period,
 which can be zero for not yet started or one for in progress.
 In other words, if the bottom two bits of <tt>-&gt;gp_seq</tt> are
-zero, the corresponding flavor of RCU is idle.
+zero, then RCU is idle.
 Any other value in the bottom two bits indicates that something is broken.
 This field is protected by the root <tt>rcu_node</tt> structure's
 <tt>-&gt;lock</tt> field.
@@ -403,10 +376,10 @@ as follows:
 grace period in jiffies.
 It is protected by the root <tt>rcu_node</tt>'s <tt>-&gt;lock</tt>.
 
-<p>The <tt>-&gt;name</tt> field points to the name of the RCU flavor
-(for example, &ldquo;rcu_sched&rdquo;), and is constant.
-The <tt>-&gt;abbr</tt> field contains a one-character abbreviation,
-for example, &ldquo;s&rdquo; for RCU-sched.
+<p>The <tt>-&gt;name</tt> and <tt>-&gt;abbr</tt> fields distinguish
+between preemptible RCU (&ldquo;rcu_preempt&rdquo; and &ldquo;p&rdquo;)
+and non-preemptible RCU (&ldquo;rcu_sched&rdquo; and &ldquo;s&rdquo;).
+These fields are used for diagnostic and tracing purposes.
 
 <h3><a name="The rcu_node Structure">
 The <tt>rcu_node</tt> Structure</a></h3>
@@ -972,8 +945,7 @@ of <tt>rcu_barrier()</tt>.
 <h3><a name="The rcu_data Structure">
 The <tt>rcu_data</tt> Structure</a></h3>
 
-<p>The <tt>rcu_data</tt> maintains the per-CPU state for the
-corresponding flavor of RCU.
+<p>The <tt>rcu_data</tt> maintains the per-CPU state for the RCU subsystem.
 The fields in this structure may be accessed only from the corresponding
 CPU (and from tracing) unless otherwise stated.
 This structure is the
@@ -1030,7 +1002,6 @@ as follows:
   3   bool cpu_no_qs;
   4   bool core_needs_qs;
   5   bool gpwrap;
-  6   unsigned long rcu_qs_ctr_snap;
 </pre>
 
 <p>The <tt>-&gt;gp_seq</tt> and <tt>-&gt;gp_seq_needed</tt>
@@ -1076,10 +1047,6 @@ CPU has remained idle for so long that the
 <tt>gp_seq</tt> counter is in danger of overflow, which
 will cause the CPU to disregard the values of its counters on
 its next exit from idle.
-Finally, the <tt>rcu_qs_ctr_snap</tt> field is used to detect
-cases where a given operation has resulted in a quiescent state
-for all flavors of RCU, for example, <tt>cond_resched()</tt>
-when RCU has indicated a need for quiescent states.
 
 <h5>RCU Callback Handling</h5>
 
@@ -1387,7 +1354,7 @@ the last part of the array, thus traversing only the leaf
 <h3><a name="Summary">
 Summary</a></h3>
 
-So each flavor of RCU is represented by an <tt>rcu_state</tt> structure,
+So the state of RCU is represented by an <tt>rcu_state</tt> structure,
 which contains a combining tree of <tt>rcu_node</tt> and
 <tt>rcu_data</tt> structures.
 Finally, in <tt>CONFIG_NO_HZ_IDLE</tt> kernels, each CPU's dyntick-idle
diff --git a/Documentation/RCU/Design/Data-Structures/blkd_task.svg b/Documentation/RCU/Design/Data-Structures/blkd_task.svg
index 00e810bb8419..bed13e9ecab8 100644
--- a/Documentation/RCU/Design/Data-Structures/blkd_task.svg
+++ b/Documentation/RCU/Design/Data-Structures/blkd_task.svg
@@ -14,12 +14,12 @@
    xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
    xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
    width="10.1in"
-   height="8.6in"
-   viewBox="-44 -44 12088 10288"
+   height="6.5999999in"
+   viewBox="-44 -44 12088 7895.4414"
    id="svg2"
    version="1.1"
-   inkscape:version="0.48.4 r9939"
-   sodipodi:docname="blkd_task.fig">
+   inkscape:version="0.92.2pre0 (973e216, 2017-07-25)"
+   sodipodi:docname="blkd_task.svg">
   <metadata
      id="metadata212">
     <rdf:RDF>
@@ -37,15 +37,16 @@
     <marker
        inkscape:stockid="Arrow1Mend"
        orient="auto"
-       refY="0.0"
-       refX="0.0"
+       refY="0"
+       refX="0"
        id="Arrow1Mend"
-       style="overflow:visible;">
+       style="overflow:visible">
       <path
          id="path3970"
-         d="M 0.0,0.0 L 5.0,-5.0 L -12.5,0.0 L 5.0,5.0 L 0.0,0.0 z "
-         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.0pt;"
-         transform="scale(0.4) rotate(180) translate(10,0)" />
+         d="M 0,0 5,-5 -12.5,0 5,5 Z"
+         style="fill-rule:evenodd;stroke:#000000;stroke-width:1.00000003pt"
+         transform="matrix(-0.4,0,0,-0.4,-4,0)"
+         inkscape:connector-curvature="0" />
     </marker>
   </defs>
   <sodipodi:namedview
@@ -57,787 +58,574 @@
      guidetolerance="10"
      inkscape:pageopacity="0"
      inkscape:pageshadow="2"
-     inkscape:window-width="1087"
-     inkscape:window-height="1144"
+     inkscape:window-width="1920"
+     inkscape:window-height="1019"
      id="namedview208"
      showgrid="false"
      inkscape:zoom="1.0495049"
-     inkscape:cx="454.50003"
-     inkscape:cy="387.00003"
-     inkscape:window-x="833"
-     inkscape:window-y="28"
-     inkscape:window-maximized="0"
-     inkscape:current-layer="g4" />
+     inkscape:cx="456.40569"
+     inkscape:cy="348.88682"
+     inkscape:window-x="0"
+     inkscape:window-y="0"
+     inkscape:window-maximized="1"
+     inkscape:current-layer="g4"
+     showguides="false" />
   <g
-     style="stroke-width:.025in; fill:none"
-     id="g4">
+     style="fill:none;stroke-width:0.025in"
+     id="g4"
+     transform="translate(0,-2393.6637)">
     <!-- Line: box -->
-    <rect
-       x="450"
-       y="0"
-       width="6300"
-       height="7350"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
-       id="rect6" />
     <!-- Line: box -->
-    <rect
-       x="4950"
-       y="4950"
-       width="1500"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
-       id="rect8" />
     <!-- Line: box -->
-    <rect
-       x="750"
-       y="600"
-       width="5700"
-       height="3750"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
-       id="rect10" />
     <!-- Line -->
-    <polyline
-       points="5250,8100 5688,5912 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline12" />
     <!-- Arrowhead on XXXpoint 5250 8100 - 5710 5790-->
     <polyline
        points="5714 6068 5704 5822 5598 6044 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline14" />
+       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8"
+       id="polyline14"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Line -->
-    <polyline
-       points="4050,9300 4486,7262 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline16" />
     <!-- Arrowhead on XXXpoint 4050 9300 - 4512 7140-->
     <polyline
        points="4514 7418 4506 7172 4396 7394 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline18" />
+       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8"
+       id="polyline18"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Line -->
-    <polyline
-       points="1040,9300 1476,7262 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline20" />
     <!-- Arrowhead on XXXpoint 1040 9300 - 1502 7140-->
     <polyline
        points="1504 7418 1496 7172 1386 7394 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline22" />
+       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8"
+       id="polyline22"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Line -->
-    <polyline
-       points="2240,8100 2676,6062 "
-       style="stroke:#00ff00;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
-       id="polyline24" />
     <!-- Arrowhead on XXXpoint 2240 8100 - 2702 5940-->
     <polyline
        points="2704 6218 2696 5972 2586 6194 "
-       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8; "
-       id="polyline26" />
+       style="stroke:#00ff00;stroke-width:14;stroke-miterlimit:8"
+       id="polyline26"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Line: box -->
     <rect
-       x="0"
-       y="450"
+       x="23.757858"
+       y="2635.7231"
        width="6300"
        height="7350"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffffff; "
+       style="fill:#ffffff;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect28" />
     <!-- Line: box -->
     <rect
-       x="300"
-       y="1050"
+       x="323.75787"
+       y="3235.7231"
        width="5700"
        height="3750"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffff00; "
+       style="fill:#ffff00;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect30" />
     <!-- Line -->
     <polyline
        points="1350,3450 2350,2590 "
-       style="stroke:#00d1d1;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline32" />
+       style="stroke:#00d1d1;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline32"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 1350 3450 - 2444 2510-->
     <!-- Line -->
     <polyline
        points="4950,3450 3948,2590 "
-       style="stroke:#00d1d1;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline36" />
+       style="stroke:#00d1d1;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline36"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 4950 3450 - 3854 2510-->
     <!-- Line -->
     <polyline
        points="4050,6600 4050,4414 "
-       style="stroke:#00d1d1;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline40" />
+       style="stroke:#00d1d1;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline40"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 4050 6600 - 4050 4290-->
     <!-- Line -->
     <polyline
        points="1050,6600 1050,4414 "
-       style="stroke:#00d1d1;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline44" />
+       style="stroke:#00d1d1;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline44"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 1050 6600 - 1050 4290-->
     <!-- Line -->
     <polyline
        points="2250,5400 2250,4414 "
-       style="stroke:#00d1d1;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline48" />
+       style="stroke:#00d1d1;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline48"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 2250 5400 - 2250 4290-->
     <!-- Line -->
-    <polyline
-       points="2250,8100 2250,6364 "
-       style="stroke:#00ff00;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline52" />
     <!-- Arrowhead on XXXpoint 2250 8100 - 2250 6240-->
     <!-- Line -->
-    <polyline
-       points="1050,9300 1050,7564 "
-       style="stroke:#00ff00;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline56" />
     <!-- Arrowhead on XXXpoint 1050 9300 - 1050 7440-->
     <!-- Line -->
-    <polyline
-       points="4050,9300 4050,7564 "
-       style="stroke:#00ff00;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline60" />
     <!-- Arrowhead on XXXpoint 4050 9300 - 4050 7440-->
     <!-- Line -->
-    <polyline
-       points="5250,8100 5250,6364 "
-       style="stroke:#00ff00;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline64" />
     <!-- Arrowhead on XXXpoint 5250 8100 - 5250 6240-->
     <!-- Circle -->
     <circle
-       cx="2850"
-       cy="3900"
+       cx="2873.7581"
+       cy="6085.7236"
        r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
+       style="fill:#000000;stroke:#000000;stroke-width:14"
        id="circle68" />
     <!-- Circle -->
     <circle
-       cx="3150"
-       cy="3900"
+       cx="3173.7581"
+       cy="6085.7236"
        r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
+       style="fill:#000000;stroke:#000000;stroke-width:14"
        id="circle70" />
     <!-- Circle -->
     <circle
-       cx="3450"
-       cy="3900"
+       cx="3473.7581"
+       cy="6085.7236"
        r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
+       style="fill:#000000;stroke:#000000;stroke-width:14"
        id="circle72" />
     <!-- Circle -->
     <circle
-       cx="1350"
-       cy="5100"
+       cx="1373.7578"
+       cy="7285.7236"
        r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
+       style="fill:#000000;stroke:#000000;stroke-width:14"
        id="circle74" />
     <!-- Circle -->
     <circle
-       cx="1650"
-       cy="5100"
+       cx="1673.7578"
+       cy="7285.7236"
        r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
+       style="fill:#000000;stroke:#000000;stroke-width:14"
        id="circle76" />
     <!-- Circle -->
     <circle
-       cx="1950"
-       cy="5100"
+       cx="1973.7578"
+       cy="7285.7236"
        r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
+       style="fill:#000000;stroke:#000000;stroke-width:14"
        id="circle78" />
     <!-- Circle -->
     <circle
-       cx="4350"
-       cy="5100"
+       cx="4373.7578"
+       cy="7285.7236"
        r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
+       style="fill:#000000;stroke:#000000;stroke-width:14"
        id="circle80" />
     <!-- Circle -->
     <circle
-       cx="4650"
-       cy="5100"
+       cx="4673.7578"
+       cy="7285.7236"
        r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
+       style="fill:#000000;stroke:#000000;stroke-width:14"
        id="circle82" />
     <!-- Circle -->
     <circle
-       cx="4950"
-       cy="5100"
+       cx="4973.7578"
+       cy="7285.7236"
        r="76"
-       style="fill:#000000;stroke:#000000;stroke-width:14;"
+       style="fill:#000000;stroke:#000000;stroke-width:14"
        id="circle84" />
     <!-- Line: box -->
     <rect
-       x="750"
-       y="3450"
+       x="773.75781"
+       y="5635.7236"
        width="1800"
        height="900"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
+       style="fill:#ffbfbf;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect86" />
     <!-- Line: box -->
     <rect
-       x="300"
-       y="6600"
+       x="323.75787"
+       y="8785.7227"
        width="1500"
        height="900"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
+       style="fill:#87cfff;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect88" />
     <!-- Line: box -->
     <rect
-       x="4500"
-       y="5400"
+       x="4523.7578"
+       y="7585.7236"
        width="1500"
        height="900"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
+       style="fill:#87cfff;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect90" />
     <!-- Line: box -->
     <rect
-       x="3300"
-       y="6600"
+       x="3323.7581"
+       y="8785.7227"
        width="1500"
        height="900"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
+       style="fill:#87cfff;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect92" />
     <!-- Line: box -->
     <rect
-       x="2250"
-       y="1650"
+       x="2273.7581"
+       y="3835.7231"
        width="1800"
        height="900"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
+       style="fill:#ffbfbf;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect94" />
     <!-- Line: box -->
-    <rect
-       x="0"
-       y="9300"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect96" />
     <!-- Line: box -->
-    <rect
-       x="1350"
-       y="8100"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect98" />
     <!-- Line: box -->
-    <rect
-       x="3000"
-       y="9300"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect100" />
     <!-- Line: box -->
-    <rect
-       x="4350"
-       y="8100"
-       width="2100"
-       height="900"
-       rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#00ff00; "
-       id="rect102" />
     <!-- Line: box -->
     <rect
-       x="1500"
-       y="5400"
+       x="1523.7578"
+       y="7585.7236"
        width="1500"
        height="900"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#87cfff; "
+       style="fill:#87cfff;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect104" />
     <!-- Line -->
     <polygon
-       points="5550,3450 7350,2850 7350,5100 5550,4350 5550,3450 "
-       style="stroke:#000000;stroke-width:14; stroke-linejoin:miter; stroke-linecap:butt; stroke-dasharray:120 120;fill:#ffbfbf; "
-       id="polygon106" />
+       points="7350,2850 7350,5100 5550,4350 5550,3450 "
+       style="fill:#ffbfbf;stroke:#000000;stroke-width:14;stroke-linecap:butt;stroke-linejoin:miter;stroke-dasharray:120, 120"
+       id="polygon106"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Line -->
     <polyline
        points="9300,3150 10734,3150 "
-       style="stroke:#000000;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline108" />
+       style="stroke:#000000;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline108"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 9300 3150 - 10860 3150-->
     <!-- Line: box -->
     <rect
-       x="10800"
-       y="2850"
+       x="10823.758"
+       y="5035.7236"
        width="1200"
        height="750"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
+       style="stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect112" />
     <!-- Line -->
     <polyline
        points="11400,3600 11400,4284 "
-       style="stroke:#000000;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline114" />
+       style="stroke:#000000;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline114"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 11400 3600 - 11400 4410-->
     <!-- Line: box -->
     <rect
-       x="10800"
-       y="4350"
+       x="10823.758"
+       y="6535.7236"
        width="1200"
        height="750"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
+       style="stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect118" />
     <!-- Line -->
     <polyline
        points="11400,5100 11400,5784 "
-       style="stroke:#000000;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline120" />
+       style="stroke:#000000;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline120"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 11400 5100 - 11400 5910-->
     <!-- Line: box -->
     <rect
-       x="10800"
-       y="5850"
+       x="10823.758"
+       y="8035.7236"
        width="1200"
        height="750"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; "
+       style="stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect124" />
     <!-- Line -->
     <polyline
        points="9300,3900 9900,3900 9900,4650 10734,4650 "
-       style="stroke:#000000;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline126" />
+       style="stroke:#000000;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline126"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 9900 4650 - 10860 4650-->
     <!-- Line -->
     <polyline
        points="9300,4650 9600,4650 9600,6150 10734,6150 "
-       style="stroke:#000000;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline130" />
+       style="stroke:#000000;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline130"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 9600 6150 - 10860 6150-->
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="6450"
-       y="300"
-       fill="#000000"
-       font-family="Helvetica"
-       font-style="normal"
-       font-weight="normal"
-       font-size="192"
-       text-anchor="end"
-       id="text134">rcu_bh</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="3150"
-       y="1950"
-       fill="#000000"
-       font-family="Courier"
+       x="3173.7581"
+       y="4135.7231"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text136">struct</text>
+       id="text136"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="3150"
-       y="2250"
-       fill="#000000"
-       font-family="Courier"
+       x="3173.7581"
+       y="4435.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text138">rcu_node</text>
+       id="text138"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">rcu_node</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="1650"
-       y="3750"
-       fill="#000000"
-       font-family="Courier"
+       x="1673.7578"
+       y="5935.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text140">struct</text>
+       id="text140"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="1650"
-       y="4050"
-       fill="#000000"
-       font-family="Courier"
+       x="1673.7578"
+       y="6235.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text142">rcu_node</text>
+       id="text142"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">rcu_node</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="2250"
-       y="5700"
-       fill="#000000"
-       font-family="Courier"
+       x="2273.7581"
+       y="7885.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text144">struct</text>
+       id="text144"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="2250"
-       y="6000"
-       fill="#000000"
-       font-family="Courier"
+       x="2273.7581"
+       y="8185.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text146">rcu_data</text>
+       id="text146"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">rcu_data</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="1050"
-       y="6900"
-       fill="#000000"
-       font-family="Courier"
+       x="1073.7578"
+       y="9085.7227"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text148">struct</text>
+       id="text148"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="1050"
-       y="7200"
-       fill="#000000"
-       font-family="Courier"
+       x="1073.7578"
+       y="9385.7227"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text150">rcu_data</text>
+       id="text150"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">rcu_data</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="5250"
-       y="5700"
-       fill="#000000"
-       font-family="Courier"
+       x="5273.7578"
+       y="7885.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text152">struct</text>
+       id="text152"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="5250"
-       y="6000"
-       fill="#000000"
-       font-family="Courier"
+       x="5273.7578"
+       y="8185.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text154">rcu_data</text>
+       id="text154"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">rcu_data</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="4050"
-       y="6900"
-       fill="#000000"
-       font-family="Courier"
+       x="4073.7578"
+       y="9085.7227"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text156">struct</text>
+       id="text156"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="4050"
-       y="7200"
-       fill="#000000"
-       font-family="Courier"
+       x="4073.7578"
+       y="9385.7227"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text158">rcu_data</text>
+       id="text158"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">rcu_data</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="450"
-       y="1350"
-       fill="#000000"
-       font-family="Courier"
+       x="473.75784"
+       y="3535.7231"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="start"
-       id="text160">struct rcu_state</text>
+       id="text160"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:start;fill:#000000">struct rcu_state</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="9600"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text162">struct</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="1050"
-       y="9900"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text164">rcu_dynticks</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="9600"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text166">struct</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="4050"
-       y="9900"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text168">rcu_dynticks</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2400"
-       y="8400"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text170">struct</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="2400"
-       y="8700"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text172">rcu_dynticks</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5400"
-       y="8400"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text174">struct</text>
     <!-- Text -->
-    <text
-       xml:space="preserve"
-       x="5400"
-       y="8700"
-       fill="#000000"
-       font-family="Courier"
-       font-style="normal"
-       font-weight="bold"
-       font-size="192"
-       text-anchor="middle"
-       id="text176">rcu_dynticks</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="6000"
-       y="750"
-       fill="#000000"
-       font-family="Helvetica"
+       x="6023.7578"
+       y="2935.7231"
        font-style="normal"
        font-weight="normal"
        font-size="192"
-       text-anchor="end"
-       id="text178">rcu_sched</text>
+       id="text178"
+       style="font-style:normal;font-weight:normal;font-size:192px;font-family:Helvetica;text-anchor:end;fill:#000000">rcu_state</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="11400"
-       y="3300"
-       fill="#000000"
-       font-family="Helvetica"
+       x="11423.758"
+       y="5485.7236"
        font-style="normal"
        font-weight="normal"
        font-size="216"
-       text-anchor="middle"
-       id="text180">T3</text>
+       id="text180"
+       style="font-style:normal;font-weight:normal;font-size:216px;font-family:Helvetica;text-anchor:middle;fill:#000000">T3</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="11400"
-       y="4800"
-       fill="#000000"
-       font-family="Helvetica"
+       x="11423.758"
+       y="6985.7236"
        font-style="normal"
        font-weight="normal"
        font-size="216"
-       text-anchor="middle"
-       id="text182">T2</text>
+       id="text182"
+       style="font-style:normal;font-weight:normal;font-size:216px;font-family:Helvetica;text-anchor:middle;fill:#000000">T2</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="11400"
-       y="6300"
-       fill="#000000"
-       font-family="Helvetica"
+       x="11423.758"
+       y="8485.7227"
        font-style="normal"
        font-weight="normal"
        font-size="216"
-       text-anchor="middle"
-       id="text184">T1</text>
+       id="text184"
+       style="font-style:normal;font-weight:normal;font-size:216px;font-family:Helvetica;text-anchor:middle;fill:#000000">T1</text>
     <!-- Line -->
     <polyline
        points="5250,5400 5250,4414 "
-       style="stroke:#00d1d1;stroke-width:30.00057884;stroke-linejoin:miter;stroke-linecap:butt;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
-       id="polyline186" />
+       style="stroke:#00d1d1;stroke-width:30.00057793;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;marker-end:url(#Arrow1Mend)"
+       id="polyline186"
+       transform="translate(23.757862,2185.7233)" />
     <!-- Arrowhead on XXXpoint 5250 5400 - 5250 4290-->
     <!-- Line: box -->
     <rect
-       x="3750"
-       y="3450"
+       x="3773.7581"
+       y="5635.7236"
        width="1800"
        height="900"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
+       style="fill:#ffbfbf;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect190" />
     <!-- Line: box -->
     <rect
-       x="7350"
-       y="2850"
+       x="7373.7578"
+       y="5035.7236"
        width="1950"
        height="750"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
+       style="fill:#ffbfbf;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect192" />
     <!-- Line: box -->
     <rect
-       x="7350"
-       y="3600"
+       x="7373.7578"
+       y="5785.7236"
        width="1950"
        height="750"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
+       style="fill:#ffbfbf;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect194" />
     <!-- Line: box -->
     <rect
-       x="7350"
-       y="4350"
+       x="7373.7578"
+       y="6535.7236"
        width="1950"
        height="750"
        rx="0"
-       style="stroke:#000000;stroke-width:30; stroke-linejoin:miter; stroke-linecap:butt; fill:#ffbfbf; "
+       style="fill:#ffbfbf;stroke:#000000;stroke-width:30;stroke-linecap:butt;stroke-linejoin:miter"
        id="rect196" />
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="4650"
-       y="4050"
-       fill="#000000"
-       font-family="Courier"
+       x="4673.7578"
+       y="6235.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text198">rcu_node</text>
+       id="text198"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">rcu_node</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="4650"
-       y="3750"
-       fill="#000000"
-       font-family="Courier"
+       x="4673.7578"
+       y="5935.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="middle"
-       id="text200">struct</text>
+       id="text200"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:middle;fill:#000000">struct</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="7500"
-       y="3300"
-       fill="#000000"
-       font-family="Courier"
+       x="7523.7578"
+       y="5485.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="start"
-       id="text202">blkd_tasks</text>
+       id="text202"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:start;fill:#000000">blkd_tasks</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="7500"
-       y="4050"
-       fill="#000000"
-       font-family="Courier"
+       x="7523.7578"
+       y="6235.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="start"
-       id="text204">gp_tasks</text>
+       id="text204"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:start;fill:#000000">gp_tasks</text>
     <!-- Text -->
     <text
        xml:space="preserve"
-       x="7500"
-       y="4800"
-       fill="#000000"
-       font-family="Courier"
+       x="7523.7578"
+       y="6985.7236"
        font-style="normal"
        font-weight="bold"
        font-size="192"
-       text-anchor="start"
-       id="text206">exp_tasks</text>
+       id="text206"
+       style="font-style:normal;font-weight:bold;font-size:192px;font-family:Courier;text-anchor:start;fill:#000000">exp_tasks</text>
   </g>
 </svg>
-- 
2.17.1

