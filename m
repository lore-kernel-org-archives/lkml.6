Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD4DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9382E20837
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9382E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLHLNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:13:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50438 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHLNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 06:13:51 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6435280A0C; Sat,  8 Dec 2018 12:13:43 +0100 (CET)
Date:   Sat, 8 Dec 2018 12:13:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     bp@alien8.de, hpa@zytor.com,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, jani.nikula@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        chris@chris-wilson.co.uk
Subject: Re: v4.20-rc1: list_del corruption on thinkpad x220, graphics
 related?
Message-ID: <20181208111346.GA5535@amd>
References: <20181108175803.GA10785@amd>
 <154279919462.20217.14259089584802660420@jlahtine-desk.ger.corp.intel.com>
 <20181121115449.GA32455@amd>
 <154296105546.7930.1457928786446716358@jlahtine-desk.ger.corp.intel.com>
 <20181124152352.GA9548@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20181124152352.GA9548@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > There's one similar for nouveau in Bugzilla, but it seems like a ge=
nuine
> > > > memory corruption (1 bit flipped):
> > > >=20
> > > > https://bugs.freedesktop.org/show_bug.cgi?id=3D84880
> > > >=20
> > > > Any extra information would be of use :)
> > > >=20
> > > > Regards, Joonas
> > > >=20
> > > > PS. Could you open a bug to Bugzilla, it'll help to collect the
> > > > information in one consolidated place:
> > > >=20
> > > > https://01.org/linuxgraphics/documentation/how-report-bugs
> > >=20
> > > I prefer email... certainly for bugs that can't be reproduced.
> >=20
> > By adding it to the Bugzilla it may be recognized by somebody else
> > who is experiencing a similar issue. Internet points are not deducted
> > for submitting bugs in good faith, even if they get closed as
> > NOTABUG.

Well, your documentation suggests you'll deduce my internet points:

	Before filing the bug, please try to reproduce your issue with the
	latest kernel. Use the latest drm-tip branch from
	http://cgit.freedesktop.org/drm-tip and build as instructed on our
	Build Guide.

:-)

> Feel free to copy from email to bugzilla :-).

Hmm, so it seems it happened again today:

Dec  8 11:45:01 duo CRON[29325]: (root) CMD (command -v debian-sa1 >
/dev/null && debian-sa1 1 1)
Dec  8 11:46:42 duo
org.mate.panel.applet.MateWeatherAppletFactory[3983]:
(mateweather-applet-2:4242): GLib-CRITICAL **: Source ID 14603 was not
found
 when attempting to remove it
 Dec  8 11:54:59 duo kernel: list_del corruption. prev->next should be
 ffff88019283ea28, but was ffff8801411a1c68
 Dec  8 11:54:59 duo kernel: ------------[ cut here ]------------
 Dec  8 11:54:59 duo kernel: kernel BUG at
 /data/fast/l/k/lib/list_debug.c:53!
 Dec  8 11:54:59 duo kernel: invalid opcode: 0000 [#1] SMP PTI
 Dec  8 11:54:59 duo kernel: CPU: 1 PID: 3428 Comm: Xorg Not tainted
 4.20.0-rc1+ #4
 Dec  8 11:54:59 duo kernel: Hardware name: LENOVO 42872WU/42872WU,
 BIOS 8DET74WW (1.44 ) 03/13/2018
 Dec  8 11:54:59 duo kernel: RIP:
 0010:__list_del_entry_valid+0x8e/0x90
 Dec  8 11:54:59 duo kernel: Code: 16 88 d1 ff 0f 0b 48 89 fe 31 c0 48
 c7 c7 08 75 5e 85 e8 03 88 d1 ff 0f 0b 48 89 fe 31 c0 48 c7 c7 40 75
 5e 85 e8 f0
  87 d1 ff <0f> 0b 55 48 89 d0 48 8b 52 08 48 89 e5 48 39 f2 75 19 48
  8b 32 48
  Dec  8 11:54:59 duo kernel: RSP: 0000:ffffc90000223ac0 EFLAGS:
  00213282
  Dec  8 11:54:59 duo kernel: RAX: 0000000000000054 RBX:
  ffff880115a07c40 RCX: 0000000000000000
  Dec  8 11:54:59 duo kernel: RDX: 0000000000000000 RSI:
  ffff88019e2653d8 RDI: ffff88019e2653d8
  Dec  8 11:54:59 duo kernel: RBP: ffffc90000223ac0 R08:
  ffff880193a2ad10 R09: 0000000000000000
  Dec  8 11:54:59 duo kernel: R10: 00000000008e9088 R11:
  2e6e6f6974707501 R12: ffff8801960cb240
  Dec  8 11:54:59 duo kernel: R13: ffff88019283e900 R14:
  ffff880115a07ec0 R15: ffff88019283ea28
  Dec  8 11:54:59 duo kernel: FS:  0000000000000000(0000)
  GS:ffff88019e240000(0063) knlGS:00000000f79c4880
  Dec  8 11:54:59 duo kernel: CS:  0010 DS: 002b ES: 002b CR0:
  0000000080050033
  Dec  8 11:54:59 duo kernel: CR2: 00000000086b0df8 CR3:
  00000001939f6004 CR4: 00000000000606a0
  Dec  8 11:54:59 duo kernel: Call Trace:
  Dec  8 11:54:59 duo kernel: i915_vma_move_to_active+0x1c3/0x510
  Dec  8 11:54:59 duo kernel: ? i915_request_await_object+0xf4/0x280
  Dec  8 11:54:59 duo kernel: i915_gem_do_execbuffer+0xe2f/0x10a0
  Dec  8 11:54:59 duo kernel: ? find_held_lock+0x39/0xb0
  Dec  8 11:54:59 duo kernel: ? kvmalloc_node+0x26/0x70
  Dec  8 11:54:59 duo kernel: i915_gem_execbuffer2_ioctl+0x1b4/0x360
  Dec  8 11:54:59 duo kernel: ? i915_gem_execbuffer_ioctl+0x290/0x290
  Dec  8 11:54:59 duo kernel: drm_ioctl_kernel+0xaa/0xf0
  Dec  8 11:54:59 duo kernel: drm_ioctl+0x323/0x3d0
  Dec  8 11:54:59 duo kernel: ? i915_gem_execbuffer_ioctl+0x290/0x290
  Dec  8 11:54:59 duo kernel: ? posix_ktime_get_ts+0xc/0x10
  Dec  8 11:54:59 duo kernel: i915_compat_ioctl+0x37/0x40
  Dec  8 11:54:59 duo kernel: __ia32_compat_sys_ioctl+0x429/0xe90
  Dec  8 11:54:59 duo kernel: ? put_old_timespec32+0x9/0x10
  Dec  8 11:54:59 duo kernel: ?
  __ia32_compat_sys_clock_gettime+0x67/0x90
  Dec  8 11:54:59 duo kernel: do_int80_syscall_32+0x50/0x100
  Dec  8 11:54:59 duo kernel: entry_INT80_compat+0x7d/0x82
  Dec  8 11:54:59 duo kernel: RIP: 0023:0xf7fd5c42
  Dec  8 11:54:59 duo kernel: Code: 65 8b 15 04 00 00 00 8b 0e 8b 0c
  ca 83 f9 ff 75 0c 89 04 24 89 f0 e8 b3 fe ff ff eb 05 8b 46 04 01 c8
  83 c4 14 5b 5e c3 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00
  8b 1c 24 c3 8d b6 00 00
  Dec  8 11:54:59 duo kernel: RSP: 002b:00000000fff1a014 EFLAGS:
  00203292 ORIG_RAX: 0000000000000036
  Dec  8 11:54:59 duo kernel: RAX: ffffffffffffffda RBX:
  000000000000000a RCX: 0000000040406469
  Dec  8 11:54:59 duo kernel: RDX: 00000000fff1a0bc RSI:
  0000000000000000 RDI: 0000000040406469
  Dec  8 11:54:59 duo kernel: RBP: 000000000000000a R08:
  0000000000000000 R09: 0000000000000000
  Dec  8 11:54:59 duo kernel: R10: 0000000000000000 R11:
  0000000000000000 R12: 0000000000000000
  Dec  8 11:54:59 duo kernel: R13: 0000000000000000 R14:
  0000000000000000 R15: 0000000000000000
  Dec  8 11:54:59 duo kernel: Modules linked in:
  Dec  8 11:54:59 duo kernel: ---[ end trace 0c1e74ccc719c763 ]---
  Dec  8 11:54:59 duo kernel: RIP:
  0010:__list_del_entry_valid+0x8e/0x90
  Dec  8 11:54:59 duo kernel: Code: 16 88 d1 ff 0f 0b 48 89 fe 31 c0
  48 c7 c7 08 75 5e 85 e8 03 88 d1 ff 0f 0b 48 89 fe 31 c0 48 c7 c7 40
  75 5e 85 e8 f0 87 d1 ff <0f> 0b 55 48 89 d0 48 8b 52 08 48 89 e5 48
  39 f2 75 19 48 8b 32 48
  Dec  8 11:54:59 duo kernel: RSP: 0000:ffffc90000223ac0 EFLAGS:
  00213282
  Dec  8 11:54:59 duo kernel: RAX: 0000000000000054 RBX:
  ffff880115a07c40 RCX: 0000000000000000
  Dec  8 11:54:59 duo kernel: RDX: 0000000000000000 RSI:
  ffff88019e2653d8 RDI: ffff88019e2653d8
  Dec  8 11:54:59 duo kernel: RBP: ffffc90000223ac0 R08:
  ffff880193a2ad10 R09: 0000000000000000
  Dec  8 11:54:59 duo kernel: R10: 00000000008e9088 R11:
  2e6e6f6974707501 R12: ffff8801960cb240
  Dec  8 11:54:59 duo kernel: R13: ffff88019283e900 R14:
  ffff880115a07ec0 R15: ffff88019283ea28
  Dec  8 11:54:59 duo kernel: FS:  0000000000000000(0000)
  GS:ffff88019e240000(0063) knlGS:00000000f79c4880
  Dec  8 11:54:59 duo kernel: CS:  0010 DS: 002b ES: 002b CR0:
  0000000080050033
  Dec  8 11:54:59 duo kernel: CR2: 00000000086b0df8 CR3:
  00000001939f6004 CR4: 00000000000606a0
  Dec  8 11:54:59 duo org.mate.panel.applet.WnckletFactory[3983]:
  wnck-applet: Fatal IO error 11 (Resource temporarily unavailable) on
  X server :0.
  Dec  8 11:54:59 duo
  org.mate.panel.applet.MateWeatherAppletFactory[3983]:
  mateweather-applet-2: Fatal IO error 11 (Resource temporarily
  unavailable) on X server :0.
  Dec  8 11:55:00 duo
  org.mate.panel.applet.CommandAppletFactory[3983]: command-applet:
  Fatal IO error 11 (Resource temporarily unavailable) on X server :0.
  Dec  8 11:55:00 duo
  org.mate.panel.applet.NotificationAreaAppletFactory[3983]:
  notification-area-applet: Fatal IO error 11 (Resource temporarily
  unavailable) on X server :0.
  Dec  8 11:55:00 duo org.mate.panel.applet.ClockAppletFactory[3983]:
  clock-applet: Fatal IO error 11 (Resource temporarily unavailable)
  on X server :0.
  Dec  8 11:55:01 duo CRON[30056]: (root) CMD (command -v debian-sa1 >
  /dev/null && debian-sa1 1 1)
  Dec  8 11:55:02 duo
  org.mate.panel.applet.InhibitAppletFactory[3983]:
  mate-inhibit-applet: Fatal IO error 11 (Resource temporarily
  unavailable) on X server :0.
  Dec  8 11:55:09 duo org.a11y.atspi.Registry[4114]: XIO:  fatal IO
  error 11 (Resource temporarily unavailable) on X server ":0"
 =20
Do you see high chance of this being DRM/Intel issue?

> > It sounds like you've hit the same signature twice, so it may very well
> > be reproducible. Does flightgear have some demo mode where you could
> > leave it running a heavy scene overnight?
>=20
> I'm not sure if it was same signature twice. I had two lockups, but
> IIRC only investigated one.

So it is twice now.

> Not really a demo mode. I can put plane on autopilot, but eventually
> gas runs out. (And I guess window needs to be visible for test to be
> effective.) I tried today, but it did not crash.
>=20
> Do you have something else I could run to do the testing?

This time I was not really running anything graphics heavy, except of
chromium playing youtube video.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwLp2oACgkQMOfwapXb+vI0XACdH0satQGXAAMdSigxZkvIDTa2
3oMAoIIJfZkJIezNfuhaXs6ChXNrysoO
=pYnC
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
