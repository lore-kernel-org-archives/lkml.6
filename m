Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A5EC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC22D20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC22D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeKDE1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 00:27:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42939 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeKDE1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 00:27:02 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 676E380938; Sat,  3 Nov 2018 20:14:48 +0100 (CET)
Date:   Sat, 3 Nov 2018 20:14:50 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 1/4] dt-bindings: mrvl,mmp-timer: add clock
Message-ID: <20181103191449.GG31179@amd>
References: <20180918205455.25464-1-lkundrak@v3.sk>
 <20180918205455.25464-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Content-Disposition: inline
In-Reply-To: <20180918205455.25464-2-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-09-18 22:54:52, Lubomir Rintel wrote:
> The timer needs the timer clock to be enabled, otherwise it stops
> ticking.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>


> ---
> Changes since v1:
> - Made the clock optional, to keep compatibility with DTs without it
>=20
>  Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt b=
/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> index 9a6e251462e7..b8f02c663521 100644
> --- a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> @@ -5,9 +5,13 @@ Required properties:
>  - reg : Address and length of the register set of timer controller.
>  - interrupts : Should be the interrupt number.
> =20
> +Optional properties:
> +- clocks : Should contain a single entry describing the clock input.
> +
>  Example:
>  	timer0: timer@d4014000 {
>  		compatible =3D "mrvl,mmp-timer";
>  		reg =3D <0xd4014000 0x100>;
>  		interrupts =3D <13>;
> +		clocks =3D <&coreclk 2>;
>  	};

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvd86kACgkQMOfwapXb+vLeSACfS5SqUwjMRNdgqkk+HEPTq6zB
zTIAoJRjcH1mr9mcHZDiBzsrmWoAvbO2
=CcrF
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
