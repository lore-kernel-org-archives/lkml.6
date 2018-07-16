Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA00CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F9B20877
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X5A1lsUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F9B20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeGPT7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:59:11 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39502 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeGPT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:59:10 -0400
Received: by mail-io0-f196.google.com with SMTP id e13-v6so38914431iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5tblEWJAkxnWjkLrth4QxGXaRt2ur5mdFARlDS6TuQQ=;
        b=X5A1lsUXZH2bx9qMVwSO+/i26sdanFXjjL1A2fFB6xa21snGoS7L+g9tNa0E0YXSWV
         BpNUBg0w0KG/NwwpNdNBMmYj62jPqCv7Sk4T9dIv0OOrbQHiVWkFhPRZWU4DuIoeHzmM
         Mp91JQbWvA2elxKITeHFSNWZcip6w7I8Hm98I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tblEWJAkxnWjkLrth4QxGXaRt2ur5mdFARlDS6TuQQ=;
        b=NIM3t9zoJDvOeg+POaXRsREYuEP05ojkD0BPuTqx5/6CCMBq44VsAVc9whBmXpog3r
         Jfx4OhquKpD/d7r8QqNdC6g2UBs7UIkJ62gsU+q9usBhMLugRvFM5a9k5zhVte0JmDHv
         2Kefb/q8p8WeFo3sBe7niSi0J+c7/uxWaVZew0EKsSCAYNnTxYGqFzMUZCKJ0zFGT6q1
         mrAWTL5O/00Wpil/NW6TsUQcea3FBBi/kXqF4Z1IzF7RnODrbkGfBVBrBK8HfWRpETvy
         SZaks9CVk0PVRA+w8Rwu0luubZHt58xAIVzmPyrlaIIq0AWnEzeTzn/s0yl07Qj4gqM2
         trAQ==
X-Gm-Message-State: AOUpUlFOa4z6ITdzsT21eDWbGX3ir63KbWPO56L6ia1kzptDOydi8X9K
        ONfMrb5T1cWt4UUKPLeMRWuabvvC8j+o1UJwqEE=
X-Google-Smtp-Source: AAOMgpdSd8s8EXilxdBVqR8MbII9edSz5+LQJr5KS+0rulzW/79loPHrk3QY3O7MRk9ea+y6K2aO4eonB2O+6QaeHFc=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr42620179ion.259.1531769419074;
 Mon, 16 Jul 2018 12:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com> <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net> <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net> <87601fz1kc.fsf@concordia.ellerman.id.au>
In-Reply-To: <87601fz1kc.fsf@concordia.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jul 2018 12:30:07 -0700
Message-ID: <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 7:40 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> If the numbers can be trusted it is actually slower to put the sync in
> lock, at least on one of the machines:
>
>               Time
> lwsync_sync   84,932,987,977
> sync_lwsync   93,185,930,333

Very funky.

> I guess arguably it's not a very macro benchmark, but we have a
> context_switch benchmark in the tree[1] which we often use to tune
> things, and it degrades badly. It just spins up two threads and has them
> ping-pong using yield.

I hacked that up to run on x86, and it only is about 5% locking
overhead in my profiles. It's about 18% __switch_to, and a lot of
system call entry/exit, but not a lot of locking.

I'm actually surprised it is even that much locking, since it seems to
be single-cpu, so there should be no contention and the lock (which
seems to be

        rq = this_rq();
        rq_lock(rq, &rf);

in do_sched_yield()) should stay local to the cpu.

And for you the locking is apparently even _more_ noticeable.

But yes, a 10% regression on that context switch thing is huge. You
shouldn't do ping-pong stuff, but people kind of do.

              Linus
