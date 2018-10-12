Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52AFC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797752147C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797752147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeJLR4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:56:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52925 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbeJLR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:56:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4191E80A1D; Fri, 12 Oct 2018 12:24:59 +0200 (CEST)
Date:   Fri, 12 Oct 2018 12:24:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Gleixner <tglx@linutronix.de>, sfr@canb.auug.org.au
Cc:     kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: -next20181010,1011 regression: thinkpad x60 (32 bit) dies during
 boot.
Message-ID: <20181012102459.GA4469@amd>
References: <20181010195920.GA13860@amd>
 <20181010200331.GA13975@amd>
 <20181011180328.GA6740@amd>
 <alpine.DEB.2.21.1810112208200.1457@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810112208200.1457@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > I updated to todays next... and boot crashes with
> > > >=20
> > > > ..
> > > > Call Trace:
> > > > kick_ilb
> > > > trigger_load_balance
> > > > ? active_load..
> > > > scheduler_tick
> > > > update_process_times
> > > > tick_nohz_handler
> > > >=20
> > > > -next20181005 worked ok.
> >=20
> > Problem is still there in today's next.
>=20
> So what came in between -next20181005 and the first bad one? kernel/sched=
/*
> being the first place to look at.

kernel/sched does not seem to contain anything too scary.

I know that -next20181005 works ok, and I know -next20181010 is
bad. Is there easy way to bisect using that information? I can do
bisect between -next and mainline, but that's a lot of patches and
thus not much fun :-(.

In the meantime, I reproduced the failure with T40p. Is there someone
with working x86-32 in -next?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvAdnsACgkQMOfwapXb+vLZ0QCgsolqVO72mtcrnF1uoJ6RlBos
gAkAoIm1jfldXFm020FWi7xAFTSn+eoW
=OZfg
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
