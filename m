Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6408BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6462086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KRdazDr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfARP4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:56:52 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45116 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfARP4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:56:51 -0500
Received: by mail-ed1-f43.google.com with SMTP id d39so11443108edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 07:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xs0Wq9yv1JQc7EqjJlD5ZMBNcuwmnG1fIWNiPqiqBHQ=;
        b=KRdazDr/0ZYmhe6Ec/pRY+VNN98+1GDeYhds4j9mGeVVryB27ZySyze9NIQTMBXxGb
         /5U2tXGb7/O2EkAbky0LkaTX04sfuZAHZUAOCuszINj7crXPNG6OVUMWiyzyci152zWX
         /4MwdyFomK8+lIILaBLaWIWiJC1MM9G1mZVHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xs0Wq9yv1JQc7EqjJlD5ZMBNcuwmnG1fIWNiPqiqBHQ=;
        b=f2WxF7jQkZtmwdMw8BqEVHgSlTb/DApX5d4VKhUpKZjC+KU6xFMExl5ZSs3G2mEE5y
         wMbX+Xw41KkAd6h38ctW244KQUMs2VLMPsxX4s86/b3K8jSo7AgobWHU/j9FsGZoFspG
         11WjTSaKD8OLxEElKpeHmZcRZqN/1eA8BltE/Ahp4hi9R1g7tYYzxaxBUsd2hlECUncz
         RfbteiPmBPxoUJpGC8y7/E9S6ZXg3qOfJThiJbwQyESEgjtNAXrqxdjpQWhZPT6S04ib
         sVb8EZo50fxyrZ6h0RNqlVmVQbDiyq4dYPR7FcWcuqRpkX1jQV0sh+k9Y84MC/r5EJnm
         M40A==
X-Gm-Message-State: AJcUukc0vCCYi2L5wuRCEg7Nu0WbTzsKO6kn1pToQmvIRp3W5Xcy8PCd
        +Wezq8yMcvcSF1qsNKFXB7oW/Tg7GXyy8A==
X-Google-Smtp-Source: ALg8bN5HP+aoEN8p4HoSRpVu+6cZk6w8+Gsh41UNiNdxP1gnT1X9NC8nBVpkaarv+q253uGRbZO36A==
X-Received: by 2002:aa7:ca0d:: with SMTP id y13mr15986458eds.285.1547827009477;
        Fri, 18 Jan 2019 07:56:49 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id gk8-v6sm4174872ejb.42.2019.01.18.07.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 07:56:48 -0800 (PST)
Date:   Fri, 18 Jan 2019 16:56:38 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
Message-ID: <20190118155638.GA24442@andrea>
References: <20190117150336.GA10381@andrea>
 <Pine.LNX.4.44L0.1901181005110.1425-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901181005110.1425-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:10:22AM -0500, Alan Stern wrote:
> On Thu, 17 Jan 2019, Andrea Parri wrote:
> 
> > > Can the compiler (maybe, it does?) transform, at the C or at the "asm"
> > > level, LB1's P0 in LB2's P0 (LB1 and LB2 are reported below)?
> > > 
> > > C LB1
> > > 
> > > {
> > > 	int *x = &a;
> > > }
> > > 
> > > P0(int **x, int *y)
> > > {
> > > 	int *r0;
> > > 
> > > 	r0 = rcu_dereference(*x);
> > > 	*r0 = 0;
> > > 	smp_wmb();
> > > 	WRITE_ONCE(*y, 1);
> > > }
> > > 
> > > P1(int **x, int *y, int *b)
> > > {
> > > 	int r0;
> > > 
> > > 	r0 = READ_ONCE(*y);
> > > 	rcu_assign_pointer(*x, b);
> > > }
> > > 
> > > exists (0:r0=b /\ 1:r0=1)
> > > 
> > > 
> > > C LB2
> > > 
> > > {
> > > 	int *x = &a;
> > > }
> > > 
> > > P0(int **x, int *y)
> > > {
> > > 	int *r0;
> > > 
> > > 	r0 = rcu_dereference(*x);
> > > 	if (*r0)
> > > 		*r0 = 0;
> > > 	smp_wmb();
> > > 	WRITE_ONCE(*y, 1);
> > > }
> > > 
> > > P1(int **x, int *y, int *b)
> > > {
> > > 	int r0;
> > > 
> > > 	r0 = READ_ONCE(*y);
> > > 	rcu_assign_pointer(*x, b);
> > > }
> > > 
> > > exists (0:r0=b /\ 1:r0=1)
> > > 
> > > LB1 and LB2 are data-race free, according to the patch; LB1's "exists"
> > > clause is not satisfiable, while LB2's "exists" clause is satisfiable.
> 
> A relatively simple solution to this problem would be to say that 
> smp_wmb doesn't order plain writes.

It seems so; I don't have other solutions to suggest ATM.  (But, TBH,
I'm still in the process of reviewing/testing these changes... )

And yes, this is a pain! : I don't have the exact statistics, but I'm
willing to believe that removing this order will take us back ~99% of
the current (~500!) uses of smp_wmb() ;-/

Oh, well, maybe we'll find a better solution one day: after all, that
one doesn't seem worse than what the current LKMM has to say! ;-)


> 
> I think the rest of the memory model would then be okay.  However, I am
> open to arguments that this approach is too complex and we should
> insist on the same kind of strict ordering for race avoidance that the
> C11 standard uses (i.e., conflicting accesses separated by full memory
> barriers or release & acquire barriers or locking).

Indeed;  maybe, we've just found another reason to obsolete smp_wmb()! ;-)

  Andrea


> 
> Alan
> 
