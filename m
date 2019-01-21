Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4340FC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0859920861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyHbwJoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfAULUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:20:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39072 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfAULUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:20:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so10324851wmi.4;
        Mon, 21 Jan 2019 03:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O0Y1XJ+0xnuvSlAHla8rWWZZRIYWEJRmnWlUlMTmyI4=;
        b=WyHbwJoZVxO6pDTUxINZ6UHzAOONrXs1mhjvBlQST4yb4YhWsUHlasUe52dxf/VSFb
         OdoSHhWj4B3u3TstYfTIFALayk9OTt7/0f2EQAlAIUgYHUrrwFnAMIU3aCZ2b4nFZ64M
         uv1gtJw3XuIu1t3XlutSZcKpO6L1I0sAZIWvmGpmWlUx7WUAHRB6d1Sm2+qtv/chT0sj
         GYrYKkbRsqEQC490ef4gC1CSZRM1oJ9Xlf2+HxWbctJG5YsXBA8yRsGmkzlUYLynf/O3
         02RTFXt6HKBASPI/nhFYaWkmbsYlZ52ecbqKSHt0nZFtT9v6h22KdJu5HECBla7tqLTm
         jWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0Y1XJ+0xnuvSlAHla8rWWZZRIYWEJRmnWlUlMTmyI4=;
        b=Ts9aH7b0DXcxZWeobWmUaEJayIH9vO/BJ157kVhpyg/k94y7ZYhb2NxcOptEzGVfm+
         5nslhZgjfiFxr/Hg3swfU8ENMTFjEjln7trQyQS7ww+eIT7LaEQhlZJXdJ77Plbfyhri
         rJ+xuaweYU0vfh/x1dTGNgbUmPWQNxPUN0oiXlcb8U9/We3w8bzqWaq105fZg545bP+N
         v2i7tPOCUSNuPfmfQ3J6BHpHaKIey+umQBhDlEERubIy9awyoBnoDQgb54liR7kM3ct/
         iN+BR9w4Ys5WNiY714w9RF7wPlNF/tEg+jtiWrYf2gNLkBOvl1w723di0Mg0xMcyKHVp
         oWVw==
X-Gm-Message-State: AJcUukfBbEa8qbKFgsgbQYDwUIQcGMRjTockJ+usbMERJL4nUWfhRX0v
        BLPZHbWx436tQvZ0+pUrNss=
X-Google-Smtp-Source: ALg8bN4sPiue9kGGFEkEIJRmMcE+sT/aAECrKBjZOmV9VvI+j9RBigmTIoREZfQM85EyxoY0RGbaIQ==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr8529880wmz.150.1548069629901;
        Mon, 21 Jan 2019 03:20:29 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id u204sm79202993wmu.30.2019.01.21.03.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 03:20:28 -0800 (PST)
Date:   Mon, 21 Jan 2019 12:20:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Message-ID: <20190121112027.GH16756@ulmo>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-2-git-send-email-yash.shah@sifive.com>
 <20190115201149.ghddnf27s5kqephc@pengutronix.de>
 <CAJ2_jOGPpwsn=+OU3QcHtGYJ3MFYh9azdALSeWz3-WPXL9vHnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <CAJ2_jOGPpwsn=+OU3QcHtGYJ3MFYh9azdALSeWz3-WPXL9vHnw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 02:51:31PM +0530, Yash Shah wrote:
> On Wed, Jan 16, 2019 at 1:41 AM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > this is v3, right? It is helpful to point this out to ease reviewing.
>=20
> Yes, it is v3. Will take care of this in v4.
>=20
> >
> > On Fri, Jan 11, 2019 at 01:52:43PM +0530, Yash Shah wrote:
> > > DT documentation for PWM controller added with updated compatible
> > > string.
> >
> > Not sure what was updated here. But assuming this is compared to v2 this
> > is not a helpful info in the commit log.
>=20
> Ok, will remove the 'updated compatible string' part.
>=20
> >
> > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > [Atish: Compatible string update]
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > ---
> > >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 37 ++++++++++++=
++++++++++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.=
txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/D=
ocumentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > new file mode 100644
> > > index 0000000..e0fc22a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > @@ -0,0 +1,37 @@
> > > +SiFive PWM controller
> > > +
> > > +Unlike most other PWM controllers, the SiFive PWM controller current=
ly only
> > > +supports one period for all channels in the PWM. This is set globall=
y in DTS.
> > > +The period also has significant restrictions on the values it can ac=
hieve,
> > > +which the driver rounds to the nearest achievable frequency.
> > > +
> > > +Required properties:
> > > +- compatible: Please refer to sifive-blocks-ip-versioning.txt
> >
> > While the description was too verbose in v2, this is too short. You
> > should at least mention something like "sifive,pwmX" and
> > "sifive,$cpuname-pwm" (or how ever that scheme works).
>=20
> Will mention the above.
>=20
> >
> > > +- reg: physical base address and length of the controller's registers
> > > +- clocks: Should contain a clock identifier for the PWM's parent clo=
ck.
> > > +- #pwm-cells: Should be 2.
> > > +  The first cell is the PWM channel number
> > > +  The second cell is the PWM polarity
> >
> > I'd drop these two lines and refer to bindings/pwm/pwm.txt instead.
>=20
> Will be done.

I don't think you can do that. You're omitting the second cell
representing the period, so this is different from the standard binding
and therefore needs to be explicit.

That said, given the rest of the discussion in the other threads, maybe
it no longer makes sense to set the period on the whole block, but
rather just note in the binding that all PWMs need to run at the same
period. If the driver already refuses to apply incompatible periods,
your users are going to notice that they've got the DT wrong.

This would have the advantage that you can use the standard bindings.

Thierry

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFqvgACgkQ3SOs138+
s6HkDw/9G/+2aipEoQrz+7s6f9UOqF7LrWscQSYjZU3i8G/nYxfxiTDpwarQYIZt
Ceycjf6nt8x4bCAN76myAY8O/399OfKy/4s6EfFoIg77g5FVuhxWi0teEkn8cwo/
SvzQypcgPO40uwU7sD5gYzKv8BL2DbV/v8gHq1MZYsw6F5P6hnpk3y1dRn9udrUw
nL4qI1NR75zXBm6t+e5n3CBc6A/fBRo5juU1a4zJlxZIqbWz8Hw2MpeHZ/i22N7m
MaepSUgGGS/Bk4qa3Jy4Qg82sHjSf1GYMBQnPTlSdA+Araw7xtpxGtFRJA92q4xk
I8UEVbB7vfxqyKbcYcExzQIxnSNniRK64VQqiKq80NMVY3O/QA3gRa9aK/tQDSrG
eJvpydF29+oGW2lncgxLZPT2mwTdtW10QyvjLnXqqlA8jlzhbsKUs5e8gVF65i94
buG1R3zI9ngJ3LkkAUHFHiYZU9B0AxuZoz6X3IQlGcbInTC+lc3hB6jeNapMw5yL
4pl6vUvxKQCauM7h5XpGlOVyZfBMV/4R6wRW1dEGhRusog1zIQTbQahwix1J06Kp
N0ZbLtJ/4NJ+XSBNrFzLpM0JVKmJZdRBadJ2da6wbDmCRuULwC3rTS96rG9hEwQK
kEV573LtxIY4rXw/zsD4wTrT02eM+TOl9NtC4EQVYl7ImIn9JhI=
=ysK7
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
