Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FE12081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FE12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeKBBQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:16:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728156AbeKBBQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:16:50 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1G9arw035245
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 12:13:12 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ng47sst84-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:13:12 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Nov 2018 16:13:11 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 16:13:08 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1GD7Xr38142184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 16:13:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2B12B2065;
        Thu,  1 Nov 2018 16:13:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1818B205F;
        Thu,  1 Nov 2018 16:13:07 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 16:13:07 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E1AFB16C34AA; Thu,  1 Nov 2018 09:13:07 -0700 (PDT)
Date:   Thu, 1 Nov 2018 09:13:07 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101050019.GA45865@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110116-2213-0000-0000-0000030F4836
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009966; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111161; UDB=6.00575813; IPR=6.00891253;
 MB=3.00023992; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-01 16:13:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110116-2214-0000-0000-00005C1AA271
Message-Id: <20181101161307.GO4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:00:19PM -0700, Joel Fernandes wrote:
> On Wed, Oct 31, 2018 at 11:17:48AM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 30, 2018 at 06:11:19PM -0700, Joel Fernandes wrote:
> > > Hi Paul,
> > > 
> > > On Tue, Oct 30, 2018 at 04:43:36PM -0700, Paul E. McKenney wrote:
> > > > On Tue, Oct 30, 2018 at 03:26:49PM -0700, Joel Fernandes wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > On Sat, Oct 27, 2018 at 09:30:46PM -0700, Joel Fernandes (Google) wrote:
> > > > > > As per this thread [1], it seems this smp_mb isn't needed anymore:
> > > > > > "So the smp_mb() that I was trying to add doesn't need to be there."
> > > > > > 
> > > > > > So let us remove this part from the memory ordering documentation.
> > > > > > 
> > > > > > [1] https://lkml.org/lkml/2017/10/6/707
> > > > > > 
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > 
> > > > > I was just checking about this patch. Do you feel it is correct to remove
> > > > > this part from the docs? Are you satisified that a barrier isn't needed there
> > > > > now? Or did I miss something?
> > > > 
> > > > Apologies, it got lost in the shuffle.  I have now applied it with a
> > > > bit of rework to the commit log, thank you!
> > > 
> > > No worries, thanks for taking it!
> > > 
> > > Just wanted to update you on my progress reading/correcting the docs. The
> > > 'Memory Ordering' is taking a bit of time so I paused that and I'm focusing
> > > on finishing all the other low hanging fruit. This activity is mostly during
> > > night hours after the baby is asleep but some times I also manage to sneak it
> > > into the day job ;-)
> > 
> > If there is anything I can do to make this a more sustainable task for
> > you, please do not keep it a secret!!!
> 
> Thanks a lot, that means a lot to me! Will do!
> 
> > > BTW I do want to discuss about this smp_mb patch above with you at LPC if you
> > > had time, even though we are removing it from the documentation. I thought
> > > about it a few times, and I was not able to fully appreciate the need for the
> > > barrier (that is even assuming that complete() etc did not do the right
> > > thing).  Specifically I was wondering same thing Peter said in the above
> > > thread I think that - if that rcu_read_unlock() triggered all the spin
> > > locking up the tree of nodes, then why is that locking not sufficient to
> > > prevent reads from the read-side section from bleeding out? That would
> > > prevent the reader that just unlocked from seeing anything that happens
> > > _after_ the synchronize_rcu.
> > 
> > Actually, I recall an smp_mb() being added, but am not seeing it anywhere
> > relevant to wait_for_completion().  So I might need to add the smp_mb()
> > to synchronize_rcu() and remove the patch (retaining the typo fix).  :-/
> 
> No problem, I'm glad atleast the patch resurfaced the topic of the potential
> issue :-)

And an smp_mb() is needed in Tree RCU's __wait_rcu_gp().  This is
because wait_for_completion() might get a "fly-by" wakeup, which would
mean no ordering for code naively thinking that it was ordered after a
grace period.

> > The short form answer is that anything before a grace period on any CPU
> > must be seen by any CPU as being before anything on any CPU after that
> > same grace period.  This guarantee requires a rather big hammer.
> > 
> > But yes, let's talk at LPC!
> 
> Sounds great, looking forward to discussing this.

Would it make sense to have an RCU-implementation BoF?

> > > Also about GP memory ordering and RCU-tree-locking, I think you mentioned to
> > > me that the RCU reader-sections are virtually extended both forward and
> > > backward and whereever it ends, those paths do heavy-weight synchronization
> > > that should be sufficient to prevent memory ordering issues (such as those
> > > you mentioned in the Requierments document). That is exactly why we don't
> > > need explicit barriers during rcu_read_unlock. If I recall I asked you why
> > > those are not needed. So that answer made sense, but then now on going
> > > through the 'Memory Ordering' document, I see that you mentioned there is
> > > reliance on the locking. Is that reliance on locking necessary to maintain
> > > ordering then?
> > 
> > There is a "network" of locking augmented by smp_mb__after_unlock_lock()
> > that implements the all-to-all memory ordering mentioned above.  But it
> > also needs to handle all the possible complete()/wait_for_completion()
> > races, even those assisted by hypervisor vCPU preemption.
> 
> I see, so it sounds like the lock network is just a partial solution. For
> some reason I thought before that complete() was even called on the CPU
> executing the callback, all the CPUs would have acquired and released a lock
> in the "lock network" atleast once thus ensuring the ordering (due to the
> fact that the quiescent state reporting has to travel up the tree starting
> from the leaves), but I think that's not necessarily true so I see your point
> now.

There is indeed a lock that is unconditionally acquired and released by
wait_for_completion(), but it lacks the smp_mb__after_unlock_lock() that
is required to get full-up any-to-any ordering.  And unfortunate timing
(as well as spurious wakeups) allow the interaction to have only normal
lock-release/acquire ordering, which does not suffice in all cases.

SRCU and expedited RCU grace periods handle this correctly.  Only the
normal grace periods are missing the needed barrier.  The probability of
failure is extremely low in the common case, which involves all sorts
of synchronization on the wakeup path.  It would be quite strange (but
not impossible) for the wait_for_completion() exit path to -not- to do
a full wakeup.  Plus the bug requires a reader before the grace period
to do a store to some location that post-grace-period code loads from.
Which is a very rare use case.

But it still should be fixed.  ;-)

> Did you feel this will violate condition 1. or condition 2. in "Memory-Barrier
> Guarantees"? Or both?
> https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Memory-Barrier%20Guarantees

Condition 1.  There might be some strange combination of events that
could also cause it to also violate condition 2, but I am not immediately
seeing it.

> > > ----------------------
> > > TODO list of the index file marking which ones I have finished perusing:
> > > 
> > > arrayRCU.txt			DONE
> > > checklist.txt			DONE
> > > listRCU.txt			DONE
> > > lockdep.txt			DONE
> > > lockdep-splat.txt		DONE
> > > NMI-RCU.txt
> > > rcu_dereference.txt
> > > rcubarrier.txt
> > > rculist_nulls.txt
> > > rcuref.txt
> > > rcu.txt
> > > RTFP.txt			DONE
> > > stallwarn.txt			DONE
> > > torture.txt
> > > UP.txt
> > > whatisRCU.txt			DONE
> > > 
> > > Design
> > >  - Data-Structures		DONE
> > >  - Requirements			DONE
> > >  - Expedited-Grace-Periods
> > >  - Memory Ordering		next
> > 
> > Great progress, and again, thank you!!!
> 
> Thanks and you're welcome!

And here is the fix proposed above.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit bf3c11b7b9789283f993d9beb80caaabc4403916
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Thu Nov 1 09:05:02 2018 -0700

    rcu: Add full memory barrier in __wait_rcu_gp()
    
    RCU grace periods have extremely strong any-to-any ordering
    requirements that are met by placing full barriers in various places
    in the grace-period computation.  However, normal grace period requests
    might be subjected to a "fly-by" wakeup in which the requesting process
    doesn't actually sleep and in which the corresponding CPU is not yet
    aware that the grace period has ended.  In this case, loads in the code
    immediately following the synchronize_rcu() call might potentially see
    values before stores preceding the grace period on other CPUs.
    
    This is an unusual use case, because RCU readers normally read.  However,
    they can do writes, and if they do, we need post-grace-period reads to
    see those writes.
    
    This commit therefore adds an smp_mb() to the end of __wait_rcu_gp().
    
    Many thanks to Joel Fernandes for the series of questions leading to me
    realizing that this bug exists!
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 1971869c4072..74020b558216 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -360,6 +360,7 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 			wait_for_completion(&rs_array[i].completion);
 		destroy_rcu_head_on_stack(&rs_array[i].head);
 	}
+	smp_mb(); /* Provide ordering in case of fly-by wakeup. */
 }
 EXPORT_SYMBOL_GPL(__wait_rcu_gp);
 

