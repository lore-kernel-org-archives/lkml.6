Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6152BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FBD2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FBD2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJZSwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:52:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39239 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeJZSwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:52:21 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C8146808BD; Fri, 26 Oct 2018 12:15:48 +0200 (CEST)
Date:   Fri, 26 Oct 2018 12:15:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg KH <greg@kroah.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH AUTOSEL 4.14 02/15] s390/hibernate: fix error handling
 when suspend cpu != resume cpu
Message-ID: <20181026101549.GA30955@amd>
References: <20181022102026.40869-1-sashal@kernel.org>
 <20181022102026.40869-2-sashal@kernel.org>
 <20181026090543.GC20200@amd>
 <20181026092214.GA4307@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20181026092214.GA4307@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-10-26 10:22:14, Greg KH wrote:
> On Fri, Oct 26, 2018 at 11:05:43AM +0200, Pavel Machek wrote:
> > On Mon 2018-10-22 06:20:13, Sasha Levin wrote:
> > > From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > >=20
> > > [ Upstream commit 55a5542a546238354d1f209f794414168cf8c71d ]
> > >=20
> > > The resume code checks if the resume cpu is the same as the suspend c=
pu.
> > > If not, and if it is also not possible to switch to the suspend cpu, =
an
> > > error message should be printed and the resume process should be stop=
ped
> > > by loading a disabled wait psw.
> > >=20
> > > The current logic is broken in multiple ways, the message is never pr=
inted,
> > > and the disabled wait psw never loaded because the kernel panics befo=
re that:
> > > - sam31 and SIGP_SET_ARCHITECTURE to ESA mode is wrong, this will bre=
ak
> > >   on the first 64bit instruction in sclp_early_printk().
> > > - The init stack should be used, but the stack pointer is not set up =
correctly
> > >   (missing aghi %r15,-STACK_FRAME_OVERHEAD).
> > > - __sclp_early_printk() checks the sclp_init_state. If it is not
> > >   sclp_init_state_uninitialized, it simply returns w/o printing anyth=
ing.
> > >   In the resumed kernel however, sclp_init_state will never be uninit=
ialized.
> >=20
> > Stable patches should fix one bug, and one bug only.
>=20
> So should upstream patches, but the rule of "stable patches match
> upstream identically" overrules this :)

a) There is no such rule for upstream.

b) You should split the patch if it is important enough.

c) The "stable patches match upstream identically" rule does not
exist. Check the documentation.

:-(
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvS6VUACgkQMOfwapXb+vIGaACfRMWb1/mzL0L/XxOwmw/AphVV
c8EAn3IOm0LpJdXe25NtRVXR1o09joha
=z+53
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
