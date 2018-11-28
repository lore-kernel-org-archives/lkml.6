Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861CFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD132081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="uDZiZvjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD132081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeK1UPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:15:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53816 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeK1UPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HrXWLXzmABjeM0iZ6BQmSLqGtkeAtlJ47/zLeVwtFhk=; b=uDZiZvjXgDEaaNb9ZvG1ZK5jy
        UBsJbfC7tQChv+JFaMORaITAUjYpzTbYX+UABB56baS9tSczeuXvtQFv8D6mjyYHrppW9n7v36Bzg
        qTjGzPadjHYd19eXdAyLZDgRY1qnJHz39QdT1KYXKbUZf6JJ334Uayq7mHKBixKgXMn98=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRvvc-0004Z7-NH; Wed, 28 Nov 2018 09:14:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 08A671125056; Wed, 28 Nov 2018 09:14:40 +0000 (GMT)
Date:   Wed, 28 Nov 2018 09:14:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anatolij Gustschin <agust@denx.de>
Cc:     linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, atull@kernel.org, mdf@kernel.org
Subject: Re: [PATCH v2 2/3] spi: add FTDI MPSSE SPI controller driver
Message-ID: <20181128091439.GA6828@sirena.org.uk>
References: <20181120002821.12794-1-agust@denx.de>
 <20181120002821.12794-3-agust@denx.de>
 <20181121124237.GC8059@sirena.org.uk>
 <20181127012127.24e455b6@crub>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20181127012127.24e455b6@crub>
X-Cookie: I had pancake makeup for brunch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 01:21:27AM +0100, Anatolij Gustschin wrote:
> Mark Brown broonie@kernel.org wrote:

> >> +	if (max_cs > 12) {
> >> +		dev_err(dev, "Invalid max CS in platform data: %d\n", max_cs);
> >> +		return -EINVAL;
> >> +	}
> >> +	dev_dbg(dev, "CS count %d, max CS %d\n", num_cs, max_cs);
> >> +	max_cs +=3D 1; /* including CS0 */ =20

> >Why not just size the array based on the platform data?

> The driver must also support multiple SPI slaves with additional control
> pins (besides SPI chip-select gpios). There are devices with not adjacent
> chip-select gpios or devices with single chip-select gpio starting at
> some offset. The array size is not always the number of chip-selects
> or the max. chip-select, e.g.:

A few unused entries really won't matter.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+XH0ACgkQJNaLcl1U
h9BN6Qf8Cf8z9g7M2CSYTvbGRDLuKh4WWK/9Bj96Cg/lOX0H+++0glbKaXR9LZdW
C3Kq93XpWg+pjvDcHSP1OEOgeG4nXIiunOIgIUTALoTqhYVxDy+XnHF2cYgz5epK
y4BBtFVsUbA0WxN0YjEGoPRc8R2Mx/duLdpeRw2O1RvGLxZYaPYNAd5WZnoahP0c
zjoUB0uH+H12whUSCHQuky6IEOGC2/VkKNF6zZ4sMaFaAYV94VGp5ZWYvzHrjoJg
R8d+RKvq4vuobYgmvclOk+pKI5hr9PY2wkZ/539VoPtn6kMFDshiWeWXEQNr9AVf
mDfS4RQOzpO6S1CfGm7XQKcqzzNrkg==
=i8pS
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
