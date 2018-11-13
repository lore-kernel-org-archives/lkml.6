Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B52C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9479A21780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hzmF2/Ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9479A21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbeKND35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:29:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49832 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731496AbeKND35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v9RZAqaBuzfjAzVEyD1GgAhu8xgBBGo3/OyNktqx9Dc=; b=hzmF2/LsvbBFcRkCRnla0QzZb
        suXhLkeczYx7oLUWH0y5EwFTblN5FDNVGbYaGhHXgxuGbX7CnF1X98epIkfa+cYe4Urpqk00dFvoZ
        DhlAYR02p/ByoBdUs/jw5FGnPeYsowuD0/v0Z2RRTh8zXOBsF8iI+f4P6N1d/4Y1X1y8w=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMcWS-0002LP-4Z; Tue, 13 Nov 2018 17:30:44 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 25A7F440078; Tue, 13 Nov 2018 17:30:37 +0000 (GMT)
Date:   Tue, 13 Nov 2018 09:30:37 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Andrei.Stefanescu@microchip.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        Cristian.Birsan@microchip.com, Claudiu.Beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Message-ID: <20181113173036.GA2089@sirena.org.uk>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542108563-10108-2-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <1542108563-10108-2-git-send-email-andrei.stefanescu@microchip.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2018 at 11:29:24AM +0000, Andrei.Stefanescu@microchip.com wrote:

> +- lpm-gpio: GPIO for LPM pin. Note that this GPIO *must* remain high during
> +	     suspend-to-ram, keeping the PMIC into HIBERNATE mode.

All GPIO properties should be -gpios even if they can only ever have one
GPIO.

> +- regulators: A node that houses a sub-node for each regulator within
> +              the device. Each sub-node is identified using the node's
> +              name. The content of each sub-node is defined by the
> +              standard binding for regulators; see regulator.txt.

You should describe which regulators exist for the device.

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrCjwACgkQJNaLcl1U
h9DZswf9GQpDUhtUazQEWWGCA9nxNLctztNbAOvLPP1iIsX0/japywptd3vRfEPi
eP57zQj15pBOhxlFb3LwdfwOqaTvHdwui5eJdc7HVhtWfBbKihu5m5bgOJOL+C6g
0lCxFzMlfPD/GyaTsOImaJjOiFWjG6sJHuUHCil7llizBr3mBumvywomjxH5MIx0
xH2juZw+l+vaInsTfJTO8B/T0v2GlH8Xk9H1ZEGUGVs2SHe5UCFD7Daf2F2iCcJw
5gDG0h8AW0I9oNSf2bMQ7lFFfoAX+3j2Fn6KjJxlAjP+6kQYsNzUE/SnFYqyp/0M
FWGlobdhWxRGVh1eUksXpPkrJxlNFA==
=w5i+
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
