Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132BBECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8DF21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8DF21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbeISA2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:28:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33769 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeISA2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:28:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9C6088072A; Tue, 18 Sep 2018 20:54:16 +0200 (CEST)
Date:   Tue, 18 Sep 2018 20:54:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Numan =?utf-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net
Subject: Re: PROBLEM: Keyboard not responding after resuming from
 suspend/hibernate
Message-ID: <20180918185415.GC4501@amd>
References: <20180831215121.1b1f66bf@korsan.localdomain>
 <20180903115313.3cd38b1e@korsan.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <20180903115313.3cd38b1e@korsan.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-03 11:53:51, Numan Demird=C3=B6=C4=9Fen wrote:
> Fri, 31 Aug 2018 21:51:21 +0300 tarihinde
> Numan Demird=C3=B6=C4=9Fen <if.gnu.linux@gmail.com> yazd=C4=B1:
>=20
> >If I put laptop to suspend or hibernate by closing lid, power
> >manager or any other method and then I resume/wake up laptop, keyboard
> >is not responding. My laptop is a Sony Vaio VPCEH2F1E.=20
> >
> >Steps to produce bug:
> >1. Boot
> >2. Put laptop to sleep
> >3. Resume
> >
> >What I expect to happen: Keyboard responds to key press.
> >What happens: Keyboard does not respond but mouse and trackball are
> >working.
> >
> >git bisect point 9d659ae14b545c4296e812c70493bfdc999b5c1c as the first
> >bad commit.
> >
> >Bad commit link:
> >https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=
=3D9d659ae14b545c4296e812c70493bfdc999b5c1c
> >
>=20
> I tried some kernel parameters related to i8042 driver:
>=20
> i8042.debug=3D1 i8042.reset=3D1	keyboard not working
> i8042.debug=3D1 i8042.kbdreset=3D1	keyboard not working
> i8042.debug=3D1 i8042.nomux=3D1	keyboard not working
> i8042.debug=3D1 i8042.noaux=3D1	keyboard working, but touchpad not
> working
>=20
> On some rare occasions, keyboard responds to key press but  it remains
> pressed forever even if I stop pressing it.
>=20
> dmesg output after rebooting with i8042.debug=3D1 i8042.noaux=3D1
> parameters:

You may want to cc linux-input people. See the maintainers.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluhSdcACgkQMOfwapXb+vLxLwCgucNLmKILEiZrBD8/aLwTzDny
oZwAn0DSfg3ewt7MLcx9uXWvR8zHU+QL
=w1qP
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
