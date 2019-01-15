Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B25C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3F720651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iHdQVil3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfAONKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:10:49 -0500
Received: from ozlabs.org ([203.11.71.1]:40807 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbfAONKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:10:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43f9gn1TRPz9s3q;
        Wed, 16 Jan 2019 00:10:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547557845;
        bh=GYdM6qXJEjqmXX2Iu8J53tSAEoQ34aZJKMfupYoO7uI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iHdQVil3RcJSAzc1C2R1QCbWbG23LNlYBD8BkeJBlqEN2gDog26fYyAq6W1hFqgPE
         8K2lvGvvlfWJiFgiETjcX9ei+5AtlnZpPbZjkgCfiy+9WSAtA+LwEPhBUw4mdyQWZ4
         dHAhYDN0gkod1/pZR6WSuI7N2x7gr9fK3YAmhsjSJl1m/z6RQ5LtkBLUyIUjJicWcW
         ZerFQxLpYwqBq0qV1ea/Ic0AqVcxhkZ8naW8wRAa5O6dnIpINkJITLOA/m+iQ/wtwb
         Calanjxv+H2dlSIAvZQokgTlDeEH/EK0flqV1sEHfsV/f8eK3Xa2a7PpHxEAmdFXsS
         3hdeHjmQy1Pwg==
Date:   Wed, 16 Jan 2019 00:10:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Message-ID: <20190116001043.69529b90@canb.auug.org.au>
In-Reply-To: <e892304bde543b86a9d0ad4409d0c6a1f509a312.camel@nxp.com>
References: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
        <20190114005600.GN11426@dragon>
        <e892304bde543b86a9d0ad4409d0c6a1f509a312.camel@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/t.tgKeD2y1yX06Oh8kdGcV0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t.tgKeD2y1yX06Oh8kdGcV0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leonard,

On Tue, 15 Jan 2019 12:30:23 +0000 Leonard Crestez <leonard.crestez@nxp.com=
> wrote:
>
> On 1/14/19 2:56 AM, Shawn Guo wrote:
> > On Fri, Jan 11, 2019 at 05:57:30AM +0000, Anson Huang wrote: =20
> > > This patch adds cpuidle support for i.MX7ULP, 3 cpuidle
> > > states supported as below:
> > >=20
> > > 1. WFI, just ARM wfi;
> > > 2. WAIT mode, mapped to SoC's partial stop mode #3;
> > > 3. STOP mode, mapped to SoC's partial stop mode #1.
> > >=20
> > > In WAIT mode, system clock and bus clock will be enabled;
> > > In STOP mode, system clock and bus clock will be disabled.
> > >=20
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com> =20
> >=20
> > Applied, thanks.
> >  =20
>=20
> Hello,
>=20
> I'm not sure if anyone else already noticed but it seems the
> arch/arm/mach-imx/cpuidle-imx7ulp.c file was dropped?
>=20
> It's not in your tree:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit=
/?h=3Dimx/soc&id=3Dcf2d2d392906f5603cf0d0f3630f6386babf7e4b
>=20
> This causes build failures in next-20190115 with imx_v6_v7_defconfig.

That file does not exist in Linus' tree either.  And there are no
commits in linux-next that add it.


--=20
Cheers,
Stephen Rothwell

--Sig_/t.tgKeD2y1yX06Oh8kdGcV0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw929MACgkQAVBC80lX
0GyDEwgAmGv+Q6po4XzsOJ+7bVXlMggp3rkzl4n6ZYgfNPZgMeqcvHJ7/zVxj+TO
nesTdlgal/q+X5x0f39z8t4+UcXJGIpctOULWDMIRt3n5G0aLIIlTSFae9yf3+gY
2UvR483ALXoBUsoBFxJfSyBedzVvt+syAenCsN2RgSJxWe5ymPNX9/LZPjrJULEs
d32HvN4hrGcIwKoHLceHRUCi4OBA9yJ2qEkAXgoPFFMBA5LaLM36SNAwr7yGw+SV
kJQAToTo4IAs7LntQr/Kt1B/9n7VXV6UcrWRAKzwEp4ibIo8DTfL7Clglfgw+UgD
NXmau7HKeWeCpAjmy7kprK2pgtSpbQ==
=34oG
-----END PGP SIGNATURE-----

--Sig_/t.tgKeD2y1yX06Oh8kdGcV0--
