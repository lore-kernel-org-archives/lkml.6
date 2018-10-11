Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED105C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E47A21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XCTeT+TW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E47A21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeJLBW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:22:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeJLBW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/ocA6D1i1+XRcxPD1Dxu6BwC1ucs9CTJ+9L81tTz3tU=; b=XCTeT+TWIRH3kFXihEDNFSSiC
        lk/3yj2MmH/qzhoeyfaM/5B3PrCM8x6AkWz/wVMp6hq6RAX97ViceYZuTG9oBqQ3ZwnO3BIy/Hhxl
        lB7Jno9sevbeMkNQKAuG33z2HaSTFNg8xGXSmCRjgBHisptjSmHSY3XKqQO13B6tPebT4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAf9z-00029A-G8; Thu, 11 Oct 2018 17:54:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E9AFD11223ED; Thu, 11 Oct 2018 18:54:06 +0100 (BST)
Date:   Thu, 11 Oct 2018 18:54:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] gpio/regulator: Allow nonexclusive GPIO access
Message-ID: <20181011175406.GH25351@sirena.org.uk>
References: <20181011143531.7195-1-linus.walleij@linaro.org>
 <20181011144330.GF25351@sirena.org.uk>
 <CACRpkdbTnBQhPQARX77KfjtfWXY+t0oH6-B=WUN4hid8eQT0DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fd5uyaI9j6xoeUBo"
Content-Disposition: inline
In-Reply-To: <CACRpkdbTnBQhPQARX77KfjtfWXY+t0oH6-B=WUN4hid8eQT0DA@mail.gmail.com>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 11, 2018 at 07:01:13PM +0200, Linus Walleij wrote:
> On Thu, Oct 11, 2018 at 4:43 PM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Oct 11, 2018 at 04:35:31PM +0200, Linus Walleij wrote:

> > enable line so you don't need to use the bus to do the enables.  That
> > should just be a case of adding this flag to all the drivers that have
> > already been converted to gpiod (including the core code that's in
> > regulator_ena_gpio_request() which I thought was coping with this
> > already) unless I'm missing something?

> Sorry if I don't get it... we already have code in the core to
> check if the same gpiod is used by two regulators.
> regulator_ena_gpio_request() does this:

>         if (config->ena_gpiod)
>                 gpiod = config->ena_gpiod;
>         else
>                 gpiod = gpio_to_desc(config->ena_gpio);

> So after the change I made to fixed.c this comes in through
> config->ena_gpiod.

Other regulators that have GPIO control for their enables do their own
requests (as does the core) so don't they all need to set the flag
GPIOD_FLAGS_BIT_NONEXCLUSIVE when they request otherwise it'll only work
in systems where the regulators after the first that request the GPIO
are fixed regulators?

--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu/jj4ACgkQJNaLcl1U
h9BhsQgAhqcaxL3AJRBNhk8J1gpoIf8ReGJaLmFdBgzg/TIWH1yMWH2S1f2JkKyP
022ZSDRhwPujqi3c4BYYyLAoRb0rCh7aTnqcx5bkwpUxlBqF5kRFVMvZL3iymW0G
r0dmnzCF79gli8w1ru6OUzkqdN8/iYX/+u9L8ji+xSQsMq8zB+Ele9nz8BNRJMH0
toQ4GcnX3GsO4sUYuyJB3zS5bLwenmSzz1V6NIzdu5bpS1MOV5c1om0DMKxcrlUX
8SLCdrRxrrjdgm/xBEOhKGyrAE2IXSsbX2Jq3MwOpt7/UryRJSiZgYwSqeRy6sOS
9iWTH/qfAR8+a9wjIAKFOEL4pPT/nA==
=moG1
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--
