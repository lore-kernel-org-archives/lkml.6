Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16760C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C407B20873
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JSdgF9jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C407B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeGDOco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:32:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeGDOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A/bGbKFSKUsQIozjipXzuGYzgVThWWoHCrIw+616kdQ=; b=JSdgF9jfHK/f88l8YkmzGpuk/
        0xHS4ohkMYy1VSKqKfp9wm/8jj4SjHL4cYnlo8cZEtgxLsV938kfL5oPwdlKrx7GmNID6iyzt5n7S
        +V5yOV2eR1oe96kYd87jgTa4Ul8G0cLejtiJMg4TuQsxWFICpNq4ysiLRunzDKXKwZP0M=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faipE-000727-L6; Wed, 04 Jul 2018 14:32:08 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faipD-0003Di-Px; Wed, 04 Jul 2018 15:32:07 +0100
Date:   Wed, 4 Jul 2018 15:32:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ben Whitten <Ben.Whitten@lairdtech.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?iso-8859-1?Q?R=F6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Steve deRosier <derosier@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "LoRa_Community_Support@semtech.com" 
        <LoRa_Community_Support@semtech.com>,
        Hasnain Virk <Hasnain.Virk@arm.com>
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Message-ID: <20180704143207.GD11693@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
 <20180703153137.GB13744@sirena.org.uk>
 <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
 <20180704114355.GB11693@sirena.org.uk>
 <BY1PR02MB1114BC0F12654B1E7C614108E7410@BY1PR02MB1114.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <BY1PR02MB1114BC0F12654B1E7C614108E7410@BY1PR02MB1114.namprd02.prod.outlook.com>
X-Cookie: Many suitcases look alike.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 04, 2018 at 01:41:42PM +0000, Ben Whitten wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> In my SX1257 driver currently the regmap is backed via SPI with
> devm_regmap_init_spi, please correct me if I am wrong but if I
> understand correctly this could be split out to regmap backed by SPI
> in the case of a direct host connection, and a regmap backed by the
> SX1301's regmapped strobing register interface, regmap_bus?

Yes.

> Is there a precedent to this I can examine?

There's lots of devices that provide both SPI and I2C, you'd just be
using a regmap_bus instead of the I2C one.  I can't recall an example of
the specific combination you're looking for though.

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls82mcACgkQJNaLcl1U
h9BTpwf/T2VrVZLcZ8Fk98fHgO3xln63cUiCQVjFwc8A8IHLEpsjgAkaHnNR3RLG
zxKmqIw63sSmHMxIwZ+cfJEAxiRDGpp6JgFtQgwPRRBzdsbizXRTXQJ+BwjixJHS
ntupUSgKDCe1XnMXjo21ZiaFsPvzxctSA6WRYKWYYjXh/uYoAi830siYyDLSqDFV
xqDd0iCQQZfijvrU6RYuTE5Mk7cSEkG6e0KLy6Sd51jisdcGN79P6Ao0zYwFveaG
MBmLiwacvAd2cokiIOCTfNg9+pEWwBsMcCkz1uoutML1wAyVZJg+UGWnAb664n2t
NCZ48qCSgHDInfA7uVmDddihsXD7Kw==
=b1ya
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
