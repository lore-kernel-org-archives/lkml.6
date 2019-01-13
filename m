Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD242C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA71720842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfAMXJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 18:09:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46949 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfAMXJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 18:09:50 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 22179809C5; Mon, 14 Jan 2019 00:09:41 +0100 (CET)
Date:   Mon, 14 Jan 2019 00:09:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: NULL pointer dereference when writing fuzzed data to /dev/uhid
Message-ID: <20190113230946.GA18710@amd>
References: <CAE5jQCch70ZSmGZeA6RQxjXhL=LjgShdj_VZAGmqUzVRPSQBZw@mail.gmail.com>
 <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I just want to note that while these may not be high-priority, they
are still security holes to be fixed.

> > When writing the attached file to /dev/uhid, a NULL dereference occurs
> > in kernel. As I understand, the problem is not UHID-specific, but is
> > related to HID subsystem.
>=20
> Thanks for the report.
> I wanted to tell you that I started investigating the other private
> report you sent us, but couldn't find the time to properly come with a
> fix as the fuzzed data is hard to discriminate from valid data.
>=20
> A couple of notes though:
> - writing to uhid needs to be done by root. Any distribution that
> doesn't enforce that is doomed to have several security issues

We want to protect kernel from root, too.

> - we could somehow reproduce those fuzzed data on a USB or Bluetooth
> connection, but that would require physical access to the device, so
> you are doomed also

Not neccessarily. Imagine a kiosk where PC is protected but keyboard
uses USB connection. If our USB stack is buggy, you are doomed... but
you should not be ;-).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw7xToACgkQMOfwapXb+vJlLACgm4d3vDsB9nJwfr2hXsDb7+K+
yqUAoJgqQ2VnCZ52zQ9eptL+D5k5BLSb
=zVPf
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
