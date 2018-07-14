Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC65ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C1120871
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C1120871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbeGNUHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 16:07:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43444 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeGNUHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 16:07:25 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8852D80548; Sat, 14 Jul 2018 21:47:17 +0200 (CEST)
Date:   Sat, 14 Jul 2018 21:47:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Willy Tarreau <w@1wt.eu>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180714194716.GA27381@amd>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org>
 <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org>
 <20180501220228.GD7397@sasha-vm>
 <20180502043017.GA11938@1wt.eu>
 <20180502194139.GA18390@sasha-vm>
 <20180502200229.GA12729@1wt.eu>
 <20180714173812.xhfwtcijlxebmn2k@devuan>
 <e1198cd9-9113-d231-d15a-31ac5224b3b1@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <e1198cd9-9113-d231-d15a-31ac5224b3b1@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>The way I see it, if a commit can get one or two tested-by, it's a good
> >>>alternative to a week in -next.
> >>
> >>Agreed. Even their own actually. And I'm not kidding. Those who run lar=
ge
> >>amounts of tests on certain patches could really mention is in tested-b=
y,
> >>as opposed to the most common cases where the code was just regularly
> >>tested.
> >
> >Actually, it would be cool to get "Tested: no" and "Tested: compile"
> >tags in the commit mesages. Sometimes it is clear from the context
> >that patch was not tested (treewide update of time to 64bit), but
> >sometime it is not.
> >
> >This is especially problem for -stable, as it seems that lately
> >patches are backported from new version without any testing.
>=20
>=20
> When I started my own testing some five years ago, most architectures
> did not even build in stable releases. At that time, the only tests being
> done on stable release candidates were a number of build tests, and most
> of the results were ignored.
>=20
> Today, we have 0day, kernelci, kerneltests, Linaro's LKFT, and more, plus
> several merge and boot tests done by individuals. Stable release candidat=
es
> are build tested on all supported architectures, with hundreds of
=2E..
> Sure, testing is still far from perfect and needs to be improved. However,
> requiring that every patch applied to stable releases be tested individua=
lly
> (where ? on all affected architectures ?) would be the wrong
>direction.

Well, 0day, kernelci etc... is nice... until the change is in the
driver. Most of the kernel are drivers, remember?

I don't know. I'd say that if patch is important enough for -stable,
there should be someone testing it. For core kernel changes, that can
be 0day bot, but for drivers...

And problem exists on mainline, too.

Hmm. Patch for obscure driver. Wow, nice, is WellKnownName actually
using that driver? Aha, no, he is not; he is doing global
search&replace, and did not test the patch...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltKU0QACgkQMOfwapXb+vKyRACcDkIDk//KX5XRu/ZqhSvh3P7W
bOcAn2aYayhT2Pg9QPbqg9HRLWGcTkhU
=PPeV
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
