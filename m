Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6306FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C41120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEsMOHrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfAQICv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:02:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34030 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfAQICu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:02:50 -0500
Received: by mail-io1-f66.google.com with SMTP id b16so7125525ior.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGyAna2Dl1h07bAPr3fca2q6SGrMBnxgn0zuhAtSdwE=;
        b=HEsMOHrU+BUCVJkbjxCoSHvj7aRRm4WHhMBt9q1LuXgpfMqUsxqaFvwI2cmJwk5uHm
         vlLcaXpKscjYuHoJQmeSZs7fmzvd8XihEFxpmGxFZTWx5og1OY1NQ4hGP2gAWIIpFw21
         Kyci6U6QJ7vQm5mAhrQ1piv8jQiw099hLYerc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGyAna2Dl1h07bAPr3fca2q6SGrMBnxgn0zuhAtSdwE=;
        b=tkW6KMqVN5cP4CDLIdUMbv02H84WRnV4bQ7wu1ydw82FNqyKlZvDjXDKM48qw2dJo2
         vCjgh2PyemawINAAl8AxvnOLHZOYCHEOebmL4jMQmgTG4WYYXVjAevWdvzTDug0nMm7j
         ajhYoqdsXdq2TegtUrm0pTCzoisv0Z6T5niwc2b4iNAWa808diV0X8VgMJnUP2n2woqU
         36VvRjmrCt7ygLnQrYd5hOynQa+OyxyucyHTySAsJpvLZMYxSnW/DjLI9pcpwSIRY2Kb
         vTm8p4JkhfjlNoO0qssQBnjq8grFLitXoaS9irDrRruFvo7X394e52WzmrrmMpOYXjGK
         Ww2Q==
X-Gm-Message-State: AJcUukesaMiify9qeVNMq3BQkdpMYZXZal0jTKsjSgMRP9/jW8Hy5KV0
        QryHPfaJ6GRaHcXTYqNQYKjNvjQfS0e79nHzQQf74g==
X-Google-Smtp-Source: ALg8bN6JU/UXKOzDfgrYdJgaXLJ9oLIW2kKXTJ5WCAbcEAD+xlWlbkqjq4HuqVVNB0xrMLwsHpeQeXkQvDd/ImbkBaM=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr6691822iob.170.1547712169544;
 Thu, 17 Jan 2019 00:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net> <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com> <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com> <20190114191350.GA29600@fuggles.cambridge.arm.com>
 <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com> <20190114193548.GB29600@fuggles.cambridge.arm.com>
 <87a7k2yx66.fsf@concordia.ellerman.id.au> <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
 <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com> <CAKv+Gu8_0HjPsT2ne-uCtxRt=2CE_tLGY6wo9xafC5SmJOGRKA@mail.gmail.com>
 <9d706807c93f88bc850153ae20ea28e6502e0aac.camel@kernel.crashing.org>
In-Reply-To: <9d706807c93f88bc850153ae20ea28e6502e0aac.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 17 Jan 2019 09:02:38 +0100
Message-ID: <CAKv+Gu_jQzQ08tiC2TfSpHRvoH=AU9g50Vo-LB2yd4vTD7Qw5A@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
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

On Thu, 17 Jan 2019 at 07:07, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2019-01-16 at 08:47 +0100, Ard Biesheuvel wrote:
> > > As far as I know on x86 it doesn't, so when you have an un-cached page
> > > you can still access it with a snooping DMA read/write operation and
> > > don't cause trouble.
> > >
> >
> > I think it is the other way around. The question is, on an otherwise
> > cache coherent device, whether the NoSnoop attribute set by the GPU
> > propagates all the way to the bus so that it bypasses the caches.
>
> On powerpc it's ignored, all DMA accesses will be snooped. But that's
> fine regardless of whether the memory was mapped cachable or not, the
> snooper will simply not find anything if not. I *think* we only do
> cache inject if the line already exists in one of the caches.
>

Others should correct me if I am wrong, but arm64 SoCs often have L3
system caches, and I would expect inbound transactions with writeback
write-allocate (WBWA) attributes to allocate there.

> > On x86, we can tolerate if this is not the case, since uncached memory
> > accesses by the CPU snoop the caches as well.
> >
> > On other architectures, uncached accesses go straight to main memory,
> > so if the device wrote anything to the caches we won't see it.
>
> Well, on all powerpc implementations that I am aware of at least (dunno
> about ARM), they do, but we don't have a problem because I don't think
> the devices can/will write to the caches directly unless a
> corresponding line already exists (but I might be wrong, we need to
> double check all implementations which is tricky).
>
> I am not aware of any powerpc chip implementing NoSnoop.
>

Do you have any history on why this optimization is disabled for power
unless CONFIG_NOT_CACHE_COHERENT is set?

That also begs the question how any of this is supposed to work with
non-cache coherent DMA. The code appears to always assume cache
coherent, and provide non-cache coherent as an optimization if
dma_arch_can_wc_memory() returns true. So I wonder if that helper
should take a struct device pointer instead, and return true for
non-cache coherent devices.

> > So to use this optimization, you have to either be 100% sure that
> > NoSnoop is implemented correctly, or have a x86 CPU.
> >
> > > > The old hack of using non-cached mapping to avoid snoop cost in AGP and
> > > > others is just that ... an ugly and horrible hacks that should have
> > > > never eventuated, when the search for performance pushes HW people into
> > > > utter insanity :)
> > >
> > > Well I agree that un-cached system memory makes things much more
> > > complicated for a questionable gain.
> > >
> > > But fact is we now have to deal with the mess, so no point in
> > > complaining about it to much :)
> > >
> >
> > Indeed. I wonder if we should just disable it altogether unless CONFIG_X86=y
>
> The question is whether DMA from a device can instanciate cache lines
> in your system. This a system specific rather than architecture
> specific question I suspect...
>

The ARM architecture permits it, afaict, and write-allocate is a hint
so the implementation is free to ignore it, whether it is set or
cleared.
