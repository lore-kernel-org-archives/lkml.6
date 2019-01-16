Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB6CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1C62082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTUPsbML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbfAPHrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:47:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37622 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfAPHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:47:53 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so4196726iok.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 23:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mEUMRRlUi2pZohKna/C1HxAnZ2ybcIeGI4SY2Mk+gA=;
        b=hTUPsbML0ukR5dIPafvw+6K+BfPvAKpEWrvgfRl6Lv870z/Ju5YHi5xcC6mdqXGkqP
         mLMkeGbBxGmdT945de0fjJl+JkigUNS1x5aeMax2W9M3IydKLQNL+gPiyiRTW0NfVFxU
         31ZxDvVHJN9HWl+9iBqxcTAbPrdL2b40qzM74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mEUMRRlUi2pZohKna/C1HxAnZ2ybcIeGI4SY2Mk+gA=;
        b=MERRQkoAG5+7PMQzZfiMU+qzJ6PiAEmI3MxoN6QObkUt3ajb8Cgm17vvpenQEPPsAm
         x6FkvApo4BFyo9rSSayHsh3VAz3xm190jcUEI56In5+FWhzysN9yYZYK2B5jXpPg8QfB
         qbyhJBFpnzqFqReAHH0CairB4s67MqGMXKTLTSUFZh4QdIW/zX6RsevhF5z+6WAmEcwM
         qM6Peq5hsFeJ1tMMx3w0MwtsMrmsSPnaGlz87J4ec8pKT6Z7LNj2y6Es/4MLUHh+x8rT
         wp1MsneYq73DrpfxAHdrFnXzAVE2eunwsxfw1+wSjQbOcCJQIs5r6kPbh4N3DvwcEky3
         wG9Q==
X-Gm-Message-State: AJcUukd53+xxM+4NgT6ekrNBOkvaGqEUePdGkDrva/Z4qClmUc853cdU
        zbzkfkWZjs21q8NrjGTU+xHkKWLz4ajTjb+6nxK2cw==
X-Google-Smtp-Source: ALg8bN4LIbm3/m7VL/ZdwolPRIEFlWj8fWTKy1FlTUUjIbFOzDbYjm2Pl4gUs8LVt9PKPzqz4Ra3FcA7u16SZXw7mwA=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr4432621iop.60.1547624872328;
 Tue, 15 Jan 2019 23:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net> <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com> <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com> <20190114191350.GA29600@fuggles.cambridge.arm.com>
 <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com> <20190114193548.GB29600@fuggles.cambridge.arm.com>
 <87a7k2yx66.fsf@concordia.ellerman.id.au> <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
 <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com>
In-Reply-To: <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 16 Jan 2019 08:47:41 +0100
Message-ID: <CAKv+Gu8_0HjPsT2ne-uCtxRt=2CE_tLGY6wo9xafC5SmJOGRKA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= 
        <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 at 08:36, Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 16.01.19 um 01:33 schrieb Benjamin Herrenschmidt:
> > On Tue, 2019-01-15 at 22:31 +1100, Michael Ellerman wrote:
> >>>> As far as I know Power doesn't really supports un-cached memory at all,
> >>>> except for a very very old and odd configuration with AGP.
> >>> Hopefully Michael/Ben can elaborate here, but I was under the (possibly
> >>> mistaken) impression that mismatched attributes could cause a machine-check
> >>> on Power.
> >> That's what I've always been told, but I can't actually find where it's
> >> documented, I'll keep searching.
> >>
> >> But you're right that mixing cached / uncached is not really supported,
> >> and probably results in a machine check or worse.
> >   .. or worse :) It could checkstop.
>
> Not sure if that would be so bad, it would at least give us a clear
> indicator that something is wrong instead of silently corrupting data.
>
> > It's also my understanding that on ARM v7 and above, it's technically
> > forbidden to map the same physical page with both cached and non-cached
> > mappings, since the cached one could prefetch (or speculatively load),
> > thus creating collisions and inconsistencies. Am I wrong here ?
>
> No, but you answer the wrong question.
>
> See we don't want to have different mappings of cached and non-cached on
> the CPU, but rather want to know if a snooped DMA from the PCIe counts
> as cached access as well.
>
> As far as I know on x86 it doesn't, so when you have an un-cached page
> you can still access it with a snooping DMA read/write operation and
> don't cause trouble.
>

I think it is the other way around. The question is, on an otherwise
cache coherent device, whether the NoSnoop attribute set by the GPU
propagates all the way to the bus so that it bypasses the caches.

On x86, we can tolerate if this is not the case, since uncached memory
accesses by the CPU snoop the caches as well.

On other architectures, uncached accesses go straight to main memory,
so if the device wrote anything to the caches we won't see it.

So to use this optimization, you have to either be 100% sure that
NoSnoop is implemented correctly, or have a x86 CPU.

> > The old hack of using non-cached mapping to avoid snoop cost in AGP and
> > others is just that ... an ugly and horrible hacks that should have
> > never eventuated, when the search for performance pushes HW people into
> > utter insanity :)
>
> Well I agree that un-cached system memory makes things much more
> complicated for a questionable gain.
>
> But fact is we now have to deal with the mess, so no point in
> complaining about it to much :)
>

Indeed. I wonder if we should just disable it altogether unless CONFIG_X86=y
