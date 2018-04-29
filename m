Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeD2FyY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 01:54:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45398 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeD2FyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 01:54:23 -0400
X-Google-Smtp-Source: AB8JxZrztPblLvfpRVmrdSXeundcWIiMAztLaH8cV08RItu8WwmFtzgpDoQVl0R98eeQr5i3pTbgrg==
Date: Sun, 29 Apr 2018 07:54:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Wesley W. Terpstra" <wesley@sifive.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver
 documentation
Message-ID: <20180429055417.GA10221@mithrandir>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <1524869998-2805-2-git-send-email-wesley@sifive.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 03:59:56PM -0700, Wesley W. Terpstra wrote:
> Document new PWM device tree bindings for SiFive SoCs.
>=20
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 28 ++++++++++++++++=
++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Docum=
entation/devicetree/bindings/pwm/pwm-sifive.txt
> new file mode 100644
> index 0000000..7cea20d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> @@ -0,0 +1,28 @@
> +SiFive PWM controller
> +
> +Unlike most other PWM controllers, the SiFive PWM controller currently o=
nly
> +supports one period for all channels in the PWM. This is set globally in=
 DTS.
> +The period also has significant restrictions on the values it can achiev=
e,
> +which the driver rounds to the nearest achievable frequency.

How about you encode this in the driver rather than DT? We have several
drivers with similar restrictions and they usually allow the first PWM
channel to choose an arbitrary period and return an error if subsequent
channels request a period that can't be supported.

I think something similar could work with that second restriction. Why
not return an error if the exact period can't be set? Or perhaps allow
some percentage of deviation.

If the exact period is achieved in a deterministic way, it should be
possible for board designers to specify it exactly, so the consumer's
pwms property can simply take the correct period.

> +Required properties:
> +- compatible: should be "sifive,pwm0"

Why not simply "sifive,pwm"? If this is supposed to be some sort of
version number, then it is more customary to use the name of the first
SoC that integrates the IP. There are some exceptions, like for example
when the IP is third-party and is integrated in a number of different
SoCs. In such cases the IP is often properly versioned. But that doesn't
seem to be the case here.

Thierry

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrlXgAACgkQ3SOs138+
s6G0og/5AcKecMoLYsTgL/lfsWklBkmYsnoNapJacw4g7JWBgbhcx0HpWM3rK1AQ
CdjVFvb5i/XPAG9O2VEobdWpSjzXwx3d71v9QfaSqLSPQnbhOPcBieWCcq1F0vll
dtUMHwAPVmSDDIiCcmQoFRsEQ7NgtklZbQcFxR06PknQ14Dcg3KpOww5+JDv5zdy
ZBPLGhRBm4jfcxeV6oIbEDSOHYKOdLZNwf7qnWFHo8fzMnI4PSkRfG09kHP3AJMz
qK4dkj8ZwmhIT92XkCzt9Xa4zXyAp9CRDnhe9qT+Svy8RU1m1If7DbE5w/ENbmpJ
735qfQL9jlgm/Q0bJQOHE8N8ZLTCCBmWRpcioPTy/+8TPJSmG3e8jPmlKnJDxUzF
gCbWYL+PuiWBU+NRzCxTtQMarpmRc08pqPBbScHQgSioUfcd+KDZrPPQUdp1uUmB
d2jadVcI+bRn7u/Hlt01Sax4h8hV5ZLWdiMPhZGB3MgoDRbNiv95X8MqcRnY9yd6
usyj8ZHwTJ/SNtRCdCIZI26zwztzx4BYDyD4grE7noYMJFY4+yjfU07gb6qtSqgZ
LvoXm6R1WDqeATn2g4svd4nKz5O7GpYe3lLf/EXUyIvtTxHjVu3BLpEXW7VwZPXV
TpqnNC7thuVskPodkixMi+6bn2DFi0yOKwHLrIaUsFGJc9hhj0g=
=DkNP
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
