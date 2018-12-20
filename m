Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41607C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BFB20815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbeLTRF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:05:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729720AbeLTRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:05:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBKH4hAF143975
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:05:25 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pgdrfm519-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:05:25 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 20 Dec 2018 17:05:24 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Dec 2018 17:05:21 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBKH5KNo21233800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 17:05:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 111A1B2068;
        Thu, 20 Dec 2018 17:05:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0A68B2070;
        Thu, 20 Dec 2018 17:05:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Dec 2018 17:05:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B9DB816C36A7; Thu, 20 Dec 2018 09:05:25 -0800 (PST)
Date:   Thu, 20 Dec 2018 09:05:25 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     fweisbec@gmail.com
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] time: Move CONTEXT_TRACKING to kernel/time/Kconfig
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18122017-0064-0000-0000-00000389B581
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010255; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01134551; UDB=6.00589898; IPR=6.00914723;
 MB=3.00024771; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-20 17:05:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122017-0065-0000-0000-00003BBFD792
Message-Id: <20181220170525.GA12579@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both CONTEXT_TRACKING and CONTEXT_TRACKING_FORCE are currently defined
in kernel/rcu/kconfig, which might have made sense at some point, but
no longer does given that RCU refers to neither of these Kconfig options.
This commit therefore moves them to kernel/time/Kconfig, where the rest
of the NO_HZ_FULL Kconfig options live.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 939a2056c87a..37301430970e 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -87,36 +87,6 @@ config RCU_STALL_COMMON
 config RCU_NEED_SEGCBLIST
 	def_bool ( TREE_RCU || PREEMPT_RCU || TREE_SRCU )
 
-config CONTEXT_TRACKING
-       bool
-
-config CONTEXT_TRACKING_FORCE
-	bool "Force context tracking"
-	depends on CONTEXT_TRACKING
-	default y if !NO_HZ_FULL
-	help
-	  The major pre-requirement for full dynticks to work is to
-	  support the context tracking subsystem. But there are also
-	  other dependencies to provide in order to make the full
-	  dynticks working.
-
-	  This option stands for testing when an arch implements the
-	  context tracking backend but doesn't yet fullfill all the
-	  requirements to make the full dynticks feature working.
-	  Without the full dynticks, there is no way to test the support
-	  for context tracking and the subsystems that rely on it: RCU
-	  userspace extended quiescent state and tickless cputime
-	  accounting. This option copes with the absence of the full
-	  dynticks subsystem by forcing the context tracking on all
-	  CPUs in the system.
-
-	  Say Y only if you're working on the development of an
-	  architecture backend for the context tracking.
-
-	  Say N otherwise, this option brings an overhead that you
-	  don't want in production.
-
-
 config RCU_FANOUT
 	int "Tree-based hierarchical RCU fanout value"
 	range 2 64 if 64BIT
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 58b981f4bb5d..e2c038d6c13c 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -117,6 +117,35 @@ config NO_HZ_FULL
 
 endchoice
 
+config CONTEXT_TRACKING
+       bool
+
+config CONTEXT_TRACKING_FORCE
+	bool "Force context tracking"
+	depends on CONTEXT_TRACKING
+	default y if !NO_HZ_FULL
+	help
+	  The major pre-requirement for full dynticks to work is to
+	  support the context tracking subsystem. But there are also
+	  other dependencies to provide in order to make the full
+	  dynticks working.
+
+	  This option stands for testing when an arch implements the
+	  context tracking backend but doesn't yet fullfill all the
+	  requirements to make the full dynticks feature working.
+	  Without the full dynticks, there is no way to test the support
+	  for context tracking and the subsystems that rely on it: RCU
+	  userspace extended quiescent state and tickless cputime
+	  accounting. This option copes with the absence of the full
+	  dynticks subsystem by forcing the context tracking on all
+	  CPUs in the system.
+
+	  Say Y only if you're working on the development of an
+	  architecture backend for the context tracking.
+
+	  Say N otherwise, this option brings an overhead that you
+	  don't want in production.
+
 config NO_HZ
 	bool "Old Idle dynticks config"
 	depends on !ARCH_USES_GETTIMEOFFSET && GENERIC_CLOCKEVENTS

