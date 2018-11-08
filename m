Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3748ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3D20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF3D20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeKIBHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:07:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726774AbeKIBHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:07:16 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8FG0D4136182
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 10:31:14 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmqb1ht9a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 10:31:14 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Nov 2018 15:31:13 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 15:31:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8FVAfE28836068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 15:31:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42083B2066;
        Thu,  8 Nov 2018 15:31:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2427EB2068;
        Thu,  8 Nov 2018 15:31:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.145.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 15:31:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BA2AD16C3A85; Thu,  8 Nov 2018 07:31:09 -0800 (PST)
Date:   Thu, 8 Nov 2018 07:31:09 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Question on comment header for for_each_domain()
Reply-To: paulmck@linux.ibm.com
References: <20181107230002.GA15577@linux.ibm.com>
 <20181108092151.GM9761@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108092151.GM9761@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110815-0052-0000-0000-00000352B0A4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010008; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114499; UDB=6.00577820; IPR=6.00894597;
 MB=3.00024076; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 15:31:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110815-0053-0000-0000-00005EB2CC48
Message-Id: <20181108153109.GF4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:21:51AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 07, 2018 at 03:00:02PM -0800, Paul E. McKenney wrote:
> > Hello!
> > 
> > The header comment for for_each_domain() talks about a call to
> > synchronize_sched() within detach_destroy_domains(), but I am not
> > seeing any such call.  Because synchronize_sched() is now folded into
> > synchronize_rcu(), I have a patch that edits the comment, but it looks
> > like a larger change is needed.
> > 
> > Or am I blind today?
> 
> I think you're quite right and that comment is a wee bit stale.
> 
> The sched domain tree is indeed protected by regular RCU (not RCU-sched
> as the comment seems to imply) and this is per destroy_sched_domains()
> using call_rcu().
> 
> And most (I didn't look at all) uses for the sched-domain tree do indeed
> employ rcu_read_lock().

Ah, thank you for the info!  Would this patch do the trick?

							Thanx, Paul

------------------------------------------------------------------------

commit 4182d416309b11d16e882ab637ab11cecef0bddc
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Tue Nov 6 19:10:53 2018 -0800

    sched: Replace call_rcu_sched() with call_rcu()
    
    Now that call_rcu()'s callback is not invoked until after all
    preempt-disable regions of code have completed (in addition to explicitly
    marked RCU read-side critical sections), call_rcu() can be used in place
    of call_rcu_sched().  This commit therefore makes that change.
    
    While in the area, this commit also updates an outdated header comment
    for for_each_domain().
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Peter Zijlstra <peterz@infradead.org>

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 618577fc9aa8..00b91d16af9f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1237,7 +1237,7 @@ extern void sched_ttwu_pending(void);
 
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.
- * See detach_destroy_domains: synchronize_sched for details.
+ * See destroy_sched_domains: call_rcu for details.
  *
  * The domain tree of any CPU may only be accessed from within
  * preempt-disabled sections.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8d7f15ba5916..04d458faf2c1 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -248,7 +248,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	raw_spin_unlock_irqrestore(&rq->lock, flags);
 
 	if (old_rd)
-		call_rcu_sched(&old_rd->rcu, free_rootdomain);
+		call_rcu(&old_rd->rcu, free_rootdomain);
 }
 
 void sched_get_rd(struct root_domain *rd)
@@ -261,7 +261,7 @@ void sched_put_rd(struct root_domain *rd)
 	if (!atomic_dec_and_test(&rd->refcount))
 		return;
 
-	call_rcu_sched(&rd->rcu, free_rootdomain);
+	call_rcu(&rd->rcu, free_rootdomain);
 }
 
 static int init_rootdomain(struct root_domain *rd)

