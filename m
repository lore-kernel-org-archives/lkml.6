Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFBAC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D07208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D07208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933356AbeGJNan (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:30:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56302 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933138AbeGJNam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:30:42 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 012118049F; Tue, 10 Jul 2018 15:30:40 +0200 (CEST)
Date:   Tue, 10 Jul 2018 15:30:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Vibrations on Droid 4?
Message-ID: <20180710133040.GA4391@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20180710101147.lyu65ro4czvrs2da@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-10 12:11:47, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Jul 10, 2018 at 12:02:11AM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > > Do you have vibrations on d4 working?
> > > > I believe I have required drivers enabled, but no luck:
> > > >=20
> > > > user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > > > bind  uevent  unbind
> > > > user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > > > bind  uevent  unbind
> > >=20
> > > Have you checked probe deferrals?
> >=20
> > Not really. Is there easier way to do that than adding printks in the
> > probe function? (I can go through dmesg tommorow).
>=20
> Option 1: https://lkml.org/lkml/2018/7/8/63

I tried this methodq, and no luck.

static int pwm_omap_dmtimer_probe(struct platform_device *pdev)

does not seem to be called.

Its parent is gpio@4805d000 , and that one seems to be present.

user@devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
driver				       driver_override  gpio
gpiochip5  modalias  of_node  power  subsystem  uevent

So I'm now confused.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltEtQAACgkQMOfwapXb+vIgrwCeK6kvpDJt3t59+EQq3uaP5JSI
J04AnR+VSJy8R+0VMkQAVA/Uc0VgjkmP
=vCN0
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
