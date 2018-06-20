Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DBAC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392AD20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cVcUZa7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392AD20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753832AbeFTKgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:36:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51160 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeFTKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y4Ozfu1i0GISRIKwPtXkypx6KWn041XeqNiCYZMo2nc=; b=cVcUZa7KOQJIxN3hfG/yqc/QM
        si+yrPgMtfbFZ9GdrTMPnrI57wVFIV5uH/ii5aWxsrSwpy4+AhzuC882dgHj+xSPxizbpdeKQPL9p
        xetH+eZmAYpg/4N8VgTXYez1hHngIdJuXh7zMWk0l3x46qjL79ulzLeqxdvLbv/emuJTM=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVaT1-00029o-6X; Wed, 20 Jun 2018 10:35:59 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVaT0-00022f-Lg; Wed, 20 Jun 2018 11:35:58 +0100
Date:   Wed, 20 Jun 2018 11:35:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change
 notification
Message-ID: <20180620103558.GA6242@sirena.org.uk>
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
 <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
 <2523505.Jaak4fIuPm@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <2523505.Jaak4fIuPm@aspire.rjw.lan>
X-Cookie: No directory.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 10:02:41AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 19, 2018 5:22:06 PM CEST Geert Uytterhoeven wrote:
> > On Tue, Jun 19, 2018 at 4:48 PM Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > On Tue, Jun 19, 2018 at 3:55 PM, Geert Uytterhoeven

> > In v1 (https://patchwork.kernel.org/patch/9996567/), I had a
> > driver-specific "backup_mode" sysfs file.
> > In v2 and later of the driver series (https://lkml.org/lkml/2018/4/18/3=
45),
> > I changed that to use the standard "wakeup" file in sysfs, in response =
to
> > a comment from Mark Brown.

> Well, I'm not convinced that this is the right approach, though.

The original description of the changes made it sound like this
controlled if the power switch would make the device resume from suspend
or not which seems like a wakeup to me.  Honestly as things are I've no
idea what the hardware designers were thinking or how to explain what
this stuff is doing.

> > Do you still prefer a driver-specific sysfs file?

> Yes, I do.

The flip side of that is that either suspend and resume or poweroff are
broken for userspace unless they know about this magic sysfs file which
isn't great either. =20

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqLgsACgkQJNaLcl1U
h9A1WAf/W+iAzmIxCA5P/0REMQRGGV0f8DvyQNyWjw14r2tgeam4ICyj2O9MDiPK
6eBbLg2K2l0Mb8H70GN0pStm68Eu0Cezl3E0h3Reup6iEIJ3vU+AhMlmjW5Fsi+R
wkOJV7DIdicsDCT5laA+D/RESmrZs8xjKDiZCLnkbjlZ/1IH/TQvMsk+9ms5YrSa
odXmHYBBTEwoc/ovHdZeWZXD6JaHYF/59nyXWE9Xi/hPSzHINRuxbiXh5ypAtKxz
bFt+OANtju9USl5yiT7SaONKYKxXsi3XIaR8GlXG7CkkAg0fYWOtwNRdMvfT8tPi
Xg82aAzpzLnDPXh3sbP9L/khnllCEg==
=I5Ee
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
