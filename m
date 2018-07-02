Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6ACC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FDB257CC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEa3RHeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FDB257CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932646AbeGBXCc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:02:32 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39361 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932351AbeGBXCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:02:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id s24-v6so25250plq.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fJ8h9+x6eMcvhm3rdxMdE8iY4gPyMUhG0KdqoVFHjdo=;
        b=aEa3RHeSpKtvjo6iorSVo+70ya1BOQoEXH9TQonhPrt7ztvnESw91HCtihQHOGl8l7
         De0A+1XJlfMWANEH8wJWKjkZ0n0eDpwSOzbu+SseXzmVhjq8sf+kZ+47kIzktfCbMCd6
         to34ko6d0TjRIoWZceQ8vpaDzlgucljMt7WIHgFZV7Gjm6uvY9EcmhoSQRtlpyhrgqvq
         Fac4yv2neVtnHPXvBsHj1r4wPhaD0g3Iug6m2ctESFc57i0gsR5foDDiuU/vfPyNlcIa
         IceLSxMEle3+ocaHc9qz2lGfskYpehl1xDsrMvAQSI9aCsjeGS/tjiarDQU39GXJ5Xlf
         jl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJ8h9+x6eMcvhm3rdxMdE8iY4gPyMUhG0KdqoVFHjdo=;
        b=moL4rTbD0w66zsaSnTkemVXDZ0dMKicpzKTQlSybbhtRwmjfRP7Uqj7JyMe0Zs8rTH
         3Wn4LhXdIMW7zU+Tq0flBdgSfFtRmi8toAUlikvEDaWe3y5D9N8gU51+No3gdxjX2Kl4
         /ks1ST2MUK4g/QLsxf2yY8JFcJQCmv2YkkS+Xxy+66UW3hb7e0VK9Tmhvi0y1EnMCTKt
         fS81fR7+YaAvjJW17i0OgYWQfEFsZddIsNOGfUKYIxeOiwCM693fnjiwd4qmV+4c7Yqk
         8MY2B6Ekhpvg+QMNWXq9pNNNE0Hx8yLwH0YON/PH7TODISA0GmsJNEI3K/xixgUdcVEC
         IhjA==
X-Gm-Message-State: APt69E3fPPhE/+duC3Vp8HKghv3LKZFZI2pt+HvBqAOMsPDVEfKRsqNn
        iyCIzbIHvsY9bLJmfXNdFXgFKw==
X-Google-Smtp-Source: AAOMgpeRbP4zIvK2v5isFGcJiHZ6wGrSYXNvAd7vSFHr+GCmO7udM4KEJMbik9J6bnw05Q+MYBvSUQ==
X-Received: by 2002:a17:902:b7c5:: with SMTP id v5-v6mr19949005plz.30.1530572549425;
        Mon, 02 Jul 2018 16:02:29 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:0:1000:1501:e4e8:e3c6:19f1:ae51])
        by smtp.gmail.com with ESMTPSA id s8-v6sm383565pfi.154.2018.07.02.16.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 16:02:28 -0700 (PDT)
Date:   Mon, 2 Jul 2018 16:02:26 -0700
From:   Benson Leung <bleung@google.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Guenter Roeck <groeck@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anand Moon <linux.amoon@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lukas Wunner <lukas@wunner.de>,
        Tony Lindgren <tony@atomide.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 2/3] arm/arm64: configs: Remove the MFD_ prefix for
 MFD_CROS_EC_I2C/SPI symbols.
Message-ID: <20180702230226.GA86110@decatoncale.mtv.corp.google.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
 <20180702102201.13461-3-enric.balletbo@collabora.com>
 <CAJKOXPd51yU8-zObXszc4zJpHsGtMNFTsbQsQdKBFg=k22xZLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <CAJKOXPd51yU8-zObXszc4zJpHsGtMNFTsbQsQdKBFg=k22xZLA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, Jul 02, 2018 at 01:05:40PM +0200, Krzysztof Kozlowski wrote:
> On 2 July 2018 at 12:22, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> > The cros-ec I2C and SPI transport drivers have been moved from MFD
> > subsystem to platform/chrome, at the same time, the config symbol has
> > been renamed and lost the MFD_ prefix, so update all configs to the new
> > config symbol name.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> >  arch/arm/configs/exynos_defconfig   | 4 ++--
> >  arch/arm/configs/multi_v7_defconfig | 4 ++--
> >  arch/arm/configs/pxa_defconfig      | 4 ++--
> >  arch/arm64/configs/defconfig        | 4 ++--
> >  4 files changed, 8 insertions(+), 8 deletions(-)
>=20
> Since you put in one patch multiple defconfigs belonging to multiple
> maintainers, I assume you are pushing this through arm-soc or Russell.
> In such case, for Exynos boards:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> Best regards,
> Krzysztof

I was planning on creating an immutable branch for this series and merging =
it
through platform/chrome.

Lee, Russell, Dmitry, what do you think?

Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAls6rwEACgkQHwn1ewov
5lhvDg/8Ctet9aT5WelDcq5dXHCWbGiDxsm+8Nl+ZzfjWInJL2HUBWOPSYYHOcKh
tL2EMtraikirjj0oPbOEjaq7EcJNi3MYqj308oNQ6SlJy4X9QxVrFMs7RwuM494r
UlyNBmEKf8kSHUUMX6IWM4LDPjzUlCuqXqFCLCjKlt2NhjBMmf1/nQiyxF5Vt9MM
LwNZTi3+SAHrUeYOM1YUwyEl2ZACC5M8LWr7uLZuPDOBPhTvtQHTbueeOhKFZmo3
lLVXs+7cBN6hJsaL6p7HB4Nuv9wNBZ1hNitE7WUpAoxaSvYFYUE4pz/ZEaZTVcfT
WaqM0Ob+gwluUBlsSdGxF5wPPs7z9OrHnaLEN920tl+JFzOUr45Q+hmbZn+duA98
fAZZIru1eqViveBMEiHPTTokImjirWf5f5bdqHkfjcLJtkOb/ksjyyKqQxAIFtAa
TtuBq6Dl4/p2xkO4OiIO76xyx8S/TRafFNmaBADM7bcPE0JS71RTenrW/iG3IIOr
cKn5gAd9p833BNynFHWGUHTdnAS5oA2wTzQW1VYjytPFCHk9HdPl+XTP9huWcDZ7
IwXwH8+6L9pcfMc363FJUKsSChq5y1/Ap9sWxLlZypwV3GcQKdu9O14H7Uz7B3MN
EeuYo9lti4dxFcbxlJPrw3Q+ZxEvr0eY3uVv7cgdF106RehhuGg=
=xCVU
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
