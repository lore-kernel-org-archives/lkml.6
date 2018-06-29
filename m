Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E59C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3595927469
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3595927469
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeF2H3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:29:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37944 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeF2H3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:29:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C31BA805BB; Fri, 29 Jun 2018 09:29:12 +0200 (CEST)
Date:   Fri, 29 Jun 2018 09:29:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Willy Tarreau <w@1wt.eu>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-morse: send out morse code
Message-ID: <20180629072912.GB10079@amd>
References: <20180628134227.GA1719@arbeit>
 <20180628185630.GA6095@amd>
 <20180628202955.GA1534@imap.1und1.de>
 <20180628204516.GA29146@amd>
 <20180629064147.GA3219@arbeit>
 <20180629071724.GA10079@amd>
 <CAMuHMdXaPz3ckT1cPZed4e=iwk3nb75UBGC66hm+b+xRDNNnNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXaPz3ckT1cPZed4e=iwk3nb75UBGC66hm+b+xRDNNnNg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-29 09:21:24, Geert Uytterhoeven wrote:
> Hi Pavel,
>=20
> On Fri, Jun 29, 2018 at 9:17 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > > Yeah, well... I don't think decoding sentences in morse code is goi=
ng
> > > > to be much fun.
> > > >
> > > > And we don't really want encoder in kernel. Just do encoding in
> > > > userspace, and use pattern trigger to display it.
> > > >
> > > > For many uses, morse code is "too geeky", and other patterns will be
> > > > used.
> > > >
> > > > Like " X    " for error 1, " X X     " for error 2, " .xX .xX " for
> > > > charging, " .xXx. " for everything okay...
> > > >
> > >
> > > The hardware i'm using is not able to adjust brightness. It can just =
switch the
> > > LED on or off. That's it.
> > >
> > > If anybody is interested i can submit a version 2 of the morse trigge=
r with the
> > > improvements suggested by Greg and Geert. Please let me know.
> >
> > I'd prefer more general pattern trigger.
>=20
> There are two parts here:
>   1. The general pattern trigger (which is not yet upstream),
>   2. A way to supply a string, convert it into morse code, and feed it to
>      the LED subsystem.
>=20
> Given 1 is not yet upstream, I think Andreas solution is fine.
> Once 1 is upstream, 2 can be modified to feed into 1, if available.

There's no reason 2. should be in kernel ("mechanism, not policy").

Given 1. is not really more complicated than the morse
trigger... please just help with pattern trigger if you want this to
happen.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls138gACgkQMOfwapXb+vI9qwCgkOLyrjQtpTdr4NQ1mNsrVbnz
+ggAn1SEUlfJuMI6urjJhj+lEAvSgRQ0
=6+sG
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
