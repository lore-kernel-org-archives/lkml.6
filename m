Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6120214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfAJObt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:31:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729163AbfAJObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:31:47 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0AEU2p3132540
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:31:46 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2px483atk1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:31:45 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 10 Jan 2019 14:31:43 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 14:31:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0AEVaid26673222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 14:31:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C08E3B2064;
        Thu, 10 Jan 2019 14:31:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EA7EB205F;
        Thu, 10 Jan 2019 14:31:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 14:31:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4A02E16C5FAB; Thu, 10 Jan 2019 06:31:37 -0800 (PST)
Date:   Thu, 10 Jan 2019 06:31:37 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        willy@infradead.org
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Reply-To: paulmck@linux.ibm.com
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109231852.GA4494@andrea>
 <20190109234043.GD1215@linux.ibm.com>
 <20190110003952.GA4354@andrea>
 <20190110042027.GG1215@linux.ibm.com>
 <20190110084024.GA10280@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110084024.GA10280@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011014-0072-0000-0000-000003E7DE05
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010379; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144478; UDB=6.00595910; IPR=6.00924742;
 MB=3.00025068; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 14:31:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011014-0073-0000-0000-00004AC1F1E3
Message-Id: <20190110143137.GJ1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:40:24AM +0100, Andrea Parri wrote:
> > > > > It seems that
> > > > > 
> > > > >   1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> > > > >   
> > > > > from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
> > > > > considered that, IIRC, you introduced the primitive and RCU is currently
> > > > > its only user.)
> > > > 
> > > > That commit is in -tip:
> > > > 
> > > > 4607abbcf464 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> > > > 
> > > > So it has already left my -rcu tree.  ;-)
> > > 
> > > Oh, you're right: now I see the commit (e.g., with "git show"), but I
> > > don't see the corresponding changes applied to the tree.
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=locking/core&id=4607abbcf464ea2be14da444215d05c73025cf6e
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/memory-model/linux-kernel.bell?h=locking/core
> > > 
> > > Is this expected?
> > 
> > Are you asking why it is in -tip but not in mainline?  I am not sure,
> > but given that the merge window was over the holiday season and that
> > the length of the merge window proved to be shorter than many people
> > expected it to be, I am not too surprised.  ;-)
> 
> Mmh, let me try again:
> 
>   $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>   $ cd tip
>   $ git checkout -b locking/core origin/locking/core
> 
>   $ git show 4607abbcf464
>   commit 4607abbcf464ea2be14da444215d05c73025cf6e
>   Author: Andrea Parri <andrea.parri@amarulasolutions.com>
>   Date:   Mon Dec 3 15:04:49 2018 -0800
> 
>       tools/memory-model: Model smp_mb__after_unlock_lock()
> 
>   $ cd tools/memory-model
>   $ herd7 -conf linux-kernel.cfg after-unlock-lock-same-cpu.litmus
>   File "after-unlock-lock-same-cpu.litmus": Unknown macro smp_mb__after_unlock_lock (User error)
> 
>   [aka, linux-kernel.def in tip:locking/core does not have the
>    smp_mb__after_unlock_lock() added by 4607abbcf464]

Color me confused:

------------------------------------------------------------------------

$ git checkout 4607abbcf464Checking out files: 100% (18397/18397), done.
Previous HEAD position was 4e284b1bf15a rcu: Remove wrapper definitions for obsolete RCU update functions
HEAD is now at 4607abbcf464 tools/memory-model: Model smp_mb__after_unlock_lock()
$ grep smp_mb__after_unlock_lock tools/memory-model/linux-kernel.def 
smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }

------------------------------------------------------------------------

In addition, it handles this litmus test just fine:

------------------------------------------------------------------------

C MP+polocks

(*
 * Result: Never
 *
 * This litmus test demonstrates how lock acquisitions and releases can
 * stand in for smp_load_acquire() and smp_store_release(), respectively.
 * In other words, when holding a given lock (or indeed after releasing a
 * given lock), a CPU is not only guaranteed to see the accesses that other
 * CPUs made while previously holding that lock, it is also guaranteed
 * to see all prior accesses by those other CPUs.
 *)

{}

P0(int *x, int *y, spinlock_t *mylock)
{
	WRITE_ONCE(*x, 1);
	spin_lock(mylock);
	smp_mb__after_unlock_lock();
	WRITE_ONCE(*y, 1);
	spin_unlock(mylock);
}

P1(int *x, int *y, spinlock_t *mylock)
{
	int r0;
	int r1;

	spin_lock(mylock);
	r0 = READ_ONCE(*y);
	spin_unlock(mylock);
	r1 = READ_ONCE(*x);
}

exists (1:r0=1 /\ 1:r1=0)

------------------------------------------------------------------------

Again, color me confused.

							Thanx, Paul

