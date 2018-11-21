Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E987EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B5020870
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="juyeit0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B5020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbeKUWxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:53:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52844 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbeKUWxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GWr93rI5vOjJXu1utLg01PpRQmImuvJaHVDucwXozd0=; b=juyeit0swniFgBcdVatbZQ3Ah
        01H0iRMsUXNkl/7kET1p6FMPx+2uwJClx5F54ER0Q1hbvpf4tTakc0ZoPPq5TX5AEJD9+o5d09hNu
        LhytakDVWPnDYVGB6Z9uVyxp6UKTdrcJ7C3QYp+s2nwPTcLjLC6EW+O9Q0gfGS6kk14ZU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gPRTH-0003OT-Dn; Wed, 21 Nov 2018 12:19:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2890611250AD; Wed, 21 Nov 2018 12:19:07 +0000 (GMT)
Date:   Wed, 21 Nov 2018 12:19:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] regulator: wm8994: Don't use devres for enable GPIOs
Message-ID: <20181121121907.GB8059@sirena.org.uk>
References: <CGME20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386@epcas1p2.samsung.com>
 <20181120170152.24652-1-ckeepax@opensource.cirrus.com>
 <c426f174-dc45-3a25-4c7e-018972c2ceef@samsung.com>
 <b7648606-b5d1-c42f-cf68-338fbc3cf4df@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <b7648606-b5d1-c42f-cf68-338fbc3cf4df@samsung.com>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2018 at 10:26:30AM +0100, Marek Szyprowski wrote:

> from wm8994_ldo_remove(), switched to regulator_register() in
> wm8994_ldo_probe() and added regulator_unregister() in
> wm8994_ldo_remove(). This way the warning is gone. If there is any

I don't understand why you'd need to switch to regulator_register()?

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv1TToACgkQJNaLcl1U
h9C3fgf8C1bb6yGkcttdeXdyvwZEEn6gl0GMOvwtCHrHWs5iBNArWTUxnbL991iC
8t3nRBVhP9TyKelPK7h0zYAA7hxa3xhfDJRiEVKSjVSEJCzUoCjWetWElAzb8qv2
x7xBm7iAdi3lOsyV9H67ucWKhSaHdp1l7QfTa5PSinQBmfW40MMlq2iPSTI/lUjQ
7cOiOVnCg2UVj5q9WX6KEUgf/uUcbi86V+QQFHObU0cLDulcJGlUEsv2Vs5fBbPz
FZHYfyPrIw7mbEPG8SeP9UUzI6FTWa6Ezg60xmi8Kdhnv0px5hZdrutugQ6dQq8G
BBRtUQkrZQ0q6bjsa/jRo/Gxhahoow==
=lEJM
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
