Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC531C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E6620879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="knWbAVnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfAUQuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:50:22 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52682 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbfAUQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:50:20 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so17247101itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 08:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZkIHXbK2+RKhg/FHopxKpLPTPpYQ83cmICCVP5I1bs=;
        b=knWbAVnHA7+Agjb5/CO/MtnhNDzHxs1w+IC3Nz1jpwcsb8snEobirr9OPT7vnVAyjM
         G6NAWfTMsLKfJPaK/+xd1CR0jyRbpul4k6GUchiOBw9O6hv9K5TJcivnab0xl8rTcuH/
         6w2XqvWbUPGinJlmAPo+bB1hFD6OeQcxuzw8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZkIHXbK2+RKhg/FHopxKpLPTPpYQ83cmICCVP5I1bs=;
        b=Tzr7TQU8nnOGZD+Yc7PjA6lMoboKi/KXUBKSPpsjwP3KxpsTgC1OkuUACbf1J/W03Y
         I8XReZ+hweIG+RKcMVkJ6aCvVvBdewpsYpm7eBOQEzJNUELA8pWn+DRwYf0TUAEVGloE
         kTC7uiTjbR2PPwdh57f8fRKr9FhkFbugJV+wDVVT9UoG5BwY4UOH8kvLkWLn3AI42+UX
         K+WDbuX/jBywPP4JHd614Qqg174n7OKXkRzJm2hHNfRk8Yr6BXeexZxG89Tu/W64J8XG
         9cqN5XJUYBJWazgQkYLXf63ycLUODYhW7iaCl/mzncRtPRaSng2gH+ydmEfHJtvxKVQE
         p+NQ==
X-Gm-Message-State: AJcUukeLQ5Z7LCfoFcMLo+ofoCClJDnpkfulfMAdeQ7ybL5d7AsKXGpg
        SrzySrcnE+1jzN8h7uxSclBSWi9ycP0+h79ueFFn6bu6z8U=
X-Google-Smtp-Source: AHgI3IZ8jqfnbXkm8z0a6VM6wu0ORa/r/ofG2Bo4LFcs9kk1YW++hnvh4+IvRBmFKzE2afhxd1IwQGXtRgBhCS6uCg0=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr132454ith.158.1548089419522;
 Mon, 21 Jan 2019 08:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org> <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <20190121163539.GA18070@infradead.org>
In-Reply-To: <20190121163539.GA18070@infradead.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 17:50:07 +0100
Message-ID: <CAKv+Gu-NxJkT7ViO8HogVMnPyiYDfOEQsEJ8AFNshexopbby8A@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Michel Daenzer <michel.daenzer@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 17:35, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 21, 2019 at 05:30:00PM +0100, Ard Biesheuvel wrote:
> > > Until that happens we should just change the driver ifdefs to default
> > > the hacks to off and only enable them on setups where we 100%
> > > positively know that they actually work.  And document that fact
> > > in big fat comments.
> >
> > Well, as I mentioned in my commit log as well, if we default to off
> > unless CONFIG_X86, we may break working setups on MIPS and Power where
> > the device is in fact non-cache coherent, and relies on this
> > 'optimization' to get things working. The same could be true for
> > non-coherent ARM systems, hence my approach to disable this hack for
> > cache coherent devices on non-X86 only.
>
> Do we break existing setups or just reduce performance due to the lack
> of WC mappings?  I thought it was the latter.

Combining this check

#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
    return false;
...
#else
    return true;
#endif

with the fact that the driver assumes that DMA is cache coherent, I'd
be surprised if this hardware works without the hack.

The optimization targets cache coherent systems where pushing data
through the cache into the GPU is wasteful, given that it evicts other
data and relies on snooping by the device. In this case, disabling the
optimization reduces performance.

My point is that it is highly likely that non-cache coherent systems
may accidentally be in a working state only due to this optimization,
and not because the driver deals with non-cache coherent DMA
correctly.

> The point is that
> even your check won't do what you actually said.

Well, it enables the optimization only for non-cache coherent devices.
How is that different from what I said?

>  At lot of non-loongson
> mips platforms are not cache coherent.

You are assuming that whoever added that check cared about other MIPS platforms

> As are a lot of arm setups
> and all sparc64 ones for example.  And chances that someone will
> hacks this file out in a random subsystem when adding news ports also
> is rather slim, so we'll remaing broken by default.
>
> That is why I want at very least:  a whitelist instead of a blacklist
> and some very big comments explaining what is going on here.

ideally, we'd turn off this optimization entirely unless running on
x86. That would be my preference.

However, given the above re non-cache coherent systems, i am cautious.

>  And in
> the mid to long term even drm really needs to learn to use the
> proper APIs :(

+1
