Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE76C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3757206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfAIVuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:50:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726895AbfAIVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:50:18 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LnW7a025785
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:50:17 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq5ew6pb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:50:17 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:50:16 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:50:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LoAsL24707180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:50:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7582DB206B;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 550B9B2068;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2AB5216C63C9; Wed,  9 Jan 2019 13:50:10 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 02/10] torture: Explain and simplify odd "for" loop in mkinitrd.sh
Date:   Wed,  9 Jan 2019 13:50:00 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109214944.GA5610@linux.ibm.com>
References: <20190109214944.GA5610@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0052-0000-0000-00000375B6C1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144152; UDB=6.00595713; IPR=6.00924414;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:50:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0053-0000-0000-00005F67A01E
Message-Id: <20190109215008.6401-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why a Bourne-shell "for" loop?  And why 192 instances of "a"?  This commit
adds a shell comment to present the answer to these mysteries.  It also
uses a series of factor-of-four Bourne-shell assignments to make it
easy to see how many instances there are, replacing the earlier wall of
'a' characters.

Reported-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
[ paulmck: Fix wrong-variable bugs noted by Andrea Parri. ]
---
 .../selftests/rcutorture/bin/mkinitrd.sh      | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index da298394daa2..e79eb35c41e2 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -40,17 +40,24 @@ mkdir $T
 cat > $T/init << '__EOF___'
 #!/bin/sh
 # Run in userspace a few milliseconds every second.  This helps to
-# exercise the NO_HZ_FULL portions of RCU.
+# exercise the NO_HZ_FULL portions of RCU.  The 192 instances of "a" was
+# empirically shown to give a nice multi-millisecond burst of user-mode
+# execution on a 2GHz CPU, as desired.  Modern CPUs will vary from a
+# couple of milliseconds up to perhaps 100 milliseconds, which is an
+# acceptable range.
+#
+# Why not calibrate an exact delay?  Because within this initrd, we
+# are restricted to Bourne-shell builtins, which as far as I know do not
+# provide any means of obtaining a fine-grained timestamp.
+
+a4="a a a a"
+a16="$a4 $a4 $a4 $a4"
+a64="$a16 $a16 $a16 $a16"
+a192="$a64 $a64 $a64"
 while :
 do
 	q=
-	for i in \
-		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
-		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
-		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
-		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
-		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
-		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a
+	for i in $a192
 	do
 		q="$q $i"
 	done
-- 
2.17.1

