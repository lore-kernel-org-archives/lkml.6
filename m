Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F32CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDDE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="megRal5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDDE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeFTN2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:28:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754342AbeFTN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=djUFlbeabQQKdJBGtq97E/X/fZXBWeimfgL8KIcf+g0=; b=megRal5NT+fZWoCzk+v2qxPWe
        /c6NiOqyli1SnHf7cxhDF5ooXfwD9+fYRTM4DHH/xGR4ikkQQ3F1aQ+SnR1O3/qa5zWRTS3errRea
        S0epas4ee++NUJo5vIKewFhPa9BxYzhHxLf6EEqK5BSy8iuEBO+0CSCO0zSpCyV0bPuNw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVd9P-0002Hz-FS; Wed, 20 Jun 2018 13:27:55 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVd9P-00087e-1p; Wed, 20 Jun 2018 14:27:55 +0100
Date:   Wed, 20 Jun 2018 14:27:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-spi@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Subject: Re: [PATCH 03/12] spi: spi-fsl-dspi: Fix per transfer cs_change
 handling
Message-ID: <20180620132755.GF6242@sirena.org.uk>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
 <20180620073442.20913-4-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <20180620073442.20913-4-esben.haabendal@gmail.com>
X-Cookie: No directory.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2018 at 09:34:33AM +0200, Esben Haabendal wrote:

> As of 92dc20d83adec565378254c0630e839ff5674e14, transfer->cs_change has
> been supported for non-last transfers, but not for last transfer.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqVloACgkQJNaLcl1U
h9AWlgf+Jn8V8GuWmqwEjOKvD0pO8SCEE/IgKm5c/+b3o8F/A0emloVE+ajKiHbr
oBK3+hMehOCGdgDuE9TYltcC3q8v64mqtIHqrqunm4cgFaE6xzWzBbBNn6lI07Z6
6zleQcD5fYwaZv/AJOIIdcuxTOFISymveAuR1ghppifKWOub2cFhNdfC7cCUYUII
5hOcMmb8+/P870I/45ZfOVoK+wZZ4Mt5DtXy2zVgwWL95FIIMMBIfFVlQ9UFCib5
baIGM5L7JNNEHR536q9HB7BHqx69yCDNZk9F4SUMrc2yxFavpLzKsTjWZM6vwAnT
e9IJKF1ocTg12yzqRbpGU/uJ6OrtEQ==
=j208
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
