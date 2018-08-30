Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D698C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6632082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLX4vldW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6632082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeH3NSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:18:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42980 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeH3NSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:18:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id l5so3352563edw.9;
        Thu, 30 Aug 2018 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tmIUoLP6b3psegjFkPpkZ8MvhRIOC99dPPuu3f3nTcQ=;
        b=YLX4vldWI0gywCXsW5jIOp2VMaXcJhX8KO23hoJyW0HPiNvfZTBgw33XaTeitqM6VE
         5iVDdYxgElyZ4WutagFJ7YqvF+z6JeYBVD6MUDWp3UJT0G9LoExtPd6QtpUoW5uAx/IB
         U+zlWcoh27JfaqpSw8ZS3ucLnKJmQV0Lk9z8ilmvYzM9zupo2BTY7AZnMZcTWyZqOowP
         v28q8wVRREmcSfdFOyFNIuPp8h+UO6TU+UR1878hbItPxCqW6N2HrWinFoWuMSGK6Kii
         WzmSa9Oipue6idPhMDKYrDX2oqE75BSQH4CypCmIjVwUxloS1B5Ixz4VSv7zKY4xF6dw
         Kbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tmIUoLP6b3psegjFkPpkZ8MvhRIOC99dPPuu3f3nTcQ=;
        b=nP9EiNIvqvv6VFuaZD1N7v/sQm2WwsWUDSuJQzgwc40tw7Svy5TyKFkF3Et+10Ocvc
         RcJX+CzFMpB5+feUY6/IvhF1j1AvV1EO+g8nr0SVFohoiiM+mqOh2v2auEPUZMKFSsa9
         ynJem5T0tfPjt0a1Cb/HEueIheNQ7ONfFQo038531H9MImgbEwTRbq9GbUUMNiVdd7ln
         NIgNyOtfg+pq4QQgcBP6uVlVHi4rgROVFOkQloAs/6M4GBjMy47kqFwKrOV8o0YNz9kw
         gYJ+XJBkFG5hjFZss3XWT4uBylRFuzgp/8m0HFOLMEoJ6/w82HrJcmKC0iq5+corHarb
         o/pg==
X-Gm-Message-State: APzg51AOup9EFbhkK7/kCfjw4I2cJpfuQ0ksKmwyLWry5x1SNuG80sFN
        uO6YlY0m10CUF/TrbjSaakU=
X-Google-Smtp-Source: ANB0VdZF+G/SaSq9U7V1V4A9IcfHLq2+UoqxwSJeJFNk7mojYL+D6OHkoSyDAH5PqHWhBRjpmnwr2g==
X-Received: by 2002:aa7:d141:: with SMTP id r1-v6mr12298854edo.83.1535620641611;
        Thu, 30 Aug 2018 02:17:21 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id x7-v6sm2852193edx.65.2018.08.30.02.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 02:17:21 -0700 (PDT)
Date:   Thu, 30 Aug 2018 11:17:13 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 3/7] EXP tools/memory-model: Add more LKMM
 limitations
Message-ID: <20180830091713.GA4617@andrea>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-3-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829211053.20531-3-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 02:10:49PM -0700, Paul E. McKenney wrote:
> This commit adds more detail about compiler optimizations and
> not-yet-modeled Linux-kernel APIs.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  tools/memory-model/README | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index ee987ce20aae..acf9077cffaa 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -171,6 +171,12 @@ The Linux-kernel memory model has the following limitations:
>  	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
>  	and "A WARNING" sections).
>  
> +	Note that this limitation in turn limits LKMM's ability to
> +	accurately model address, control, and data dependencies.
> +	For example, if the compiler can deduce the value of some variable
> +	carrying a dependency, then the compiler can break that dependency
> +	by substituting a constant of that value.
> +
>  2.	Multiple access sizes for a single variable are not supported,
>  	and neither are misaligned or partially overlapping accesses.
>  
> @@ -190,6 +196,36 @@ The Linux-kernel memory model has the following limitations:
>  	However, a substantial amount of support is provided for these
>  	operations, as shown in the linux-kernel.def file.
>  
> +	a.	When rcu_assign_pointer() is passed NULL, the Linux
> +		kernel provides no ordering, but LKMM models this
> +		case as a store release.
> +
> +	b.	The "unless" RMW operations are not currently modeled:
> +		atomic_long_add_unless(), atomic_add_unless(),
> +		atomic_inc_unless_negative(), and
> +		atomic_dec_unless_positive().  These can be emulated
> +		in litmus tests, for example, by using atomic_cmpxchg().

There is a prototype atomic_add_unless(): with current herd7,

$ cat atomic_add_unless.litmus
C atomic_add_unless

{}

P0(atomic_t *u, atomic_t *v)
{
	int r0;
	int r1;

	r0 = atomic_add_unless(u, 1, 2);
	r1 = atomic_read(v);
}

P1(atomic_t *u, atomic_t *v)
{
	int r0;
	int r1;

	r0 = atomic_add_unless(v, 1, 2);
	r1 = atomic_read(u);
}

exists (0:r1=0 /\ 1:r1=0)

$ herd7 -conf linux-kernel.cfg atomic_add_unless.litmus
Test atomic_add_unless Allowed
States 3
0:r1=0; 1:r1=1;
0:r1=1; 1:r1=0;
0:r1=1; 1:r1=1;
No
Witnesses
Positive: 0 Negative: 3
Condition exists (0:r1=0 /\ 1:r1=0)
Observation atomic_add_unless Never 0 3
Time atomic_add_unless 0.00
Hash=fa37a2359831690299e4cc394e45d966

The last commit in the herdtools7 repo. related to this implementation
(AFAICT) is:

  9523c340917b6a ("herd/linux: make atomic_add_unless a primitive, so as to yield more precise dependencies for the returned boolean.")

but I can only vaguely remember those dependencies issues now :/  ...;
maybe we can now solve these issues?  or should we change herd7 to re-
turn a warning?  (Notice that this primitive is currently not exported
to the linux-kernel.def file.)

  Andrea


> +
> +	c.	The call_rcu() function is not modeled.  It can be
> +		emulated in litmus tests by adding another process that
> +		invokes synchronize_rcu() and the body of the callback
> +		function, with (for example) a release-acquire from
> +		the site of the emulated call_rcu() to the beginning
> +		of the additional process.
> +
> +	d.	The rcu_barrier() function is not modeled.  It can be
> +		emulated in litmus tests emulating call_rcu() via
> +		(for example) a release-acquire from the end of each
> +		additional call_rcu() process to the site of the
> +		emulated rcu-barrier().
> +
> +	e.	Sleepable RCU (SRCU) is not modeled.  It can be
> +		emulated, but perhaps not simply.
> +
> +	f.	Reader-writer locking is not modeled.  It can be
> +		emulated in litmus tests using atomic read-modify-write
> +		operations.
> +
>  The "herd7" tool has some additional limitations of its own, apart from
>  the memory model:
>  
> @@ -204,3 +240,6 @@ the memory model:
>  Some of these limitations may be overcome in the future, but others are
>  more likely to be addressed by incorporating the Linux-kernel memory model
>  into other tools.
> +
> +Finally, please note that LKMM is subject to change as hardware, use cases,
> +and compilers evolve.
> -- 
> 2.17.1
> 
