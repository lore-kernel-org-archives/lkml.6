Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E814DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9185020833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9185020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeKCFIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:08:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbeKCFIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:08:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2Jx1gk002412
        for <linux-kernel@vger.kernel.org>; Fri, 2 Nov 2018 16:00:04 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ngs8as4w6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 16:00:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Nov 2018 20:00:02 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 20:00:00 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA2Jxxhs28901596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 19:59:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CE72B2067;
        Fri,  2 Nov 2018 19:59:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 262AAB2064;
        Fri,  2 Nov 2018 19:59:59 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 19:59:59 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4DA6516C2ABB; Fri,  2 Nov 2018 13:00:00 -0700 (PDT)
Date:   Fri, 2 Nov 2018 13:00:00 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Reply-To: paulmck@linux.ibm.com
References: <20181028043046.198403-1-joel@joelfernandes.org>
 <20181030222649.GA105735@joelaf.mtv.corp.google.com>
 <20181030234336.GW4170@linux.ibm.com>
 <20181031011119.GF224709@google.com>
 <20181031181748.GG4170@linux.ibm.com>
 <20181101050019.GA45865@google.com>
 <20181101161307.GO4170@linux.ibm.com>
 <20181102061518.GA22191@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102061518.GA22191@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110220-0064-0000-0000-0000036D492A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009973; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111717; UDB=6.00576147; IPR=6.00891809;
 MB=3.00024008; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-02 20:00:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110220-0065-0000-0000-00003B34307F
Message-Id: <20181102200000.GC4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:15:18PM -0700, Joel Fernandes wrote:
> On Thu, Nov 01, 2018 at 09:13:07AM -0700, Paul E. McKenney wrote:
> > > > > BTW I do want to discuss about this smp_mb patch above with you at LPC if you
> > > > > had time, even though we are removing it from the documentation. I thought
> > > > > about it a few times, and I was not able to fully appreciate the need for the
> > > > > barrier (that is even assuming that complete() etc did not do the right
> > > > > thing).  Specifically I was wondering same thing Peter said in the above
> > > > > thread I think that - if that rcu_read_unlock() triggered all the spin
> > > > > locking up the tree of nodes, then why is that locking not sufficient to
> > > > > prevent reads from the read-side section from bleeding out? That would
> > > > > prevent the reader that just unlocked from seeing anything that happens
> > > > > _after_ the synchronize_rcu.
> > > > 
> > > > Actually, I recall an smp_mb() being added, but am not seeing it anywhere
> > > > relevant to wait_for_completion().  So I might need to add the smp_mb()
> > > > to synchronize_rcu() and remove the patch (retaining the typo fix).  :-/
> > > 
> > > No problem, I'm glad atleast the patch resurfaced the topic of the potential
> > > issue :-)
> > 
> > And an smp_mb() is needed in Tree RCU's __wait_rcu_gp().  This is
> > because wait_for_completion() might get a "fly-by" wakeup, which would
> > mean no ordering for code naively thinking that it was ordered after a
> > grace period.
> 
> Makes sense.
> 
> > > > The short form answer is that anything before a grace period on any CPU
> > > > must be seen by any CPU as being before anything on any CPU after that
> > > > same grace period.  This guarantee requires a rather big hammer.
> > > > 
> > > > But yes, let's talk at LPC!
> > > 
> > > Sounds great, looking forward to discussing this.
> > 
> > Would it make sense to have an RCU-implementation BoF?
> 
> Yes, I would very much like that. I also spoke with my colleage Daniel
> Colascione and he said he would be interested too.

Sounds good!

> I think it would make sense also to combine it with other memory-ordering
> topics like the memory model and rseq/cpu-opv things that Mathieu was doing
> (if it makes sense to combine). But yes, I am definitely interested in an
> RCU-implementation BoF session.

There is an LKMM kernel summit track presentation.  I believe that
Mathieu's rseq/cpu-opv would be a good one as well, but Mathieu needs
to lead this up and it should be a separate BoF.  Please do feel free
to reach out to him.  I am sure that he would be particularly interested
in potential uses of rseq and especially cpu-opv.

> > > > > Also about GP memory ordering and RCU-tree-locking, I think you mentioned to
> > > > > me that the RCU reader-sections are virtually extended both forward and
> > > > > backward and whereever it ends, those paths do heavy-weight synchronization
> > > > > that should be sufficient to prevent memory ordering issues (such as those
> > > > > you mentioned in the Requierments document). That is exactly why we don't
> > > > > need explicit barriers during rcu_read_unlock. If I recall I asked you why
> > > > > those are not needed. So that answer made sense, but then now on going
> > > > > through the 'Memory Ordering' document, I see that you mentioned there is
> > > > > reliance on the locking. Is that reliance on locking necessary to maintain
> > > > > ordering then?
> > > > 
> > > > There is a "network" of locking augmented by smp_mb__after_unlock_lock()
> > > > that implements the all-to-all memory ordering mentioned above.  But it
> > > > also needs to handle all the possible complete()/wait_for_completion()
> > > > races, even those assisted by hypervisor vCPU preemption.
> > > 
> > > I see, so it sounds like the lock network is just a partial solution. For
> > > some reason I thought before that complete() was even called on the CPU
> > > executing the callback, all the CPUs would have acquired and released a lock
> > > in the "lock network" atleast once thus ensuring the ordering (due to the
> > > fact that the quiescent state reporting has to travel up the tree starting
> > > from the leaves), but I think that's not necessarily true so I see your point
> > > now.
> > 
> > There is indeed a lock that is unconditionally acquired and released by
> > wait_for_completion(), but it lacks the smp_mb__after_unlock_lock() that
> > is required to get full-up any-to-any ordering.  And unfortunate timing
> > (as well as spurious wakeups) allow the interaction to have only normal
> > lock-release/acquire ordering, which does not suffice in all cases.
> > 
> > SRCU and expedited RCU grace periods handle this correctly.  Only the
> > normal grace periods are missing the needed barrier.  The probability of
> > failure is extremely low in the common case, which involves all sorts
> > of synchronization on the wakeup path.  It would be quite strange (but
> > not impossible) for the wait_for_completion() exit path to -not- to do
> > a full wakeup.  Plus the bug requires a reader before the grace period
> > to do a store to some location that post-grace-period code loads from.
> > Which is a very rare use case.
> > 
> > But it still should be fixed.  ;-)
> > 
> > > Did you feel this will violate condition 1. or condition 2. in "Memory-Barrier
> > > Guarantees"? Or both?
> > > https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Memory-Barrier%20Guarantees
> > 
> > Condition 1.  There might be some strange combination of events that
> > could also cause it to also violate condition 2, but I am not immediately
> > seeing it.
> 
> In the previous paragraph, you mentioned the bug "requires a reader before
> the GP to do a store". However, condition 1 is really different - it is a
> reader holding a reference to a pointer that is used *after* the
> synchronize_rcu returns. So that reader's load of the pointer should have
> completed by the time GP ends, otherwise the reader can look at kfree'd data.
> That's different right?

More specifically, the fix prevents a prior reader's -store- within its
critical section to be seen as happening after a load that follows the
end of the grace period.  So I stand by Condition 1.  ;-)

And again, a store within an RCU read-side critical section is a bit
on the strange side, but this sort of thing is perfectly legal and
is used, albeit rather rarely.

> For condition 2, I analyzed it below, let me know what you think:
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit bf3c11b7b9789283f993d9beb80caaabc4403916
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Thu Nov 1 09:05:02 2018 -0700
> > 
> >     rcu: Add full memory barrier in __wait_rcu_gp()
> >     
> >     RCU grace periods have extremely strong any-to-any ordering
> >     requirements that are met by placing full barriers in various places
> >     in the grace-period computation.  However, normal grace period requests
> >     might be subjected to a "fly-by" wakeup in which the requesting process
> >     doesn't actually sleep and in which the corresponding CPU is not yet
> >     aware that the grace period has ended.  In this case, loads in the code
> >     immediately following the synchronize_rcu() call might potentially see
> >     values before stores preceding the grace period on other CPUs.
> >     
> >     This is an unusual use case, because RCU readers normally read.  However,
> >     they can do writes, and if they do, we need post-grace-period reads to
> >     see those writes.
> >     
> >     This commit therefore adds an smp_mb() to the end of __wait_rcu_gp().
> >     
> >     Many thanks to Joel Fernandes for the series of questions leading to me
> >     realizing that this bug exists!
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index 1971869c4072..74020b558216 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -360,6 +360,7 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
> >  			wait_for_completion(&rs_array[i].completion);
> >  		destroy_rcu_head_on_stack(&rs_array[i].head);
> >  	}
> > +	smp_mb(); /* Provide ordering in case of fly-by wakeup. */
> >  }
> >  EXPORT_SYMBOL_GPL(__wait_rcu_gp);
> >  
> 
> The fix looks fine to me. Thanks.
> 
> If I understand correctly the wait_for_completion() is an ACQUIRE operation,
> and the complete() is a RELEASE operation aka the "MP pattern". The
> ACQUIRE/RELEASE semantics allow any writes that happened before the ACQUIRE
> to get ordered after it. So that would actually imply it is not strong enough
> for ordering purposes during a "fly-by" wake up scenario and would be a
> violation of CONDITION 2, I think (not only condition 1 as you said).  This
> is because future readers may accidentally see the writes that happened
> *before* the synchronize_rcu which is CONDITION 2 in the requirements:
> https://goo.gl/8mrDHN  (I had to shortlink it ;))

I do appreciate the shorter link.  ;-)

A write happening before the grace period is ordered by the grace period's
network of strong barriers, so the fix does not matter in that case.
Also, the exact end of the grace period is irrelevant for Condition 2,
it is instead the beginning of the grace period compared to the beginning
of later RCU read-side critical sections.

Not saying that Condition 2 cannot somehow happen without the memory
barrier, just saying that it will take quite a bit more creativity to
find a relevant scenario.

Please see below for the updated patch, containing only the typo fix.
Please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit bdf892699a32e82305c7203d61f93cffdfbe8735
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Sat Oct 27 21:30:46 2018 -0700

    doc: Fix "struction" typo in RCU memory-ordering documentation.
    
    This commit replaces "struction" with the correct "structure".
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
index a346ce0116eb..e4d94fba6c89 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
@@ -77,7 +77,7 @@ The key point is that the lock-acquisition functions, including
 <tt>smp_mb__after_unlock_lock()</tt> immediately after successful
 acquisition of the lock.
 
-<p>Therefore, for any given <tt>rcu_node</tt> struction, any access
+<p>Therefore, for any given <tt>rcu_node</tt> structure, any access
 happening before one of the above lock-release functions will be seen
 by all CPUs as happening before any access happening after a later
 one of the above lock-acquisition functions.

