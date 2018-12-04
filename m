Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4CDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FECA206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="P0CNRjdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FECA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeLDPKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:10:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39872 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeLDPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1x+InGfy+R+JKyg18Jez/GqAMNx8TbwgBoRZ07sXDXY=; b=P0CNRjdX02l/PUg/RZeaCIkUI
        UrOexDN/m4FYbmWt9Nsa8DrBsxy3YlxPkXi3ZuxtJHuMT37f6xTtg8APpVtmYUVO28V/LsEzx3baT
        bWEJfNP+vO7DLU/wFvfGe3L4cFjm2U59/rtmiAoxw1pIBQOoTW6CNsO7fluaKUnYKOHI8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUCKh-0007XZ-8E; Tue, 04 Dec 2018 15:09:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B144111251E3; Tue,  4 Dec 2018 15:09:54 +0000 (GMT)
Date:   Tue, 4 Dec 2018 15:09:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 06/14] regulator: axp20x: add software based soft_start
 for AXP209 LDO3
Message-ID: <20181204150954.GC6809@sirena.org.uk>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <41cb1b4dac3a15595c89fa962b78d3f68f370021.1543245984.git-series.plaes@plaes.org>
 <20181127093619.72ensythkx2mhdf5@flea>
 <20181204133144.eqd3dk3jgqm4fbk4@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20181204133144.eqd3dk3jgqm4fbk4@plaes.org>
X-Cookie: The sum of the Universe is zero.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 01:31:44PM +0000, Priit Laes wrote:

> Yes, makes sense. Although, should we then also distinguish between
> regulators which support soft-start in hardware and devices which emulate
> it by delay, like in this case?

Drivers should not be emulating soft start, if they need a ramp delay
they should set that in their descriptor and let the framework do it.

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwGmMEACgkQJNaLcl1U
h9CpFQf/SOm+w6bfzdiV1mRAj1uTKpc8/3V/4pVfrGTWO1zcbprN9Bhwx/eucEeR
hNTs3C6ApYsMW3cYqgbc/FhcNvsTCF4dLs73wkRpTOYV011dtkvJfnyFJZ0gD1ko
R+G/vg+PO7DAogzZVPbU2/LezobGagpma578ucZVUdesyv4PVOx6RB4Llg07sfIn
NFGEMfRjjOziJpg24raKgigiZBx54Cz9q7e0b19pJAeYl+Xb1I05QNN2C66Vf853
ZdLfvbyC+4ucB02jZmydtJqf1YYG58KwcI+2wcx4CCYxzbC7pP3yVGfUxlzLxZjR
0+ZWUI+2xKFwR1VBuHpWQJ9whgroQg==
=cKg0
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
