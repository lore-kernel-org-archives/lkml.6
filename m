Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B767EC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADDC21473
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547836624;
	bh=20jChncdEM7xxfBaH+UP9TYNyBtUa8qfM/PAgl05RWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=or/zpvTwi53iOrRmc1nWoovA3YfN40RXDll2FaSIkOgS/lvo8Oa3SYZIcdgtFdgdL
	 P2SgjYLVh1a+Rj2BTsOeJL7L5qxFmGF3tVVOvV2moCkbpw83aqM311GT7k6OXQUz6q
	 F/xec8KYv+1WoYkqPtxPgSVVGYiG+w33pbUDAavU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfARShC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:37:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54642 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbfARShB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=20jChncdEM7xxfBaH+UP9TYNyBtUa8qfM/PAgl05RWo=; b=spijkb0kxXyuH/EcbHJjjKz9s
        FYG0LhmA6BuzBL8JF7gNGiCypeq9/IMZboXyySD/DBzZfguq7RhlNWg35ahLFbAC7pHICl2ui7jLy
        7k82Gd3eqgGRTynPBV7SKRs/ZNArSO5UqXuvLkwqrqkvgyBUDt12oQIh1G28T6OoA0eBU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gkZ0g-0005LA-V3; Fri, 18 Jan 2019 18:36:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BCD1811276E7; Fri, 18 Jan 2019 18:36:53 +0000 (GMT)
Date:   Fri, 18 Jan 2019 18:36:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 08/13] regulator: max77650: add regulator support
Message-ID: <20190118183653.GE6260@sirena.org.uk>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-9-brgl@bgdev.pl>
 <20190118180148.GD6260@sirena.org.uk>
 <CAMpxmJX8OmnDtOhQjWi9edX-4pHu1daKiDkRdNAVw-PZsz9UXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <CAMpxmJX8OmnDtOhQjWi9edX-4pHu1daKiDkRdNAVw-PZsz9UXA@mail.gmail.com>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 07:13:38PM +0100, Bartosz Golaszewski wrote:
> pt., 18 sty 2019 o 19:01 Mark Brown <broonie@kernel.org> napisa=C5=82(a):

> > > +++ b/drivers/regulator/max77650-regulator.c
> > > @@ -0,0 +1,537 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2018 BayLibre SAS
> > > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>

> > Please make the entire header C++ style so it looks more intentional.

> Seems like there are more files in the kernel source using the mixed
> comment style for the SPDX identifier and I also prefer it over C++
> only. Would you mind if it stayed that way?

I'd prefer to change.

> > You don't need to do this, the core will do it for you (it will actually
> > still do it even with the above, it'll only fall back to using
> > config->init_data if it's own lookup fails).

> I added this loop specifically because the core would not pick up the
> init data from DT. What did I miss (some specific variable to assign)?
> I just noticed some other drivers do the same and thought it's the
> right thing to do.

You should set regulators_node and of_match, see regulator_of_get_init_node=
().

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxCHMQACgkQJNaLcl1U
h9DXBwf8DBxtp6P6ln8aUsZTEj9e2Ti+0cszf0ukaKXrny3tYAfY8PiUE/iYvr3E
1xb8upkWmq7kT7QO8bm/PbeDdClAIKlfI9aUoWyLo1HkHkj0F4VMUjDMy6mTbsl6
cijuEtr67FxzE+pak6KQOvqhKhh/tp2DMQFZD30dbDhSX3p8cMsM5YTqmlIO1q4t
p0Md4tGBiMAvtcI2suzwxkteeTVogqx00qMv6FdUGmupnQZ3y+PldPNpMmRY6ck2
xajDLGrBuvWCLesasIimDKVxmo2VRIYQ+fBqL1zPSJ0roZL1gknOfgmTOPyCwkYs
SzRytR1wQyrsQzW0TzFtxFhHHBuNKQ==
=LpDs
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
