Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054EFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8E2218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CuUrRRIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394285AbfBMTre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:47:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41561 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392745AbfBMTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:47:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id e17-v6so3082145lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmAH68Yw/MiLp8QA832f5AZIzUd8aplDyG7cE2JEA7g=;
        b=CuUrRRIr+f6aB/1ZZBkoqhUf+tUoJRKkt/+H+BF3JvB7Z1Nw+z+esbhIq3qA3FEsTA
         nrLoAPq09XAmVszHyDXba1wTIc2SFEo8y2W8BCO8j1PtIC5r6AO1Snf+Nl9M8YMcV5Vm
         QxAeBJRIIwGhURda3OOc/sqsSfVO5I2TdQP4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmAH68Yw/MiLp8QA832f5AZIzUd8aplDyG7cE2JEA7g=;
        b=LW2lq9HvWMldcXRRk2TRfdG0XfUt13z9i8fat58M4pjZQWYnaJYvgiSV4KUSdqjrIi
         EAePqbOHHnXEuPGarSPwtiurxnzxydENIOTxtjK05QpLkXlri+tE49e0qvS5sElUWakS
         ifaGcUsl/wV9MgCZG+nUiWo2a9LOW5yejVRwF2kw76ylAAsTv6KSNTxngwq1EsLNmOim
         KtAfkGPEJjMf7xuaoH7pQQvMsGMopFyYsSHKkJNB9paEap5KV52Q+uyLV7cIHyEVwlBX
         Cdl6C1wvrzk3KtSTtP0J9Dr0gV8/pS4Qe1o1DIKESHbmAiayUznTweXzP9eR0cF4n7am
         CPxg==
X-Gm-Message-State: AHQUAubXR9weCZ423+f+2y2Dz/BXdEqebNAg1jfZJmSTXK8czVo1aGnJ
        L57GZ/RVEhgNr3n31RfLqLnVyQD44wY=
X-Google-Smtp-Source: AHgI3IaPminfe+m7j0q3sDE7KbunqN854lxNcQFtwKx7KEav1raZfMaEpFVWQX3ZgE8x8MmNkfmkfA==
X-Received: by 2002:a2e:9245:: with SMTP id v5-v6mr1244311ljg.195.1550087251239;
        Wed, 13 Feb 2019 11:47:31 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id h7-v6sm37745ljc.45.2019.02.13.11.47.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 11:47:30 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id f5so2693004lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:47:29 -0800 (PST)
X-Received: by 2002:a19:ab09:: with SMTP id u9mr1305258lfe.149.1550087249403;
 Wed, 13 Feb 2019 11:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20190212171423.8308-1-frederic@kernel.org> <20190212171423.8308-6-frederic@kernel.org>
 <CAHk-=whhGQuMuuBkLBKGL3kM+8j3+TC_xt+QKFCs1qNySBv3-A@mail.gmail.com> <20190213151648.GD8524@lenoir>
In-Reply-To: <20190213151648.GD8524@lenoir>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Feb 2019 11:47:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9q2o+oJtzuaZFPxXWrcKiO-bRBGBePfnLx6nPS+aiCA@mail.gmail.com>
Message-ID: <CAHk-=wh9q2o+oJtzuaZFPxXWrcKiO-bRBGBePfnLx6nPS+aiCA@mail.gmail.com>
Subject: Re: [PATCH 05/32] locking/lockdep: Prepare valid_state() to handle
 plain masks
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 7:16 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > If "vectors" only has the high hit set, you end up with "fs" having
> > the value "64".
> >
> > And then "vectors >>= fs" is undefined and won't actually do anything
> > at all on x86.
>
> Oh! ok didn't know that...

So in general, shift counts >= width of the type (or negative) are undefined.

They can sometimes happen to work (that's the "undefined" part ;), but
it's not reliable or portable.

It's why you occasionally see things like

drivers/block/sx8.c:
        tmp             = (blk_rq_pos(rq) >> 16) >> 16;

to get the upper 32 bits of the value. It is written with that odd
double shift, rather than being written as ">> 32". That way it works
even if the sector type happens to be 32-bit (and the compiler will
just end up turning it into a zero if it's an unsigned 32-bit type
since it's compile-time obvious).

> I see, perhaps I should use for_each_set_bit() that should take care about those
> details?

That would _work_, but don't do that. "for_each_set_bit()" works on
bitmaps in memory, and is slow for a simple word case. In addition to
being slow, it uses the Linux tradition of working on bitmaps that are
comprised of "unsigned long". So it has byte order issues too.

So for_each_set_bit() is useful when you have real arrays of bits and
are using the "set_bit()" etc interfaces.

When you're actually working on just a single variable, your "__ffs()"
model works fine, you just need to be careful to _not_ do the "+1" and
then use it for shifts.

Also, it actually turns out that if you want to be really clever, you
can play tricks if you don't care about the exact bit *number*.

For example, this expression:

       v =  a & (a-1);

will remove the lowest bit set from 'a' very cheaply. So what you can
do is something like this:

    void for_each_bit_in_mask(u64 mask)
    {
        while (mask) {
                u64 newmask = mask & (mask-1);
                u64 onebit = mask ^ newmask;
                mask = newmask;
                do_something_with(onebit);
        }
    }

to do some operation on each bit set, and quite efficiently and
without any undefined behavior or expensive shifts.

But the above trick does require that you are happy to just see the
bit *mask*, not the bit *number*. I'm not sure any of your cases match
that.

                Linus
