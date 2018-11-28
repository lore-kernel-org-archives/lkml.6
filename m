Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D3DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5092B205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4+vRqYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5092B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeK1Vpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41023 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeK1Vpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id z28so21654505edi.8;
        Wed, 28 Nov 2018 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A+L4+VpYEMHbBAPSGcpp/+QQTNEFAiVbJ/YxlGWW4GE=;
        b=s4+vRqYi+VIUIzVnOrjQDZobeJBXQ5n1CYUHFHy6eSc95RzBCax+3Qd9HnoRokQ6aY
         PFfYVBqA5h6Sxo5GBnpV8vKfCNRfsUYBskz7yI3e9JOBlxILZELTArwxuu6/aLWj5DsF
         7gYFzWRUDkHzW/v0+Esm24T6hDCLn+j8q+FkIjTSZ9YcvOzctnjjDvlUCZ6rwT6afsCG
         zdeR1uMfnFvVRP4bkvCqPEAdILgPFDYPYGAIADsPZD4k7OdDqHssuN4EmiBXzX31jA4N
         vXauSe3/EVQ3w7mqjST6cnQ5mym9DoTso+K+ZK9zG/8zBzF8Mh0WtADLR/9ZueL+V4wf
         Shhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A+L4+VpYEMHbBAPSGcpp/+QQTNEFAiVbJ/YxlGWW4GE=;
        b=YI0slWdlfG9ByF28bwJB+zOzL5SCspj25pizmDt5HA4LSBdOg1uQS/Nw4Qbq61rZKH
         /uE3lQeh9U12PPyWEVBMaKb/EE81G38MC+7StgrdrZaeES38K4xA28oVkRXZy3ZmZNnV
         pfUw6y5ai12u2kuyyNVy7c351iZpSMgZAyTN5CMIr4FOIODu/ucMiPIVrxOOWsaUTzdB
         HsjUlFaMYab/aojWkb8ICUBf2obmtJjmrbbZoNuyQnwEDmcGOmpy3N5cmwrksPwdg0nD
         tAyKQZPMsC+c+otPbYknjLZEwATLWKkbHioF+46i1h7nmqC4byRSbJFhoued1uEyMV4E
         14Lg==
X-Gm-Message-State: AGRZ1gIfuEz0nbqFA8xJLQLLNLDy74wmGaftmPkDwkhlgu3eiMDbxQpU
        a+g5yc4VmWou9w6/yNquYDg=
X-Google-Smtp-Source: AJdET5eFptZI91m50G+9OVZ9bdQft0ebmRI3YpOL0Ayi/BFJH9HDSn9krvcvEIEHkEiG5rmkKmGTQQ==
X-Received: by 2002:a17:906:3548:: with SMTP id s8-v6mr26246365eja.161.1543401878710;
        Wed, 28 Nov 2018 02:44:38 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y53sm1693904edd.84.2018.11.28.02.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:44:37 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:44:36 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] dt-bindings: tegra186-gpio: Add wakeup parent support
Message-ID: <20181128104436.GA22559@ulmo>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <20180921102546.12745-8-thierry.reding@gmail.com>
 <20181015144612.GA23929@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20181015144612.GA23929@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 09:46:12AM -0500, Rob Herring wrote:
> On Fri, Sep 21, 2018 at 12:25:44PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Tegra186 and later have some top-level controls for wake events in the
> > power management controller (PMC). In order to enable the system to wake
> > up from low power states, additional registers in the PMC need to be
> > programmed. Add a wakeup-parent property to establish this relationship
> > between the GPIO controller and the PMC.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../devicetree/bindings/gpio/nvidia,tegra186-gpio.txt      | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpi=
o.txt b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> > index adff16c71d21..cbb51a8990c3 100644
> > --- a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> > +++ b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> > @@ -127,6 +127,11 @@ Required properties:
> >              - 8: Active low level-sensitive.
> >              Valid combinations are 1, 2, 3, 4, 8.
> > =20
> > +Optional properties:
> > +- wake-parent
> > +    A phandle to the Power Management Controller (PMC) that contains t=
op-
> > +    level controls to enable the wake-up capabilities of some GPIOs.
> > +
> >  Example:
> > =20
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > @@ -148,6 +153,7 @@ gpio@2200000 {
> >  	#gpio-cells =3D <2>;
> >  	interrupt-controller;
> >  	#interrupt-cells =3D <2>;
> > +	wakeup-parent =3D <&pmc>;
> >  };
> > =20
> >  gpio@c2f0000 {
> > @@ -162,4 +168,5 @@ gpio@c2f0000 {
> >  	#gpio-cells =3D <2>;
> >  	interrupt-controller;
> >  	#interrupt-cells =3D <2>;
> > +	wakeup-parent =3D <&pmc>;
>=20
> If all the GPIO instances point to the same PMC and have no per instance=
=20
> data, why do you need this in DT? You can just search for the compatible=
=20
> node.

That would be slightly annoying to do. I mean, we'd have to somehow
construct the compatible string that we're looking for. I guess we could
get around this mostly by just looking for a device matching one of the
entries in a "pmc_gpio_of_match" table. That would potentially match a
Tegra194 GPIO against a Tegra186 PMC, but that should never happen in
practice because it'd be a bug in the DT.

Although that somewhat depends on exactly what we mean by "compatible".
Technically the Tegra194 PMC is compatible with the Tegra186 PMC in
terms of register layout and so on. However, since both chips have
undergone quite some changes with regards to the pins they expose, the
set of wake events exposed on Tegra186 and Tegra194 varies wildly. So if
that means that the compatible needs to be different (I think it should)
then we could go with the OF match table approach.

Actually, thinking about it some more, even if we had a Tegra186
fallback compatible string in the Tegra194 PMC's device tree node, we'd
still be matching on the correct instance, and therefore get the right
IRQ domain for the hierarchy.

I'll rework the patches accordingly.

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+cZIACgkQ3SOs138+
s6EyIA/+LkKrq620emgEtZpd9U8q5GjkFRVNO7ncdVE1d3P1znsFtICWHyX0Iux5
r3V0vB7/R4HoH0bPDZzJdbFH/BrsWRf9H2E+S7LbFNsBDuN07vjHQlDGexR82c5q
h0D+QQ9JYzJkqciahQlqIvJ/AulAbXfozP/3jxlq0FtSSnc3apn8YDyRV1kWCDnc
IOgW59NqqBBoXCz1cBXIk+U22NvbtxLVL/qR+TjQJIsHZKWh7Kqv6oAZM53xW7XJ
sLt3Hvvot+6pwfOMQAhViix/MZgIM/Yq8gmy7ZmPW4JpIOtHvtqoIekrdpw2M+8q
gjsv1yU/4zrgtlRq4FqEqJjFAPNo6lnFt3uas1be1PrzDVQU1BYe6DPtqJhileFa
gi2kBD+MfPPGaz58IXnpCFHZ+ynoj/lzqlU85txkXC7C4iTHtn7NKhGA3g7+7Pok
FQNlhm1VKjzyac7qFu3MLtXy7Yit+k9AFqmYh7PtH9OfX5C046lnawKiEahzAd5c
AQrxCT7/Q+dRVWXTRhZ4YQyBeYRLM/cayFgUrRs3lB0zNf4Kdv+dW7WcW2P64+i1
T9dfM5cq/Su66zqOWp1KT/wqOG5aUk4OovC6CsYv7wtMAGtiWBozzizYDBSji6dl
XwEX54BBof0kWZAhShV0lSB469yw3m3ebkluFoVGy0fNVyN+muw=
=U3yi
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
