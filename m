Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D108EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E8C214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeL0Ien (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:34:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44936 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbeL0Ien (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:34:43 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CAA3F806D0; Thu, 27 Dec 2018 09:34:35 +0100 (CET)
Date:   Thu, 27 Dec 2018 09:34:39 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     bp@alien8.de, hpa@zytor.com,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, jani.nikula@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        chris@chris-wilson.co.uk
Subject: [regression from v4.19] Re: 4.20.0-rc6-next-20181210, v4.20-rc1:
 list_del corruption on thinkpad x220, graphics related?
Message-ID: <20181227083439.GA30407@amd>
References: <20181108175803.GA10785@amd>
 <154279919462.20217.14259089584802660420@jlahtine-desk.ger.corp.intel.com>
 <20181121115449.GA32455@amd>
 <154296105546.7930.1457928786446716358@jlahtine-desk.ger.corp.intel.com>
 <20181124152352.GA9548@amd>
 <20181208111346.GA5535@amd>
 <20181208112447.GA9663@amd>
 <64409c484c0601e7504ccc0cf8d211b3bb524ebe.camel@linux.intel.com>
 <20181212182902.GA7380@amd>
 <154468977288.4945.12937975200892746470@jlahtine-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <154468977288.4945.12937975200892746470@jlahtine-desk.ger.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > If you think it is useful, I can try to update my machine to
> > > > linux-next.
> > >=20
> > > linux-next is closer to drm-tip, so it's better. Do you have some
> > > specific reason for not wanting to run drm-tip (but linux-next is sti=
ll
> > > ok)?
> >=20
> > I already have build/update scripts for -next, and I trust -next not
> > to store screenshots of my desktop in my master boot record :-).
> >=20
> > Anyway, it does happen with -next. This time, chromiums were running,
> > and crash happened minute? after I exited flightgear. It can be seen
> > in the logs.
> >=20
> > Oh and I might want to mention -- machine was rather deep in swap this
> > time, as in "mouse jumping when starting fgfs" and "could feel the
> > chromium being swapped back in". I might have had this situation
> > before, and just powercycled the machine "because it is so deep in
> > swap that it will not recover".
> >=20
> > top says:
> >=20
> > top - 19:18:24 up 2 days,  8:03,  2 users,  load average: 3.02, 3.45,
> > 3.21
> > Tasks: 141 total,   1 running,  86 sleeping,   0 stopped,   2 zombie
> > %Cpu(s): 18.8 us,  7.6 sy,  3.0 ni, 68.4 id,  1.3 wa,  0.0 hi,  0.9
> > si,  0.0 st
> > KiB Mem:   5967968 total,   663244 used,  5304724 free,    48876
> > buffers
> > KiB Swap:  1681428 total,   170904 used,  1510524 free.   446280
> > cached Mem
> >=20
> > ....but of course that memory is free once everything died.
> >=20
> > Any ideas? Should I go back to v4.19 to see if it happens there, too?
>=20
> linux-next includes very much the same code as drm-tip. There's nobody
> magically reviewing the code more than it is reviewed for inclusion into
> drm-tip, when it is fed into linux-next. So thinking linux-next would be
> some way safer is an illusion.
>=20
> It sounds like having memory pressure expedites the corruption, which
> should make it easier to reproduce and thus fix.
>=20
> So if you could please try drm-tip reproducing AND open a bug in Bugzilla.
> If you are unwilling to do that, it is very difficult to help you
> more.

Website says I have to read and agree to two different pieces of
legalesee, and I'd need to keep track of yet another password... so
you can "communicate" with me.

But you can already communicate with me, over email.

I verified v4.19 is stable -- it worked ok for way more than two days
it usually takes to crash.

                                                                Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwkjp8ACgkQMOfwapXb+vIRmgCdEftYJwTynT2yOypZqXgvWCtu
zaUAn1ITEZYsEFnDtUMaFXj5SZAvruQs
=ciEn
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
