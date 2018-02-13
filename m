Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-638285-1518546561-2-15570428061786715674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518546561; b=JJgEwsi2jHJK8oWu/ypjsGsW8qpmC2lbuGtJQ6iC7MLQ6Lc
    kOVjO2lH8EkcVWO50uzUVyQFH4a0oje2W+4jh8WI1om+IRWxr+Sg62qFlDbFDqV0
    g9mSPQp3S1ZYOYHY/NTxIiQws6YnStmgo/MluaNKqWENgElVp25E9AOGKagrgTt/
    FZPtCAd94GKUkkBdPce2BCwgWNeosE6ZlnDu649+Hjhv13NQ6eexS0PP0VZeyQpn
    hD5isVuvHzWj02nUa5Pw7Jppn+adQPYvs32FpfosW9Zn3iI4K02/jvLZfcmod84S
    DsZup/DDZWl22FBSr7g1u1GNcYLdvU3wsOxy8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1518546561; bh=YF8zWjUUFXwrQ5ae54uyPp9GQr
    y2wVEkmwRZFQa+2X0=; b=ZEAqt6TEQN86dFJTw8l1VvxLnmYotzpMiGTJPCAnNo
    YS/mTtD3r9xFWmlisIGdaEE2cRI96zE+IPlEjm6PY8Cgu5C3Ae5lThBPR+OXBlIo
    coSKvM/82TP4NgqeVVV53y/LjqPyXZpYyNG8BFFbTqesmaAX72En5uBOEx5xaC5P
    zSgSYUTTWWJqy3fQJt+Fu139GYi9lS2uehCCfvYN+jP4kOV6KilTSy9UOMhAubVc
    ahovmOQXY35KgoB+baBn4OhBwhzfaIcGTM/PxhD3QtWAMyLXICNezpotGdFW/xVw
    B0EdXDCOo+Q1HWHvKzPv3EadcdLfNRSGPVF01m0OTGKA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965399AbeBMS3S (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 13:29:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60233 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965344AbeBMS3S (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 13:29:18 -0500
Message-ID: <1518546535.2617.47.camel@decadent.org.uk>
Subject: Re: [PATCH 3.2 57/79] ALSA: usb-audio: Fix potential zero-division
 at parsing FU
From: Ben Hutchings <ben@decadent.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org
Date: Tue, 13 Feb 2018 18:28:55 +0000
In-Reply-To: <s5hr2pqae1k.wl-tiwai@suse.de>
References: <lsq.1518322802.943358572@decadent.org.uk>
         <lsq.1518322806.943407157@decadent.org.uk> <s5hr2pqae1k.wl-tiwai@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ml8q+OIeh+zg/Un6wEjH"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-ml8q+OIeh+zg/Un6wEjH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-02-12 at 07:59 +0100, Takashi Iwai wrote:
> On Sun, 11 Feb 2018 05:20:06 +0100,
> Ben Hutchings wrote:
> >=20
> > 3.2.99-rc1 review patch.  If anyone has any objections, please let me k=
now.
> >=20
> > ------------------
> >=20
> > From: Takashi Iwai <tiwai@suse.de>
> >=20
> > commit 8428a8ebde2db1e988e41a58497a28beb7ce1705 upstream.
>=20
> Please drop this.  This patch is broken, and was reverted in the later
> commit 3c02a6d94665.

Thanks, I've dropped this from 3.2 and 3.16 patch queues.

Ben.

> thanks,
>=20
> Takashi
>=20
>=20
> >=20
> > parse_audio_feature_unit() contains a code dividing potentially with
> > zero when a malformed FU descriptor is passed.  Although there is
> > already a sanity check, it checks only the value zero, hence it can
> > still lead to a zero-division when a value 1 is passed there.
> >=20
> > Fix it by correcting the sanity check (and the error message
> > thereof).
> >=20
> > Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0=
")
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > [bwh: Backported to 3.2: adjust context]
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  sound/usb/mixer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -1262,9 +1262,9 @@ static int parse_audio_feature_unit(stru
> >  			return -EINVAL;
> >  		}
> >  		csize =3D hdr->bControlSize;
> > -		if (!csize) {
> > +		if (csize <=3D 1) {
> >  			snd_printdd(KERN_ERR "usbaudio: unit %u: "
> > -				    "invalid bControlSize =3D=3D 0\n", unitid);
> > +				    "invalid bControlSize <=3D 1\n", unitid);
> >  			return -EINVAL;
> >  		}
> >  		channels =3D (hdr->bLength - 7) / csize - 1;
> >=20
--=20
Ben Hutchings
friends: People who know you well, but like you anyway.


--=-ml8q+OIeh+zg/Un6wEjH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqDLmcACgkQ57/I7JWG
EQn/vg/8Ddyk2bchhVumhEc0Qvqj7Q3K34FOnhKMmGUN7TTsoNUKk4exoZk5nZXi
d9Y70IuU3yVy43ibCtbBiNhUAvPaAb2OCjxPRsLZ7+rj8jHgGhEWUMtbjuNlCUdI
7a/KBd073IZjzarvhrNeKhazvBZA7JTAgD+YlvigXuqO103SduOYaGgEmo5Dc+L4
sqsKxXopFlwc7SJbdnvaZQt4ZQ2qNxLgOqtgmGzgTODn/Wcw6W8wOlUCv1bgVlQz
tISnAsZKZxCVYNAP0+AhlctDw7Lsq6eZboStPfGbdcGFpgw33KG9YrRS8OdsIdSx
i1ccAIN4w/4pGlOqI/Tka1pCaSlcNnxZo5EKsBC3Hnj/JWlPDycnCNhV5eRiPQ4R
Cct1m4C61siLqo22fSgDDpHjhIqfdhgktti+IN2gU8/p6+rng3GPn3zlMZ9ueOiz
klKRH7r2N/3mmxIGm1U3uCIhSZgwg1QN0p56eG0KZyCIu3JPsyxl7vMCnkVMxLx5
gylSF3U7A01XCEJGFM7SedOc6n3WuZ/JuWDXIpJ6MH+ZAxFoGRkbb1ZGIrxIPwu5
7O7UPPSNtzbjTuU5WPsdUY5y2zJKPsUpuHcVMBYhFVtVbjAT8R30cpfKEzz77y79
Zp3PtZMBl6zw4+MVHhWfSnHUv+sf2Z7AxaKw/hNNe9vnXZDVpXU=
=L0l0
-----END PGP SIGNATURE-----

--=-ml8q+OIeh+zg/Un6wEjH--
