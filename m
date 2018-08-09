Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68010C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1541121C39
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rl5c/0Iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1541121C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbeHIQe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:34:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37337 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbeHIQe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:34:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so5278863wrr.4;
        Thu, 09 Aug 2018 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eNOgxjB8T7M0ZdOrGi/tjWm0iMuidXJC7ZmtkULxL8g=;
        b=rl5c/0IwLgr8IrS1q+2WQEi8QmVqLQeB5i2T7N2e4F76krN8Diy7Yu6WWWTgxJtJgV
         sMiw+4QnlB2Mpp5PlYf6Gd5/wTRKJH+bLLeEjpGUhMQapelqt04Wq4icDrBd3G+35ZxI
         Vrmy/frgaxEpiI5KzdA9nOYC1/D5/0//gVoyp+kleidRP7+Y1rUw7KR0sGGESJb2lTWo
         PkGbMlt6wMaagxMgBVAomGs7BlWpDkUpre4xdgRJFEi/2yQn77JK+BtcLa9skLvIdpBN
         KFQ7QcdrvreZTHghRnA7dfZJzWecVUlrtFgrWqNMrPD7qxtQ0q6NdfhvAAd6Ha7CupZI
         OQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eNOgxjB8T7M0ZdOrGi/tjWm0iMuidXJC7ZmtkULxL8g=;
        b=ckUgstYwIrI7pMjJAmq6XKb5d5uhXMhMIuzJ+erkQ6VrbXNujbxr4QSLUOQNO1lJ+x
         OXquaLcVaLNe1RCSAzZEdTaR/fIEiLmVpWhYrfFkqIkLLyf2GYFv7Noj62rfQoXvVwr3
         1jgR+OpNnQvgeDBt2sf306ib9hteu8hjpAF+x4sj3IW/gFxID3XjP+5IEzCabUJ3KRvt
         BlGyLLP46/7tPrjgf1jqTnQNggcMjZg7u0WlnpmPATH6CnZk1ZS7ouJ5WrWgGeWKiF/J
         y+T0H8DI+dLZb8JqTt0Ycnj+T+sW7AJ7LbgxMjbabhq8ONFO7kBiLduYRYBox0OVB2kd
         MpMQ==
X-Gm-Message-State: AOUpUlGFdBLQCPIAmMYJdCN/UMPpggtfEjt9PfkRQJ9rQ5rZNUkEEfYI
        TPuTtnZoYFDFAZr8BTS8ro4=
X-Google-Smtp-Source: AA+uWPx8cjebBFwsU/XVEYH5SujjBkwfciKSmCCrQHdtYeQRlRGWb4QqILCqZ8NCUEFLNRR7oT9/Hg==
X-Received: by 2002:adf:e3c5:: with SMTP id k5-v6mr1650500wrm.94.1533823789886;
        Thu, 09 Aug 2018 07:09:49 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id v14-v6sm4347016wmh.41.2018.08.09.07.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 07:09:48 -0700 (PDT)
Date:   Thu, 9 Aug 2018 16:09:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
Message-ID: <20180809140948.GI21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-2-git-send-email-avienamo@nvidia.com>
 <20180809113609.GI21639@ulmo>
 <20180809144515.06089abe@dhcp-10-21-25-168>
 <20180809134648.GD21639@ulmo>
 <20180809170604.4353fe1b@dhcp-10-21-25-168>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fh0SynPkUvrWGMR0"
Content-Disposition: inline
In-Reply-To: <20180809170604.4353fe1b@dhcp-10-21-25-168>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fh0SynPkUvrWGMR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 05:06:04PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 15:46:48 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Thu, Aug 09, 2018 at 02:45:15PM +0300, Aapo Vienamo wrote:
> > > On Thu, 9 Aug 2018 13:36:09 +0200
> > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > >  =20
> > > > On Tue, Aug 07, 2018 at 04:59:57PM +0300, Aapo Vienamo wrote: =20
> > > > > Document HS400 DQS trim value device tree property.
> > > > >=20
> > > > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt |=
 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20=
-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > > > index 3c7960a..7d294f3 100644
> > > > > --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.=
txt
> > > > > +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.=
txt
> > > > > @@ -72,6 +72,7 @@ Optional properties for Tegra210 and Tegra186:
> > > > >    trimmer value for non-tunable modes.
> > > > >  - nvidia,default-trim : Specify the default outbound clock trimm=
er
> > > > >    value.
> > > > > +- nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> > > > > =20
> > > > >    Notes on the pad calibration pull up and pulldown offset value=
s:
> > > > >      - The property values are drive codes which are programmed i=
nto the
> > > > > @@ -88,6 +89,8 @@ Optional properties for Tegra210 and Tegra186:
> > > > >      - The values are programmed to the Vendor Clock Control Regi=
ster.
> > > > >        Please refer to the reference manual of the SoC for correct
> > > > >        values.
> > > > > +    - The DQS trim values are only used on controllers which sup=
port
> > > > > +      HS400 timing.   =20
> > > >=20
> > > > One of these additions says "DQS trim values", the other says "DQS =
trim
> > > > value". It is unclear from the above how many values there are. I t=
hink
> > > > this should be more explicit. Also, I don't see why the note about =
which
> > > > controllers the DQS trim value(s) applies to is in a separate parag=
raph.
> > > > Couldn't it be moved to the property description? =20
> > >=20
> > > It's a single value. The plural form is a mistake.
> > >  =20
> > > > Also, I think the bindings should specify which generations of Tegr=
a do
> > > > support HS400. Where else are people supposed to find that informat=
ion? =20
> > >=20
> > > This property is under the "Optional properties for Tegra210 and
> > > Tegra186" section and it only applies for the said generations. =20
> >=20
> > What's the point of specifying that they are only used on controllers
> > which support HS400? Are you saying that only a subset of the SDHCI
> > controllers on Tegra210 and Tegra186 support HS400?
>=20
> Yes, on Tegra210 and Tegra186 only SDMMC4 supports HS400.

Good. I think that'd be good to have as part of the DT bindings
documentation.

Thierry

--Fh0SynPkUvrWGMR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsSysACgkQ3SOs138+
s6EWbQ/+NU+mxZMPHIiKWhWZqLzgavH9rVHffJwEXQuzkR1NY+/O6nz6PGTuLeqo
t8WgvETzPaJm6LWVFzwjg0lYi2FWOVB4pfesVC3oNKT4KtD4IxCMEERcDEUAaga0
V2QEefuiLbxVzGHTxQ/e+N2Wf1ODUzkuz+zstsEIdG7EH7CyK10hfDE1tJ6fDH1u
G4SV2UB9ifP704PhZZyIHDfYMUX+tA8LBpcwj6SIRJw66oSzXTodGUy/QvySymak
bkRnA9RV/76Zcb+BbgSS6P/GTpGkLtwXm1reKBolBUPG3q0BBOjj4pw8Y9Ut4l//
tbNCoeOJMa6MqXoKA8FhfHhAVAQp+J5VVqgAaSWhMM/z7DBK8sYk/akL5FViolJe
TI3byWJ2liN47uyGbAaYMQnnJWJoF9nq3IkH153LS8/aVUI0Db9JOGhkjQjCs59r
mk7FF+bXiTWVxGFFmTGM38sIsFnzuxGGfO7CIJv+Mn3xnUvBz5qPcmpWqOri5x5F
J7KKJUem1ccxpRKYXeSR8pFtfkFIGVwZ+GemBZUgv61ncZ0HmEaSSfxR8urWq/Oo
8WJGVYpAIZ702VnY+eT3pc1W9qCIpz0pq/HxLFZvggjxru6ttcIx551jnNHLsBno
8y9I3T44M87Sd29+d98e24EA63oKNHQAIWYOd6rB0J3Ra8QQ2Nc=
=txHf
-----END PGP SIGNATURE-----

--Fh0SynPkUvrWGMR0--
