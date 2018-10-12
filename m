Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DB7C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EDF20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tohXJscs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EDF20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeJLX2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:28:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37738 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbeJLX2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:28:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id y11-v6so13961788wrd.4;
        Fri, 12 Oct 2018 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LWPququgLQedysvFjpGLXmRRGXchcNwQRM0ixGjmZWs=;
        b=tohXJscsp+neT2UJsotVhkA9fEkTw7aX42y9wl+X+Zn/dPHKH7i/xRGDxAaU+vcR65
         eAGIR8AbkVPgO9qWtVki4S1G0VU6zKfkGfh2azu+lMwQnxbF2RWT2H2gH7hgBVMdX22M
         WQDeaW0ZKbBUouICpVaA1WCSPq0p3UHHsRV1ouGsdqyEbVG/ozfV2aWMg++z08xxBU+y
         eXjEvAG2qfXyFtU2KiqER4gRzTIOa+eLoNP2V/FSKw7iNeyirMlWtFHiz+JzK6J3ax6h
         CfhK9SDfrA5GepI9jQdAy3946pumsjeMsVqGpon8kH3hfc1T8KPme06f8MJHrePQJICV
         ipOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LWPququgLQedysvFjpGLXmRRGXchcNwQRM0ixGjmZWs=;
        b=TF9DEb8HR8Ch6duxXvI1/jbiWJRl6mGfWguMSrUvd4TEjvgDfoe7fLvFC6ArRQ3uZ/
         aF2O9+xymb5mh/FlEsEOSAYhZTuiTP0LCoMAGCy3cwnOh7F0tApx5Q7ompO4/3rNEqPU
         7z0QpCRd2/xWi0kk5sjBKuX5yhoYIJHAeH9fG7Z5xPZk+vGeENcEv4ORHGETq+MiyHEV
         bA1Eo1MhNLNo8h042EY/wex+mgxOKNhyalZUQnK3ROF304gfOdb7iIoP+RoXDdNJKVF6
         Tvb+5nVcE6lCZgEKV3z/CY2LCOnFpwJw1WEpGVWKGjH+bwoP9kuh4LdqJZMDhxp+NuOd
         twqg==
X-Gm-Message-State: ABuFfohHuL6bf5XczhmUfgnSgZNnrHCU2iDD3zQuT7UcAq8XJeizsZxv
        ukaqNPiWr2qfGHczACdguj8=
X-Google-Smtp-Source: ACcGV63Li4fcXvVP3Rvn7cytQOuTLSfE3CDPw8+hAukI8YlGk/W3FgMDglgbDc8k6B74O6mpteSkwg==
X-Received: by 2002:adf:b593:: with SMTP id c19-v6mr6129951wre.223.1539359701706;
        Fri, 12 Oct 2018 08:55:01 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id m16-v6sm1660458wmd.35.2018.10.12.08.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 08:55:00 -0700 (PDT)
Date:   Fri, 12 Oct 2018 17:54:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: =?utf-8?B?W1JDRsKgUEFUQ0gsdjIsMi8y?= =?utf-8?Q?=5D?= pwm: imx:
 Configure output to GPIO in disabled state
Message-ID: <20181012155459.GG31561@ulmo>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Content-Disposition: inline
In-Reply-To: <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 03:04:48PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> On 12.10.2018 10:57, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Oct 10, 2018 at 09:33:26AM +0000, Vok=C3=A1=C4=8D Michal wrote:
[...]
> >> +static int imx_pwm_init_pinctrl_info(struct imx_chip *imx_chip,
> >> +		struct platform_device *pdev)
> >> +{
> >> +	imx_chip->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> >> +	if (!imx_chip->pinctrl || IS_ERR(imx_chip->pinctrl)) {
> >> +		dev_info(&pdev->dev, "can not get pinctrl\n");
> >> +		return PTR_ERR(imx_chip->pinctrl);
> >> +	}
> >> +
> >> +	imx_chip->pinctrl_pins_pwm =3D pinctrl_lookup_state(imx_chip->pinctr=
l,
> >> +			"pwm");
> >> +	imx_chip->pinctrl_pins_gpio =3D pinctrl_lookup_state(imx_chip->pinct=
rl,
> >> +			"gpio");
> >> +	imx_chip->pwm_gpiod =3D devm_gpiod_get_optional(&pdev->dev, "pwm",
> >> +			GPIOD_IN);
> >> +
> >> +	if (PTR_ERR(imx_chip->pwm_gpiod) =3D=3D -EPROBE_DEFER) {
> >=20
> > You must not use PTR_ERR on a value that might not contain an error
> > pointer.
>=20
> OK, thank you for valuable info.
> So it seems like the I2C folks are in troubles as well:
>=20
> 	https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2c-im=
x.c#L996

There's nothing inherently wrong with doing it like the above, just
maybe slightly unusual. PTR_ERR() is really just casting from a pointer
to an integer, so if the pointer happens to contain the value
-EPROBE_DEFER, then the above will be true. If it contains a valid
pointer, the above will be false, so it does exactly what you want.

Perhaps a more idiomatic way to write this would be:

	if (IS_ERR(imx_chip->pwm_gpiod)) {
		if (PTR_ERR(imx_chip->pwm_gpiod) =3D=3D -EPROBE_DEFER)
			return -EPROBE_DEFER;
	}

But that's not much clearer than what you have, so feel free to keep it
that way.

Thierry

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAw88ACgkQ3SOs138+
s6GXsw//ZQtbpCz6HK0hGZvNAC+fn9QWEcg3hHDpDjDkDXJSvkbmcb0DicppwFE7
DRJcqK6M1bMI3JwZBUlrg2V3o3365DBXr+ojnTt7v1nKNhzG7+FIvL4ke6mxaiC9
NlpCqTZcD8rHxkRmT+fv5x38dIUOZJt85himbtGtO4F7uetHe5qrSRCxtbPjaeb/
Wv2lsGsaPtfTUTjO+XuoBnfpsmNrfm/iM2hJaw/YJgPk0u/roCvS2sIWcy2ldYUd
loTNjQAvPMYmQNyraEs+6cfiz0NuukN2Z16KBppbInxtLmyWqUmDMdegVzOliAWd
m0KGiSBykCkv0HeTEtvFcQwVYpvnY2NJATu06o3NvlsAabLK5O6ZEBUHu81DCo5w
NWY85+kFu+99prTYD9zJGUOaGFAPHI6jTN3bIvKG2yL7vKugqkvlAdt8+7CnalRS
7+HP+3wP22ejckc36PbT0Uiit3IiNWb+E5tkZ/CgfT+V6bCSRnG6J/IGexi7QKbi
RNIIBqrjaremE9vWtJ3jjwJIMTSwHndoOM56GoYyCNk2URoUkjuZWt47NmI78R7f
/7KtZrxYH63wQOqdstOW6WMDRJefG5XHnpubPTXplNEYSaByTkeMJJwK/SBazcDS
a2bnidG/OjnWqy8ayJkgsacoN32FNNJAf9s9PMAHLQwt/wyIFY4=
=A30V
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
