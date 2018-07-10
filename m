Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E03020877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnVa6tP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E03020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933976AbeGJOsv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:48:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41858 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933949AbeGJOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:48:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so8405367wrr.8;
        Tue, 10 Jul 2018 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dNn/8vAxHDI2qm6OM6iDZOGMMYdPmT/NFR4mkFA2O7c=;
        b=OnVa6tP9JOj3xjmCkrDl3q4iF8rSG2uBgZ4Aa/DoidXcwhgnlnOOgVOCmmgHAIoHir
         TqKvLnfSDUMcATq9fMmN4tYIlrb/i4wDwjNOclKzTBt1bHkutklLeGKQzpKQNSSbiBlB
         iquM2qyQtjgyx+9nHfnDkqtfXaF/Lv+DUGN+X5pA5EVMSKEEdLhdNxUH/7D+1PmOobbC
         Odg4gu/fiOpeDpm4OynnMyECzWSlUzZo4WHLq35firONsZknH/+a/yD1K/YqpsHgN5Bq
         1kzma8YlS2HK0f7O8IYvg/oFNp38aKuGXF/pDQx1HieTqfSO/oKCd9mmIZCZ7u83SHOy
         T0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNn/8vAxHDI2qm6OM6iDZOGMMYdPmT/NFR4mkFA2O7c=;
        b=n5TvNVthENDznzElOq+ksGO3S98vnm36rKy4/1bThpDnl8WiHOVdkQBkAWUSJ2Tgtl
         8Mjwi4L4qfRbvWqjgtXRl9+V4bnFtOmqlxmnGL3gm9WSRWHl06Vs4n9MD6lNzL6i5G1Z
         Pw3npv26uRawoOQk7lE9EJ4VhamUNys+KU9P5V8OW0ibKhG+jkATiOrT6k6VQjnE9i2+
         WekLnO1gpCGyQhoDBD4rRh7WQXu3X65dR8lPhhHTchnMpziCPvOlciST+BBUjxEKri2C
         JsgCWW+qAmTFi7tdxUVCMraYUTmDcIb4u67cXn68xFV2QZ40Xlbw8W+2f7NGoXpgPBet
         yCdg==
X-Gm-Message-State: APt69E2iEQOBAIgOUAFHer2Kg6tidH6IDeqfnkYItlpEfnC/TGWGyqHb
        lbxIB1qu623RDyW2XV7OYzU=
X-Google-Smtp-Source: AAOMgpeudq4/9C74yLaYnq22oCWtxPxaRSjd6EPw6QIaoeOifmkqbxEMmZeh/G+zpnt4J/er19vU6w==
X-Received: by 2002:a5d:428a:: with SMTP id k10-v6mr18365125wrq.225.1531234127429;
        Tue, 10 Jul 2018 07:48:47 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id h12-v6sm15112970wmb.3.2018.07.10.07.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 07:48:46 -0700 (PDT)
Date:   Tue, 10 Jul 2018 16:48:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stefan Mavrodiev <stefan.mavrodiev@gmail.com>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] drm/panel: Add support for Olimex LCD-OLinuXino
 panel
Message-ID: <20180710144845.GA25784@ulmo>
References: <1529909093-17021-1-git-send-email-stefan@olimex.com>
 <20180710103250.GG1504@ulmo>
 <e1229a90-1bdb-0c8e-c371-cde0bc30ea56@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <e1229a90-1bdb-0c8e-c371-cde0bc30ea56@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 04:08:54PM +0300, Stefan Mavrodiev wrote:
> On 07/10/2018 01:32 PM, Thierry Reding wrote:
> > On Mon, Jun 25, 2018 at 09:44:35AM +0300, Stefan Mavrodiev wrote:
[...]
> > > diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/dri=
vers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
[...]
> > > +static int lcd_olinuxino_get_modes(struct drm_panel *panel)
> > > +{
> > > +	struct lcd_olinuxino *lcd =3D to_lcd_olinuxino(panel);
> > > +	struct drm_connector *connector =3D lcd->panel.connector;
> > > +	struct lcd_olinuxino_info *lcd_info =3D &lcd->eeprom.info;
> > > +	struct drm_device *drm =3D lcd->panel.drm;
> > > +	struct lcd_olinuxino_mode *lcd_mode;
> > > +	struct drm_display_mode *mode;
> > > +	int i, num =3D 0;
> > These two can be unsigned.
> >=20
> > > +
> > > +	/* Read up to 4 modes */
> > > +	for (i =3D 0; i < lcd->eeprom.num_modes && i < 4; i++) {
> > Can it happen that lcd->eeprom.num_modes >=3D 4? Seems to me like that
> > would be a serious bug. Perhaps move that check to where the EEPROM is
> > read and output a warning, then overwrite lcd->eeprom.num_modes with 4?
> If num_modes is bigger than 4, then lcd_mode pointer will point to invalid
> location. This can happen if someone overwrite the eeprom and apply
> correct checksum at the end. Then i < 4 makes sure this won't happen.

I still think that this should be checked earlier in the code, like at
->probe() time. That way you can output a warning once so that people
have a chance to notice a broken EEPROM and potentially do something
about it. You can then also sanitize the EEPROM contents so that the
rest of the code (i.e. ->get_modes()) doesn't have to check for this
error case.

> >=20
> > > +		lcd_mode =3D (struct lcd_olinuxino_mode *)
> > > +			   &lcd->eeprom.reserved[i * sizeof(*lcd_mode)];
> > > +
> > > +		mode =3D drm_mode_create(drm);
> > > +		if (!mode) {
> > > +			dev_err(drm->dev, "failed to add mode %ux%u@%u\n",
> > > +				lcd_mode->hactive,
> > > +				lcd_mode->vactive,
> > > +				lcd_mode->refresh);
> > > +				continue;
> > > +		}
> > > +
> > > +		mode->clock =3D lcd_mode->pixelclock;
> > > +		mode->hdisplay =3D lcd_mode->hactive;
> > > +		mode->hsync_start =3D lcd_mode->hactive + lcd_mode->hfp;
> > > +		mode->hsync_end =3D lcd_mode->hactive + lcd_mode->hfp +
> > > +				  lcd_mode->hpw;
> > > +		mode->htotal =3D lcd_mode->hactive + lcd_mode->hfp +
> > > +			       lcd_mode->hpw + lcd_mode->hbp;
> > > +		mode->vdisplay =3D lcd_mode->vactive;
> > > +		mode->vsync_start =3D lcd_mode->vactive + lcd_mode->vfp;
> > > +		mode->vsync_end =3D lcd_mode->vactive + lcd_mode->vfp +
> > > +				  lcd_mode->vpw;
> > > +		mode->vtotal =3D lcd_mode->vactive + lcd_mode->vfp +
> > > +			       lcd_mode->vpw + lcd_mode->vbp;
> > > +		mode->vrefresh =3D lcd_mode->refresh;
> > > +
> > > +		if (lcd->eeprom.num_modes =3D=3D 1)
> > > +			mode->type |=3D DRM_MODE_TYPE_PREFERRED;
> > Is there no way to determine the preferred mode if there are more than
> > one? Perhaps always prefer the first mode?
> My idea here is what if the first mode is not supported by the host? That=
's
> why
> we will be storing multiple modes, one with the most strict timings
> (e.g rounded to 10kHz or less, according to the lcd datesheet), and others
> with less strict.

Its not the panel driver's responsibility to take into account the host
capabilities. The panel driver should, to the best of its abilities,
report the supported modes and the host driver is responsible for
dealing with the mode list. If any of the modes are not within its
capabilities, then it can filter them out (using the ->mode_valid()
callback).

In this particular case, if there is no clearly defined preferred mode
I'd argue that either you don't mark any mode as preferred, or you
choose the one with the strictest timings. I had hoped that perhaps the
first mode would always be the one with the strictest timings and hence
would be the preferred mode, but it seems like that's not a guarantee.
If so, it's pretty much impossible for the driver to determine a
preferred mode, so can't do much about it.

As for the special case of a single mode being present in the EEPROM,
I'm not sure if that's something worth considering. If there's only one
it doesn't really matter that it's preferred.

Thierry

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEx0sACgkQ3SOs138+
s6ECKQ//dBryPS/+3xB2zXCWHrz7hkRTj+r4FZHQg9NWA7MlEA9bRMeamyfh2PyV
uYvUGl7ihg3uDx3hm1lE7+DESVQbJCVfBJ+0K9gKf4Gb7gluuFcSP0niyhd6Qlbt
pldetrdcG1CSnbEvPSv73Fg2vEaS6DUrJ861swcSgYfToXaAmyj/v+JuCRXMqvkm
5BU/ZRLfZrsfCJyMe83enoqPaW44MY/p5DzGq3nVDSAPOJ49n/iX4g+DeqEzzZJt
bru3GaeL9ovU6iR4H6M1p0vsjN73ESTqCFzuWElc8WEHDzBjUEcJW2YTy4yoOeAp
yrPJ8YMiQkBWUDMKN59lMK/ZtgBvaVcyxDnjnC2dn1oME2Rh/tFYQgTBEVA882qA
lSe0+8dam7P0XoSAy2nE2FQIHmJQ/6ijU2N2op8a08lXRfSNjWvr2tn3/kxBuJQx
1LtdUr9ARS/mo+Ru0HiyuaHv/3BN+Gi42w+H8sZFxrJlGKZs/dv0dw8bypkjw/8Y
P6KT4Epd7eJBLEWvxWDmvoaYINzGvlH48ORiQhpOJe6l2Wt0flL3djPImlYI2qaB
QINz+eosPS6fb7Fc2XeR4+yUhp/HpDZvrbZZGC9/xrwTWfzRGtExfS5PyxXwsrr0
cC2A3nnHg3YBtbXSF56mpL5y7Duv6tXE2VTFI621CRqNKQLga5M=
=8uar
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
