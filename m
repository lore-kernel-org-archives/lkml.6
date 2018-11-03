Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A77C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEDF20685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEDF20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeKDIft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:35:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727015AbeKDIft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:35:49 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA3NE5YU112957
        for <linux-kernel@vger.kernel.org>; Sat, 3 Nov 2018 19:23:03 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nh8cb3jqa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 19:23:03 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 3 Nov 2018 23:23:01 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 3 Nov 2018 23:22:59 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA3NMwWQ45940810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 3 Nov 2018 23:22:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2807B2067;
        Sat,  3 Nov 2018 23:22:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DF36B205F;
        Sat,  3 Nov 2018 23:22:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.212.110])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  3 Nov 2018 23:22:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1674516C1857; Sat,  3 Nov 2018 16:22:59 -0700 (PDT)
Date:   Sat, 3 Nov 2018 16:22:59 -0700
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
 <20181103051226.GA18718@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103051226.GA18718@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110323-0040-0000-0000-0000048C3324
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009973; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01112010; UDB=6.00576322; IPR=6.00892101;
 MB=3.00024008; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-03 23:23:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110323-0041-0000-0000-00000895362F
Message-Id: <20181103232259.GJ4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-03_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:12:26PM -0700, Joel Fernandes wrote:
> On Thu, Nov 01, 2018 at 09:13:07AM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 31, 2018 at 10:00:19PM -0700, Joel Fernandes wrote:
> > > On Wed, Oct 31, 2018 at 11:17:48AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Oct 30, 2018 at 06:11:19PM -0700, Joel Fernandes wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > On Tue, Oct 30, 2018 at 04:43:36PM -0700, Paul E. McKenney wrote:
> > > > > > On Tue, Oct 30, 2018 at 03:26:49PM -0700, Joel Fernandes wrote:
> > > > > > > Hi Paul,
> > > > > > > 
> > > > > > > On Sat, Oct 27, 2018 at 09:30:46PM -0700, Joel Fernandes (Google) wrote:
> > > > > > > > As per this thread [1], it seems this smp_mb isn't needed anymore:
> > > > > > > > "So the smp_mb() that I was trying to add doesn't need to be there."
> > > > > > > > 
> > > > > > > > So let us remove this part from the memory ordering documentation.
> > > > > > > > 
> > > > > > > > [1] https://lkml.org/lkml/2017/10/6/707
> > > > > > > > 
> > > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > 
> > > > > > > I was just checking about this patch. Do you feel it is correct to remove
> > > > > > > this part from the docs? Are you satisified that a barrier isn't needed there
> > > > > > > now? Or did I miss something?
> > > > > > 
> > > > > > Apologies, it got lost in the shuffle.  I have now applied it with a
> > > > > > bit of rework to the commit log, thank you!
> > > > > 
> > > > > No worries, thanks for taking it!
> > > > > 
> > > > > Just wanted to update you on my progress reading/correcting the docs. The
> > > > > 'Memory Ordering' is taking a bit of time so I paused that and I'm focusing
> > > > > on finishing all the other low hanging fruit. This activity is mostly during
> > > > > night hours after the baby is asleep but some times I also manage to sneak it
> > > > > into the day job ;-)
> > > > 
> > > > If there is anything I can do to make this a more sustainable task for
> > > > you, please do not keep it a secret!!!
> > > 
> > > Thanks a lot, that means a lot to me! Will do!
> > > 
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
> > 
> > > > The short form answer is that anything before a grace period on any CPU
> > > > must be seen by any CPU as being before anything on any CPU after that
> > > > same grace period.  This guarantee requires a rather big hammer.
> > > > 
> > > > But yes, let's talk at LPC!
> > > 
> > > Sounds great, looking forward to discussing this.
> > 
> > Would it make sense to have an RCU-implementation BoF?
> > 
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
> 
> Sorry to be so persistent, but I did spend some time on this and I still
> don't get why every CPU would _not_ have executed smp_mb__after_unlock_lock at least
> once before the wait_for_completion() returns, because every CPU should have
> atleast called rcu_report_qs_rdp() -> rcu_report_qs_rnp() atleast once to
> report its QS up the tree right?. Before that procedure, the complete()
> cannot happen because the complete() itself is in an RCU callback which is
> executed only once all the QS(s) have been reported.
> 
> So I still couldn't see how the synchronize_rcu can return without the
> rcu_report_qs_rnp called atleast once on the CPU reporting its QS during a
> grace period.
> 
> Would it be possible to provide a small example showing this in least number
> of steps? I appreciate your time and it would be really helpful. If you feel
> its too complicated, then feel free to keep this for LPC discussion :)

The key point is that "at least once" does not suffice, other than for the
CPU that detects the end of the grace period.  The rest of the CPUs must
do at least -two- full barriers, which could of course be either smp_mb()
on the one hand or smp_mb__after_unlock_lock() after a lock on the other.

The reason for this is the all-to-all ordering that is required.  First,
the grace period does a fan-in operation as each CPU responds to the
grace-period request, informing RCU of its quiescent state while holding a
fully ordered lock.  Second, some CPU detects the end of the grace period
while holding a fully ordered lock.  Third, each remaining CPU notes
the end of the grace period, again while holding a fully ordered lock.

Now suppose that the wakeup callback for a given call to synchronize_rcu()
is on the CPU that detected the end of the grace period, but the task
to be awakened will run on some other CPU.  Suppose further that this
other CPU hasn't yet noticed the end of the grace period, and further
yet that it was the first one to report a quiescent state.  This means
that its most recent fully ordered lock was released too early to order
against the other CPUs' quiescent states.  Now, as you say, the lock
acquisitions and releases for the completion() and wait_for_completion()
will cause the awakened CPU to correctly see any pre-grace-period
activity on the CPU that detected the end of the grace period.  But
this is not the case for any of the other CPUs, and won't be until the
awakened CPU notes the end of the grace period while holding its fully
ordered lock.

So we really do need that memory barrier at the end of __wait_rcu_gp().

							Thanx, Paul

