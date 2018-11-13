Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B11C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485C62175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="p+xnuU+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485C62175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbeKNIwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:52:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53388 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=blM6dkEHlP4dNSD/ctuqvlpn5iLOpAwViUFOFLKrXrA=; b=p+xnuU+LZNQPzLTmmNomz1X6n
        Rxr/8Mmw/bbXux9BTex/zKVD+jFzFa1ESjdyZiKJWeOycHZ6P9RPdC/7VWTJzCzMEf6/8bRW9b+gz
        c440XMIhw8gbrRiaxfsZ/7t+c3hv0TULsZYkQ2/wVPG3ORmc11xisvYXUWx8nX96bFn9U=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMhX3-0002is-Lj; Tue, 13 Nov 2018 22:51:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8471F440078; Tue, 13 Nov 2018 22:51:35 +0000 (GMT)
Date:   Tue, 13 Nov 2018 14:51:35 -0800
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrien Charruel <adrien.charruel@devialet.com>
Subject: Re: [PATCH 1/2] ASoC: ak4118: Add support for AK4118 S/PDIF
 transceiver
Message-ID: <20181113225135.GQ2089@sirena.org.uk>
References: <20181108124934.32381-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p6hDAtPN9q+ZnUca"
Content-Disposition: inline
In-Reply-To: <20181108124934.32381-1-peron.clem@gmail.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p6hDAtPN9q+ZnUca
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 01:49:33PM +0100, Cl=E9ment P=E9ron wrote:

This looks mostly good, a few small things below but nothing too major:

> --- /dev/null
> +++ b/sound/soc/codecs/ak4118.c
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ak4118.c  --  Asahi Kasei ALSA Soc Audio driver
> + *

Please make the entire comment a C++ one so this looks more intentional.

> +static const char * const ak4118_iec958_fs_texts[] =3D {
> +	"44100",
> +	"Reserved",

If you use a _VALUE_ENUM_SINGLE you can hide the reserved/invalid values
=66rom userspace which is easier to use.

> +	ret =3D request_threaded_irq(gpiod_to_irq(ak4118->irq), NULL,
> +				   ak4118_irq_handler, IRQF_TRIGGER_RISING |
> +				   IRQF_ONESHOT, "ak4118-irq", ak4118);
> +	if (ret < 0) {
> +		dev_err(component->dev, "Fail to request_irq: %d\n", ret);
> +		return ret;
> +	}

You should request resources in the device level probe, there's no point
in requesting and releasing the interrupt like this.

--p6hDAtPN9q+ZnUca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrVXYACgkQJNaLcl1U
h9DB7wf/W1LooFgqTJgJoHvp4HpuSNxrpd12Sm2ZvqCgQcHcO4XW8JbRSm4gWq14
X9bLYqyv9bqA4ZQYDYsXPwiyC/ogftVkIejGVoijWJixtZQEfwMT3e1yFw3AASpD
p6/3pBml35uKWenFY1hsQB7pYvuh9chBs4L3paUeNhHWW+LXX/uQzbyrkvH9I/3j
7lV935pkIOpzCKBu9DhNRVaom6XjR22w9iBvJiDoOeZtGgSu7WbBWevrfzfUrg8j
wOIVZSlNPA15OBle3Zn+AozwJE1AUuw67vVvL5w1V/5WNNoxpvPtvjZ0sVmL8hSU
KhHpkDUpZyb6F7tQIRe2If8WwYA/zg==
=OxYf
-----END PGP SIGNATURE-----

--p6hDAtPN9q+ZnUca--
