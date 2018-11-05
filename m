Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F60ECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDD12147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDD12147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeKESi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:38:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46208 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeKESi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:38:58 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B255480813; Mon,  5 Nov 2018 10:20:08 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:20:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 14/14] DT: marvell,mmp2: add USB OTG host controller
Message-ID: <20181105092010.GL4439@amd>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-15-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VBq/nvTu32OVLBUP"
Content-Disposition: inline
In-Reply-To: <20180822204307.13251-15-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VBq/nvTu32OVLBUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-22 22:43:07, Lubomir Rintel wrote:
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  arch/arm/boot/dts/mmp2.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Again, I guess this could be merged with the previous patch. Anyway,
it is also good to go as-is.

Acked-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
> index 14a3448f38b9..63d4d5c6fd83 100644
> --- a/arch/arm/boot/dts/mmp2.dtsi
> +++ b/arch/arm/boot/dts/mmp2.dtsi
> @@ -124,6 +124,17 @@
>  				#phy-cells =3D <0>;
>  				status =3D "disabled";
>  			};
> +
> +			usb_otg0: usb-otg@d4208000 {
> +				compatible =3D "marvell,pxau2o-ehci";
> +				reg =3D <0xd4208000 0x200>;
> +				interrupts =3D <44>;
> +				clocks =3D <&soc_clocks MMP2_CLK_USB>;
> +				clock-names =3D "USBCLK";
> +				phys =3D <&usb_otg_phy0>;
> +				phy-names =3D "usb";
> +				status =3D "disabled";
> +			};
>  		};
> =20
>  		apb@d4000000 {	/* APB */

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VBq/nvTu32OVLBUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvgC0oACgkQMOfwapXb+vJLbgCfb8/OHT5qSbGCWSv/W8TTeOQH
oo4AnigtZYPwje7Z8p2Jn8m1Axa9qsqR
=WROm
-----END PGP SIGNATURE-----

--VBq/nvTu32OVLBUP--
