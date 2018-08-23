Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26188C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CB720C07
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CB720C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeHWOJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:09:30 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39444 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeHWOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:09:29 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41x1C91VRLz1qx9G;
        Thu, 23 Aug 2018 12:40:21 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41x1C90SLfz1qql9;
        Thu, 23 Aug 2018 12:40:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id zepDdZbK3ep7; Thu, 23 Aug 2018 12:40:19 +0200 (CEST)
X-Auth-Info: E0FwKknF1nbYvqesXAYgw4EHhqLgyh+UBXwOn5F35Iw=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 23 Aug 2018 12:40:19 +0200 (CEST)
Date:   Thu, 23 Aug 2018 12:40:13 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@karo-electronics.de>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Message-ID: <20180823123759.68b78e9f@jawa>
In-Reply-To: <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
        <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SsAnwfOlOr+S3rQE6dj.GB/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SsAnwfOlOr+S3rQE6dj.GB/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michal,

> Output of the PWM block of i.MX SoCs is always zero volts when the
> block is disabled. This can caue issues when inverted PWM polarity is
> needed. With inverted polarity a duty cycle =3D 0% corresponds to solid
> high level on the output. If the PWM is dissabled its output
> instantly goes to solid zero which corresponds to duty cycle =3D 100%.
>=20
> To have a trully inverted PWM output configure the PWM pad as a GPIO
> with pull-up. Then switch the pad to PWM output whenever non-zero
> duty cycle is needed.

Just to ask - Is your display equipped with power supply enable/disable
pin?

As fair as I remember the trick to avoid flickering the display
was to disable the display (enable-gpio property) and set the PWM PIN
as GPIO to high in u-boot.

>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44
> +++++++++++++++++++++++ 1 file changed, 44 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> b/Documentation/devicetree/bindings/pwm/imx-pwm.txt index
> c61bdf8..3b1bc4c 100644 ---
> a/Documentation/devicetree/bindings/pwm/imx-pwm.txt +++
> b/Documentation/devicetree/bindings/pwm/imx-pwm.txt @@ -14,6 +14,12
> @@ See the clock consumer binding,
> Documentation/devicetree/bindings/clock/clock-bindings.txt
>  - interrupts: The interrupt for the pwm controller
> =20
> +Optional properties:
> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure
> the PWM
> +  pin to gpio function.  It allows control over the pin output level
> when the
> +  PWM block is disabled. This is meant to be used if inverted
> polarity of the
> +  PWM signal is required. See "Inverted PWM output" section bellow.
> +
>  Example:
> =20
>  pwm1: pwm@53fb4000 {
> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>  	clock-names =3D "ipg", "per";
>  	interrupts =3D <61>;
>  };
> +
> +Inverted PWM output
> +-------------------
> +
> +The i.MX=C2=A0SoC has such limitation that whenever a pad is configured
> as a PWM +output, the output level is always zero volts when the PWM
> block is disabled. +The zero output level is actively driven by the
> output stage of the PWM block +and can not be overridden by pull-up.
> It also does not matter what PWM polarity +a PWM client (e.g.
> backlight) requested. +
> +To gain control of the PWM output level in disabled state two
> pinctrl states +can be used. The "default" state and the "pwm" state.
> In the default state the +PWM output is configured as a GPIO with
> pull-up. In the "pwm" state the output +is configured as a PWM
> output. This setup assures that the PWM output is at +the required
> level that corresponds to duty cycle =3D 0 when PWM is disabled. +E.g.
> at boot. +
> +Example:
> +
> +&pwm1 {
> +	pinctrl-names =3D "default", "pwm";
> +	pinctrl-0 =3D <&pinctrl_backlight_gpio>;
> +	pinctrl-1 =3D <&pinctrl_backlight_pwm>;
> +}
> +
> +pinctrl_backlight_gpio: pwm1grp-gpio {
> +	fsl,pins =3D <
> +		/* GPIO with 22kOhm pull-up */
> +		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008
> +	>;
> +};
> +
> +pinctrl_backlight_pwm: pwm1grp-pwm {
> +	fsl,pins =3D <
> +		/* PWM output */
> +		MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
> +	>;
> +};




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/SsAnwfOlOr+S3rQE6dj.GB/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlt+jw0ACgkQAR8vZIA0
zr3mEAf/REK+lHwHbo/LSJwTaFQuKnHAyWohjN8rW3U6OrVB+3G1nIVpLWUc6EGd
cOFMSUr01+iEFfmQiuFgpfhukEVu9GvApG1+HXw9vrynqDV9+Ty9LgKAFTmABSKU
q6opYlmy3nNgN6ukFxKVKsUZNmAb+hK4XrLp9wXcBnJ1eC5xnLl96Kv4ovmCQD/h
TM+XqoiD5GmRxZqUbo7Wxuu30oAXMNOB8/pNRhMqy6Zw9p+cKZZyvwy9kuyMolpy
ejx+8+FXjlbdapLemjFfxUTGXQyEpT/0Xb0JOZBvUBgBmeZeLUjd6bFuoSAis+9C
DvVybQ0OFfp1kpLDaG/4Ob/ah/kjbw==
=qAdX
-----END PGP SIGNATURE-----

--Sig_/SsAnwfOlOr+S3rQE6dj.GB/--
