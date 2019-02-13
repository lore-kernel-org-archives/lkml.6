Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F0CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA102175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393198AbfBMRiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:38:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390226AbfBMRhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:37:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DHSrdB008824
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 12:37:51 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qmpbbmdtk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 12:37:51 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Feb 2019 17:37:50 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Feb 2019 17:37:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1DHbiQS20709382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 17:37:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D86F5B2065;
        Wed, 13 Feb 2019 17:37:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3E8CB2066;
        Wed, 13 Feb 2019 17:37:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.41])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 13 Feb 2019 17:37:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D52D516C63E4; Wed, 13 Feb 2019 09:37:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 7/7] tools/memory-model: Avoid duplicating herdtools versions
Date:   Wed, 13 Feb 2019 09:37:43 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213173650.GA26078@linux.ibm.com>
References: <20190213173650.GA26078@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19021317-0064-0000-0000-000003A8302D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010589; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01160548; UDB=6.00605725; IPR=6.00941102;
 MB=3.00025565; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-13 17:37:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021317-0065-0000-0000-00003C678742
Message-Id: <20190213173743.26682-7-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

Currently, herdtools version information appears no fewer than three
times in the LKMM source, which is difficult to maintain.  This commit
therefore places the required version in one place, namely the
tools/memory-model/README file.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/README           | 8 ++++++--
 tools/memory-model/linux-kernel.cat | 2 --
 tools/memory-model/lock.cat         | 3 ---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 9d7d4f23503f..2b87f3971548 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -20,13 +20,17 @@ that litmus test to be exercised within the Linux kernel.
 REQUIREMENTS
 ============
 
-Version 7.49 of the "herd7" and "klitmus7" tools must be downloaded
-separately:
+Version 7.52 or higher of the "herd7" and "klitmus7" tools must be
+downloaded separately:
 
   https://github.com/herd/herdtools7
 
 See "herdtools7/INSTALL.md" for installation instructions.
 
+Note that although these tools usually provide backwards compatibility,
+this is not absolutely guaranteed.  Therefore, if a later version does
+not work, please try using the exact version called out above.
+
 
 ==================
 BASIC USAGE: HERD7
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 95bf45f1215f..8dcb37835b61 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 (*
- * Requires herd version 7.51+6 or higher.
- *
  * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
  * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 305ded17e741..a059d1a6d8a2 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -6,9 +6,6 @@
 
 (*
  * Generate coherence orders and handle lock operations
- *
- * Warning: spin_is_locked() crashes herd7 versions strictly before 7.48.
- * spin_is_locked() is functional from herd7 version 7.49.
  *)
 
 include "cross.cat"
-- 
2.17.1

