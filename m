Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2173738-1517953870-2-16287960388189881192
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
    t=1517953869; b=w5MWsbUW6xYgCbne9etvu02Rw/IPJ34BuMqj4kDv8GmB+ru
    zYv6VAsfUUPUX04yj0BZrf/bsZFlaKhYOBSvR/FON5SHiN8xS7jh/l7VNiXy9Fy0
    CRgnBfXfmfEvZk4P5ueGK+MRWtplsJVfJVkK74r+KYAeyoXp8RGVlbTy2gR+9log
    33iHEOV4loke4pferJ6Z653abAnz7lmheILzZgMSdL2XjA9Shxw3rL/YtlWm4avA
    k+5YlobtyWgT9DAHpFiyfmDeY0FlGV06r+VC6mWpMWH0+wPE4kwnyLkxVu7Gv5Bi
    h4YChWLBpM6rzmidIF42UYT9ZwE/F04AOqJyvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517953869; bh=aH73DZ5JqjrSH26H2NYCaUmd4o
    ngHvYHd33Yd5PiH0o=; b=sGYtheqw0gMJ8/N5pn2doML7ZuXm3U/c9GDruFMBhN
    DqwM138JlPWxi2Y+zzcPohHYwghu6LQ5lmarsSxpFUnX/sX9HlQetfAdJow0UEE/
    97VugwH3EfwnYydDQlkNts+0l42q5Zt4iKTaWmdY4G98uIaVkbId+uMrvl4M5yY8
    UO8Kec2USZUxfGgkYWvVg3iqJpzlvHftHwCKyuBDHjfsPibpvl0o+fnHP6fhmwgZ
    QsTLW/9rHkv7aud4SzPX+/LuH+eJAvrKi9PmIL5DOF4oFii0/+xePiNizNYRL076
    7eA3+d1eeGrif3FEK+D+QNDMmPzzmq9fYXYm9XZwDeXA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeBFVvH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 16:51:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36136 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbeBFVvG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 16:51:06 -0500
Date: Tue, 6 Feb 2018 22:51:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Message-ID: <20180206215104.GA25631@amd>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd>
 <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd>
 <20180204111500.GB14797@kroah.com>
 <20180204171736.GA1388@amd>
 <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-02-06 02:02:19, Sasha Levin wrote:
> On Sun, Feb 04, 2018 at 06:17:36PM +0100, Pavel Machek wrote:
> >
> >> > > >> *** if brightness=3D0, led off
> >> > > >> *** else apply brightness if next timer <--- timer is stop, and=
 will never apply new setting
> >> > > >> ** otherwise set led_set_brightness_nosleep
> >> > > >>
> >> > > >> To fix that, when we delete the timer, we should clear LED_BLIN=
K_SW.
> >> > > >
> >> > > >Can you run the tests on the affected stable kernels? I have feel=
ing
> >> > > >that the problem described might not be present there.
> >> > >
> >> > > Hm, I don't seem to have HW to test that out. Maybe someone else d=
oes?
> >> >
> >> > Why are you submitting patches you have no way to test?
> >>
> >> What?  This is stable tree backporting, why are you trying to make a
> >> requirement for something that we have never had before?
> >
> >I don't think random patches should be sent to stable just because
> >they appeared in mainline. Plus, I don't think I'm making new rules:
> >
> >submit-checklist.rst:
> >
> >13) Has been build- and runtime tested with and without ``CONFIG_SMP``
> >and
> >    ``CONFIG_PREEMPT.``
> >
> >stable-kernel-rules.rst:
> >
> >Rules on what kind of patches are accepted, and which ones are not,
> >into the "-stable" tree:
> >
> > - It must be obviously correct and tested.
> > - It must fix a real bug that bothers people (not a, "This could be a
> >   problem..." type thing).
>=20
> So you're saying that this doesn't qualify as a bug?

I'm saying that this does not qualitfy as severe enough
bug. stable-kernel-rules.rst describes what bugs are severe enough,
and this is not one of them.

Best regards,
									Pavel=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp6I0cACgkQMOfwapXb+vJtaQCeO4CM+FW1QjGoVcVUqRdPfqMx
rGAAmQEA1D7NoqhRYYevjqcBF7hjDaUO
=MHSV
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
