Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558AAC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D088020874
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D088020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754117AbeFPHdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 03:33:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58225 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753776AbeFPHdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 03:33:39 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B2AE880548; Sat, 16 Jun 2018 09:33:37 +0200 (CEST)
Date:   Sat, 16 Jun 2018 09:33:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180616073334.GA13880@amd>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <20180615112606.GA3986@amd>
 <20180615113728.h7snxhe2juaqvjyx@pali>
 <20180615123007.nxsymdvr3nj3it5i@khazad-dum.debian.net>
 <20180615190915.cdntdeesc52ei35u@pali>
 <20180615233628.gy2ffgupctheyqof@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20180615233628.gy2ffgupctheyqof@khazad-dum.debian.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri 2018-06-15 20:36:28, Henrique de Moraes Holschuh wrote:
> On Fri, 15 Jun 2018, Pali Roh=E1r wrote:
> > This means that kernel should not export any led class device. Or when
> > exported, then "set" operation should always fail.
>=20
> "not export" is right.
>=20
> > > 2. Otherwise implement it in-kernel, so that userspace cannot unmute
> > >    when the human has activated the "mute" switch, and the LED cannot=
 be
> > >    controlled by userspace to lie (report mute when it is not mute).
> >=20
> > This looks like a good candidate to use led "trigger" interface. Create
> > a mute trigger and attach it to that led device.
>=20
> Maybe, as long as done in-kernel and not possible to mess with from
> userspace.

Question is if we want flexibility or security.

If we want security, going through LED subsystem makes no sense, just
control the LED as hardware would, or let hardware do it.

For full flexibility, just export the LED and use normal mechanisms we
have (such as triggers). root should be allowed to configure the LEDs,
and he can change the kernel, too, so...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlskvU4ACgkQMOfwapXb+vK1RQCeLVrYE7V2GyAon12ifTwHynuY
BBgAoLNGg86oMopWJezrgikBQEkW/03t
=g9hn
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
