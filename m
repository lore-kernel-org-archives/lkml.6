Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5381C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995C420660
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547037191;
	bh=Rajy4flKaggD3cKyOAf78FUBLukYgZSQuQj2XtBOVOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VwDrfFSLiSUGppT/u+BDQSmAeA1lwwmr8g9Z1fjEcEgdGj68VFDEXyb4/FkN+Ze+w
	 GObaYwrnPx2mkMjltsV2evd66KeXhqjmD91eOU5Lw6u3KKHZxJeHUy2Tqg2tcijZ+n
	 g6+dK+AK5Fh5ihIYoV27tTNAxlaAL+KPKkjPDpho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfAIMdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:33:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50618 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbfAIMdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rajy4flKaggD3cKyOAf78FUBLukYgZSQuQj2XtBOVOM=; b=UJQODgAyUjeAK9WwHdue7yq5M
        Dk6NgcjzDT6MTTW8JRudNrjZVBnaFa/hqMERj8/4FLvHvVpPeSY+S9XGvMrAU4W7yjrRQAIC2IYPn
        jQYQOIQY5y8SkEbzAeS3hNzEzjUMx1CH33R/52fU6pit8LETHV0V/dbtHOQR7FyBiGx3Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghD2h-0007xr-NR; Wed, 09 Jan 2019 12:33:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 41B6A1127528; Wed,  9 Jan 2019 12:33:07 +0000 (GMT)
Date:   Wed, 9 Jan 2019 12:33:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] spi: lpspi: Add cs-gpio support
Message-ID: <20190109123307.GB10405@sirena.org.uk>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
 <20190107074639.6336-8-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <20190107074639.6336-8-xiaoning.wang@nxp.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:47:47AM +0000, Clark Wang wrote:
> Add cs-gpio feature for LPSPI.
> The cs line will be controlled in fsl_lpspi_transfe_one_msg() function.
>=20
> Still support using the mode without cs-gpio. It depends on if attribute
> cs-gpio has been configured in dts file.

This is open coding the GPIO - it'd be better to convert to use
transfer_one() so you can use the core GPIO handling but that's not
really directly relevant to this patch so I'm going to apply, just
something it'd be good to work on.

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw16gIACgkQJNaLcl1U
h9DaJwf9Exgdkvi3rZsDT1R7F1yOvLKAdQE5R1ZokJnvkEmbN2zfWmYpRbImm+Nt
O6OhL6Sx1J2WXlYDxQB9wr55fbTu51LAWYT8utJHAf3gMrbNEI6f5+RJMJ8rfK8v
DtwxU7pESj2C/FK2Ope74YV8zASasIl+9Hwo4UH6tKmioCwGitNqmUwpnaZn3GB1
GvnzkV5ol5eOSkRZh4nX+MjOAxOBePf/mcZ2ViSP5ej7Yn5dqoLkQHp0XPKz+DLW
n++4Oa9Rq7rrc3vjMliyKb9xqJOJ3Y3f0OqoKvvNDxnxV5B7NDvAB3wn43JitiSx
eWsErR/D3P3Zuwcma2Of+C1q6hNJ2g==
=ZlzS
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
