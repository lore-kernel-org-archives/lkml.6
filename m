Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFD5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C729C2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="A49BPK5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C729C2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbeKPFRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:17:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49870 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F/gL5wJQuyxKuxgH080Jx8m27jE6jhNuPqzqo0LX/sQ=; b=A49BPK5FXYEnKfhHAdwOzSp68
        LMJ7r0tHPx4dHYp+LiJEp/AO8ev9F/O+F/+8Lftph+tkJqh6kAmtgUeTHceROlKwsCwF9oGDMHZk/
        UkCVj5Aw/ojspUD17LBQgWyoqpV4xyy+Y4++QI5eG1tlZ3dxHGLDrvvCwba6dsDtxw0Jg=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNN0A-0006Bp-Lh; Thu, 15 Nov 2018 19:08:31 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7C5B9440078; Thu, 15 Nov 2018 19:08:24 +0000 (GMT)
Date:   Thu, 15 Nov 2018 11:08:24 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     vitor <vitor.soares@synopsys.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Message-ID: <20181115190824.GJ2089@sirena.org.uk>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
 <20181115135731.25f60990@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vCQF5Fh1eN3mBuH/"
Content-Disposition: inline
In-Reply-To: <20181115135731.25f60990@bbrezillon>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vCQF5Fh1eN3mBuH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 01:57:31PM +0100, Boris Brezillon wrote:

> What we could do though, is expose I3C devices that do not have a
> driver in kernel space, like spidev does.

Yes, this is much safer and more robust especially if the bus has
enumeration requirements like you're saying it does.  It's much easier
and more sensible to do this if the bus can be enumerated than it is
with SPI, USB would be a good example here I guess (though I've never
looked at the details of how USB does this on the implementation side=20
so this may be me speaking in blissful ignorance).

I do agree that there will be use cases that turn up for this.

--vCQF5Fh1eN3mBuH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvtxCcACgkQJNaLcl1U
h9Cwqgf9FzaFIpuw5W1ZNyAo/CrKG9CG7oGaFJL30zMrjp4pW4+47CHwCNFgWYa8
934xtfIiTiMP+TJgyRu9HkkW1/FnQQbjPUFG1sDZxDUJIrAyRpJNySUqr9gIbW0V
d/ghzX8St9zFvrvzm7aILWbwC35lbjpSFIb2pXhtril67M5ZbWBNlRONJIAXePLR
4uPM5hr202hXDVw3EJOHb5M/q+SneMMei60TIMep9qYBI/zSGHIcUUEc/nDkgU3p
gLkitVuEv1M3Imj+KmB+dnVFP5GGijN5yq5zcuKMpBoxPgt9TBpelkpFTO1ncelW
1GZMkdv9qBVLAmGo7gaP5scgYnFr/w==
=HYvt
-----END PGP SIGNATURE-----

--vCQF5Fh1eN3mBuH/--
