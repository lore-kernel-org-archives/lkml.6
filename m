Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2602457-1520927440-2-7089178316054526723
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520927440; b=qrymGNUO7FQ0337xlmFJnIZwsHVUMnBiP9Oh3aYRsMpN5S6
    BQI1VESz4pjtRq/9FemyVoknx34Uw7CxBxgRQgjfwAo7Yr+fYariXbfG0Z3ePF7j
    stO6w9MQedemjAvnDVUqNdkJHF1VEFyj3tqANSplprHabumQNwZEjNMxgxCBdHjF
    bqwpqC4ucxDEeOlf59oo5Or4J4ZxG8l7ScjHoi+cmuxJHHxZuHhrUAaJwH3k033Y
    HHHG2l8twINuxRAg7KbNwYP5nY8DGTyjupxONvFciQjKls60LjbWn+LlEV9qJcdk
    kVs+9n/Pnmcd59/97cr1js90F6uMxo4ZR5WM4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520927440; bh=byEht+FVladAeY9b6BSVJSTVn8
    edQH6BPFHNRDySXLI=; b=Vd+8IZkoJs0JlTaC2f9UY0rKGB/BMernUhSB3x+p99
    IGFjF+/6BgxSzuaxe9IjeTVYFuFN0FCeoFRQ5qjG06DykyvuX+PhxfatpdSgXNJA
    rhr3CLVnaTGN+yoe7YFGnUKavZvdBZfieDa0tYQ5CoDKeorKdL/Y5nJ3IvGLnPtj
    9ZJTXIUYicaCBQ1fSlZ2Jd+QEuOni4RWe8eNUgrMzmZS4QuKqUEB2MgNp6IB4MZg
    RP0RCdZfHdA3Gaaudzzi+BgZmDiCdixw4TPNUvKJ2C6UytuF35M6+wJw9ZZrzyiv
    uJKrOrNagR/OLj4WO9RJeUJ8H/qbo7EnxKQ0WiELQz+A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeCMHu0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 03:50:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45293 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCMHuZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 03:50:25 -0400
Date: Tue, 13 Mar 2018 08:50:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Matthias Schiffer <mschiffer@universe-factory.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Message-ID: <20180313075022.GA13394@amd>
References: <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd>
 <20180204111500.GB14797@kroah.com>
 <20180204171736.GA1388@amd>
 <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
 <713113d8-7662-d80c-c62f-af020469d0bf@gmail.com>
 <f072a5c1-95f1-e81b-c629-ebdea723e6f4@universe-factory.net>
 <20180312152811.GB16944@kroah.com>
 <5747831a-b237-aa2c-cb47-9773cd2b5956@universe-factory.net>
 <0cd72fe4-2b98-e6f7-6ae7-530524786cec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <0cd72fe4-2b98-e6f7-6ae7-530524786cec@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > At least 7b6af2c531 ("leds: core: Fix regression caused by commit
> > 2b83ff96f51d") is missing, causing visible regressions (LEDs not workin=
g at
> > all) on some OpenWrt devices. This was fixed in 4.4.121 by reverting the
> > offending commit, but if I followed the discussion correctly, 4.9 should
> > get the follow-up commit 7b6af2c531 instead (like 4.14 already did).
> >=20
> > Jacek's mail I replied to mentions that eb1610b4c273 ("led: core: Fix
> > blink_brightness setting race") should be included in 4.9 as well, but I
> > don't know the impact of the issue it fixes.
>=20
> It doesn't fix any reported issue, but is just an improvement
> aiming at preventing potential races while changing blink brightness.
>=20
> After taking closer look it turns out that for the patches in question
> to apply cleanly we need in 4.9 also a patch which introduces atomic
> bit fields for blink flags.
>=20
> Effectively, here is the list of patches required in 4.9 stable:
>=20
> Revert "led: core: Fix brightness setting when setting delay_off=3D0"
>=20
> followed by:
>=20
> a9c6ce57ec ("led: core: Use atomic bit-field for the blink-flags")
> eb1610b4c2 ("led: core: Fix blink_brightness setting race")
> 2b83ff96f5 ("led: core: Fix brightness setting when setting delay_off=3D0=
")
> 7b6af2c531 ("leds: core: Fix regression caused by commit 2b83ff96f51d")

For the record... there's no serious problem in LED subsystem in
v4.9. Just leave LED subsystem alone in v4.9-stable (reverting any
patches that were backported by some kind of bot that did not even
test them), and things will be fine.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqngr4ACgkQMOfwapXb+vJOAwCglQhsELLghisDZKNOd4Ql6uht
SQEAnA/KmCxz/hDnc1hUasIKmbEwcXD2
=LInh
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
