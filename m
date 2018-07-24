Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449F7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F191D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrvEXPt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F191D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbeGXTSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:18:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42299 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388541AbeGXTSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:18:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id u202-v6so3611710lff.9;
        Tue, 24 Jul 2018 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hFAW59Khn9P51t9LU2/3fUxZAC83Qi+KTgtC2HraFB8=;
        b=GrvEXPt9LqICM3Lw26kIaJU+GdIsOeNNrTT4fkoVGkChDXfqYFAMQszjbQBNrtzrrF
         BNSO7dI6WA6dNmaxv8ZWv1Sa/E9OM37nXq/TxYRXzFh/INGLXhvDGOR5p44VL2E8RjC9
         nuw5PXVO/CDNVE6A3yqCXzGSf1J52mRZB+maUZVdGQ+xOh47H2/JEoJLQx37sYExrZMl
         7SAuvgK4j+CN7j/fj9zIt+UbDwwLZkD59j72VMIUP22OwAN1yBcoLbKzo/P4xNiMeA8i
         w9CUVyWtOUedvDKBesQrCccxQxUfNvuNaPiZ/eTZqiWvie1AQBlOi9jV2oz0kL+cBl4i
         brmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hFAW59Khn9P51t9LU2/3fUxZAC83Qi+KTgtC2HraFB8=;
        b=da35ZX/1Ih4DrgmYomHSVqJ3nZ/LiFpTb6sVULUmq0ZcYhg6zlLgvqNEwxRc2rtnn4
         0LBB3OvO4I8QReHDR4Jyq9B6Pr2Wf9ljfOSH7GAHR/mO8KFyPTHpHEhvlUFCVj8uaWg7
         bpjIyu15HbtklYW/XyRmlynGf2GdVOxxdcRXRV1z7suKmjUu8VSPQ9ZkKmUPC2/hBpgq
         5FR9mTIsqKoLkAWhsxfYmp5CUSdd7Z2vNMlnNI/B1E12N5Fr1ZFr698zyo0CJjSbR6QH
         aNfHnqwyjRQYgyqvizbcM4i2cPKaRx2Rkq1skc/FfkLeXP1rNhSzskpxf9Y0gz8Vs4ay
         CC/w==
X-Gm-Message-State: AOUpUlGZI6NxXGTWtY7EnlA/qIwdz1ALK+Qe7BimuCjzg4b1lt2P87dY
        fvo8XbeH+Jdd7OiCsNHZ6HI=
X-Google-Smtp-Source: AAOMgpevvAnLDwuRkqzy0WJ5kzu5X3/o1+1/Eg3P0EDN/ieDxOaIlr3bE5L2LAC8EJ4FFxJKAJRHpA==
X-Received: by 2002:a19:7609:: with SMTP id c9-v6mr10362983lff.73.1532455829276;
        Tue, 24 Jul 2018 11:10:29 -0700 (PDT)
Received: from gmail.com (c-2ec2f9f0-74736162.cust.telenor.se. [46.194.249.240])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1831944ljj.75.2018.07.24.11.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 11:10:28 -0700 (PDT)
Date:   Tue, 24 Jul 2018 20:09:59 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: pxrc - do not store USB device in private struct
Message-ID: <20180724180959.GA2864@gmail.com>
References: <20180716144014.6331-1-marcus.folkesson@gmail.com>
 <20180724023804.6mnbstzdrcp74rev@penguin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20180724023804.6mnbstzdrcp74rev@penguin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On Tue, Jul 24, 2018 at 02:38:04AM +0000, Dmitry Torokhov wrote:
> Hi Marcus,
>=20
> On Mon, Jul 16, 2018 at 04:40:14PM +0200, Marcus Folkesson wrote:
> > The USB device is only needed during setup, so put it back after
> > initialization and do not store it in our private struct.
> >=20
> > Also, the USB device is a parent of USB interface so our driver
> > model rules ensure that USB device should not disappear while
> > interface device is still there.
> > So not keep a refcount on the device is safe.
> >=20
> > Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  drivers/input/joystick/pxrc.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxr=
c.c
> > index 07a0dbd3ced2..46a7acb747bf 100644
> > --- a/drivers/input/joystick/pxrc.c
> > +++ b/drivers/input/joystick/pxrc.c
> ...
>=20
> > @@ -204,23 +204,25 @@ static int pxrc_probe(struct usb_interface *intf,
> >  		return -ENOMEM;
> > =20
> >  	mutex_init(&pxrc->pm_mutex);
> > -	pxrc->udev =3D usb_get_dev(interface_to_usbdev(intf));
> > +	udev =3D usb_get_dev(interface_to_usbdev(intf));
>=20
> There is really no need to "get" device for the probe duration, or in
> general, when you are not storing the reference to it.
>=20
> I posted series with an updated version of this patch plus couple more
> cleanups/fixes, and would appreciate if you could give it a spin.

Thank you for doing this.

I have reviewed the patchset and tested on real hardware, and it looks good
to me.

For what it's worth:

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Tested-by: Marcus Folkesson <marcus.folkesson@gmail.com>=20

On the whole patchset.

>=20
> Thanks.
>=20
> --=20
> Dmitry

Best regards
Marcus Folkesson

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltXa3EACgkQiIBOb1ld
UjKr6RAAxBBPXuGaXIepNqA8k4QPrnfqoD4Giy9cteMeKIC4AF4baWejBZHqf+8D
qhq65jx1IoP+ZRXZVDNRT5HPKGnAaIMPLe1+1Mer2tMwQkmDjZNYtbxcSKjCrhoz
51UhUEsMIpGKuiB1doQ8IOPywBiUik6SvpJeXJQOehnFMo+hiozOy/re0E8ZsK62
h7aPLFAn2dgOsUWbikVSVoduc/Wcik1+3BFLkkBdXdajRqTYG/6mOSS6+4aSnPND
UowfABodFGb6U7PgU1B2iCvxClMyw1STY6TqwAUa1uotkfPj5bB6Zce+lAU0BbWR
IRTdA5MiRe+AnFqfexlQNu81RVtIGy4Qej0cCQ87QI5HO1vza3d4nLo7yWXhFops
WW7UeMGiFAjari4oHJNWfk9VH2HI4S32eeCe3xqdPzNMdIMhX0Xrlb1Bo+iFW9lx
dD2Y3XNuiX0WITmrLx7+dr+SEqgDvhgxjvXUUqQYlii0yZMagKt+iA3paypFr960
AzKdqpGi2EkJUZ2acwR61S8pbib68X1Rpvq0D4QDCqeDKZ0v0SN/vTN6mTBYh1Uz
IVU89c09T902uORhbLRiEAUVe809KiSIVCgqvlJQJJw1rSLW+o4nOVR6dXMlshsf
gnaPTut28qETXr/nDkQ1setbDDDanv5643j8JAKc2GOwkLwGaJU=
=t1xJ
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
