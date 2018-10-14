Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5FCC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0E020835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0E020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJOGTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 02:19:09 -0400
Received: from sauhun.de ([88.99.104.3]:38520 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbeJOGTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 02:19:09 -0400
Received: from localhost (p54B33E30.dip0.t-ipconnect.de [84.179.62.48])
        by pokefinder.org (Postfix) with ESMTPSA id 30A2F2C786F;
        Mon, 15 Oct 2018 00:36:37 +0200 (CEST)
Date:   Mon, 15 Oct 2018 00:36:36 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mmc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mmc: tmio: simplify the DMA mode test
Message-ID: <20181014223636.GH3260@kunai>
References: <1539356588-18191-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline
In-Reply-To: <1539356588-18191-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2018 at 12:03:08AM +0900, Masahiro Yamada wrote:
> host->chan_{rx,tx} represents the DMA capability of the platform.
> Even if DMA is supported, there are cases where we want to use PIO,
> for example, data length is short enough as commit 5f52c3552946
> ("mmc: tmio: use PIO for short transfers") mentioned.
>=20
> Regarding the hardware control flow, we are interested in whether DMA
> is currently enabled or not, instead of whether the platform has the
> DMA capability.
>=20
> Hence, the several conditionals in tmio_mmc_core.c end up with
> checking host->chan_{rx,tx} and !host->force_pio. This is not nice.
>=20
> Let's flip the flag host->force_pio into host->dma_on.
>=20
> host->dma_on represents whether the DMA is currently enabled or not.
> This flag is set false in the beginning of each command, then should
> be set true by tmio_mmc_start_dma() when the DMA is turned on.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I like it. Much easier to read!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Also here, I'd like to test this on Monday on some more devices.


--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvDxPQACgkQFA3kzBSg
KbbJOA/+OuewvEmCiaXXXhz7btIO+397hN2g3rGS9oodRKJgOOZcmRlVGhC6BdID
jXHcEyIaMzpM/oo06dmEWBF2tbOpO0+ybAtT1si9GwcXOI3IEcUS846HafjNEMJb
j2DCTp2hcsKmRrx73LUQCsbTqxPH3kBnr55ErMKUjxkK8C039yBHrg37lDDPDRwK
LUuhD5OB9jGxibcWDhObjOTn4YkZnYlXdNI+eW/bID8JlmrvZfOazK4CfPBXnsWQ
82Tvq91+kzlB94k0m7aH6cOyyTQFvysN/xpwt+rgE+Va3aDnprmaT45ct4JOuQvA
SmddIrlRwqYCg0Cz1uhurPQOT9l7YN3J2e/07Wn8avz/Ygr3iZ3MMS8cGuyRTaaX
vKmpzMv1BknlAPZ/ZxMsLzlO7hyBpP1D85feG+ntm8UOEEw0c8mNvho+TfAVXJNV
nxFhvhtqAO4vn9TOoiS6kwkMS9WJtHS1iC1d+mXFvkmo2mkWGRYUY8wEdD2Fz1S3
6CM5bfNl6zfG2A0H8vl0a8Hq5/cmzOxprKPr8PsyZDm1L7TMw9Qe1ogUUOvIjLH0
j6uhb6Tn3SvPoTUdCsZMfeo+z6u8htsXYR9yQbuIOB5Bys5NYekIMCbRnMPOaj6t
ShjV6DYIPk82rh58Qdf7KJyMDitX2RNcZT5PsNHmUPD5ed5FBMw=
=cPem
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--
