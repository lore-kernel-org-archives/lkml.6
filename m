Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3202A20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3202A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeLLWtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:49:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbeLLWtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:49:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBCMeG5n019972
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 17:49:38 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pb9syvmj3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 17:49:38 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 12 Dec 2018 22:49:36 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Dec 2018 22:49:31 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBCMnU8m18088182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 22:49:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58CD1B2064;
        Wed, 12 Dec 2018 22:49:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27243B205F;
        Wed, 12 Dec 2018 22:49:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 12 Dec 2018 22:49:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3044416C14E4; Wed, 12 Dec 2018 14:49:31 -0800 (PST)
Date:   Wed, 12 Dec 2018 14:49:31 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     David Goldblatt <davidtgoldblatt@gmail.com>,
        mathieu.desnoyers@efficios.com,
        Florian Weimer <fweimer@redhat.com>, triegel@redhat.com,
        libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux: Implement membarrier function
Reply-To: paulmck@linux.ibm.com
References: <20181212215245.GC4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812121710350.1543-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812121710350.1543-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121222-0040-0000-0000-000004A1AEDE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010216; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130884; UDB=6.00577119; IPR=6.00911017;
 MB=3.00024673; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-12 22:49:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121222-0041-0000-0000-000008AAD0F7
Message-Id: <20181212224931.GD4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=765 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 05:12:18PM -0500, Alan Stern wrote:
> On Wed, 12 Dec 2018, Paul E. McKenney wrote:
> 
> > > > I believe that this ordering forbids the cycle:
> > > > 
> > > > 	Wa=1 > membs -> [m01] -> Rc=0 -> Wc=2 -> rcu_read_unlock() ->
> > > > 		return from synchronize_rcu() -> Ra
> > > > 
> > > > Does this make sense, or am I missing something?
> > > 
> > > It's hard to tell.  What you have written here isn't justified by the
> > > litmus test source code, since the position of m01 in P1's program
> > > order is undetermined.  How do you justify m01 -> Rc, for example?
> > 
> > ... justifies Rc=0 following [m01].
> > 
> > > Write it this way instead, using the relations defined in the 
> > > sys_membarrier patch for linux-kernel.cat:
> > > 
> > > 	memb ->memb-gp memb ->rcu-link Rc ->memb-rscsi Rc ->rcu-link
> > > 		
> > > 		rcu_read_unlock ->rcu-rscsi rcu_read_lock ->rcu-link 
> > > 
> > > 		synchronize_rcu ->rcu-gp synchronize_rcu ->rcu-link memb
> > > 
> > > Recall that:
> > > 
> > > 	memb-gp is the identity relation on sys_membarrier events,
> > > 
> > > 	rcu-link includes (po? ; fre ; po),
> > > 
> > > 	memb-rscsi is the identity relation on all events,
> > > 
> > > 	rcu-rscsi links unlocks to their corresponding locks, and
> > > 
> > > 	rcu-gp is the identity relation on synchronize_rcu events.
> > > 
> > > These facts justify the cycle above.
> > > 
> > > Leaving off the final rcu-link step, the sequence matches the
> > > definition of rcu-fence (the relations are memb-gp, memb-rscsi, 
> > > rcu-rscsi, rcu-gp with rcu-links in between).  Therefore the cycle is 
> > > forbidden.
> > 
> > Understood, but that would be using the model to check the model.  ;-)
> 
> Well, what are you trying to accomplish?  Do you want to find an 
> argument similar to the one I posted for the 6-CPU test to show that 
> this test should be forbidden?

I am trying to check odd corner cases.  Your sys_membarrier() model
is quite nice and certainly fits nicely with the rest of the model,
but where I come from, that is actually reason for suspicion.  ;-)

All kidding aside, your argument for the 6-CPU test was extremely
valuable, as it showed me a way to think of that test from an
implementation viewpoint.  Then the question is whether or not that
viewpoint actually matches the model, which seems to be the case thus far.

A good next step would be to automatically generate random tests along
with an automatically generated prediction, like I did for RCU a few
years back.  I should be able to generalize my time-based cheat for RCU to
also cover SRCU, though sys_membarrier() will require a bit more thought.
(The time-based cheat was to have fixed duration RCU grace periods and
RCU read-side critical sections, with the grace period duration being
slightly longer than that of the critical sections.  The number of
processes is of course limited by the chosen durations, but that limit
can easily be made insanely large.)

I guess that I still haven't gotten over being a bit surprised that the
RCU counting rule also applies to sys_membarrier().  ;-)

							Thanx, Paul

