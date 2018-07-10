Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF166C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B7220A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BgshAPHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B7220A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389629AbeGJSj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:39:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34790 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733001AbeGJSj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QhpBur6424WXif0K9wTzfpseoph7AMZTLep40TIqhjQ=; b=BgshAPHeUMZNAo+hue/otgYll
        XL/l8kuPX4BntYBq1kTtgCoESFr6vxXzWUIjtKSlOegwTOhPCt/7e3SiDp7fgy/DAaACBLUOXZui2
        hmqgm7CbNMRFF2oOLEeJA65kxOCawA6RsgloexzueUrxLmYFZK/WSXL3KLL/oIroGo7R4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcxBA-00028j-5w; Tue, 10 Jul 2018 18:16:00 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcxB9-0001ck-Gq; Tue, 10 Jul 2018 19:15:59 +0100
Date:   Tue, 10 Jul 2018 19:15:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v10 5/6] spi: at91-usart: add driver for at91-usart as spi
Message-ID: <20180710181559.GG8104@sirena.org.uk>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-6-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline
In-Reply-To: <20180625172230.29686-6-radu.pirea@microchip.com>
X-Cookie: To teach is to learn.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 08:22:29PM +0300, Radu Pirea wrote:

This is mostly good, just a couple of small things:

> +config SPI_AT91_USART
> +	tristate "Atmel USART Controller SPI driver"
> +	depends on HAS_DMA
> +	depends on (ARCH_AT91 || COMPILE_TEST)
> +	select MFD_AT91_USART

Why is this selecting rather than depending on the MFD like we normally
do?

> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for AT91 USART Controllers as SPI
> + *
> + * Copyright (C) 2018 Microchip Technology Inc.
> + * Author: Radu Pirea <radu.pirea@microchip.com>
> + */

Please use C++ comments for the whole block so it looks a bit more
intentional.

Otherwise=20

Reviwed-by: Mark Brown <broonie@kernel.org>

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltE994ACgkQJNaLcl1U
h9AkeQf+Mq7IQsKQUVCnKMlLqJ5zyB55TxIx46+ND7yNKQrL9Iqyz6XWFUlOfwA4
4sYKoF4uDRaMv3EcelHQSA4Q4uCCfQkOB4wXeilyOM5XGz/dSu02hp9AHkUeIrYk
mFC0N0A9av/xbcS8VdDtbUjOuS/8P27Tmbwh3U/n+mcXa8k0YEQwYA1VSoIoTbno
IleZNwnp13oH/c5pDpgLX/HlmeHNjLI/DT4Rt+3nsq0sV4H3I/Zvn/wwtyhruG48
iubp+b9R6lBWFxAT/gj/WJnbMn8xa42mTFCazIwW6bJ+0d+UHQeqSmJYPZVz2jE8
rp9nuWdqIOxugrMSGaI9s+VhdD/Qzg==
=uIu3
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
