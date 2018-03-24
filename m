Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-477182-1521921764-2-6670382813210750783
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521921764; b=oJMt40yOHHm8hMO8MKivNqv/+Ady0Da6dLmS2TnQQlqlKpO
    0e+pHC0OKkgeD3A4JH5lSwqP8peTkoLbwuv/CotrIuIHn4xIZU1jmVQLv1MGd0ju
    qX3N67YsMFAgi1boMVIVpsS6Zpa0/McrYiiUtfYPhupTWFqndftRqrzPB0DFZqX9
    +mShkAOa84TpWK0cm5c7oZnGd81DaQYWWN0pjAcnj+UwEM5P/n66aHJyeVhn99ul
    EwOi1Un9B6DdojJwhOZRZRsuNuMQzO0bk8QF0XYN/06T5BZlQBqpm49lLnpFuPso
    Kea1h8PYld5lnivdpoU6e+6lwG9Kh89P9RtjXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521921764; bh=WZnx0umTbbSmG/7YEHNIr+GTQU
    MRM7pul4cOmcQg2pg=; b=Ebx2gK/6MTBZbCfyvZQTZVyyqOgJykCil+bXjCCcn5
    QGTWuV3VtHdXy6PokJhZsj2ptlhe9jzGW/TidxNT/GlrTgNhCw5b8KsEfDpp86Mo
    Gn1FZUM00g3U5UUefMLKW7graz6WQfi7p5ar8QvU2vCOCahWXggcOAMLz8uS2DMd
    7WGbRdJwjQu9GsRqXfMdinyeWQrKxdauHzxq0YSBtmG/b+UXsMEb3g7/MoZPsbFj
    BDgTJNQYjpzbAiohpw39z3oJAyO4QhmijtdwJG6UPHZW74Ob2CPQVLYjnnkmq+Jw
    sS7E7SxSsIRzUC3XTUT2mdXC7Fd+XjORJ4tle5NXfKKw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeCXUC2 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 16:02:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41745 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeCXUC0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 24 Mar 2018 16:02:26 -0400
Date: Sat, 24 Mar 2018 21:02:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Dan Williams <dcbw@redhat.com>, Sebastian Reichel <sre@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180324200224.GA17857@amd>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20180324142517.GA94954@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-03-24 07:25:17, Tony Lindgren wrote:
> * Dan Williams <dcbw@redhat.com> [180324 14:00]:
> > On Fri, 2018-03-23 at 21:13 +0100, Pavel Machek wrote:
> > > Does ofonod work for you? I could not get that one to work...
> >=20
> > Because it's looking for a Gobi modem but the MDM6600 isn't one and
> > doesn't expose that layout (and doesn't really need to anyway).  I
> > don't think ofono has a generic QMI driver, so you'd either need to for
> > ce it to use the telitqmi or quectelqmi drivers, or write your own
> > generic QMI one.
>=20
> We also get five USB uarts if we add the device id with something
> like the patch below. I don't quite get why we get five UARTS?

Not sure, either. Often more than one uart is useful, you get AT
commands on one, while GPRS data flow on some other.=20

> Also not sure if we should be using drivers/usb/serial/qcaux.c
> instead of qcserial.c?
>=20
> And from what I recall trying it out, adding the USB UARTs
> somehow confused ModemManager I think, that needs to be retested
> though :)
>=20
> And the USB UARTs added do not offer the same set of AT commands
> as the n_gsm serial mux.

Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it seems
to react to AT commands, and in particular reacts to ADT123; (; is
important).

AT+CMGF=3D1
AT+CMGS=3D"123"
foo^Z

Works for SMS sending. Good.

(And... Thanks!)

Now, if someone knows what needs to be done to get GSM audio working,
let me know. That's something I'd really like.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq2rtAACgkQMOfwapXb+vIfzwCfbqg02z0w/RbRCCJLVbkTsu7v
8doAn2cEZIYwoYurIUkBq7xfk5hI/gLE
=mWT6
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
