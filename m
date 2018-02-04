Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3990538-1517764665-3-9794158994740540036
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
    t=1517764665; b=klb9XDZNC9PFVPNwj5mhAKEpXE6EZz7wvyPWUUe/mKAPupx
    rTum1oGo12q0V5d5m1prC+0R7JAakRMWtvABDf0VZG7klIT1naxUbZ/L0wz/OX1T
    6wz+fZnCf++fhGXydJ4hY1ev/6dOD/PJnMfxzEHBFWqhuNBSd5vuUzF4hpQL9pA5
    WVQjbeWpo2kAwrCy6fTqE4B/DsfLZyIi05suOmPusUH9cz8jIAlNPqf/vxTfk/q2
    Obxg4ZO09bCDstZtVv9Kr18Uw4AOkTtJfDMIH3k/iZi0JvICVSF/0tr58d716U3M
    QDHEdC3rUDKIl4JojIAYXqP2tcpuRrubuNR4Ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517764665; bh=9Af8kj9OwJ9dgIRpDnS29XLY38
    oR2AdTg/wcd8AyZJ8=; b=v71HNfl9KToOKNd/EbMpsxodcS4gx5lUNEEI3nwYoL
    +x1Fxxw/8tOKtuyBfQqQN15UEUUZEWgPr8HfcOZy8Y+ZAUqso6yKIvTI8Jm2LcSU
    9rXmK6QDfUFNGQzbaRhxpYkmOCzW23s2kYtnhwCcKtL91Ml/ppJn2BYDAtgyDLM3
    bJ55RLkQZeiTQk33sgZDlUrnE5138EKzu/s5BWco+W5NhaRRHZlL+r76cIknAwfb
    UY2IVFO8C24P+gGEcgpCUMyUNGCO+dMVo2W/ftr39NbJvCZp+U7KxxRlrwkui2Rf
    vTwWNJcwwLiDP+0DS1jdnMA28mDEuCvdyOVqKXt5gI/w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeBDRRj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Feb 2018 12:17:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60629 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBDRRi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Feb 2018 12:17:38 -0500
Date: Sun, 4 Feb 2018 18:17:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Message-ID: <20180204171736.GA1388@amd>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd>
 <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd>
 <20180204111500.GB14797@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20180204111500.GB14797@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > >> *** if brightness=3D0, led off
> > > >> *** else apply brightness if next timer <--- timer is stop, and wi=
ll never apply new setting
> > > >> ** otherwise set led_set_brightness_nosleep
> > > >>
> > > >> To fix that, when we delete the timer, we should clear LED_BLINK_S=
W.
> > > >
> > > >Can you run the tests on the affected stable kernels? I have feeling
> > > >that the problem described might not be present there.
> > >=20
> > > Hm, I don't seem to have HW to test that out. Maybe someone else does?
> >=20
> > Why are you submitting patches you have no way to test?
>=20
> What?  This is stable tree backporting, why are you trying to make a
> requirement for something that we have never had before?

I don't think random patches should be sent to stable just because
they appeared in mainline. Plus, I don't think I'm making new rules:

submit-checklist.rst:

13) Has been build- and runtime tested with and without ``CONFIG_SMP``
and
    ``CONFIG_PREEMPT.``

stable-kernel-rules.rst:

Rules on what kind of patches are accepted, and which ones are not,
into the "-stable" tree:

 - It must be obviously correct and tested.
 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).
  =20
> This is a backport of a patch that is already upstream.  If it doesn't
> belong in a stable tree, great, let us know that, saying why it is so.

See jacek.anaszewski@gmail.com 's explanation.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp3QDAACgkQMOfwapXb+vI/YACffveTs3Hsz10azlO9o1ZZOYLJ
GU8AoJ1cPi0/+F5IdeTNnCrf+fnwIwFq
=R7Be
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
