Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1F8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E98926258
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E98926258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbeFYW4g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:56:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755488AbeFYWz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:55:59 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMmtnd096158
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:59 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96p0u54-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:59 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 18:55:58 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 18:55:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PMtpVi6422938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 22:55:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAD36B206C;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A95BB2065;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DA36416CA096; Mon, 25 Jun 2018 15:57:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 2/5] rcutorture: Remove obsolete TREE08-T.boot file
Date:   Mon, 25 Jun 2018 15:57:52 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625225735.GA11793@linux.vnet.ibm.com>
References: <20180625225735.GA11793@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062522-2213-0000-0000-000002BFD89D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052304; UDB=6.00539450; IPR=6.00830229;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 22:55:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062522-2214-0000-0000-00005A9B6F33
Message-Id: <20180625225755.12839-2-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=947 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TREE08-T.boot file was used to provide alternative options for
debugging, but things have changed, it has not kept up, and it has not
been used or missed.  This commit therefore removes it.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE08-T.boot | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE08-T.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08-T.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE08-T.boot
deleted file mode 100644
index 883149b5f2d1..000000000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08-T.boot
+++ /dev/null
@@ -1 +0,0 @@
-rcutree.rcu_fanout_exact=1
-- 
2.17.1

