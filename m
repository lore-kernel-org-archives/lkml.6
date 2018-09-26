Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99253C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6E920843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiRmLYhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6E920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeIZUR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbeIZUR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:17:57 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F420C20843;
        Wed, 26 Sep 2018 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537970689;
        bh=+hJNSw0NdUjkVVECvt33dX+YnD1ooDblCtnXdyNAoVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PiRmLYhq4OmBgQ9PtGWdZMvN3z+T9ehWhaIru4KfkLp4pABA/N5Skra1mqxuOYpCu
         Fy34i8G+gQjIIow00dkRhAV27OK9ZJaZ8Zfa2G1FT2ph/vsTZ3XZBf6F+/V515v3rm
         5R5zKQPUt5G+lt4LQSIPaA1yacJML4DBmYFqOjqY=
Received: by mail-qt1-f182.google.com with SMTP id e26-v6so5154779qtq.3;
        Wed, 26 Sep 2018 07:04:48 -0700 (PDT)
X-Gm-Message-State: ABuFfoiEUg8gBAVJZdah5qMNmHtxS5Jd6vBGUt1COq8oR0E48K1MYl6Z
        e6+we8d+OG2xwPLA9jVY/0NZdj1ObRcyWDoAmg==
X-Google-Smtp-Source: ACcGV62oL1mSIbxkrq28FNbHoTBtsTesKh+FmMwJH16ZNQh9WCt9dbbkkF1IXiviTvFiDxI/lUWw/vdsEBwfljlYBGk=
X-Received: by 2002:aed:2905:: with SMTP id s5-v6mr1426906qtd.101.1537970688174;
 Wed, 26 Sep 2018 07:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180830180205.18121-1-krzk@kernel.org> <CAOesGMgE6QaasvHi7E55Z4U1Pp0+8QYW2eRLMsExebZ999_UHA@mail.gmail.com>
 <20180924171645.GA10910@kozik-lap> <20180926035522.v5flr36nl5ftayi4@localhost>
In-Reply-To: <20180926035522.v5flr36nl5ftayi4@localhost>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Sep 2018 09:04:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvGRxY_BB+jEVZqevpCEj8cbebRubjjz4Svd+ef+J9Pg@mail.gmail.com>
Message-ID: <CAL_JsqKvGRxY_BB+jEVZqevpCEj8cbebRubjjz4Svd+ef+J9Pg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC
 as unstable
To:     Olof Johansson <olof@lixom.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:55 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Mon, Sep 24, 2018 at 07:16:45PM +0200, Krzysztof Kozlowski wrote:
> > On Sun, Sep 23, 2018 at 02:46:20PM +0100, Olof Johansson wrote:
> > > On Thu, Aug 30, 2018 at 7:02 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > Samsung Exynos SoCs and boards related bindings evolved since the initial
> > > > introduction, but initially the bindings were minimal and a bit incomplete
> > > > (they never described all the hardware modules available in the SoCs).
> > > > Since then some significant (not fully compatible) changes have been
> > > > already committed a few times (like gpio replaced by pinctrl, display ddc,
> > > > mfc reserved memory, some core clocks added to various hardware modules,
> > > > added more required nodes).
> > > >
> > > > On the other side there are no boards which have device tree embedded in
> > > > the bootloader. Device tree blob is always compiled from the kernel tree
> > > > and updated together with the kernel image.
> > > >
> > > > Thus to avoid further adding a bunch of workarounds for old/missing
> > > > bindings, make development of new platforms easier and allow to make
> > > > cleanup of the existing code and device tree files, lets mark some
> > > > Samsung Exynos SoC platform bindings as unstable. This means that
> > > > bindings can may change at any time and users should use the dtb file
> > > > compiled from the same kernel source tree as the kernel image.
> > >
> > > I have to admit that I don't really like this approach, and I missed
> > > the patch when originally posted (I did notice it in the pull request
> > > it came in with though).
> > >
> > > The main concern for me is that with a blanket "everything is always
> > > unstable" we discard the notion that we should strive for bindings to
> > > be stable and backwards compatible.
> >
> > The original idea from Marek was to mark everything unstable. After
> > comments from Rob I made it weaker already by changing to specific group
> > of compatibles. Accepting their instability does not mean that we will
> > be doing this on whenever possible. It just opens the possibility of
> > finding some balance in cleanups and development. Sometimes things have
> > to be seriously changed (fixed) and implementing workarounds for
> > existing ABI might be huge work by itself.
> >
> > IOW, we want stability but not with the costs of huge development
> > efforts... because no one else except us cares about the stability.
>
> I think it's really problematic to retroactively mark a binding as unstable.
> The best way to do it is probably at the time of introduction if you anticipate
> it needing adjustments down the road (i.e. if it's for a complex IP block).
>
> For major overhauls, it might be worth updating to a new binding instead (by
> appending a suffix to the name or similar, and documenting that).
>
> > > Questions that come to mind are:
> > >
> > >  - When do they stop being unstable?

That's my biggest issue with marking things unstable. They will never
get promoted. There's no carrot and I don't want to be the stick.

> > They became unstable in a subjective way so I assume that reverse is the
> > same, based on consensus and discussions.
> >
> > I am not sure if a hard time limit is good. There is no timeline for the
> > Exynos development, no public roadmaps but rather community and
> > partially volountary effort.  Therefore whatever number we set, it might
> > be totally not matching reality.
>
> I think that sets up for a pretty bad experience for some downstream users.

Yes, but it's the platform maintainers that should get yelled at if users care.

There's some discussion about stable/unstable DTs for EBBR[1]. The
current thought is to have an EBBR property in the DT. That would
serve as a tag that the platform DT is considered stable and something
the distros can support and rely on us not breaking.

> The main problem with unstable bindings is if you have a platform that you
> haven't (yet) upstreamed the devicetrees for. Moving around base kernel
> versions in those cases can be really awkward.
>
> "Just upstream your devicetrees" is one counter-argument, but it's not always
> that easy -- it might be unreleased products or just some experimental
> platforms that might even be tracking fairly close to mainline during whatever
> development is ongoing.
>
> > >  - Is there a way to note in the binding itself that it's still
> > > unstable with an anticipation of when it will be settled in?
> >
> > Hmm, I see that some existing bindings are being added with "Unstable"
> > warning:
> >
> >       git grep -i unstable Documentation/devicetree/
> >
> > so there should be no problem for putting there a timeframe.
>
> Yeah, adding them with unstable up front is a good way to do it (and then
> remove that warning once things have settled down).

The real question is how many have gone from unstable to stable. My guess is 0.

My preference is the default is stable (semi-stable?), but changes
that break compatibility must be documented doing so and it is up to
the platform maintainers. I don't want to see "unstable" as license to
just put anything in and have a constant churn. Extending a binding
one property at a time does not result in a good design. Then mark
platforms stable meaning no compatibility breaks and distros can count
on the stability. We could improve the documenting part as often
submitters aren't aware of the issue. I'd like to see kernel-ci do
boot tests with kernel N and DT N-1 (and perhaps N+1(-next)).

> > >  - Is there a better way to version the bindings to avoid complete
> > > backwards compatibility?
> >
> > Some architectures are using overlays for handling backward
> > compatibility. Anyway it might put additional effort on driver
> > development.
>
> In some cases it's pretty easy to stay backwards compatible by making sure
> that things like missing properties have the same defaults as they used to
> before the properties became mandatory.
>
> For complex subsystems it might be a different story, but that's also where it
> _might_ be worth looking at a new revision of the binding instead, this time
> maybe closer to a permanent one.

The distros (SUSE, at least) also care about forwards compatibility
which is harder. A common example is a platform that changes from a
bunch of fixed clocks to actual clock binding and driver. Older
kernels will be missing the clock driver the newer dtb needs. And this
case isn't even unstable bindings, it is moving from one stable
binding to another. I have some ideas on how to handle that one, but
there's probably other examples.

Rob

[1] https://github.com/ARM-software/ebbr
