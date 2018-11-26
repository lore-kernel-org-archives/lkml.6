Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274E3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D132086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DOSTd590"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D132086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeK0BDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:03:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37236 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbeK0BDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FgtY55CCMeQHnOaKqoq3GQOLNAr29qdycxemvHzwQC8=; b=DOSTd590UshdCIqonSuPNOYoq
        +FqM1PfC6kqVcuoGZvjVNJ1z/n6rZvJHx4qbbKF9pwM5MyHetQh2WNW/IbAkyctWAVLiCZU04vInl
        0DsTjXiQHaIEyFDIbmDwBspO/r9pkLS4hiGapPODIWWvnGhU4ssswT5Y3U/9tylpaMT78=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRHZn-00043j-Lo; Mon, 26 Nov 2018 14:09:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 45529112519F; Mon, 26 Nov 2018 14:09:27 +0000 (GMT)
Date:   Mon, 26 Nov 2018 14:09:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
Message-ID: <20181126140927.GD9715@sirena.org.uk>
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
 <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
 <20181123105729.GM16508@imbe.wolfsonmicro.main>
 <20181123132522.GE2089@sirena.org.uk>
 <20181126130001.GN16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <20181126130001.GN16508@imbe.wolfsonmicro.main>
X-Cookie: Gloffing is a state of mine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 01:00:01PM +0000, Charles Keepax wrote:
> On Fri, Nov 23, 2018 at 01:25:22PM +0000, Mark Brown wrote:

> > help the multiple users find each other somehow.  I think what we want
> > to do here is either push the gpiod requests into the regulator core or
> > change things so that once the regulator is registered with the
> > regulator core the regulator core owns and is responsible for freeing
> > the regulator.

> On the co-ordinating do we expect that the behaviour will
> be that the GPIO should in the "enabled" state whenever any
> regulator is requesting it? IE. the GPIO state is an OR of
> the regulator states. Or are we expecting to handle more
> complex interaction?

For the regulators that's what we do, yes - it's like they're all
sharing a single regulator.  That probably won't be true in general for
all GPIO users.

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv7/pYACgkQJNaLcl1U
h9A61wf/YTf3c1nEcIzq+uJrrPEBzxQm3qE8rBupKwbQHkqzIq/atKhxtPrQwUGT
zTLu81kIHPwquclbSVHKDJepB6abpbGpSQ3Tlwx/TDV2nUsplGvJMknnX8cRuA4I
I69mRub7Pjt6cXxKcJyynDEbGZLQjaEHBmSiUe/j0yz2UFy4SLacu5Ox0yxwL/HQ
2SL9X/iMz7GPRyTxZaVNhheL4mzTOoTshgHjiFoJ/Z2hxblhgxC1s9E4WogAYsrV
3ynQ/SHWVeJRkdvBpl9dh+2yZ7sLb+iXZDRRgeZg4ISznDpQQz1pHkXE2ifu3+Zj
yQ05v+i1ww3xAxPkvfjtyPke+DI5Lw==
=fwXX
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
