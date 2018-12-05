Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1C2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701AD205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="buWz/wuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701AD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeLELi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:38:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38960 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeLELi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=co7i7kojXM/YSztxUwTNPdkPl2J/ItoQs0xD8/ImA3I=; b=buWz/wuh3DsbaUMmiyHwOBNy0
        gYakkZgbaSiqKJFzzQB6J7XBnrB0Jl1HK6Tg9ZIJthiwXpquJPnvgqOt5TcMEBE+ExaTPRNEM+3rs
        CAiRm4Sn/S/LlEbqiM7pTkgwRdVWbhg4ELTwSXiuAB5lhH6aq9t2pUhZixyP/e2YLIuSU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUVVU-0003JX-TY; Wed, 05 Dec 2018 11:38:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7670F112533E; Wed,  5 Dec 2018 11:38:20 +0000 (GMT)
Date:   Wed, 5 Dec 2018 11:38:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 002/123] spi: uniphier: fix incorrect
 property items
Message-ID: <20181205113820.GB6205@sirena.org.uk>
References: <20181205093555.5386-1-sashal@kernel.org>
 <20181205093555.5386-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20181205093555.5386-2-sashal@kernel.org>
X-Cookie: Real Users never use the Help key.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 04:33:54AM -0500, Sasha Levin wrote:
> From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
>=20
> [ Upstream commit 3511ba7d4ca6f39e2d060bb94e42a41ad1fee7bf ]
>=20
> This commit fixes incorrect property because it was different
> from the actual.
> The parameters of '#address-cells' and '#size-cells' were removed,
> and 'interrupts', 'pinctrl-names' and 'pinctrl-0' were added.

Not sure we should be backporting documentation changes like this to
stable, especially not without accompanying code changes...

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwHuKsACgkQJNaLcl1U
h9BdGQf/cVEzlCz8LauxdMkpmxd0zk92aQB/jLXrj3Pj09j/PoB86dqeUI1VB7Q3
yGMxw6fC9Zir4cVF/r3J5I3js+BkF8F+5qCBsw2oa2v6oM8Laqat8l0U36zUulyR
Qr53SzOSGC64SH8tiXju/jRVAFAeTF07eNlSHg2Q4+cNdOqrdnn/tIDWvpC8Fqvf
9HlSLMnT19FHWm3U9f/nkzqm+UmxirUKyg2sJl1CSApMgoRqNDiMn7vkTArYXISs
V97WQ+CUSCJIca6/Etko7By+ky8wTpodYSi40uZTomzM8HoHunoxRaVGRa9vAXto
2j1FDIiwmilt8t6WBNlGI9GZ5i8p7Q==
=/7CJ
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
