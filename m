Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeBJBG7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:06:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753347AbeBJBG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:06:58 -0500
Date: Fri, 9 Feb 2018 17:07:03 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-"
 -> "_")
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180209141832.GA17505@linux.vnet.ibm.com>
 <df87e89b-7fbe-37a7-42cb-62df74591df4@gmail.com>
 <a788e08d-eccb-0aec-6aa5-944e5321e5c6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a788e08d-eccb-0aec-6aa5-944e5321e5c6@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021001-2213-0000-0000-0000026A97B6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008506; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000251; SDB=6.00987442; UDB=6.00501212; IPR=6.00766801;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019471; XFM=3.00000015;
 UTC=2018-02-10 01:06:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021001-2214-0000-0000-0000590F7EC2
Message-Id: <20180210010703.GE3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802100011
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 08:46:25AM +0900, Akira Yokosawa wrote:
> >From 7c1f497a9a51e8db1a94c8a7ef0b74b235aaab88 Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Fri, 9 Feb 2018 04:51:05 -0800
> Subject: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-" -> "_")
> 
> As of herd7 7.47, these '-'s are not permitted and end up in
> errors such as:
> 
>     File "./linux-kernel.def", line 44, characters 29-30:
>     unexpected '-' (in macros)
> 
> Partial revert of commit 2d5fba7782d6 ("linux-kernel*: Make RCU
> identifiers match ASPLOS paper") in the repository at
> https://github.com/aparri/memory-model can restore the compatibility
> with herd7 7.47.
> 
> Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Suggested-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
> Paul,
> 
> FWIW, this is a squashed version relative to patch 07/10 in the RFC series.

Thank you, Akira!

I am going to hold off on this for a bit to see if we can instead get
a new release of herd7, but if we can't. this might well be a very good
way to go.

							Thanx, Paul

>     Thanks, Akira
> --
>  tools/memory-model/linux-kernel.bell | 14 +++++++-------
>  tools/memory-model/linux-kernel.cat  |  2 +-
>  tools/memory-model/linux-kernel.def  |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index b984bbd..436791b 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -25,9 +25,9 @@ enum Barriers = 'wmb (*smp_wmb*) ||
>  		'rmb (*smp_rmb*) ||
>  		'mb (*smp_mb*) ||
>  		'rb_dep (*smp_read_barrier_depends*) ||
> -		'rcu-lock (*rcu_read_lock*)  ||
> -		'rcu-unlock (*rcu_read_unlock*) ||
> -		'sync-rcu (*synchronize_rcu*) ||
> +		'rcu_lock (*rcu_read_lock*)  ||
> +		'rcu_unlock (*rcu_read_unlock*) ||
> +		'sync_rcu (*synchronize_rcu*) ||
>  		'before_atomic (*smp_mb__before_atomic*) ||
>  		'after_atomic (*smp_mb__after_atomic*) ||
>  		'after_spinlock (*smp_mb__after_spinlock*)
> @@ -35,8 +35,8 @@ instructions F[Barriers]
> 
>  (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
>  let matched = let rec
> -	    unmatched-locks = Rcu-lock \ domain(matched)
> -	and unmatched-unlocks = Rcu-unlock \ range(matched)
> +	    unmatched-locks = Rcu_lock \ domain(matched)
> +	and unmatched-unlocks = Rcu_unlock \ range(matched)
>  	and unmatched = unmatched-locks | unmatched-unlocks
>  	and unmatched-po = [unmatched] ; po ; [unmatched]
>  	and unmatched-locks-to-unlocks =
> @@ -46,8 +46,8 @@ let matched = let rec
>  	in matched
> 
>  (* Validate nesting *)
> -flag ~empty Rcu-lock \ domain(matched) as unbalanced-rcu-locking
> -flag ~empty Rcu-unlock \ range(matched) as unbalanced-rcu-locking
> +flag ~empty Rcu_lock \ domain(matched) as unbalanced-rcu-locking
> +flag ~empty Rcu_unlock \ range(matched) as unbalanced-rcu-locking
> 
>  (* Outermost level of nesting only *)
>  let crit = matched \ (po^-1 ; matched ; po^-1)
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index babe2b3..d0085d5 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -32,7 +32,7 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; fencerel(Before_atomic) ; [RMW] ; po? ; [M]) |
>  	([M] ; po? ; [RMW] ; fencerel(After_atomic) ; [M]) |
>  	([M] ; po? ; [LKW] ; fencerel(After_spinlock) ; [M])
> -let gp = po ; [Sync-rcu] ; po?
> +let gp = po ; [Sync_rcu] ; po?
> 
>  let strong-fence = mb | gp
> 
> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> index a397387..fc08371 100644
> --- a/tools/memory-model/linux-kernel.def
> +++ b/tools/memory-model/linux-kernel.def
> @@ -41,10 +41,10 @@ spin_unlock(X) { __unlock(X) ; }
>  spin_trylock(X) __trylock(X)
> 
>  // RCU
> -rcu_read_lock() { __fence{rcu-lock}; }
> -rcu_read_unlock() { __fence{rcu-unlock};}
> -synchronize_rcu() { __fence{sync-rcu}; }
> -synchronize_rcu_expedited() { __fence{sync-rcu}; }
> +rcu_read_lock() { __fence{rcu_lock}; }
> +rcu_read_unlock() { __fence{rcu_unlock};}
> +synchronize_rcu() { __fence{sync_rcu}; }
> +synchronize_rcu_expedited() { __fence{sync_rcu}; }
> 
>  // Atomic
>  atomic_read(X) READ_ONCE(*X)
> -- 
> 2.7.4
> 
> 
