Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3102187-1517735138-2-1785470547814171389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517735138; b=Z9udEnytBdstjavxXDV9OVrCAY5Ii8BhttyszbwDW1FFDAg
    laauefytDSHQLvdpihG5SkHV8CBI32J486yMFeJJmw45TTvkAVPSXNQOht6tmTy5
    vkm0R31PES40z3Z31oG/WILzAQnHJOgJK92ZAio4LYMN8FiUO3yTdKy4bs3nxPMp
    JmPNneKNNJlglGoIxAlIgJ7C3ajfNUgyTJLLXq7u7AjmhnqdJCXrWPf46Iu7DBsr
    nE3fp85yaOkhZJMGDwj2RT0ATSR3zSpfkj8GP/iVY40H1wOwUS7RjBtjvn3sCcjt
    5M66kpF7qKT5pXKH7rSOw4IgHqQ7FouIgtZJQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517735138; bh=m6e7MLBxef3duup+8V6+MBiLBX
    b1Gq6ribgG5PLNH+E=; b=NRwIZD+YlbxhWVc5CEov3y5fbEonfZhgjLtTSoczVG
    FA1LN413llnCAucOj4LqLq0YrqJLzJJHF5qVK6tPgXXXo1lzCBUqlB+0u2BJkkzY
    gIGjQ89rVKd7UbOToW9fjMH4sO46zWYIyH0psnwrtm6t0RsXCWCJKGeogAUMaadU
    tn1GhEGoDTALygbPbopLy/ZzJe4mDYlBBhlnyD7Ec/uuA6+3TP4M0UWCC+XeRn6H
    D+RWafHxN5+KPnYCqIPwBxKPIVS/PLx3BFhsVD2vchD2Udu5UFkjmo5Bvrc8GDDQ
    650RF2YIu7XqaW5bLYcmnpqV1xcE/uDrLqv8hILIV4AQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbeBDJFg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Feb 2018 04:05:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47078 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeBDJFd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Feb 2018 04:05:33 -0500
Date: Sun, 4 Feb 2018 10:05:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Message-ID: <20180204090531.GA29468@amd>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd>
 <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-02-04 00:30:36, Sasha Levin wrote:
> On Sat, Feb 03, 2018 at 09:35:26PM +0100, Pavel Machek wrote:
> >On Sat 2018-02-03 18:00:59, Sasha Levin wrote:
> >> From: Matthieu CASTET <matthieu.castet@parrot.com>
> >>
> >> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
> >>
> >> With the current code, the following sequence won't work :
> >> echo timer > trigger
> >>
> >> echo 0 >  delay_off
> >> * at this point we call
> >> ** led_delay_off_store
> >> ** led_blink_set
> >> *** stop timer
> >> ** led_blink_setup
> >> ** led_set_software_blink
> >> *** if !delay_on, led off
> >> *** if !delay_off, set led_set_brightness_nosleep <--- LED_BLINK_SW is=
 set but timer is stop
> >> *** otherwise start timer/set LED_BLINK_SW flag
> >>
> >> echo xxx > brightness
> >> * led_set_brightness
> >> ** if LED_BLINK_SW
> >> *** if brightness=3D0, led off
> >> *** else apply brightness if next timer <--- timer is stop, and will n=
ever apply new setting
> >> ** otherwise set led_set_brightness_nosleep
> >>
> >> To fix that, when we delete the timer, we should clear LED_BLINK_SW.
> >
> >Can you run the tests on the affected stable kernels? I have feeling
> >that the problem described might not be present there.
>=20
> Hm, I don't seem to have HW to test that out. Maybe someone else does?

Why are you submitting patches you have no way to test?

Plus... you don't have PC keyboard? You don't have thinkpad notebook?


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp2zNsACgkQMOfwapXb+vId9QCgmDzJ8JPcYRsb7DlBiGAuLgEN
saUAn2lRJlxZVmsUJ61Rt/U4wdJIAbpw
=J69y
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
