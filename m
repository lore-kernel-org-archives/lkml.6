Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D0E79C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D6F208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Z7tOy0jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D6F208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbeFLLA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:00:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43006 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeFLLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d9PaYAvYD4SldT4yuguoj9WwidDRlGXzmvY18RPsK88=; b=Z7tOy0jnS0uLfEJSRwMKp20nz
        2gbjA2cFOZXVrvPnzdQ9Dzdd9D68msC7ZHdNIdW/MA6d6pLxCeJVDgg/NPuYLPkqEoOBDlDG8ckVq
        8Tl9U19boHQS2oT99KF95ydnzUbPZrSde9tJybmx3Shvjjxs2eAvffMvDKPxGPmpgw6oc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fSh2f-0001dx-VU; Tue, 12 Jun 2018 11:00:50 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fSh2f-0003Ee-0F; Tue, 12 Jun 2018 12:00:49 +0100
Date:   Tue, 12 Jun 2018 12:00:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO
 descriptor only
Message-ID: <20180612110048.GA10819@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-2-linus.walleij@linaro.org>
 <20180601093511.GA11734@ulmo>
 <CACRpkdZEMPfxHc8dZOvyYN+S4o_zwKuYCTBbMiXMLsCZRz_f6A@mail.gmail.com>
 <20180611150054.GC11580@sirena.org.uk>
 <CACRpkdYxTNWcvJ41TJ+uLyVuGzbdip9uOOgDdiyyjYt1Vd8pfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <CACRpkdYxTNWcvJ41TJ+uLyVuGzbdip9uOOgDdiyyjYt1Vd8pfg@mail.gmail.com>
X-Cookie: What!?  Me worry?
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 12, 2018 at 10:15:40AM +0200, Linus Walleij wrote:
> On Mon, Jun 11, 2018 at 5:00 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jun 11, 2018 at 03:11:14PM +0200, Linus Walleij wrote:

> >> Sadly this only handled the undocumented fixed
> >> regulator binding "reg-fixed-voltage". So I need to fix it
> >> for "regulator-fixed" as well, and then it "should work".

> > The normal fixed voltage regulator parses enable-active-high?

> Yeah currently. However I moved the handling to the gpiolib
> parsing code to centralize polarity inversion handling, in an
> attempt so keep things under control. So in the patch series
> this flag handling moves over to the gpiolib.

Ah, I see - you're talking about the series rather than the current
state of the code, I thought you were talking about the current state of
the code which was why I was confused.

> I was thinking to do the same with other subsystems, such as
> MMC to get legacy GPIO flags under control and contained.

Yes, it'd be good to try to make this clearer for users - having so many
ways of specifying the same thing makes everything hard to understand.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsfp+AACgkQJNaLcl1U
h9BiQQf/fiwFQvxaCbXDUJpr268QGKb1ZsKok1b4c4W0DyGTcmSKZjSkyIzreMAa
jZK0kidvX/IVii3k8tiFgAnz7ilgRxYJH71wD/IGayCWCVz2xxXyVRpUqOhtSfcC
nzlxuxAwrxdyxjUSoP19FW+R0Fbti35jo56l3shszsB6Kk5MxgedFkAJmTAw5hrA
9NYqb1h1z1DjMfKaygn2wzlyn+1l1l4+HY/AdWu8NKuxDZMZ5LqKwjv9zoVVadYP
6RxoYOdzGBv7Qe2Jr69NkvfoKAstUf/RHdTWvv/wSphhSndIjOciEO+ZCx8HxSmb
PP9pV2B33fK2mWm/JMK/UFij/jS9JA==
=pVtz
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
