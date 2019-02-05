Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333CBC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5DC20811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmCfEwdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfBER4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:56:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55407 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfBER4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:56:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so4582133wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 09:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F6t2vHqjJElBqnxZ3s4iHsCHHHHBHpRz4Moe2FUR4EY=;
        b=MmCfEwdU6Nbd9zeLeKmSXaKRLBQGLVlKpn0zEHyCe9TCnVHqwsBl2SRVfR16gtg6fo
         zvImm+a1/KCqmtHqHoetXLTTEt5CATeDXcqlzTIxlI2snXiKfjgjLiMzcee1VI0nS8nd
         3GbaC3YmAnJ6VSlmpvgFdfNrIrHcNRSzxi1vvhOfTx0fgWbcb0v5RZ+SI3iR76R4UMPA
         v3xVwPefLxpNESqt5Bncs2vlk3VA28ITh+A71okdS7Hr561pWCFjegPHHhEW/7P2T9BC
         +SVJu9vC4qm8Vc+5sugODkUcFvLuntxSzLxa0NheZY8+jF2ZabGOLAfS6nAqjCTk959F
         7p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F6t2vHqjJElBqnxZ3s4iHsCHHHHBHpRz4Moe2FUR4EY=;
        b=FsMjZJIPpEUn8EiSqnExj2ScgFaSWCG0ZlXPVvcGdR/5cHYLphZrNSg/gngySS4tFD
         b3i7MSwOctW4TcrIX7St+wtjw8F2sRf+TwdAd0/cNwwDGfGNFDs9ZB+iQAT1VpxjAv/V
         dDVogv4VDomPCoeg85Bt6kkJGX+WOYZX0A0EyXJqDneZhkmL+aPQbOATeY3Aqz3UXseW
         tTlSFOl/fAOVVxQ8jXPfEB1v/bI2t81nYr0lkHtYnLo/uoHCO+1nVBSwJuPIj3P3ATYK
         6PpKtFHMvC7C9iHivqXBnYvXMpiebFklxoQ3x18Cirq6CUenGt1afEF6oKQCdWR3UY1S
         4q1w==
X-Gm-Message-State: AHQUAubqUsf2IqJuMoN8XW4q6kGYb5tA/qbQdl9v0091tfSjjLqbH56v
        vjjI3yo9EtfnmsWK5NLmWiY=
X-Google-Smtp-Source: AHgI3IZATcytU3R9kazKg4gNSc/3jGs7IPpnckSt3CeLtgXc/Vw9IAtrleqIh0Rc6anCiWhySPoJlw==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr4687849wmq.151.1549389378164;
        Tue, 05 Feb 2019 09:56:18 -0800 (PST)
Received: from localhost ([217.229.16.64])
        by smtp.gmail.com with ESMTPSA id j24sm23602093wrd.86.2019.02.05.09.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 09:56:17 -0800 (PST)
Date:   Tue, 5 Feb 2019 18:56:11 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Message-ID: <20190205175611.GA7052@ulmo>
References: <20190205110602.27717-1-thierry.reding@gmail.com>
 <20190205161036.GA782@lst.de>
 <20190205162057.GA29974@ulmo>
 <20190205163837.GA1222@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20190205163837.GA1222@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 05:38:37PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 05:20:57PM +0100, Thierry Reding wrote:
> > The problem is that if I use dma_alloc_coherent(), then the memory will
> > already be mapped via the SMMU at that point and then the driver, not
> > knowing that memory has already been mapped, will attempt to map an IOVA
> > which will cause an SMMU fault when the host1x tries to access the
> > memory.
> >=20
> > I didn't find an equivalent to arm_iommu_detach_device() for non-ARM,
> > but then stumbled across this and thought it was rather convenient for
> > these cases. If there's a better way to deal with this situation, I'd be
> > happy to do so.
>=20
> So you basically do a dma_direct_alloc + iommu_map?  Can you send me
> a pointer to your code?  Maybe we need to add a proper IOMMU-layer
> API for that.

Sure, here you go:

	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/gpu/host1x/cdma.c#n106

Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxZzjgACgkQ3SOs138+
s6FcGg/9HDPe6r1j5PFKvrj6Ft7aPgTrOaDE/rYoMyc2mPL3KOzkUQJh9yg7Wa9K
p5VL1XUtuSgIXUAXnFeAAocWUa5Tmq1GPCXbbWeRi87XWVFjuKq+xCGz1AZBhgaS
EwrWRLyGqE9fZXM3iBCFyRGzNSxGiAA80TuxJCq8VmfOe6+fa0TrN3c06olPdBc3
zdARlmjL2rr0vOXG9SFz/zuK4xJ86aup3Q1H8oBFtTXM4zbmejVzxelZRkJ+Ck3U
NNCwArBojOT7DfA03QPElZZwXmwegBERMXD2Zjeb5c/c2Mhy0/tNtW9Qvd6jBDpZ
sIP9KLgL3s1PoP+fapM3V4FVf4+KSxbLe1h1GiXbkQQiD35n6b9Q+Ka5CicEBTYv
aGqQoZSHr9uNFXzDzv2cZ8KBj0lk3MvEXIB+ZQUXSyL1lLmLSMuWbpoG/9B7krfj
71CSEZO1qiP1Ya8tMbjgjOW0HjlOF/Z15mkkSizAH3YIyYnqNCWTluUADyZf/xxm
YSoOMJ2yHwUzuxO1J0pWu4kv98F+KiV8VlUwk736Ykq2oBoFzVTCQt+rBPDG8+ak
vYchQ+dOGZ+JuEiXht8ejZsTXPZEHDvo4ycudPSE3NTeEtBF0qa/1qROUQAaI8bN
Kn41hiTmlbzeyQ5tbrMO+t4ar9dlCn1NGue45ZS2pjXJh96c82o=
=eUMp
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
