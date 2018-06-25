Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103CFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32922623C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32922623C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935055AbeFYWqH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:46:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754567AbeFYWqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:46:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMictf068041
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:46:00 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96rgfg2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:46:00 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 18:45:59 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 18:45:55 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PMjsFF721274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 22:45:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9885DB2064;
        Mon, 25 Jun 2018 18:45:49 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 789B3B206B;
        Mon, 25 Jun 2018 18:45:49 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 18:45:49 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C4C4C16CA094; Mon, 25 Jun 2018 15:47:59 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 2/4] srcu: Document that srcu_funnel_gp_start() implies srcu_funnel_exp_start()
Date:   Mon, 25 Jun 2018 15:47:56 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625224734.GA10860@linux.vnet.ibm.com>
References: <20180625224734.GA10860@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062522-0068-0000-0000-0000030E112D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052301; UDB=6.00539448; IPR=6.00830226;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 22:45:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062522-0069-0000-0000-000044CEDD77
Message-Id: <20180625224758.11300-2-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates the header comment of srcu_funnel_gp_start() to
document the fact that srcu_funnel_gp_start() does the work of
srcu_funnel_exp_start(), in some cases by invoking it directly.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/srcutree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 615e414b0c1e..37bef2fe80e6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -641,6 +641,9 @@ static void srcu_funnel_exp_start(struct srcu_struct *sp, struct srcu_node *snp,
  * period s.  Losers must either ensure that their desired grace-period
  * number is recorded on at least their leaf srcu_node structure, or they
  * must take steps to invoke their own callbacks.
+ *
+ * Note that this function also does the work of srcu_funnel_exp_start(),
+ * in some cases by directly invoking it.
  */
 static void srcu_funnel_gp_start(struct srcu_struct *sp, struct srcu_data *sdp,
 				 unsigned long s, bool do_norm)
-- 
2.17.1

