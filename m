Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265F3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15332064E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JQm99NYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15332064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJCS6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:58:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57626 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeJCS6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gm96aBRVZAWsond9toH2AFDDcr8+f4bV/6UX+dI7src=; b=JQm99NYSd8N9h7Et8HCjoI7Li
        QIGZmpajxeV/f4bEqtY59UJsiDUKI/G2WPn+EprT0Xon624tZVU+Y9Y3BaISOLbd6rioJBTQ7uQIP
        qxp64wdL7yNAch7SVlyXJTOFeCexuMBdYUTr5OdzjlA6cAinCfLm2bt9zneWqzaU8L64g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g7fyd-0005kF-Bi; Wed, 03 Oct 2018 12:10:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D54151121BA7; Wed,  3 Oct 2018 13:10:02 +0100 (BST)
Date:   Wed, 3 Oct 2018 13:10:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH] regulator: fixed: Default enable high on DT regulators
Message-ID: <20181003121002.GA7132@sirena.org.uk>
References: <20181001204346.4655-1-linus.walleij@linaro.org>
 <28e88d54f6503cf1be577eb1872cdf2c50d7dfa3.camel@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <28e88d54f6503cf1be577eb1872cdf2c50d7dfa3.camel@nxp.com>
X-Cookie: The time is right to make new friends.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 02, 2018 at 01:42:38PM +0000, Leonard Crestez wrote:

> This turns the phy off and on again instead of leaving it up from uboot
> and it doesn't work for some reason. However looking at
> reg_fixed_voltage_probe introducing an edge seems to be intentional for
> regulators which are not marked with "enabled-at-boot". Right?

No, that's definitely not desired.  We don't want to change the state of
the regulator at all if we can avoid it unless the user explicitly asked
for it.

> It's possible that you exposed an imx board-specific bug: maybe power
> cycling the phy after uboot needs some missing fixup?

It'd probably also be good to sort this out though.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu0sZgACgkQJNaLcl1U
h9ARzwf/TDz782KjZEXYQtLzP0xafi1ECfJMs7Uz0IYjGOsFT3Y3HCMymbvxoz4B
BYrSygqGSpjXhYVXmCsSkWbmmlFMxfb2X4F5KkAA/VDHg0xz9bpCRtRFjvGNWMPw
2Hw82/RbNl6YU2hluVC8PGlR64kRuxjMQfefrytGAX37FZDHDJrSD5RZEMTg8hB1
5k6ndT9Y3vIOw4s4VXFalwdzu+d8TfT2gotgoWG/Up9EK35/ZY5vz+9VGTYif5fz
TiUmQcBTYm+Utwlm87OQpDNtIs3hr/jDReiG2sqMssv2QjebuzUgR90KKKMSNT4l
1uLNAyYhZcDx/oDKuAwoAALp8xb80w==
=SqpF
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
