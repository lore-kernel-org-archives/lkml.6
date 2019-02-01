Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA3DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7188121872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="RYjICEJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfBATGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:06:48 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:46502 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfBATGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MOr62uEuFtBHaIbPEFRWNgpkokVsgfLGdLcfkB3pZrs=; b=RYjICEJWot5S2LYSKXGuO9+66
        8IPZQ6xlXNLwTsxoBT4+yVZi8v9tmosaPq2WulS+ICk6dWVjFpCEZDEOvRpnv8eKTyUQ3FSDhR/pu
        IJJlvjLGDU4mVe7mJjRhiu5N2S9SA1MWZkCIeTH1UF/mDlXXA1p+y6RPObm2Mn8abPDMg=;
Received: from x2f7f3bb.dyn.telefonica.de ([2.247.243.187] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpe96-0004QR-8q; Fri, 01 Feb 2019 20:06:36 +0100
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpe92-0003IM-VA; Fri, 01 Feb 2019 20:06:33 +0100
Date:   Fri, 1 Feb 2019 20:06:30 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        letux-kernel@openphoenux.org, tony@atomide.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm: dts: gta04: add gps support
Message-ID: <20190201200630.2efc9eef@kemnade.info>
In-Reply-To: <20190201100416.GD3691@localhost>
References: <20190131180640.14480-1-andreas@kemnade.info>
        <20190131180640.14480-3-andreas@kemnade.info>
        <20190201100416.GD3691@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/01NHARD8ceDsp1l45OdUP9y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/01NHARD8ceDsp1l45OdUP9y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Feb 2019 11:04:16 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Thu, Jan 31, 2019 at 07:06:40PM +0100, Andreas Kemnade wrote:
> > The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> > which one is mounted so use the compatibility entry for w2sg0004
> > for all which will work for both.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v3:
> > - converted to a patchset
> > - added vcc-supply
> >=20
> > Changes in v2:
> > - some s/gps/gnss/
> > - not added vcc-supply because the regulator is not modelled
> >   in dts at all
> >=20
> > w2sg0004 bindings are in next-20190129
> >=20
> >  arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/oma=
p3-gta04.dtsi
> > index 02d8274a2f47..4ea0f7dc37c6 100644
> > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > @@ -320,6 +320,12 @@ =20
> >  		>; =20
> >         };
> > =20
> > +	gps_pins: pinmux_gps_pins { =20
>=20
> s/gps/gnss/ would be more consistent, but whatever.
>=20
well, gps is already in the file at another place. So it is a bit
inconsistent in any case, without further cleanup. If someone comes
up with a strong opinion here I would of course change it.

Regards,
Andreas

--Sig_/01NHARD8ceDsp1l45OdUP9y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxUmLYACgkQl4jFM1s/
ye+00xAAujwl4zZ01Q52FI7OapO7C6j5SXClBced5WldTb6FBxs6aS6ui9LdQp6Y
upieKwXd3WUwLqrfvw2EfEpeY6vDd6zIXbuQookzUJebIf2rN1DrLmQaXF8IVfmw
lFbybhZykmmGyqeS0S0008+PHlVDtBDXAJ/wR1EhwuUJYcDGrB7NWyRx5mzUy/YW
UXTZJmKE7Ce0si2zJW00NJ1rBo5c/HfNcLdnzxLpW2VyHzC8cVupFlPsa6lAX/DX
VsbtONc0gIVBgT8mcCnkT2f4InpJDBb1Y1ndCpaD2CA6VitbrWVfunshW5umlZne
7aTf1uckalGLMPtZg71CXBndFi8OtRYydeX9JF7nO9iL9cpEkFnE04yNgiDDWedv
IzYq+m94T4pXfCfB07A1gIFvMAec2nOuDbQ0VfLOOPPPSNatnyYV7vggfaurmGwI
M9tz5+mxd3pI7cSKMH/3Q7o/4vejEQ0iMi5/45g9ePOTb3Nddi7kerzMhcz8vqHz
sDzvg60pkFS3vlUqfE0+arSUuA0IwPvimb53DxMUUCLJpCbKoNIgNQLbnO4Y0WFd
x6RTDiTOvnYFquXpT+JioYYCxkHyFYsayngXn0e3d2VrdZmYhlXhYMjtOJikxvZA
7zpLyjlhEpLZRjzb+QlDggfDGU1HbRPuY8aeX+UDGoP8D3CgYGM=
=/2br
-----END PGP SIGNATURE-----

--Sig_/01NHARD8ceDsp1l45OdUP9y--
