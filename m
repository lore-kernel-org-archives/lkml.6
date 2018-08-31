Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87820C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4DF20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnpWRQ08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4DF20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeHaNYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:24:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44543 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaNYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:24:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id s10-v6so8524422edb.11;
        Fri, 31 Aug 2018 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WQAuwYTzNRNvMZH3PHWfAKuVur42rOMya+jgQTFKSqY=;
        b=gnpWRQ08CQRh2PFRHAJAd0V+uCxz4UR3iOyT0pr4hL+YFFk+ZzeOI3R0BtRWYAambt
         M+eC9UICR350bSYr9E7ds7hm+w7Iv4+4oiYXGxODpMR6nAAExCidwDsS2jEv8aGifGgS
         IodZz6loaUA6TMuC9stBlhvDZkHfWWcdFiyxeYFSyOm1jn4sVosDjJYoNlf2zkYb/YiH
         1WBPUUcz7XUc8BiyB23ooS+yUNCnInRpoh/A2MDwgT4jj7IiuuBBhvj2kStTHXNba0r8
         dHXL/Gbc6xZU/89E8GKUOu4mHE6DH02nGyUuxs7Vg0WBOKLx/XjYmSymioMxMYEzU2lI
         6R0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WQAuwYTzNRNvMZH3PHWfAKuVur42rOMya+jgQTFKSqY=;
        b=B74BQhCq84nA8CZiulA7yQXUAwntAkcN+bxt6WP0Oh/yAfDsGRIbFZqux5dzHz8H6J
         YxW2+bZa/kJrdxXTeakbxyfXc82T2NUVffoVMCedgSZY4GvVTS5xydQoSNgj7QKMQwPO
         N4yGx3PiPci8JIVIG+jqmSYiqLzZVBtPnxzzDT5NQf2d5hqE84PgKLZVDm1oTN2Soo4w
         BHy9KRNecRKtkmaxuHmtireCkXkrz9cIFkthL8U04YGPYL50MKKn2RzZcUR4qGs06Wtl
         hqq8Ah6Ikl8r9RzC4cbm5sI1l0lJgdrmm8KS+63joe86EOJ3ddhsGcnza4LIPoFvvutI
         63Uw==
X-Gm-Message-State: APzg51DIoX8CJSBILCuL2wNvHPGHkg0SfdBiFj2YnF9cDTcSxK0bTdQ9
        R5EV2Rni9C/eLdzIl9sUYko=
X-Google-Smtp-Source: ANB0VdYQ8KVlseFFpqXt1oyajkeXzOCBdx71HleJWXzFVNlTkTaEBiy5c/BV5YtwN6aVmbWE7nNiSA==
X-Received: by 2002:a50:b003:: with SMTP id i3-v6mr16406622edd.120.1535707045050;
        Fri, 31 Aug 2018 02:17:25 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id j23-v6sm4072372edh.29.2018.08.31.02.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 02:17:24 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:17:18 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180831091641.GA3634@andrea>
References: <20180830125045.GA6936@andrea>
 <Pine.LNX.4.44L0.1808301712230.31183-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1808301712230.31183-100000@netrider.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 05:31:32PM -0400, Alan Stern wrote:
> On Thu, 30 Aug 2018, Andrea Parri wrote:
> 
> > > All the architectures supported by the Linux kernel (including RISC-V)
> > > do provide this ordering for locks, albeit for varying reasons.
> > > Therefore this patch changes the model in accordance with the
> > > developers' wishes.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Round 2 ;-), I guess...  Let me start from the uncontroversial points:
> > 
> >   1) being able to use the LKMM to reason about generic locking code
> >      is useful and desirable (paraphrasing Peter in [1]);
> > 
> >   2) strengthening the ordering requirements of such code isn't going
> >      to boost performance (that's "real maths").
> > 
> > This patch is taking (1) away from us and it is formalizing (2), with
> > almost _no_ reason (no reason at all, if we stick to the commit msg.).
> 
> That's not quite fair.  Generic code isn't always universally
> applicable; some of it is opt-in -- meant only for the architectures
> that can support it.  In general, the LKMM allows us to reason about
> higher abstractions (such as locking) at a higher level, without
> necessarily being able to verify the architecture-specific details of
> the implementations.

No, generic code is "universally applicable" by definition; see below
for more on this point.


> 
> > In [2], Will wrote:
> > 
> >   "[...] having them [the RMWs] closer to RCsc[/to the semantics of
> >    locks] would make it easier to implement and reason about generic
> >    locking implementations (i.e. reduce the number of special ordering
> >    cases and/or magic barrier macros)"
> > 
> > "magic barrier macros" as in "mmh, if we accept this patch, we _should_
> > be auditing the various implementations/code to decide where to place a
> > 
> >   smp_barrier_promote_ordinary_release_acquire_to_unlock_lock()" ;-)
> > 
> > or the like, and "special ordering cases" as in "arrgh, (otherwise) we
> > are forced to reason on a per-arch basis while looking at generic code".
> 
> Currently the LKMM does not permit architecture-specific reasoning.  It 
> would have to be extended (in a different way for each architecture) 
> first.

Completely agreed; that's why I said that this patch is detrimental to
the applicability of the LKMM...


> 
> For example, one could use herd's POWER model combined with the POWER 
> compilation scheme and the POWER-specific implementation of spinlocks 
> for such reasoning.  The LKMM alone is not sufficient.
> 
> Sure, programming and reasoning about the kernel would be easier if all
> architectures were the same.  Unfortunately, we (and the kernel) have
> to live in the real world.
> 
> > (Remark: ordinary release/acquire are building blocks for code such as
> >  qspinlock, (q)rwlock, mutex, rwsem, ... and what else??).
> 
> But are these building blocks used the same way for all architectures?

The more, the better! (because then we have the LKMM tools) 

We already discussed the "fast path" example: the fast paths of the
above all resemble:

  *_lock(s):  atomic_cmpxchg_acquire(&s->val, UNLOCKED_VAL, LOCKED_VAL) ...
  *_unlock(s): ...  atomic_set_release(&s->val, UNLOCKED_VAL)

When I read this code, I think "Of course." (unless some arch. has
messed the implementation of cmpxchg_* up, which can happen...); but
then I read the subject line of this patch and I think "Wait, what?".

You can argue that this is not generic code, sure; but why on Earth
would you like to do so?!

  Andrea


> 
> > To avoid further repetition, I conclude by confirming all the concerns
> > and my assessment of this patch as pointed out in [3]; the subsequent
> > discussion, although not conclusive, presented several suggestions for
> > improvement (IMO).
> 
> Alan
> 
