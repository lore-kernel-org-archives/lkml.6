Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0F6214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfAJKgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:36:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35420 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:36:46 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 849378089B; Thu, 10 Jan 2019 11:36:37 +0100 (CET)
Date:   Thu, 10 Jan 2019 11:36:42 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        AIAMUZZ <muzafsh.113@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Magic Sysrq key option ... What is the option to record the boot
 logs to my hard disk before i issue a reboot command ?
Message-ID: <20190110103642.GA8228@amd>
References: <CAC_t1uu7DDwA6do9sXnNhjcY4T=Q5PhmP2JtejSJ+FfpwJkaeg@mail.gmail.com>
 <20181119184803.GB19377@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20181119184803.GB19377@thunk.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-11-19 13:48:03, Theodore Y. Ts'o wrote:
> On Mon, Nov 19, 2018 at 08:51:17PM +0530, AIAMUZZ wrote:
> > Hi,
> >=20
> > I have this nagging and frustrating boot freeze i often face on my
> > Deepin OS boot ... Deepin OS i think uses 'journalctl' to record logs
> > on its system.
> >=20
> > 'journalctl' however seems to record boot logs ONLY for successful
> > boots ... boot logs for instances of boot freezes/hangs that are
> > issued with a ... 'Ctrl+Alt+Del' ... key combination or the ... Magic
> > Sysrq 'b' ... key combination to get out of the frozen/hung machine
> > state are just not aved in the 'journalctl' log ...
> >=20
> > Is there any option using Magic Sysrq that will enable me to record
> > the failed/frozen/hung boot information to a file for troubleshooting
> > before i reboot the system using the option 'b' ?
> >=20
> > If not ... Isn't it a good idea to have such an option added to Magic
> > Sysrq options, that can save/record the boot/system logs upto that
> > point, until just before we restart the machines ?
>=20
> This is a hard problem to solve, because there's no place to store the
> information, at least not in the general case.  The problem is on an
> unsuccessful boot, the root file system may not have been mounted yet.
> Heck, the storage devices might not have been probed at all!
>=20
> If your hardware has a place to store dmesg output across reboots (via
> one of the CONFIG_PSTORE_* kernel configuration options) then this
> would be an easy problem --- in fact, it would be the default even
> with out needing a magic sysrq to request it.  The problem is that
> most x86 devices do not have hardware capable of supporting
> CONFIG_PSTORE.  If you have a custom BIOS which doesn't clear memory
> across a warm reset, that would make things easy.  Unless, unless you
> are a big cloud company using custom hardware and/or a custom BIOS,
> life is much more difficult.  :-(
>=20
> One alternative solution you can use is to simply use a serial
> console, and have a another computer monitoring the output from the
> serial console.  This will allow you to see all of the kernel

Serial ports are not very common these days :-(.

Ethernets are, and we have netconsole, maybe that can be used?

(Actually, I wish we had sysrq key "configure netconsole up and
re-send the dmesg buffer". Could be enabled all the time, and would
eliminate frustration of looking at blinking capslock LED and thinking
"I wish I knew what is in the buffer at the moment"....)=20

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw3IDkACgkQMOfwapXb+vIjIwCePdfw96evN/LcBiIXTOw6obY1
lKkAoLcqflcArmkewJebpmXVjbg1NVPD
=cQkv
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
