Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B491FF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F3820870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F3820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeG2NKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:10:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51909 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeG2NKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:10:18 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 81A028063B; Sun, 29 Jul 2018 13:40:06 +0200 (CEST)
Date:   Sun, 29 Jul 2018 13:40:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v2] net: dsa: Remove VLA usage
Message-ID: <20180729114006.GA11104@amd>
References: <20180717041034.GA37382@beast>
 <20180729113806.GC7333@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20180729113806.GC7333@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > We avoid 2 VLAs by using a pre-allocated field in dsa_switch. We also
> > try to avoid dynamic allocation whenever possible (when using fewer than
> > bits-per-long ports, which is the common case).
> >=20
> > Link: http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqP=
XydAacU1RqZWA@mail.gmail.com
> > Link: http://lkml.kernel.org/r/20180505185145.GB32630@lunn.ch
> > Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> > [kees: tweak commit subject and message slightly]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/net/dsa.h |  3 +++
> >  net/dsa/dsa2.c    | 14 ++++++++++++++
> >  net/dsa/switch.c  | 22 ++++++++++------------
> >  3 files changed, 27 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/include/net/dsa.h b/include/net/dsa.h
> > index fdbd6082945d..461e8a7661b7 100644
> > --- a/include/net/dsa.h
> > +++ b/include/net/dsa.h
> > @@ -259,6 +259,9 @@ struct dsa_switch {
> >  	/* Number of switch port queues */
> >  	unsigned int		num_tx_queues;
> > =20
> > +	unsigned long		*bitmap;
> > +	unsigned long		_bitmap;
>=20
> This looks rather confusing. _bitmap -> bitmap_data? bitmap_bits?

Actually, AFAICT that long is not used as a long, but as array of
bits. So maybe char bitmap_data[8] would be more appropriate?

(resend, now with right cc list).
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltdp5YACgkQMOfwapXb+vKbeACcDQsR8Uj+kaHa/Sj4+IOLf6z0
q/gAnjQgCb4rUYgNGQkpu4CMQnQnK/Vv
=kASv
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
