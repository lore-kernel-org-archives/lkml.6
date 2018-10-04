Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A64CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C902084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="naEH1LjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C902084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeJDUr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:47:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51234 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbeJDUr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GjUEwFDEyi0T31gyr6yhmj5QuNqGBsKQERskuxCxYuc=; b=naEH1LjVYaP50HRwR2EXWZ7au
        KIJ5EJIesH4Hc8fKp7ZPcnDQCjkoo18NBybNJjFcv5zV9A+8CzB3qFQKpc85EaHxF65k+9QGaJDGN
        9F/pbud0iwWzrKgtkGSiN2S/SsdOLN4WBtsUyecEIpo7lVfcAkyWr9fxRFbf0vNZnVuVU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g845D-0008SE-TF; Thu, 04 Oct 2018 13:54:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5AFB31121C82; Thu,  4 Oct 2018 14:54:27 +0100 (BST)
Date:   Thu, 4 Oct 2018 14:54:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] regulator: fixed: Use more standard GPIO binding
Message-ID: <20181004135427.GE6412@sirena.org.uk>
References: <20181004090654.32233-1-linus.walleij@linaro.org>
 <20181004105031.GD6412@sirena.org.uk>
 <CACRpkdZZHYSRXktPLHKRc4Afsegn4q3rOmcPMhXh5chC1jH-JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <CACRpkdZZHYSRXktPLHKRc4Afsegn4q3rOmcPMhXh5chC1jH-JQ@mail.gmail.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2018 at 01:32:13PM +0200, Linus Walleij wrote:
> On Thu, Oct 4, 2018 at 12:50 PM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Oct 04, 2018 at 11:06:54AM +0200, Linus Walleij wrote:

> > >  Optional properties:
> > > -- gpio: gpio to use for enable control
> > > +- gpios: gpio to use for enable control

> > Are we supposed to be able to have just plain gpios as a standards
> > conforming property or would best practice be to call it enable-gpios or
> > something?

> Oh I didn't think of that really. The gpio-regulator indeed uses
> enable-gpio for the same thing. But it complicates things codewise,
> as the GPIO line is also optional. I'm a bit uncertain, I tend
> to think just "gpios" is fine when the usage is unambigous. but
> I don't know what the DT maintainers think.

Right, well from my point of view -gpio is perfectly fine also so... :)
Rob?

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu2G5IACgkQJNaLcl1U
h9Dv0Af+NqNh4M686tx+nqKIgH4ozAC/fBA1Y2LfN1um8IE7pI7kh21OjK254T0f
pigDLEN7pTb7gqtFoAqx3mso846aQMR8mDKaxZgsd67P74gFBfQUoYwcLvxVkkWb
bE/EsXlDYkqbzFZrqWTj2RCPK2Y2ReMQ7eyVxg3UUdh8P7wHelzNa3+kQPx6lcu7
x624M/EFb9GMrxedKr+jbHKrnB4rPxhXQ1OTXo/ysHmtBB8nWSIdupX/MzcJJwnn
32orkEn4dnN390oR0lvChpDAD3GeOPevH7vOtbrrCYSWQXjE/QKw15GCuIG0rKEi
bSnbpLNwpACAgEjmdwOpQasN0rpbEw==
=604p
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
