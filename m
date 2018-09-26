Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DBBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A580521528
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKgVTvnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A580521528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeIZVzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:55:35 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52117 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeIZVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:55:35 -0400
Received: by mail-it1-f195.google.com with SMTP id 74-v6so1847845itw.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCJVnPPLWEATgE21wxrgrVuRh7WoK5vHrKiJ+37zDQI=;
        b=dKgVTvnwsOIU54webWPzIw7ix9mbqW0LGgx9gn4osbXwU1nkGWZCYqTIWHQ3jxcmfs
         CHyze8oyoSeqit+/xvP9aQH7Z/ruDBP947+pe0kY9bf6i1QzbAWyN1eUqQakJoMancmy
         vHS3O3ZnKUqEH32zKo4oV5RksxVxl/BMTo4Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCJVnPPLWEATgE21wxrgrVuRh7WoK5vHrKiJ+37zDQI=;
        b=PLNdEDHCAWUuVH+QPw1V+8B1on6Nheub+TVkSy0jiOwP444lMhHE08VGLy3e88aPWI
         hvBQYuiljhJi1ET028PC1zVAKB54PT+Y3QHdL1z+UAVxPjPpN/I25ni8jvGY12GTH+Zt
         jPHJaN7mTHZizBgWS+EBO//mBLFFREOIoKQpPq5vjryG7PATqmsUBgvXRk/zHHmJ5DHT
         sKILbbS5xANzD+8OwUYhNzLqhuIquTcqwo5Q4JtJmOhSmg3m12bsgXyHnZM1CtqJJBUc
         QRSiBD5WbvMjfz1CFZjeKBaJo3FPM7utLhj4fmPmVBoSEw/ozTBMqo3KrSHTtv9y1eFj
         s+Cw==
X-Gm-Message-State: ABuFfogV9oQboPkBJHkDnIn8qsdoT9327xWn8bPF5H4Ikw4VSYYRLFBv
        WYof7+KOgR6CsmeD0vdHJf0dy/vQjpBN4lLW4+LTtlxY
X-Google-Smtp-Source: ACcGV63LpKfGiYDXkA+mOaNjQaSmV7IFD/9CvED1fJFa1xBgwrLdwQI5WvyKwtnwFIJVGdaMDIZArgZT4sCCyME2NsI=
X-Received: by 2002:a24:e48e:: with SMTP id o136-v6mr5515810ith.58.1537976523776;
 Wed, 26 Sep 2018 08:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com> <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Sep 2018 17:41:50 +0200
Message-ID: <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 at 16:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> (+ Herbert, Thomas)
>
> On Wed, 26 Sep 2018 at 15:33, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Ard,
> >
> > On Wed, Sep 26, 2018 at 10:59 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > > +static inline bool chacha20_arch(struct chacha20_ctx *state, u8 *dst,
> > > > +                                const u8 *src, size_t len,
> > > > +                                simd_context_t *simd_context)
> > > > +{
> > > > +#if defined(CONFIG_KERNEL_MODE_NEON)
> > > > +       if (chacha20_use_neon && len >= CHACHA20_BLOCK_SIZE * 3 &&
> > > > +           simd_use(simd_context))
> > > > +               chacha20_neon(dst, src, len, state->key, state->counter);
> > > > +       else
> > > > +#endif
> > >
> > > Better to use IS_ENABLED() here:
> > >
> > > > +       if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON)) &&
> > > > +           chacha20_use_neon && len >= CHACHA20_BLOCK_SIZE * 3 &&
> > > > +           simd_use(simd_context))
> >
> > Good idea. I'll fix that up.
> >
> > >
> > > Also, this still has unbounded worst case scheduling latency, given
> > > that the outer library function passes its entire input straight into
> > > the NEON routine.
> >
> > The vast majority of crypto routines in arch/*/crypto/ follow this
> > same exact pattern, actually. I realize a few don't -- probably the
> > ones you had a hand in :) -- but I think this is up to the caller to
> > handle.
>
> Anything that uses the scatterwalk API (AEADs and skciphers) will
> handle at most a page at a time. Hashes are different, which is why
> some of them have to handle it explicitly.
>
> > I made a change so that in chacha20poly1305.c, it calls
> > simd_relax after handling each scatter-gather element, so a
> > "construction" will handle this gracefully. But I believe it's up to
> > the caller to decide on what sizes of information it wants to pass to
> > primitives. Put differently, this also hasn't ever been an issue
> > before -- the existing state of the tree indicates this -- and so I
> > don't anticipate this will be a real issue now.
>
> The state of the tree does not capture all relevant context or
> history. The scheduling latency issue was brought up very recently by
> the -rt folks on the mailing lists.
>
> > And if it becomes one,
> > this is something we can address *later*, but certainly there's no use
> > of adding additional complexity to the initial patchset to do this
> > now.
> >
>
> You are introducing a very useful SIMD abstraction, but it lets code
> run with preemption disabled for unbounded amounts of time, and so now
> is the time to ensure we get it right.
>

Actually, looking at the code again, the abstraction does appear to be
fine, it is just the chacha20 code that does not make use of it.
