Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7B6C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE9E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE9E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJPDmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:42:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52411 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeJPDmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:42:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E3FB580880; Mon, 15 Oct 2018 21:56:03 +0200 (CEST)
Date:   Mon, 15 Oct 2018 21:56:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        robh+dt@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        koen.kooi@linaro.org
Subject: Re: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels
 and triggers
Message-ID: <20181015185147.GA29649@amd>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
 <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
 <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 09:25:24, Michal Simek wrote:
> On 9.10.2018 16:05, Manivannan Sadhasivam wrote:
> > For all 96Boards, the following standard is used for onboard LEDs.
> >=20
> > device-name:green:user1  default-trigger: heartbeat
> > device-name:green:user2  default-trigger: mmc0/disk-activity
> >                                           (onboard-storage)
> > device-name:green:user3  default-trigger: mmc1 (SD-card)
> > device-name:green:user4  default-trigger: none, panic-indicator

Actually, having one LED as heartbeat and second as panic indicator
only... Could those be merged and remaining LED used to something
useful?

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---

> > index eb5e8bddb610..565ceb390f99 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> > @@ -57,29 +57,30 @@
> >  	leds {
> >  		compatible =3D "gpio-leds";
> >  		ds2 {
> > -			label =3D "ds2";
> > +			label =3D "zynqmp-zcu100-revC:green:user1";
>=20
> The purpose of this series should be standardize Led labels that's why I
> would expect that leds will be called in the same way on all these
> boards that's why I am not getting why there is board name.
>=20
> green:user1 or just user1 should be enough.

green:user1 is better. Also... I guess this should go to the LEDs
list... and if you want to make names standard, maybe there's better
naming than user1..user4?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvE8NEACgkQMOfwapXb+vJHYACgg4mhvWXArstGIqpZD5bClCm2
Wq8AoKo0xwMF3vYNemfu1pJwqXBbKS8n
=qjFQ
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
