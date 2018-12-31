Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E56C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD61C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546283496;
	bh=UyIvoZwFh8LDFrOuAXsIMtswKR7g6viqheWSHfyx2ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ae3I+CZ/qvieP4dfVr6gaavI1mkTuqIgSbkvada9dlLjeBEbp6QxEAiV7fLrirJuq
	 gRfWSzTSM4sfBypbXCaVCwVriapJtT30btaN10JD5RH8A0I5C9VMo8t7xzmyAKdfKp
	 wa/Pz2fhx00FPnrupXUkxjz4MByIImse2/1Y2v/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeLaTLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:11:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51978 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeLaTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nj8Y+aQRIRkHU+7mC4UcT1kfh7PTHrf/SYAXsGJpvkQ=; b=PKfmjnlx9OQUgqBnz48XCh94H
        SzTQ8rEeQT/IDwh3skFLDK2nkjB8DRKnb0qXhR//gsjrBIvchKiATCH+lpEjlPZoZfOiWeypvmHWA
        ZNiEMzQU9xk8uSRsj1IRqgxrMHXZg0NJq/t2fpVV4C5gV05qFay7t4mUtZJ6khnKd/ZPQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ge2yG-0002dF-I0; Mon, 31 Dec 2018 19:11:28 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C9FAC440080; Mon, 31 Dec 2018 19:11:27 +0000 (GMT)
Date:   Mon, 31 Dec 2018 19:11:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20181231191127.GL1846@sirena.org.uk>
References: <20181218115931.GA21253@localhost.localdomain>
 <CAMuHMdUbXeuemACL+GGx0HFjn2oKUb2UbDUKJedzCrm8JDfNaA@mail.gmail.com>
 <20181227073531.GA2461@localhost.localdomain>
 <20181227075648.GB2461@localhost.localdomain>
 <20181228080533.GC2461@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eWbcAUUbgrfSEG1c"
Content-Disposition: inline
In-Reply-To: <20181228080533.GC2461@localhost.localdomain>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eWbcAUUbgrfSEG1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 28, 2018 at 10:05:33AM +0200, Matti Vaittinen wrote:

> Last night - just when I was about to get some sleep - it stroke me. I
> think the correct thing to do would be leaving the irq_set_type to NULL
> for those IRQ chips which do not support type setting. If we do that,
> then the irq core will take care of situations where user requests type
> setting but the chip does not support it. Which means the regmap-irq
> would be no different from any other irq chip where type setting is not
> supported.

Yes, this is the best fix - let the framework handle things properly.
We'll need a second set of operations and to select which to use based
on having type information but that's fine.

> So at the cost of removing "const" from regmap_irq_chip we could do:

...

> Mark, Geert, what do you think? (And maybe same for the .irq_set_wake -
> but I did omit this as I have never looked at the wake functionality
> before).

We need a separate struct as otherwise if there's multiple devices with
regmap irq_chip implementations then they'll collide with each other but
otherwise I like this approach (or we could copy the irq_chip struct
when registering and then modify which is going to scale a bit better -
you're probably right that we need to do the same thing for the wake
configuration.  I'll still look at applying your patch as a temporary
fix though.

--eWbcAUUbgrfSEG1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwqad4ACgkQJNaLcl1U
h9Bc0Af8DMJruSFgiVs/MWljDlBa743YhF8i6QW5jYRmLkU6Rm6iD5FJAJ8sGXag
R/h/8Z8o9HoZn62qHkinaOvZa/hg4at63kwp6riLnIsJFS1uCSacwBpCNTf1LvyW
Zv5Cd4WVW+ldiaVEWJPcV23UWqjHWdSMEtYG2/FUycSoTMZNzHLiZc27euQ3Izi1
bGQEAGJU/5koBsDa2eoLkbmFg58Kc5HBcmw0wPgLnRX5/8LcXMrrh7dF8bypLJDG
K7+WrkyFLgDBGZ8QHdzVUUHUj7+W5o2xkB5/yTedou/e0dr2jtgcrfHSvMitCePa
eGKlmA0VqMLTsEhp+wvK55Iy0lmAjg==
=U4/g
-----END PGP SIGNATURE-----

--eWbcAUUbgrfSEG1c--
