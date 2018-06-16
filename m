Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B306FC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCAC208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/AbpLGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCAC208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756546AbeFPPnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 11:43:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46946 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbeFPPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 11:43:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id v13-v6so12593276wrp.13;
        Sat, 16 Jun 2018 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2w/7JMVPIDXYySrNFs0xXFj+rhOCElKZ/6heB5wBGmU=;
        b=u/AbpLGKvhBsDZQGNXdhEvGvNvzOgyyetn/1Ax0/6aoJ45MxCxu78m6HkbxsYhh9kZ
         XGvcHqd56K5JuPKktBJlj/r/WkkxN+tLTTHzQRNBAtHbaI7nu9Ks+Z1ONwr54dbLX2NK
         unmJtTb6EOS3e7sykQ7Bqn6GQatVRXCctHLAYWvp4YeoKC4c62GWJw7si4j7/E++utUR
         lawc/PaokbTJvPfotHvSaA9bNnIR837Ueeys1oVNfoTZ9HnQVbX+gk+WJyIy6Fj92itw
         ZXnv4FPH0yuMbJ9EgVy9BGu/IqelQIeH99I+i8JcXZODvBXzSwgZuy/6z31vZ9YZCK7K
         J1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2w/7JMVPIDXYySrNFs0xXFj+rhOCElKZ/6heB5wBGmU=;
        b=Whyi1ZQVtz3DTPj+IG1RXrg9cH+s1yXFacOehd9uXm/jB8qUb9OWE/3/j1b8Anvuib
         HgZXlMkey5iHSWBohoISfpPvTyQA+SD7TaBlJVEdiv6Dsf1PwQy5e678yCUwTH/vsYmM
         twlyTFpzFb5OOsvI1Bn4F+U0zXgTiJWAfSZjgBfV/tiuIlJ39FjMKgcOJDsrndxJDin5
         ikSPEIApuSH0oG3NLQbsaKV5Ew2Axm5nBYDiuo6vsm0JD6MzVR01BfXkiKube7Gsr+mP
         w/42rS9v7zlzIuzKPEa3O+F94k7anKjLtxeporW3H3w2zhDEyOjm/SP9DXKjr5gzey6/
         ifww==
X-Gm-Message-State: APt69E0dATy/G3o6i65i0uyHxA08yBorwLFrtOzRGcwLsgpn1W5vT5mu
        SdA9CCHWriwm6zwORzwXNHw=
X-Google-Smtp-Source: ADUXVKLYLycWAsIi2SudtMb96XSPlseM9qxy60wvr5AvZs/t7AVXKTGNv/nCnyYmv4PATYohd29TZg==
X-Received: by 2002:adf:f112:: with SMTP id r18-v6mr4961461wro.134.1529163791991;
        Sat, 16 Jun 2018 08:43:11 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y30-v6sm7980990wrd.70.2018.06.16.08.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 08:43:10 -0700 (PDT)
Date:   Sat, 16 Jun 2018 17:43:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180616154309.ualrx2py6ndr5xgz@pali>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <s5hk1r01acc.wl-tiwai@suse.de>
 <20180615190959.pqipwnm6a3tf3lxc@pali>
 <s5hmuvvtdmi.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xo3hws7qzxgkftvu"
Content-Disposition: inline
In-Reply-To: <s5hmuvvtdmi.wl-tiwai@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo3hws7qzxgkftvu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 16 June 2018 09:05:41 Takashi Iwai wrote:
> On Fri, 15 Jun 2018 21:09:59 +0200,
> Pali Roh=C3=A1r wrote:
> >=20
> > On Friday 15 June 2018 14:51:47 Takashi Iwai wrote:
> > > On Fri, 08 Jun 2018 13:10:57 +0200,
> > > Pali Roh=C3=A1r wrote:
> > > >=20
> > > > Hi! With up-to-date thinkpad_acpi.ko driver on ThinkPad T480s I'm s=
eeing
> > > > a strange behavior of LEDs which are integrated into mic mute (Fn+F=
4)
> > > > and mute (Fn+F1) keys.
> > > >=20
> > > > When thinkpad_acpi.ko is not loaded, then mute key is working fine.=
 When
> > > > pressed, it correctly generates KEY_MUTE on AT Translated Set 2 key=
board
> > > > input device and also turn on/of mute led. But when micmute key is
> > > > pressed then, nothing happen. No key event is reported and also led=
 is
> > > > not turned on/off.
> > > >=20
> > > > On the other hand, when thinkpad_acpi.ko is loaded, then both butto=
ns
> > > > mute and micmute correctly generates input events; mute via AT keyb=
oard
> > > > and micmute via ThinkPad Extra Buttons. But led is not changed. When
> > > > thinkpad_acpi.ko is loaded it turn off both leds (mute and micmute)=
 and
> > > > leds after pressing any of those buttons, leds are not turned on ag=
ain.
> > > >=20
> > > > When thinkpad_acpi.ko is unloaded, then pressing mute button again =
start
> > > > switching led on/off.
> > > >=20
> > > > So it seems that some init sequence of thinkpad_acpi.ko breaks mute=
 led.
> > > > And fini sequence of thinkpad_acpi.ko makes mute led working again.
> > >=20
> > > Usually the mute LED on Thinkpad is triggered from HD-audio driver
> > > (sound/pci/hda/thinkpad_helper.c), and it's a soft-bound via
> > > symbol_request(tpacpi_led_set).  I thought thinkpad_acpi is
> > > auto-loaded when the module gets bound.
> > >=20
> > > A possible explanation would be that TPT480s has neither IBM0068,
> > > LEN0068 nor LEN0268 ACPI HIDs, hence the driver is not auto-loaded.
> >=20
> > I have Debian Stretch kernel (4.9) which does not have LEN0268 alias for
> > thinkpad_acpi.ko. So thinkpad_acpi.ko is not loaded automatically. But I
> > have put thinkpad_acpi into /etc/modules and it is now automatically
> > loaded at boot.
>=20
> That's odd.  It's exposed via
>   MODULE_DEVICE_TABLE(acpi, ibm_htk_device_ids);
>=20
> It's been already in 4.9.  At this point, something is fishy.

$ /sbin/modinfo thinkpad_acpi | grep alias
alias:          dmi:bvnIBM:bvrI[MU]ET??WW*
alias:          tpacpi
alias:          acpi*:LEN0068:*
alias:          acpi*:IBM0068:*

No there is no LEN0268 on 4.9.

> > I also compiled upstream version of thinkpad_acpi.ko, loaded it in
> > Stretch kernel, but it behaves in same way.
> >
> > Maybe... there could be a problem that thinkpad_acpi.ko must be already
> > loaded when sound subsystem is doing initialization? If yes, this could
> > explain it as /etc/modules is loaded at later stage and manually loading
> > of new version of thinkpad_acpi.ko at runtime does not help when sound
> > subsystem is already running.
>=20
> Not really.  The HD-audio driver tries to bind with tpacpi_led_set()
> via symbol_request().  i.e. if it's not present, it tries to load a
> module.
>=20
> Check whether hda_fixup_thinkpad_acpi() is called and the symbol gets
> loaded or not.
>=20
> But, I don't think it's worth to debug such an old kernel primarily.

It is default one used by the last released Debian stable version.

> Could you test the latest Linus tree or 4.17.x at least as a test
> basis?

Ok, will do that later.

> > > (In HD-audio driver side, the ACPI ID is checked and the mute LED
> > >  control is applied only to these three IDs, too.)
> > > Meanwhile, when you load thinkpad_acpi, it does still recognize some
> > > device and initialize it.  By the initialization, it goes out of BIOS
> > > control, and the OS control is expected...   This is my wild guess.
> > >=20
> > >=20
> > > BTW, the reason we have no LED class for these is that we don't want
> > > to confuse users by providing multiple ways to access to the single
> > > stuff.  We've had already the mute LED control from the audio driver
> > > since long time ago, we don't want to drop and enforce the user-space
> > > solution (that is anyway flakier than in kernel in most cases).
> >=20
> > If possible... I would prefer swapped LED behavior: turn led on when
> > microphone is turned on AND turn led off when microphone is turned off.
> > Because current behavior is to have turned led off when microphone is
> > on which seems a bit strange. Also microphone is in majority of time not
> > used and when is not used it is (or should be) turned off. On the other
> > hand e.g. CAPSLOCK led is turned on when CAPSLOCK is enabled (and not
> > opposite) -- which matches uses, it is not used in majority of time.
>=20
> Currently the mixer control to change such LED behavior is provided
> only for Dell laptops.  It'd be trivial to port to Thinkpad, though.
> I can provide a patch once after you test with the recent kernels.
>=20
>=20
> thanks,
>=20
> Takashi

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--xo3hws7qzxgkftvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWyUwCwAKCRCL8Mk9A+RD
Uhq6AJ43bcEE+oQ1etKkpYS5XeWAvbh91ACdETFjNhGZM9uGOUPhNAFUQFBtBjQ=
=Qd2z
-----END PGP SIGNATURE-----

--xo3hws7qzxgkftvu--
