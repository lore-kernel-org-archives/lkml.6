Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF4F20841
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mG09QPlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF4F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933758AbeGDLoa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:44:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36398 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932864AbeGDLo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6ke+Htqfw7pHtQB6b1no00XaJOBrcpAKSkti5HJhXkw=; b=mG09QPlr0XUWty8BpAEv5Sh95
        762NwXO0C5A+GY713Nyj3+u6dRqXLisG+bWaYUkJ3gPBt/53Awj1CSET1SxUqfateP0snGYfPueMB
        H/j6IIs8svb8OVYVrfgrZuj7M29Fn5iSJXicIrbDh3q+FdXMXorMA5YZtrYg7mPix8FRk=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fagCS-0006w9-5U; Wed, 04 Jul 2018 11:43:56 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fagCR-0006Xf-AO; Wed, 04 Jul 2018 12:43:55 +0100
Date:   Wed, 4 Jul 2018 12:43:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?iso-8859-1?Q?R=F6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Steve deRosier <derosier@gmail.com>, linux-spi@vger.kernel.org,
        LoRa_Community_Support@semtech.com,
        Hasnain Virk <Hasnain.Virk@arm.com>
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Message-ID: <20180704114355.GB11693@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
 <20180703153137.GB13744@sirena.org.uk>
 <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
X-Cookie: Many suitcases look alike.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 06:40:41PM +0200, Andreas F=E4rber wrote:

> Do you have an alternative solution for abstraction? A regmap would seem
> to require putting everything into a monolithic SX1301 driver despite
> those connected chipsets actually being regular, external SPI chips that
> could also be attached to non-SX1301 SPI masters.

I'm suggesting a regmap for those external SPI chips.  It doesn't matter
what the host uses.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls8svoACgkQJNaLcl1U
h9BJzQf+MAsXjRHeQXvCHJN0ToPWII6jvxcjvoQYIZZxzeImZA2TyBNSJWMPR2Fm
vQDZ7DxwN6kk8vnSEjjzOGRm+bbVgja3qRkb0HS+WbDYGQNro80F1m35hT8O3B37
lZWZL9C20bImSJWQExgmr+il35fBvJUzkLQY1J9syMRLaaRJ4+CIKrH7Xj16mZKM
Hfr/G9HU0llJnefxKdyW5s5xNA7u2xSq+PrekNTVhAK0/sketwIueXHiuM4EF7pz
vNjy5KKIhnvdEDhKA1bI+podQlSOQyuox8y9zav42sy+Oz94lnUNo2D/+DlBgRFr
hcD5HtTKBAqZUKbMSJQOtoshneigLg==
=ldPE
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
