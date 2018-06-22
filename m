Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35267C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA5823F62
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rsTXH4Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA5823F62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbeFVJG5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:06:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53730 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFVJGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:06:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so1452687wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 02:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nFlv8k/+t0Nepf0ALOPGnXEleR+ZvXyKWeWsaTY82wI=;
        b=rsTXH4KbZENFy6n/ddcJ6huxfEAgSPSGxoXRIYL9IilF0mTbZJ9uYucrFNOXvnj+Yp
         FMy6GPx2edbektnjr2vhbbLOiGJ8H6Ci5dc9pu96ASroH+tk/X/c7pR2GL5Ec8mJ8eTw
         AWkonclX+nf1OkTR8dciEB0nrHAPhEUoOp4ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nFlv8k/+t0Nepf0ALOPGnXEleR+ZvXyKWeWsaTY82wI=;
        b=I1Z32c/SZoU3Fp3JQRBzeA6dGlchEXfSdM/9LCFXMssxmA4XI00Ebb6q+KlKCgei76
         Tby5nUER1olR8E1uHB0v3dEoycwoE7DafdDtuvSjj6SE9Hnr9rsus0+7ajeCnF7UxIOl
         +XU+blIL+m8puk7eaYllBR3sXqPqANLHACoXTcq4ory9sV8QEJ+fHJAHFkQ+0sq/NGhN
         0OWXCofDJcRh/2+TD+yFAK8gsCnr2gAg85lFoy3HoLHWydSarxgJh3quhdoUlQ8AKwqz
         6jXSgR/8H8dRc0Z3Op0c2ASqv87w3mK8XNH3VKPxlISWYa265vIMqdCU5M8FBhoZeSpw
         wsig==
X-Gm-Message-State: APt69E3t8xg5emgLR6u+0wh2zRW32Yahc3DWLgqxNDt4YXc2JqG4mzQa
        Rtpr4nJ44kpKuvoBzs3ZiuUzeg==
X-Google-Smtp-Source: AAOMgpdCduLqWA94pUc8STLYuw316ysaidutVQpaEsTjIdoBvcEyPdzb6DpOS8/w/qDHrC6VqBlNUA==
X-Received: by 2002:a1c:d884:: with SMTP id p126-v6mr949518wmg.110.1529658414232;
        Fri, 22 Jun 2018 02:06:54 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id v138-v6sm1857590wmd.47.2018.06.22.02.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 02:06:53 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:06:51 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180622090651.GB6933@andrea>
References: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:27:12PM -0400, Alan Stern wrote:
> More than one kernel developer has expressed the opinion that the LKMM
> should enforce ordering of writes by release-acquire chains and by
> locking.  In other words, given the following code:
> 
> 	WRITE_ONCE(x, 1);
> 	spin_unlock(&s):
> 	spin_lock(&s);
> 	WRITE_ONCE(y, 1);
> 
> or the following:
> 
> 	smp_store_release(&x, 1);
> 	r1 = smp_load_acquire(&x);	// r1 = 1
> 	WRITE_ONCE(y, 1);
> 
> the stores to x and y should be propagated in order to all other CPUs,
> even though those other CPUs might not access the lock s or be part of
> the release-acquire chain.  In terms of the memory model, this means
> that rel-rf-acq-po should be part of the cumul-fence relation.
> 
> All the architectures supported by the Linux kernel (including RISC-V)
> do behave this way, albeit for varying reasons.  Therefore this patch
> changes the model in accordance with the developers' wishes.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

This patch changes the "Result" for ISA2+pooncelock+pooncelock+pombonce,
so it should update the corresponding comment/README.

Reviewed-and-Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>

  Andrea


> 
> ---
> 
> 
> [as1871]
> 
> 
>  tools/memory-model/Documentation/explanation.txt |   81 +++++++++++++++++++++++
>  tools/memory-model/linux-kernel.cat              |    2 
>  2 files changed, 82 insertions(+), 1 deletion(-)
> 
> Index: usb-4.x/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> +++ usb-4.x/tools/memory-model/linux-kernel.cat
> @@ -66,7 +66,7 @@ let ppo = to-r | to-w | fence
>  
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = rfe? ; r
> -let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
> +let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | rel-rf-acq-po
>  let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
>  
>  (*
> Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-4.x/tools/memory-model/Documentation/explanation.txt
> @@ -1897,3 +1897,84 @@ non-deadlocking executions.  For example
>  Is it possible to end up with r0 = 36 at the end?  The LKMM will tell
>  you it is not, but the model won't mention that this is because P1
>  will self-deadlock in the executions where it stores 36 in y.
> +
> +In the LKMM, locks and release-acquire chains cause stores to
> +propagate in order.  For example:
> +
> +	int x, y, z;
> +
> +	P0()
> +	{
> +		WRITE_ONCE(x, 1);
> +		smp_store_release(&y, 1);
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +
> +		r1 = smp_load_acquire(&y);
> +		WRITE_ONCE(z, 1);
> +	}
> +
> +	P2()
> +	{
> +		int r2, r3, r4;
> +
> +		r2 = READ_ONCE(z);
> +		smp_rmb();
> +		r3 = READ_ONCE(x);
> +		r4 = READ_ONCE(y);
> +	}
> +
> +If r1 = 1 and r2 = 1 at the end, then both r3 and r4 must also be 1.
> +In other words, the smp_store_release() read by the smp_load_acquire()
> +together act as a sort of inter-processor fence, forcing the stores to
> +x and y to propagate to P2 before the store to z does, regardless of
> +the fact that P2 doesn't execute any release or acquire instructions.
> +This conclusion would hold even if P0 and P1 were on the same CPU, so
> +long as r1 = 1.
> +
> +We have mentioned that the LKMM treats locks as acquires and unlocks
> +as releases.  Therefore it should not be surprising that something
> +analogous to this ordering also holds for locks:
> +
> +	int x, y;
> +	spinlock_t s;
> +
> +	P0()
> +	{
> +		spin_lock(&s);
> +		WRITE_ONCE(x, 1);
> +		spin_unlock(&s);
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +
> +		spin_lock(&s);
> +		r1 = READ_ONCE(x):
> +		WRITE_ONCE(y, 1);
> +		spin_unlock(&s);
> +	}
> +
> +	P2()
> +	{
> +		int r2, r3;
> +
> +		r2 = READ_ONCE(y);
> +		smp_rmb();
> +		r3 = READ_ONCE(x);
> +	}
> +
> +If r1 = 1 at the end (implying that P1's critical section executes
> +after P0's) and r2 = 1, then r3 must be 1; the ordering of the
> +critical sections forces the store to x to propagate to P2 before the
> +store to y does.
> +
> +In both versions of this scenario, the store-propagation ordering is
> +not required by the operational model.  However, it does happen on all
> +the architectures supporting the Linux kernel, and kernel developers
> +seem to expect it; they have requested that this behavior be included
> +in the LKMM.
> 
