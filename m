Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A352EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F7E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfAaXeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:34:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41109 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfAaXeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:34:50 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F221980224; Fri,  1 Feb 2019 00:34:39 +0100 (CET)
Date:   Fri, 1 Feb 2019 00:34:45 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Hovold <johan@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>,
        Jiri Slaby <jslaby@suse.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] serdev support for n_gsm
Message-ID: <20190131233445.GA21200@amd>
References: <20190114012528.2367-1-tony@atomide.com>
 <20190118115958.GA5532@kroah.com>
 <20190121105735.GI3691@localhost>
 <20190121170116.GA5544@atomide.com>
 <20190124163932.GZ3691@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20190124163932.GZ3691@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > And without the n_gsm serdev support, it's a mess of some app
> > similar to [5] initializing n_gsm, trying to deal with the USB
> > PHY PM, dealing with Motorola custom packet numbering, kicking
> > GNSS device, feeding data to /dev/ugnss. Hmm I think I've already
> > been there just to be able to type AT commands to the modem and
> > it did not work :)
>=20
> It's a mess indeed, but I'd rather see user-space dealing with until we
> figure out how best to do it in the kernel. ;)
>=20
> > Anyways, for the serdev kernel drivers, the criteria I've tried
> > to follow is: "Can this serdev device driver make user space
> > apps use standard Linux interfaces for the hardware?"
> >=20
> > So for the serdev Alsa ASoC driver, user space can use the standard
> > Alsa interface for setting voice call volume. And for the serdev
> > GNSS driver, user space can use /dev/gnss0.
>=20
> I understand. Both drivers appears to be using AT commands for control.
> It would be interesting to hear what Mark has to say about the codec
> driver too. Moving AT handling into the kernel scares me a bit. If we
> already have a telephony stack to deal with it in user-space, my
> inclination is to let it continue to handle it.

The userspace part of the telephony stack uses ALSA mixers to
do... well... audio mixer configuration for phone calls, and it would
be good if Droid 4 could keep the same interface.

> Modem-managed GNSS is also different from receivers connected directly
> to the host. It's really the modem that drives the GNSS receiver, and
> offers a higher-level interface to the host, for example, by buffering
> output which the host can later request. It may or may not be the
> kernel's job to periodically poll the modem to recreate an NMEA feed so
> to speak.
>=20
> But the end-result of having it accessible through a standard interface
> is of course appealing.

Yes please. On N900, there's special (socket-based) interface to the
GPS... and it si painful.

Plus, it will take some time before modem support on Droid 4
stabilizes... and it would be very welcome to be able to use the GPS
in the meantime.

Best regards,

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

iEYEARECAAYFAlxThhUACgkQMOfwapXb+vJx3ACgofj+yxrp/4p5cuhPEPiAS+O2
nYkAoKvUwdB7quhD5kxVNlzcN+l4sJGs
=jqTU
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
