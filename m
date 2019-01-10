Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD3CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F092173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfAJXhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:37:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730276AbfAJXhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:37:11 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0ANXeuj059438
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:37:10 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pxfbjh4bv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:37:10 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 10 Jan 2019 23:37:09 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 23:37:04 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0ANb3Nv5570732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 23:37:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8F49B2066;
        Thu, 10 Jan 2019 23:37:03 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9F20B2067;
        Thu, 10 Jan 2019 23:37:03 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 23:37:03 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BA3ED16C5F90; Thu, 10 Jan 2019 15:37:04 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:37:04 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 13/12] Remove wrapper definitions for obsolete
 RCU update functions
Reply-To: paulmck@linux.ibm.com
References: <20190109211830.GA30595@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109211830.GA30595@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011023-2213-0000-0000-0000033A7058
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010381; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144660; UDB=6.00596019; IPR=6.00924924;
 MB=3.00025075; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 23:37:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011023-2214-0000-0000-00005CEBC961
Message-Id: <20190110233704.GA27112@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of synchronize_rcu_bh, synchronize_rcu_bh_expedited, call_rcu_bh,
rcu_barrier_bh, synchronize_sched, synchronize_sched_expedited,
call_rcu_sched, rcu_barrier_sched, get_state_synchronize_sched, and
cond_synchronize_sched are actually used.  This commit therefore removes
their trivial wrapper-function definitions.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
[ paulmck: The intent was to defer this to the following release, but
  there are no more uses of these functions, so full speed ahead!!! ]

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 4db8bcacc51a..0e39e0d2629e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -896,57 +896,4 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 	return false;
 }
 
-
-/* Transitional pre-consolidation compatibility definitions. */
-
-static inline void synchronize_rcu_bh(void)
-{
-	synchronize_rcu();
-}
-
-static inline void synchronize_rcu_bh_expedited(void)
-{
-	synchronize_rcu_expedited();
-}
-
-static inline void call_rcu_bh(struct rcu_head *head, rcu_callback_t func)
-{
-	call_rcu(head, func);
-}
-
-static inline void rcu_barrier_bh(void)
-{
-	rcu_barrier();
-}
-
-static inline void synchronize_sched(void)
-{
-	synchronize_rcu();
-}
-
-static inline void synchronize_sched_expedited(void)
-{
-	synchronize_rcu_expedited();
-}
-
-static inline void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
-{
-	call_rcu(head, func);
-}
-
-static inline void rcu_barrier_sched(void)
-{
-	rcu_barrier();
-}
-
-static inline unsigned long get_state_synchronize_sched(void)
-{
-	return get_state_synchronize_rcu();
-}
-
-static inline void cond_synchronize_sched(unsigned long oldstate)
-{
-	cond_synchronize_rcu(oldstate);
-}
-
 #endif /* __LINUX_RCUPDATE_H */

