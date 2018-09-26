Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D83BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A8D20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="F1slAWPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A8D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeIZKG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:06:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46293 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeIZKG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 06:06:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so23771474ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+LJIPvJiJ6wnG6U5CNxMDIKiCfrNB+VT23fiK/MPuLA=;
        b=F1slAWPMYi7SkFZgvp0xMUEjIl1Ln4I/w0ao2Yk5Ojps8O9P3rhtxn0wMpDuoFhbo7
         ZzSuNmEst02aEom7V8ZFlCLLCK2WbUKuQt/Ws47PtuDyYGERP5jd08Olu8glsYpvQRvp
         nJQ4z5UgOtlMmIBdhqWHENm1Cdv5Mu0fmPGHT9Y67QKUjhUwZZ2mOhMYSMrSBIo2UaLA
         WZ1pEBFZD/a4o3Osk+liIjoEe5x2Jq7Z4UYSP8nwJX4aIT7srD7E+VtoblJ6XaC6m0HA
         WjEx228UL+eYSjqNpwbZZbQ99gHJcwd+V/+aUBwD5sXxYljnBWyVtu9IpolVy6dTNZTq
         dPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+LJIPvJiJ6wnG6U5CNxMDIKiCfrNB+VT23fiK/MPuLA=;
        b=lh2iskwskfEwFpgb2DI5QUqL3MII8QAch/bKNeB+vZ2ivRU8tYlvEacafYkxvLpebl
         J+v4WENlU4v/EKEm0qRInPgKcDWhsvpn0Utma8LfVq/YAllDihp+IQ24YXejXfuNXnPN
         yK4qNEHPomQ3ytnPbxwD2GwALg5TMlxgtmQfZArtOn/4Z/fpFOX1lOHGClyT1au7Hp7U
         VS6xJESmfMddvojOjeZnlB82b9cbZ90W4hgczg/KEftyvxM7b3WbuLVkkabKFbtGg6B5
         NuaJGq8RZmsuMbQfMkwhUkR8wbTYJwh8zDGgcGWjSbgsknDTsAbWlj80xgetptLqRDjr
         /0tQ==
X-Gm-Message-State: ABuFfojwI1BOQEn4RPXwjAlsjqGb19rskx+rt83R4qDFg8xY3Jd8Rlxp
        4CW1+uVF7Z7bvoxWDn1iaGel5g==
X-Google-Smtp-Source: ACcGV61If61vgm+Kri6AXVkgk849ZHhfK5njwxjYFbw+sNzU5hVCbT6chmiipazrH9fJxEsgz7LFYg==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr2721499ljc.148.1537934132459;
        Tue, 25 Sep 2018 20:55:32 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id y30-v6sm44586ljd.42.2018.09.25.20.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 20:55:30 -0700 (PDT)
Date:   Tue, 25 Sep 2018 20:55:22 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC
 as unstable
Message-ID: <20180926035522.v5flr36nl5ftayi4@localhost>
References: <20180830180205.18121-1-krzk@kernel.org>
 <CAOesGMgE6QaasvHi7E55Z4U1Pp0+8QYW2eRLMsExebZ999_UHA@mail.gmail.com>
 <20180924171645.GA10910@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924171645.GA10910@kozik-lap>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 07:16:45PM +0200, Krzysztof Kozlowski wrote:
> On Sun, Sep 23, 2018 at 02:46:20PM +0100, Olof Johansson wrote:
> > On Thu, Aug 30, 2018 at 7:02 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > Samsung Exynos SoCs and boards related bindings evolved since the initial
> > > introduction, but initially the bindings were minimal and a bit incomplete
> > > (they never described all the hardware modules available in the SoCs).
> > > Since then some significant (not fully compatible) changes have been
> > > already committed a few times (like gpio replaced by pinctrl, display ddc,
> > > mfc reserved memory, some core clocks added to various hardware modules,
> > > added more required nodes).
> > >
> > > On the other side there are no boards which have device tree embedded in
> > > the bootloader. Device tree blob is always compiled from the kernel tree
> > > and updated together with the kernel image.
> > >
> > > Thus to avoid further adding a bunch of workarounds for old/missing
> > > bindings, make development of new platforms easier and allow to make
> > > cleanup of the existing code and device tree files, lets mark some
> > > Samsung Exynos SoC platform bindings as unstable. This means that
> > > bindings can may change at any time and users should use the dtb file
> > > compiled from the same kernel source tree as the kernel image.
> > 
> > I have to admit that I don't really like this approach, and I missed
> > the patch when originally posted (I did notice it in the pull request
> > it came in with though).
> > 
> > The main concern for me is that with a blanket "everything is always
> > unstable" we discard the notion that we should strive for bindings to
> > be stable and backwards compatible.
> 
> The original idea from Marek was to mark everything unstable. After
> comments from Rob I made it weaker already by changing to specific group
> of compatibles. Accepting their instability does not mean that we will
> be doing this on whenever possible. It just opens the possibility of
> finding some balance in cleanups and development. Sometimes things have
> to be seriously changed (fixed) and implementing workarounds for
> existing ABI might be huge work by itself.
> 
> IOW, we want stability but not with the costs of huge development
> efforts... because no one else except us cares about the stability.

I think it's really problematic to retroactively mark a binding as unstable.
The best way to do it is probably at the time of introduction if you anticipate
it needing adjustments down the road (i.e. if it's for a complex IP block).

For major overhauls, it might be worth updating to a new binding instead (by
appending a suffix to the name or similar, and documenting that).

> > Questions that come to mind are:
> > 
> >  - When do they stop being unstable?
> 
> They became unstable in a subjective way so I assume that reverse is the
> same, based on consensus and discussions.
> 
> I am not sure if a hard time limit is good. There is no timeline for the
> Exynos development, no public roadmaps but rather community and
> partially volountary effort.  Therefore whatever number we set, it might
> be totally not matching reality.

I think that sets up for a pretty bad experience for some downstream users.

The main problem with unstable bindings is if you have a platform that you
haven't (yet) upstreamed the devicetrees for. Moving around base kernel
versions in those cases can be really awkward.

"Just upstream your devicetrees" is one counter-argument, but it's not always
that easy -- it might be unreleased products or just some experimental
platforms that might even be tracking fairly close to mainline during whatever
development is ongoing.

> >  - Is there a way to note in the binding itself that it's still
> > unstable with an anticipation of when it will be settled in?
> 
> Hmm, I see that some existing bindings are being added with "Unstable"
> warning:
> 
> 	git grep -i unstable Documentation/devicetree/
> 
> so there should be no problem for putting there a timeframe.

Yeah, adding them with unstable up front is a good way to do it (and then
remove that warning once things have settled down).

> >  - Is there a better way to version the bindings to avoid complete
> > backwards compatibility?
> 
> Some architectures are using overlays for handling backward
> compatibility. Anyway it might put additional effort on driver
> development.

In some cases it's pretty easy to stay backwards compatible by making sure
that things like missing properties have the same defaults as they used to
before the properties became mandatory.

For complex subsystems it might be a different story, but that's also where it
_might_ be worth looking at a new revision of the binding instead, this time
maybe closer to a permanent one.

> > Pointing out a couple of cases where it has been painful to stay
> > backwards compatible could also be useful for understanding (even
> > though you run the risk of each case being explained away with
> > suggestions of how it can be handled).

Marek, do you have any good examples here? Could still be useful.


-Olof
