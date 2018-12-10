Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D62BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD882082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD882082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeLJSZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:25:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728754AbeLJSZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:25:23 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBAIDbN3088611
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:25:22 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p9tp00tw6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:25:22 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 10 Dec 2018 18:25:20 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Dec 2018 18:25:14 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBAIPDY819333316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 18:25:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC09CB2067;
        Mon, 10 Dec 2018 18:25:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6032B206C;
        Mon, 10 Dec 2018 18:25:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 10 Dec 2018 18:25:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8ED5A16C2BD9; Mon, 10 Dec 2018 10:25:16 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:25:16 -0800
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
References: <20181206215405.GL4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812101113430.1562-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812101113430.1562-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121018-0064-0000-0000-000003840CFA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010209; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01129835; UDB=6.00587047; IPR=6.00909969;
 MB=3.00024644; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-10 18:25:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121018-0065-0000-0000-00003BA179E9
Message-Id: <20181210182516.GV4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:22:31AM -0500, Alan Stern wrote:
> On Thu, 6 Dec 2018, Paul E. McKenney wrote:
> 
> > Hello, David,
> > 
> > I took a crack at extending LKMM to accommodate what I think would
> > support what you have in your paper.  Please see the very end of this
> > email for a patch against the "dev" branch of my -rcu tree.
> > 
> > This gives the expected result for the following three litmus tests,
> > but is probably deficient or otherwise misguided in other ways.  I have
> > added the LKMM maintainers on CC for their amusement.  ;-)
> > 
> > Thoughts?
> 
> Since sys_membarrier() provides a heavyweight barrier comparable to 
> synchronize_rcu(), the memory model should treat the two in the same 
> way.  That's what this patch does.
> 
> The corresponding critical section would be any region of code bounded
> by compiler barriers.  Since the LKMM doesn't currently handle plain
> accesses, the effect is the same as if a compiler barrier were present
> between each pair of instructions.  Basically, each instruction acts as
> its own critical section.  Therefore the patch below defines memb-rscsi
> as the trivial identity relation.  When plain accesses and compiler 
> barriers are added to the memory model, a different definition will be 
> needed.
> 
> This gives the correct results for the three C-Goldblat-memb-* litmus 
> tests in Paul's email.

Yow!!!

My first reaction was that this cannot possibly be correct because
sys_membarrier(), which is probably what we should call it, does not
wait for anything.  But your formulation has the corresponding readers
being "id", which as you say above is just a single event.

But what makes this work for the following litmus test?

------------------------------------------------------------------------

C membrcu

{
}

P0(intptr_t *x0, intptr_t *x1)
{
	WRITE_ONCE(*x0, 2);
	smp_memb();
	intptr_t r2 = READ_ONCE(*x1);
}


P1(intptr_t *x1, intptr_t *x2)
{
	WRITE_ONCE(*x1, 2);
	smp_memb();
	intptr_t r2 = READ_ONCE(*x2);
}


P2(intptr_t *x2, intptr_t *x3)
{
	WRITE_ONCE(*x2, 2);
	smp_memb();
	intptr_t r2 = READ_ONCE(*x3);
}


P3(intptr_t *x3, intptr_t *x4)
{
	rcu_read_lock();
	WRITE_ONCE(*x3, 2);
	intptr_t r2 = READ_ONCE(*x4);
	rcu_read_unlock();
}


P4(intptr_t *x4, intptr_t *x5)
{
	rcu_read_lock();
	WRITE_ONCE(*x4, 2);
	intptr_t r2 = READ_ONCE(*x5);
	rcu_read_unlock();
}


P5(intptr_t *x0, intptr_t *x5)
{
	rcu_read_lock();
	WRITE_ONCE(*x5, 2);
	intptr_t r2 = READ_ONCE(*x0);
	rcu_read_unlock();
}

exists
(5:r2=0 /\ 0:r2=0 /\ 1:r2=0 /\ 2:r2=0 /\ 3:r2=0 /\ 4:r2=0)

------------------------------------------------------------------------

For this, herd gives "Never".  Of course, if I reverse the write and
read in any of P3(), P4(), or P5(), I get "Sometimes", which does make
sense.  But what is preserving the order between P3() and P4() and
between P4() and P5()?  I am not immediately seeing how the analogy
with RCU carries over to this case.

							Thanx, Paul

> Alan
> 
> PS: The patch below is meant to apply on top of the SRCU patches, which
> are not yet in the mainline kernel.
> 
> 
> 
> Index: usb-4.x/tools/memory-model/linux-kernel.bell
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.bell
> +++ usb-4.x/tools/memory-model/linux-kernel.bell
> @@ -24,6 +24,7 @@ instructions RMW[{'once,'acquire,'releas
>  enum Barriers = 'wmb (*smp_wmb*) ||
>  		'rmb (*smp_rmb*) ||
>  		'mb (*smp_mb*) ||
> +		'memb (*sys_membarrier*) ||
>  		'rcu-lock (*rcu_read_lock*)  ||
>  		'rcu-unlock (*rcu_read_unlock*) ||
>  		'sync-rcu (*synchronize_rcu*) ||
> Index: usb-4.x/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> +++ usb-4.x/tools/memory-model/linux-kernel.cat
> @@ -33,7 +33,7 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
>  	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>  		fencerel(After-unlock-lock) ; [M])
> -let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> +let gp = po ; [Sync-rcu | Sync-srcu | Memb] ; po?
>  
>  let strong-fence = mb | gp
>  
> @@ -102,8 +102,10 @@ acyclic pb as propagation
>   *)
>  let rcu-gp = [Sync-rcu]		(* Compare with gp *)
>  let srcu-gp = [Sync-srcu]
> +let memb-gp = [Memb]
>  let rcu-rscsi = rcu-rscs^-1
>  let srcu-rscsi = srcu-rscs^-1
> +let memb-rscsi = id
>  
>  (*
>   * The synchronize_rcu() strong fence is special in that it can order not
> @@ -119,15 +121,19 @@ let rcu-link = po? ; hb* ; pb* ; prop ;
>   * the synchronize_srcu() and srcu_read_[un]lock() calls refer to the same
>   * struct srcu_struct location.
>   *)
> -let rec rcu-fence = rcu-gp | srcu-gp |
> +let rec rcu-fence = rcu-gp | srcu-gp | memb-gp |
>  	(rcu-gp ; rcu-link ; rcu-rscsi) |
>  	((srcu-gp ; rcu-link ; srcu-rscsi) & loc) |
> +	(memb-gp ; rcu-link ; memb-rscsi) |
>  	(rcu-rscsi ; rcu-link ; rcu-gp) |
>  	((srcu-rscsi ; rcu-link ; srcu-gp) & loc) |
> +	(memb-rscsi ; rcu-link ; memb-gp) |
>  	(rcu-gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
>  	((srcu-gp ; rcu-link ; rcu-fence ; rcu-link ; srcu-rscsi) & loc) |
> +	(memb-gp ; rcu-link ; rcu-fence ; rcu-link ; memb-rscsi) |
>  	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; rcu-gp) |
>  	((srcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; srcu-gp) & loc) |
> +	(memb-rscsi ; rcu-link ; rcu-fence ; rcu-link ; memb-gp) |
>  	(rcu-fence ; rcu-link ; rcu-fence)
>  
>  (* rb orders instructions just as pb does *)
> Index: usb-4.x/tools/memory-model/linux-kernel.def
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.def
> +++ usb-4.x/tools/memory-model/linux-kernel.def
> @@ -20,6 +20,7 @@ smp_store_mb(X,V) { __store{once}(X,V);
>  smp_mb() { __fence{mb}; }
>  smp_rmb() { __fence{rmb}; }
>  smp_wmb() { __fence{wmb}; }
> +smp_memb() { __fence{memb}; }
>  smp_mb__before_atomic() { __fence{before-atomic}; }
>  smp_mb__after_atomic() { __fence{after-atomic}; }
>  smp_mb__after_spinlock() { __fence{after-spinlock}; }
> 

