Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3192281-1522004357-2-2893034150300181190
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
    t=1522004356; b=qgbBTkuZNVT2/aMG9/TZVwhiQzgzC7QqaJKJnC4RdhccIuT
    Ckf3bJxMUgWo1XY4PylqR2+7t5M1HSLCg+tmwLVsaqHm6hThiMGP/Gq7sWTsJ9TQ
    JnTnYbYOyplR0QcUctu5JApgvXve6lkr+vw0gXuZNyh8Ql7Ia1LEPDhhxgvjFyzk
    hHYMMlJDOE4iD94XyBZk9EWQ92Lbg5UeQOKK4o5rH1G1NGxdIcpkomAzdL++xSCg
    cthWvZB0g8l7AmeKkgT+P/rAsYjQHfsnTgRaFAIrVN5hxDi3tPhXDZp0f36pQYzR
    N6jTTqPYxVbQ3dlgSs6RJLTX9+IgTXXDwtY2Mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522004356; bh=QyDA1sNIY9HGse2WJxqhDsHzQ+
    8NhaJXGTgiC2+vMzc=; b=wtct5ohJ0rxw/VhxzWIxrvrBGyvC0km9gjcNYGh/eh
    d1QwplR6C4A3ttuvp8s9MBFOdGe1dpweg89N75kZRiw9Igftc1sUYH/YCM37jpTe
    acIUyiKiqlrStq7bpQAcJT39RMun0H8HiMR96SL1VCcJPJYEbxThaIs8Q3pulUtj
    w3hkhE1FGJ2hjTD+QjH9tayyr/zH5dyC/+1mIzTEgR+2tscaksORgWH9soqlNMee
    oWcQUDfmeNTpdYPdvuN4amrEvyi0LbDIvJRMQMaklCLj/7ww8tQQOJ1BZsoPZ4Dw
    zc189B/1aeQwJPOLsC2hL6pijkUapsYjv+UyXaQBD0Bw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1753899AbeCYS7B (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Mar 2018 14:59:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44385 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbeCYS7A (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Mar 2018 14:59:00 -0400
Date: Sun, 25 Mar 2018 20:58:58 +0200
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
Message-ID: <20180325185857.GA7582@amd>
References: <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
 <20180325154512.GC5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20180325154512.GC5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it seems
> > to react to AT commands, and in particular reacts to ADT123; (; is
> > important).
>=20
> Is that to dial a voice call?

Yes. And it is ATD123; not ATD.

> > AT+CMGF=3D1
> > AT+CMGS=3D"123"
> > foo^Z
> >=20
> > Works for SMS sending. Good.
>=20
> So what do you use for reading notifying and reading sms?

Well, did not try that, but they should just be displayed in the
serial terminal.

Anyway, "good" solution is to get ofonod running, then use ofone from
here: https://github.com/pavelmachek/unicsy_demo

But parsing AT commands is easy enough that I can probably hack it
together in few days if neccessary.

> > Now, if someone knows what needs to be done to get GSM audio working,
> > let me know. That's something I'd really like.
>=20
> I think it's the cpcap based config to route voice call audio
> to SoC, Sebastian knows the details :)
>=20
> The way to figure that one out is to dump the cpcap registers
> before and during voice call on android with cpcaprw, then
> diff the output for the audio registers. Probably some SoC
> registers need to be diffed too with rwmem or similar tool
> for the mcbsp instance(s) used.

That sounds like hard way to do it. There's source available, I'm now
trying to understand it / fit it into Sebastian's driver.

https://raw.githubusercontent.com/NotKit/android_kernel_motorola_omap4-comm=
on/hybris-11.0/sound/soc/codecs/cpcap.c

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq38XEACgkQMOfwapXb+vLQaACfRbi3fedoNP8KvAVCxGprzpWZ
uZgAoLr5p+ovefk4xKPfs/jf4AtFHpMc
=wPdt
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
