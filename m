Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA4FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2123320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="h9iPWzoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2123320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbeFRP0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:26:07 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:60569 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754110AbeFRP0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:26:05 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 87a6dfe5
        for <linux-kernel@vger.kernel.org>;
        Mon, 18 Jun 2018 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=COjnSFlcb4X92uEDe3+JDCHJYRw=; b=h9iPWz
        oPiYkpjd8ZkYIVJ2zWyXWp4Me2F7+CvoKRiuNhjFo/IZ/a4Cfc3DJQDXHiv94FCD
        bcoBn5mg2SWvQo8jjpVfAencFBkvEwvO5UKYjS2hd1rKwop569mzFWVUixKwaY8s
        NTtYNhIvr3ZmRQHhCYVr+qdixNvvozuo9GAEY9lV2jat33TZaCVYKNgmZakCOTH0
        Cnpof3TbtPC3JYvI7pZkUg9hCBh03hHaSrRwQEcfPb/qojTjVOu69AZm0oxXRVRo
        LtQGO63haKmZsHaiy5bgwdH7t9rOtP07cd4UFGTCzi+iwOnX8tzrdC4kfsM1WGGf
        xn9Z6tZaPG73Jp2g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f43305d9 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 18 Jun 2018 15:20:19 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id a141-v6so15184899oii.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:26:04 -0700 (PDT)
X-Gm-Message-State: APt69E3lF7hSmmuMlZKIhQA/FJQz9WhU5cph55Z89uy8ZxIh+fW+9KxJ
        vNeTNb/7hhxFBeO4/RLR5EjcDn8PWQG8u6NcHGE=
X-Google-Smtp-Source: ADUXVKJlAfm86DKevqVNWo21uHWI3iHAX4cmdrPehSW110tLg2TTLOYCAOF02gjMn3zu/zke55lBIy5oxEhbGsVShds=
X-Received: by 2002:aca:e40b:: with SMTP id b11-v6mr6593204oih.243.1529335564243;
 Mon, 18 Jun 2018 08:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <alpine.DEB.2.21.1806151815080.1582@nanos.tec.linutronix.de>
 <20180615193438.GE2458@hirez.programming.kicks-ass.net> <CAHmME9qr4PzsGKK2r2sGoCty_Yum_3UqUdL76CPOAOq18K+a4A@mail.gmail.com>
 <20180618094447.GG2458@hirez.programming.kicks-ass.net>
In-Reply-To: <20180618094447.GG2458@hirez.programming.kicks-ass.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 18 Jun 2018 17:25:53 +0200
X-Gmail-Original-Message-ID: <CAHmME9rGD9BjZebc9Zsa69rsNxoHBTvayydfk0XzDCNjCGnZxA@mail.gmail.com>
Message-ID: <CAHmME9rGD9BjZebc9Zsa69rsNxoHBTvayydfk0XzDCNjCGnZxA@mail.gmail.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 15, 2018 at 10:30:46PM +0200, Jason A. Donenfeld wrote:
> > On Fri, Jun 15, 2018 at 9:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > Didn't we recently do a bunch of crypto patches to help with this?
> > >
> > > I think they had the pattern:
> > >
> > >         kernel_fpu_begin();
> > >         for (units-of-work) {
> > >                 do_unit_of_work();
> > >                 if (need_resched()) {
> > >                         kernel_fpu_end();
> > >                         cond_resched();
> > >                         kernel_fpu_begin();
> > >                 }
> > >         }
> > >         kernel_fpu_end();
> >
> > Right, so that's the thing -- this is an optimization easily available
> > to individual crypto primitives. But I'm interested in applying this
> > kind of optimization to an entire queue of, say, tiny packets, where
> > each packet is processed individually. Or, to a cryptographic
> > construction, where several different primitives are used, such that
> > it'd be meaningful not to have to get the performance hit of
> > end()begin() in between each and everyone of them.
>
> I'm confused.. how does the above not apply to your situation?

In the example you've given, the optimization is applied at the level
of the, say, encryption function. Suppose you send a scattergather off
to an encryption function, which then walks the sglist and encrypts
each of the parts using some particular key. For each of the parts, it
benefits from the above optimization.

But what I'm referring to is encrypting multiple different things,
with different keys. In the case I'd like to optimize, I have a worker
thread that's processing a large queue of separate sglists and
encrypting them separately under different keys. In this case, having
kernel_fpu_begin/end inside the encryption function itself is a
problem, since that means toggling the FPU in between every queue
item. The solution, for now, is to just hoist the kernel_fpu_begin/end
out of the encryption function, and put them instead at the beginning
and end of my worker thread that handles all the items of the queue.

This is fine and dandy, but far from ideal, as putting that kind of
logic inside the encryption function itself makes more sense. For
example, the encryption function can decide whether or not it even
wants to use the FPU before calling kernel_fpu_begin. Ostensibly this
logic too could be hoisted outside, but at what point do you draw the
line and decide these optimizations are leading the API in the wrong
direction?

Hence, the idea here in this thread is to make it cost-free to place
kernel_fpu_begin/end as close as possible to the actual use of the
FPU. The solution, it seems, is to have the actual kernel_fpu_end work
occur on context switch.
