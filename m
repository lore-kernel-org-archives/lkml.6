Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A8BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128862088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVHRhOYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128862088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966130AbeFOTKG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:10:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40039 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965052AbeFOTKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:10:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id l41-v6so10882278wre.7;
        Fri, 15 Jun 2018 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UeI+DsSZ1K9mje934RlzOP7AAnZ6O+MsXja7HmwZxlE=;
        b=jVHRhOYPBi+JWt/HqRyyg7R6L49f9s1cSdXd0I3ERikW37Eh6dN7osr51nGf4DYxGb
         yesJxYRpIc6gU1iHxPTo0poKbBVuB+0CHBv569YzhR0Zm2r37oZVj17Tbf+phsqatG3M
         NsawLBjNXr9F3tSAD9n7+mT61l2iecZHxL4qXisyjyXytrqNPyGPkkAeL+EKckWgCkQO
         yTJ/HTXO0IByQYPpYxcBaA1qa24HC00LucMXx8GXibp3yqRgKwpkeBxtBzr8U7GKi9AA
         J1o9t6/z2ulixNyY3ylybXk7wWz2K5QsZChcMX1Kb7zD5lJ8zaAVpYm335bLgwLo/kab
         haig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UeI+DsSZ1K9mje934RlzOP7AAnZ6O+MsXja7HmwZxlE=;
        b=ud5Gpjez1XZ+bFzkGXuaVLI1qYcwi3ShvSjUbiPjWku3KqVg/xxag611t+mr8rEOrN
         2IjQgXtbXlKuYykwCWW39JAODTlOw5S7cuGtidTF1EyFPbMSPRURFGtyxjAojlWUSyMO
         H1+8Wn2SFk2dWF0sxcsbhJshh25sgIJ5kp3m26HPkPCt1SIXbD6DpyxWnySAVnZg94H+
         9VnX6q5i54reYYURCLWQz79uOolNoQaSisl451JUNQIQFLfiMFJ63WoGpUyoIXI2AxlP
         7f9VBK7PtpnXGXUCnqde/wYTehDIwSRrTzt8+nvbAe277eNCXX2TgOAzyeRQfpUqxurK
         /GpQ==
X-Gm-Message-State: APt69E3ix88k64VWHEdhEW6u09vBkv1UmEq8Sm7q3IwAKqTzF/JSZnPC
        Hu8jMCIw9tXYqACdKh+ADP8=
X-Google-Smtp-Source: ADUXVKILROjfUfD+apCqOhNqKb2QdrG1MOxuFg/Qhb5mYniXUkqfZkfSD+zTKPTsRq3L89m8kXsfYA==
X-Received: by 2002:adf:f98a:: with SMTP id f10-v6mr2653884wrr.105.1529089801032;
        Fri, 15 Jun 2018 12:10:01 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id j4-v6sm8007963wrr.47.2018.06.15.12.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 12:10:00 -0700 (PDT)
Date:   Fri, 15 Jun 2018 21:09:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180615190959.pqipwnm6a3tf3lxc@pali>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <s5hk1r01acc.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sak2akqrac45d545"
Content-Disposition: inline
In-Reply-To: <s5hk1r01acc.wl-tiwai@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sak2akqrac45d545
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 15 June 2018 14:51:47 Takashi Iwai wrote:
> On Fri, 08 Jun 2018 13:10:57 +0200,
> Pali Roh=C3=A1r wrote:
> >=20
> > Hi! With up-to-date thinkpad_acpi.ko driver on ThinkPad T480s I'm seeing
> > a strange behavior of LEDs which are integrated into mic mute (Fn+F4)
> > and mute (Fn+F1) keys.
> >=20
> > When thinkpad_acpi.ko is not loaded, then mute key is working fine. When
> > pressed, it correctly generates KEY_MUTE on AT Translated Set 2 keyboard
> > input device and also turn on/of mute led. But when micmute key is
> > pressed then, nothing happen. No key event is reported and also led is
> > not turned on/off.
> >=20
> > On the other hand, when thinkpad_acpi.ko is loaded, then both buttons
> > mute and micmute correctly generates input events; mute via AT keyboard
> > and micmute via ThinkPad Extra Buttons. But led is not changed. When
> > thinkpad_acpi.ko is loaded it turn off both leds (mute and micmute) and
> > leds after pressing any of those buttons, leds are not turned on again.
> >=20
> > When thinkpad_acpi.ko is unloaded, then pressing mute button again start
> > switching led on/off.
> >=20
> > So it seems that some init sequence of thinkpad_acpi.ko breaks mute led.
> > And fini sequence of thinkpad_acpi.ko makes mute led working again.
>=20
> Usually the mute LED on Thinkpad is triggered from HD-audio driver
> (sound/pci/hda/thinkpad_helper.c), and it's a soft-bound via
> symbol_request(tpacpi_led_set).  I thought thinkpad_acpi is
> auto-loaded when the module gets bound.
>=20
> A possible explanation would be that TPT480s has neither IBM0068,
> LEN0068 nor LEN0268 ACPI HIDs, hence the driver is not auto-loaded.

I have Debian Stretch kernel (4.9) which does not have LEN0268 alias for
thinkpad_acpi.ko. So thinkpad_acpi.ko is not loaded automatically. But I
have put thinkpad_acpi into /etc/modules and it is now automatically
loaded at boot.

I also compiled upstream version of thinkpad_acpi.ko, loaded it in
Stretch kernel, but it behaves in same way.

Maybe... there could be a problem that thinkpad_acpi.ko must be already
loaded when sound subsystem is doing initialization? If yes, this could
explain it as /etc/modules is loaded at later stage and manually loading
of new version of thinkpad_acpi.ko at runtime does not help when sound
subsystem is already running.

> (In HD-audio driver side, the ACPI ID is checked and the mute LED
>  control is applied only to these three IDs, too.)
> Meanwhile, when you load thinkpad_acpi, it does still recognize some
> device and initialize it.  By the initialization, it goes out of BIOS
> control, and the OS control is expected...   This is my wild guess.
>=20
>=20
> BTW, the reason we have no LED class for these is that we don't want
> to confuse users by providing multiple ways to access to the single
> stuff.  We've had already the mute LED control from the audio driver
> since long time ago, we don't want to drop and enforce the user-space
> solution (that is anyway flakier than in kernel in most cases).

If possible... I would prefer swapped LED behavior: turn led on when
microphone is turned on AND turn led off when microphone is turned off.
Because current behavior is to have turned led off when microphone is
on which seems a bit strange. Also microphone is in majority of time not
used and when is not used it is (or should be) turned off. On the other
hand e.g. CAPSLOCK led is turned on when CAPSLOCK is enabled (and not
opposite) -- which matches uses, it is not used in majority of time.

>=20
> thanks,
>=20
> Takashi

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--sak2akqrac45d545
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWyQPBQAKCRCL8Mk9A+RD
UrtHAJkB5cAenB0sM6BVqgbhZriVYxEaVgCfSNUzJoOmk94jtUKPt0UeA7uh8ws=
=EwWa
-----END PGP SIGNATURE-----

--sak2akqrac45d545--
