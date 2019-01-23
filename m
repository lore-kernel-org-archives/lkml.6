Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF653C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DAE20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9Ydi6Cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfAWJIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:08:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38765 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfAWJIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:08:34 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so1962517ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3SLQAjcWFTSHuFKqdcoCiPl5duUwcMm1WoAe2zQCBc=;
        b=i9Ydi6CmBjJ7Qni4RNgJ7lVtnh7RArk6uu2wSuqNpqsad96ta1d0NpdiQ8BzSHc4bS
         JSqoFLKVsdEmvHnzmHhGGbByZ+V+aMxHR8SrW0V5DwK0TWDHR6fwuiK7ubFkstFD9yoW
         jIdGnPi2Kr0fLwvVBBPLZg3ugX1LDdyHHV+Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3SLQAjcWFTSHuFKqdcoCiPl5duUwcMm1WoAe2zQCBc=;
        b=WzWIeSL5ti0mjJjKxdl/Np848z33VcbCpMwFxNGKZmv4QXFrqSBLajH51eyPO/UBa1
         bf+yDD2/6bZmzlZBxNoV1qJS3CpYthoRPyPP9gw9eB9jx6FgCiGP2Rksv10oclNX79Al
         TUYp6T3j6F5NYafuTP7RPA7OL3hDSJF6i5AEY02kc5YQkXDXFacQ9Qxiv0TZfWIULinZ
         uK6peAX4JHcG0LeZzQdjsq4ZDPXhdK3lvUNNF4K2CXkPMHiIT+OGXt8hOW0/VggKgPVu
         HQDpwRI/QQDqOYAETBu7HwPzX+Z7cW1HmB/x10rDD2Fpn89RNG12nr2Saj6+oJ469Ide
         oMQA==
X-Gm-Message-State: AJcUukfU0xyULcNO1HO/rqH4kLRhHkakac7g+jbzDXRN5YPLppl9ERS7
        ANx59FGGRT4O+JeJLeOQh3sXiRIoWKo4m+utJK9WAQ==
X-Google-Smtp-Source: ALg8bN4lk85uz0JceBO+AHKsHYOmxUSU7AKhBIG8KtUj87JvWhQZ8S5QHF2//QK6ItCYhNLvXzxgFQc5lPCkqkFW2vY=
X-Received: by 2002:a02:183:: with SMTP id 3mr834166jak.130.1548234513858;
 Wed, 23 Jan 2019 01:08:33 -0800 (PST)
MIME-Version: 1.0
References: <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
 <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net> <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net> <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net> <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com> <20190123071521.GB20526@infradead.org>
In-Reply-To: <20190123071521.GB20526@infradead.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 23 Jan 2019 10:08:22 +0100
Message-ID: <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 08:15, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jan 22, 2019 at 10:07:07PM +0100, Ard Biesheuvel wrote:
> > Yes, so much was clear. And the reason this breaks on some arm64
> > systems is because
> > a) non-snooped PCIe TLP attributes may be ignored, and
> > b) non-x86 CPUs do not snoop the caches when accessing uncached mappings.
> >
> > I don't think there is actually any disagreement on this part. And I
> > think my patch is reasonable, only Christoph is objecting to it on the
> > grounds that drivers should not go around the DMA API and create
> > vmap()s of DMA pages with self chosen attributes.
>
> I object to it on various grounds.  While the above is correct it really
> is a mid to long-term fix.
>
> But even in the short term your patch just maintains a random list of
> idefs in a random driver, pokes into the dma-mapping internals and lacks
> any comments in the code explaining on what is going on, leading to
> futher cargo culting.  So it very clearly is not acceptable.

Fair enough. It would be helpful, though, if you could give more
guidance on what you do find acceptable. You haven't answered my
question on whether you think drivers should be allowed to reason at
all about the device's cache coherence.

In any case, I think we (you and I) could easily agree on the correct fix being:
- introduce DMA_ATTR_NOSNOOP
- implement it as a no-op for non-cache coherent devices (since
nosnoop is implied)
- permit non-x86 architectures to override/ignore it if not supported
- rip out all the explicit vmap()/kmap()s of DMA pages from the DRM
drivers, and instead, set the DMA_ATTR_NOSNOOP attribute where
desired, and always use the mappings provided by the DMA API.

The problem is that we will need the DRM/radeon/amdgpu maintainers on
board with this, and until this happens, I am stuck in the middle with
a broken arm64 system.

So, given the above, what /would/ you find acceptable?
