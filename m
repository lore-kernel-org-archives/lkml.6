Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56D6C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F92F2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3Mcgr3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F92F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeJVTwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbeJVTvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:51:41 -0400
Received: from earth.universe (unknown [185.7.230.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 169A920853;
        Mon, 22 Oct 2018 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540208010;
        bh=rav48Sonf9lzRMj9HC6JUUbBHzP3W4mWu0dmyKD8/ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3Mcgr3Zd1OlTuaUT0kHv90nDoEnyGZSXOU802+5Biajte5aCaWa/ID96wNj50kHy
         5NTwjicPJmB2hyruBxEumQgHkHjHCDuYBeRPG9OYQg2DmgPa4BzbtuonnybiafbNms
         J+9ITBDAVdgPN10RbReuAF1+q1z516jSXgm3d2AU=
Received: by earth.universe (Postfix, from userid 1000)
        id C65893C0990; Sun, 21 Oct 2018 23:45:54 +0200 (CEST)
Date:   Sun, 21 Oct 2018 23:45:54 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
Message-ID: <20181021214554.i2mb5yn2doabyt5a@earth.universe>
References: <20181010172300.317643-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jnox64lrvnzk7wym"
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jnox64lrvnzk7wym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 10, 2018 at 07:22:45PM +0200, Lubomir Rintel wrote:
> Hi.
>=20
> This patchset adds support for the Embedded Controller on an OLPC XO
> 1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
> the existing OLPC platform infrastructure, currently used by the x86
> based models.
>=20
> The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
> uses extra handshake signal to signal readiness of SOC to accept data
> from EC and to initiate a transaction if SOC wishes to submit data.
>=20
> The SPI slave support for MMP2 was submitted separately:
> https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t
>=20
> THe "power: supply: olpc_battery: correct the temperature" patch was
> already sent out separately, but I'm including it because the last
> commit of the set depends on it.
>=20
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.
>=20
> Thanks in advance for reviews and feedback of any kind.

I reviewed the power-supply related patches (1, 10, 12-15) and think
they are fine apart from the things found by Andy Shevchenko.

-- Sebastian

--jnox64lrvnzk7wym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvM848ACgkQ2O7X88g7
+pqfnA//TKs8BES/kjdXsbsj0Q2N00S/gqI2yAJfPVzPjGUx8CwKBsRzW1yiQa5L
PLupI4oHdeRkThPP8o3aS1kLwHuJXxDt9VWCNQl98LpoTPs9iTDGfraFfSlVSFYG
arjQBKbPBt1wLt2hsEOgiipPA9nNZM+rFcO3nzYbTKgmf+wQ+bpKettsf/3qDeNV
3ZPj2LK/WX3jY0cnIw2y1vuR5PJj4eBsPwWC+FeOj63JJBtCHfY6jvfMv0rcOOz3
u9AQQJdhd23BK5xWT8qrOQ0OPLWvr9sFpImAvUjwT52okULTzCUJsFUR+X3iWHBg
FtHSUjwzf4tMVHQFsQmUGOdjrzXNnAOFs+OV3r/MHRNPc/eHHSE1GfPlgE3o0MBp
dFFs60geDQStMBxkGnCi1ILoU2pzOkBG/t0Hzd0rWGHWJPYApZIv5yJ8b/EBO+nJ
+e5/dXhe3d6lpdr6mECRoMXnpeGZAmhX95LLi6CdyMb9BfZVP2PVugBeD3pIaGwH
sEj21DXPTFM1lhgKFjD884E2CQEEpnxRhbcLCnpDmFjkt20h8irChVqq3NPaCphX
+4DgSj3ZRE9EgNNWgAA2K4UoJFupeGxk9EatMxMpxWybnoYgwyBg+SFZeh/v7LJt
9LC2H1BGBA0eP1A6UUc+ETcV9Qj2C/BGVbbKUfR7hLCxrx8WDaQ=
=Xjo8
-----END PGP SIGNATURE-----

--jnox64lrvnzk7wym--
