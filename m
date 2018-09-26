Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C20C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FB721537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FB721537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeI0Anr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:43:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728498AbeI0Anp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:43:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QIT9YY138287
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:29:31 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mrf5krqps-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:29:31 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 26 Sep 2018 14:29:29 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 14:29:23 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8QITMOx43057340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 18:29:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 618EEB2065;
        Wed, 26 Sep 2018 14:27:42 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BE3EB206E;
        Wed, 26 Sep 2018 14:27:42 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.155.193])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Sep 2018 14:27:42 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BF23B16C39D4; Wed, 26 Sep 2018 11:29:21 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH memory-model 5/5] doc: Replace smp_cond_acquire() with smp_cond_load_acquire()
Date:   Wed, 26 Sep 2018 11:29:20 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926182845.GA24839@linux.ibm.com>
References: <20180926182845.GA24839@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18092618-0064-0000-0000-00000355980C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009776; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01094026; UDB=6.00565497; IPR=6.00874063;
 MB=3.00023518; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-26 18:29:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092618-0065-0000-0000-00003AC8240B
Message-Id: <20180926182920.27644-5-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=597 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
with smp_cond_load_acquire()") by updating the documentation accordingly.
Also remove some obsolete information related to the implementation.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 Documentation/memory-barriers.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 0d8d7ef131e9..c1d913944ad8 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -471,8 +471,7 @@ And a couple of implicit varieties:
      operations after the ACQUIRE operation will appear to happen after the
      ACQUIRE operation with respect to the other components of the system.
      ACQUIRE operations include LOCK operations and both smp_load_acquire()
-     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
-     semantics from relying on a control dependency and smp_rmb().
+     and smp_cond_load_acquire() operations.
 
      Memory operations that occur before an ACQUIRE operation may appear to
      happen after it completes.
-- 
2.17.1

