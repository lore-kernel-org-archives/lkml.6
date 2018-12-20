Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5F1C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94C12186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je/p97iS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbeLTRjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:39:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35358 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbeLTRjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:39:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so2462161edx.2;
        Thu, 20 Dec 2018 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ztZtXb7LkmN+J/DHEGiSJERmjE2sMXdpFqMqyM0TrjQ=;
        b=je/p97iSPcO7zkNK4jgfwqhXcHmgKBMOlBKA8YMiqCR4xbUhMil0IGWC5iYq9LlldO
         kfaG8wW96XLFSab7b1DGWebMyt7zZFD87xKB57FEKlrZvKj7Ni9Tt6nFCmdwPkFMgRfT
         MRmggp4wdmsvW3PLJCmQG3eqthbjwM0PPn2XItchhmBHrlP9KorCRqCfOZyfZ/DbOGwL
         He1SHyg7f/znJYi0OwxELpkjmCa26D/gak6wklvbh4B7KlN7fPhyT9/7kx2rLH2ZrEAJ
         bWrSVQd3bhw3Ql0vtjcMd52/zwY5y7FJYF4TEmqtnXg2fRNijHNRCNq9FxD+X42hQUBL
         aRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ztZtXb7LkmN+J/DHEGiSJERmjE2sMXdpFqMqyM0TrjQ=;
        b=Hyko2Ok/+goKLbzaIG4nQ9SuQKB9YYAomxolFiJFfr+g2hpT2aitz1Ut+dkLSRF2N9
         7vZu6Zl6ttwzBr68CAJ8iNURbwq2rc1oIFMFL4kVDDNyE0qhjs1inYraBlWx3FDz9bRG
         QrwjKekAnYguEyrHCgb7YWLHpZxyjU4DpPxEsSt4H+x6/TZbA3vJG+3cOEoC0XYLkZtj
         QVMon/5yaP18AM0i4aFKYpDPBW3UBjsWi+OFc278mKtkWShQ91+sIr51sHpRZ02TnchS
         0AnkCqUEOOfVm08wTaf6KwKzLi6qEJ9QHDSoaIKwhKXpFV+jeKCTw6u6Hor/VxOQp3+C
         QX9A==
X-Gm-Message-State: AA+aEWag0jA/2kcAQ0cLRJcuTdMtC1AvHDmpNwEIwHget8U/IfeQygQ4
        6VoxaebR/otjrC1xTS1HX+c=
X-Google-Smtp-Source: AFSGD/VNbmKdDZWGj9jtF0gqtj6UCbP6mKM/5DHezG1sA418uySDqKmkZGGAU3OIL8KNNM9JOc69dg==
X-Received: by 2002:a50:ad55:: with SMTP id z21mr24473300edc.74.1545327545905;
        Thu, 20 Dec 2018 09:39:05 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id r23-v6sm2219868eji.64.2018.12.20.09.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:39:04 -0800 (PST)
Date:   Thu, 20 Dec 2018 18:39:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>, ezequiel@collabora.co.uk,
        prasannatsmkumar@gmail.com, linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>, od@zcrc.me
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
Message-ID: <20181220173904.GE9408@ulmo>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
 <1544709795.18952.1@crapouillou.net>
 <20181213204219.onem3q6dcmakusl2@pengutronix.de>
 <CACRpkdbABtDgwKai=8Pfji7qVb-XHsX8pDsuDdS5hhg7qEN0Bw@mail.gmail.com>
 <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
 <1544969932.1649.1@crapouillou.net>
 <20181217075321.k45vhgnszeqs3tea@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
In-Reply-To: <20181217075321.k45vhgnszeqs3tea@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 08:53:21AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Sun, Dec 16, 2018 at 03:18:52PM +0100, Paul Cercueil wrote:
> > Hi,
> >=20
> > Le ven. 14 d=C3=A9c. 2018 =C3=A0 15:26, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > > Hello,
> > >=20
> > > On Fri, Dec 14, 2018 at 02:50:20PM +0100, Linus Walleij wrote:
> > > > On Thu, Dec 13, 2018 at 9:42 PM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > [Adding Linus Walleij to Cc:]
> > > > > On Thu, Dec 13, 2018 at 03:03:15PM +0100, Paul Cercueil wrote:
> > > > > > Le jeu. 13 d=C3=A9c. 2018 =C3=A0 10:24, Uwe Kleine-K=C3=B6nig
> > > > > > <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > > > > > > On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
> > > > > > > >  The PWM in the JZ4725B works the same as in the JZ4740,
> > > > > > > >  except that it only has 6 channels available instead of
> > > > > > > >  8.
> > > > > > >
> > > > > > > this driver is probed only from device tree? If yes, it
> > > > > > > might be sensible to specify the number of PWMs there and
> > > > > > > get it from there.
> > > > > > > There doesn't seem to be a generic binding for that, but ther=
e are
> > > > > > > several drivers that could benefit from it. (This is a bigger=
 project
> > > > > > > though and shouldn't stop your patch. Still more as it alread=
y got
> > > > > > > Thierry's ack.)
> > > > > >
> > > > > > I think there needs to be a proper guideline, as there doesn't =
seem to be
> > > > > > a consensus about this. I learned from emails with Rob and  Lin=
us (Walleij)
> > > > > > that I should not have in devicetree what I can deduce from the=
 compatible
> > > > > > string.
> > > > >
> > > > > I understood them a bit differently. It is ok to deduce things fr=
om the
> > > > > compatible string. But if you define a generic property (say) "nu=
m-pwms"
> > > > > that is used uniformly in most bindings this is ok, too. (And the=
n the
> > > > > two different devices could use the same compatible.)
> > > > >
> > > > > An upside of the generic "num-pwms" property is that the pwm core=
 could
> > > > > sanity check pwm phandles before passing them to the hardware dri=
vers.
> > > >=20
> > > >  I don't know if this helps, but in GPIO we have "ngpios" which is
> > > >  used to augment an existing block as to the number of lines actual=
ly
> > > >  used with it.
> > > >=20
> > > >  The typical case is that an ASIC engineer synthesize a block for
> > > >  32 GPIOs but only 12 of them are routed to external pads. So
> > > >  we augment the behaviour of that driver to only use 12 of the
> > > >  32 lines.
> > > >=20
> > > >  I guess using the remaining 20 lines "works" in a sense but they
> > > >  have no practical use and will just bias electrons in the silicon
> > > >  for no use.
> > >=20
> > > This looks very similar to the case under discussion.
> > >=20
> > > >  So if the PWM case is something similar, then by all means add
> > > >  num-pwms.
> > >=20
> > > .. or "npwms" to use the same nomenclature as the gpio binding?
> >=20
> > If we're going to do something like this, should it be the drivers or
> > the core (within pwmchip_add) that checks for this "npwms" property?
>=20
> Of course this should be done in the core. The driver than can rely on
> the validity of the index. But as I wrote before, this shouldn't stop
> your patch from going in.
>=20
> But if Thierry agrees that this npmws (or num-pwms) is a good idea, it
> would be great to start early to convert drivers.

Do we actually need this? It seems like Paul's patch here properly
derives the number of available PWMs from the compatible string, so I
don't see what the extra num-pwms (or whatever) property would add.

Thierry

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb07cACgkQ3SOs138+
s6HqPQ/9EvqzyNbYIZcLq9uI1GFXYCcBJH2WDzabK4dC9qZDaof2UMjSPj5rBEaL
EOZv/Yn+EaN5IoIo65MIVyPzB5dSyFuh2MZkBlXpH0c2JhIY/d/hd+7ZmxdjEVib
CcBiBHi+QP+CJhQ5gKDFtqwXiU1hlff560NFpfDfFVNWtyeXN+2I1caEftRybYsq
R+V/boJKSK+HygyNlKxY8bpZq2p/9eC2hndeJNI1rXdzXuv/if4+ZC9ZqKlDOLbz
3zOHzMjHAl33uUVpQhJR11x+KmAnkTPBZ0Mn3Jv1AtAL/3FCOkNDwBx2CXjUnUxC
HzRLcURjKRctjATnpd2tJwtuJZUyFxY0dcysRK0/+C/DD0Rj78aECIXald7npdDl
MVk5SNplY1WpWkzdM8rwYWYuskHpU5IWB2haq6FLju6vq6ABEQYlg95OskrjZOih
QPW2aN7CPgKfCilVhS1Ur3r4t6FxX/w33rEuJNeVaNsn2jFuQrVLeff1iHoXeRNg
832gbMNIdJnSEV18tXizFVwvC3s1GWKiBLk7spSLTuxGaYQr82Na9DyBTdsqj/0a
V2AttQ1GeTlDN/GjmqQrpfDYG6LJK7SRsXSmqsXR6J7187gSfRoLMzivYMaxJGsj
qgbreq98AzZ1z5GiHQKL0NFRHaoHlTSMprrjhLsnIy+sBV+8t/g=
=pWXg
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
