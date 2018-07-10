Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3770BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBCB208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBCB208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbeGJJcs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:32:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50723 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeGJJcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:32:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 279078022D; Tue, 10 Jul 2018 11:32:46 +0200 (CEST)
Date:   Tue, 10 Jul 2018 11:32:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: 4.18-rc* regression: x86-32 troubles (with timers?)
Message-ID: <20180710093244.GB31518@amd>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-07-04 14:41:08, Meelis Roos wrote:
> I tried 4.18.0-rc1-00023-g9ffc59d57228 and now=20
> 4.18.0-rc3-00113-gfc36def997cf on a 32-bit server and then some other=20
> 32-bit machines, and got half-failed bootup - kernel and userspace come=
=20
> up but some services fail to start, including network and=20
> systemd-journald:
>=20
> systemd-journald[85]: Assertion 'clock_gettime(map_clock_id(clock_id), &t=
s) =3D=3D 0' failed at ../src/basic/time-util.c:53, function now(). Abortin=
g.
>=20
> I then tried multiple other machines. All x86-64 machines seem=20
> unaffected, some x86-32 machines are affected (Athlon with AMD750=20
> chipset, Fujitsu RX100-S2 with P4-3.4, and P4 with Intel 865 chipset),=20
> some very similar x86-32 machines are unaffected. I have different=20
> customized kernel configuration on them, so far I have not pinpointed=20
> any configuration option to be at fault.
>=20
> All machines run Debian unstable.
>=20
> 4.17.0 was working fine.
>=20
> Will continue with bisecting between 4.17.0 and=20
> 4.18.0-rc1-00023-g9ffc59d57228.

Details of my tests (.config, dmesg, versions) can be found in

https://github.com/pavelmachek/missy/tree/master/db/notebook/lenovo/thinkpa=
d/x60/pavel/2018.3648830947643

(and nearby directories).

									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltEfTwACgkQMOfwapXb+vJUWQCguusi4d+tvXTotTGx2KtCIcs6
erwAn1H9b7EkG69bFzdRIr8+Es5P8/eD
=S3f+
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
