Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E730220824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E730220824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeKXIv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:51:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38521 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeKXIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 03:51:29 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1BB10807C8; Fri, 23 Nov 2018 23:05:21 +0100 (CET)
Date:   Fri, 23 Nov 2018 23:05:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Message-ID: <20181123220523.GA22118@amd>
References: <s5hr2fgfcrm.wl-tiwai@suse.de>
 <20181120091039.GA16916@amd>
 <s5hbm6kf6gi.wl-tiwai@suse.de>
 <20181120093610.GF16916@amd>
 <s5h4lccf58f.wl-tiwai@suse.de>
 <20181120115159.GG16916@amd>
 <s5hzhu4c569.wl-tiwai@suse.de>
 <CAHp75VddanEB-7qQutSWkbSZW4srRzGXkigCMxEP7zJ=KC6iKw@mail.gmail.com>
 <20181122131802.GB13339@amd>
 <s5h8t1l5ish.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <s5h8t1l5ish.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

> > > > > > > You have general-purpose LED, yet you are treating it as "som=
ething
> > > > > > > special". That means ugly code (quoted above) and lack of fle=
xibility.
> > > > > > >
> > > > > > > For example, if my notebook lacks HDD LED, I can use scrolloc=
k LED for
> > > > > > > that instead. Or, in reverse way, maybe "mic mute" LED is not=
 useful
> > > > > > > for me, and I'd like to use it for notifications instead.
> > > > > >
> > > > > > I'm not against adding the LEDs device implementation for any e=
xotic
> > > > > > usage.
> > > > > >
> > > > > > But for the audio mute LED features, you'll need really lots of=
 other
> > > > > > works if it were implemented via leds device.  That's the harde=
st
> > > > > > part, and a few lines of hooks solves it easily in the kernel s=
ide.
> > > > > > That's all about it.
> > > > > >
> > > > > > If you are ready for submitting the real solutions in user-spac=
e side
> > > > > > (patching PulseAudio and whatever all existing sound daemons, a=
nd
> > > > > > creating yet another daemon for non-PA systems (another footpri=
nt,
> > > > > > lovely), and so on), we can happily delete such in-kernel hooks=
 :)
> > > > >
> > > > > I'm not saying we should move it to the userspace.
> > > > >
> > > > > I'm saying this should be "normal" led. drivers/leds/led-huawei-a=
cpi.c,
> > > > > or something. Perhaps this acpi stuff is so similar you don't rea=
lly
> > > > > need .c code.
> > > > >
> > > > > And then there should be a "mic muted" trigger. Similar to
> > > > > drivers/leds/trigger/ledtrig-disk.c.
> > > >
> > > > And who will trigger this, e.g. when the mixer is muted?
> > >=20
> > > Is this settled? I'm encouraged to promote this series to our for-nex=
t branch.
> >=20
> > I'd prefer this to be normal LED and "mic muted" to become normal
> > trigger.
>=20
> But how would you solve the existing problem?
>=20
> As already mentioned, you'll need to hook the LED trigger and the
> actual mixer value change.  This is the biggest missing piece, and
> it's the very reason we have the exported symbol from the platform
> driver side.
>=20
> So, if you prefer in that way, please implement that for the existing
> driver (thinkpad_acpi and dell-laptop) at first.  I'll be really happy
> to get rid of the present ugly solution!  But it's been there just
> because it's not so trivial at all.  FWIW, this must be all done
> inside the kernel; otherwise you'll hit a regression.

I am really have enough work to do at the moment, but let me take a look.

> If the path via leds class can't be achieved quickly, I'd prefer
> taking the current approach at first.  Once after it's done for those
> above, we can apply the same for huawei-wmi later, too.

I'd prefer not adding more mess. Don't expect full solution from me,
but ... I should have something better than what is in the tree rather
soon.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv4eaMACgkQMOfwapXb+vJuAACdH7eG8BCG9j+wfTKoEyj7B3hc
TIsAoI89+VS11+xTUpAodEJdFYwOmH1V
=shKN
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
