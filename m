Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB2C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADD420671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADD420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeKTUEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:04:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49354 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeKTUEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:04:24 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 824C3806AF; Tue, 20 Nov 2018 10:36:08 +0100 (CET)
Date:   Tue, 20 Nov 2018 10:36:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>,
        alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Message-ID: <20181120093610.GF16916@amd>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
 <20181108171701.4444-4-ayman.bagabas@gmail.com>
 <20181119235713.GB7367@amd>
 <s5hr2fgfcrm.wl-tiwai@suse.de>
 <20181120091039.GA16916@amd>
 <s5hbm6kf6gi.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline
In-Reply-To: <s5hbm6kf6gi.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-20 10:23:25, Takashi Iwai wrote:
> On Tue, 20 Nov 2018 10:10:39 +0100,
> Pavel Machek wrote:
> >=20
> > On Tue 2018-11-20 08:07:09, Takashi Iwai wrote:
> > > On Tue, 20 Nov 2018 00:57:13 +0100,
> > > Pavel Machek wrote:
> > > >=20
> > > > > +#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
> > > > > +#include <linux/platform_data/x86/huawei_wmi.h>
> > > > > +
> > > > > +static int (*huawei_wmi_micmute_led_set_func)(bool);
> > > > > +
> > > >=20
> > > > So we should not be doing this.
> > > >=20
> > > > Thinkpad ACPI module exports its LEDs there, for example.
> > >=20
> > > Both thinkpad_acpi and dell_laptop provide the interface to HD-audio
> > > in the very same way like this.
> >=20
> > Not good :-(. Please don't add new ones, general purpose LEDs should
> > really use LED subsystem.
>=20
> What's the problem with this approach?

You have general-purpose LED, yet you are treating it as "something
special". That means ugly code (quoted above) and lack of flexibility.

For example, if my notebook lacks HDD LED, I can use scrollock LED for
that instead. Or, in reverse way, maybe "mic mute" LED is not useful
for me, and I'd like to use it for notifications instead.

(If the LED was driven by hardware, and always reflected microphone
status, that would be different. But that's not the case AFAICT).


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvz1YoACgkQMOfwapXb+vJllwCdHcI/tlhb2dC+Gk2nGzfzl+es
b0AAnj/CkHkP1ohu7choUS40EEKEZE1B
=HdJf
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
