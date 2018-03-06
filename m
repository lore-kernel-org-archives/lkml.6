Return-Path: <broonie@sirena.org.uk>
X-Cyrus-Session-Id: sloti22d1t05-540544-1520346400-2-8652956907134499909
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='172.104.155.198', Host='heliosphere.sirena.org.uk', Country='DE',
  FromHeader='org', MailFrom='uk'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: broonie@sirena.org.uk
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520346400; b=BUrc5bptoVBZrLFfGrdqZ3Ow1BcUahwDQQioMtQ4GUksfKX
    5FJJy4e5cb20PCf9hfZsXk+/cwbI0Q2edxLbwWcAQEoptbUdw3jTTRWkCSpBHwPa
    TGAb5jMnEmEMwkk1N89VHzb1y+4IOS2za33SW0ijnvBDJTxC59m87UGM6JMOexbp
    inVH989pbfnosFg65xaMMdEAJmhOwhkM0Mv2fB0lVVG1IcxTDBLGbjNhD3+aEsnT
    EUv87O5MoQ32Yfi7AHPcHzDoQws7iX0miFBOZPefFh7m2leL80fuDMvxacj1kYDC
    4G6seRCDT/WnD2WF1btXpwUGs2x4LeZYXnnpqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520346400; bh=8eFG5YwbIPu4Sa77vPSp9uzJ3SL2e5XCeLjbRSbXHfQ=; b=P
    rpECLbLG4lGwHrxtHMnWUEzZHG1y1JfUAbl5rS74kTWqINdNfrKprcj7WfDuNUL+
    UEDn0uw5kakqe12GqY0f/JL2l67Un9vBf414art/q0aCoztZzvph2tc5ftE9LL2e
    7oVNwI9XlniC7lnViAmL3nJxpkFDrUDfEwlSAoxYeFpMuiXBP0L9Cdk8tRzJQOW3
    hevN4nbQwRh8kySGVpqy8xNFA5IiRRYFKIGnvJ6JUdnyzzozMDRITm3M6SNoL1qw
    8WExqasxdULaVg9cLiNbhidGa2SQ0We5qLjJYPAr7gdLsDXtyQ93y34Y0nS3gySG
    twqscyG3kHWvK2TLpERRA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=NB8gBuwv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=172.104.155.198 (heliosphere.sirena.org.uk);
    spf=pass smtp.mailfrom=broonie@sirena.org.uk smtp.helo=heliosphere.sirena.org.uk;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=heliosphere.sirena.org.uk x-ptr-lookup=heliosphere.sirena.org.uk;
    x-return-mx=pass smtp.domain=sirena.org.uk smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=NB8gBuwv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=172.104.155.198 (heliosphere.sirena.org.uk);
    spf=pass smtp.mailfrom=broonie@sirena.org.uk smtp.helo=heliosphere.sirena.org.uk;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=heliosphere.sirena.org.uk x-ptr-lookup=heliosphere.sirena.org.uk;
    x-return-mx=pass smtp.domain=sirena.org.uk smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Tue, 6 Mar 2018 14:26:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Alex Shi <alex.shi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
Message-ID: <20180306142634.GC13586@sirena.org.uk>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <20180305124638.GG8588@sirena.org.uk>
 <20180305130859.GB17802@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <20180305130859.GB17802@kroah.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 02:08:59PM +0100, Greg KH wrote:

> I know there is lots more than Android to ARM, but the huge majority by
> quantity is Android.

> What I'm saying here is look at all of the backports that were required
> to get this working in the android tree.  It was non-trivial by a long
> shot, and based on that work, this series feels really "small" and I'm
> really worried that it's not really working or solving the problem here.

Unfortunately what's been coming over was just the bit about using
android-common, not the bit about why you're worried about the code.  :(

> There are major features that were backported to the android trees for
> ARM that the upstream features for Spectre and Meltdown built on top of
> to get their solution.  To not backport all of that is a huge risk,
> right?

I'm not far enough into the details to comment on the specifics here;
there's other people in the CCs who are.  Let's let people look at the
code and see if they think some of the fixes are useful in LTS.  The
Android tree does have things beyond what's in LTS and there's been more
time for analysis since the changes were made there.

> So that's why I keep pointing people at the android trees.  Look at what
> they did there.  There's nothing stoping anyone who is really insistant
> on staying on these old kernel versions from pulling from those branches
> to get these bugfixes in a known stable, and tested, implementation.

I think there's enough stuff going on in the Android tree to make that
unpalatable for a good segment of users.

> Or just move to 4.14.y.  Seriously, that's probably the safest thing in
> the long run for anyone here.  And when you realize you can't do that,
> go yell at your SoC for forcing you into the nightmare that they conned
> you into by their 3+ million lines added to their kernel tree.  You were
> always living on borowed time, and it looks like that time is finally
> up...

Yes, there are some people who are stuck with enormous out of tree patch
sets on most architectures (just look at the enterprise distros!) - but
there are also people who are at or very close to vanilla and just
trying to control their validation costs by not changing too much when
they don't need to.  There's a good discussion to be had about it being
sensible for people to accept more change in that segment of the market
but equally those same attitudes have been an important part of the
pressure that's been placed on vendors long term to get things in
mainline. =20

> [1] It's also why I keep doing the LTS merges into the android-common
>     trees within days of the upstream LTS release (today being an
>     exception).  That way once you do a pull/merge, you can just keep
>     always merging to keep a secure device that is always up to date
>     with the latest LTS releases in a simple way.  How much easier can I
>     make it for the ARM ecosystem here, really?

That's great for the Android ecosystem, it's fantastic work and is doing
a lot to overcome resistances people had there to merging up the LTS
which is going to help many people.  While that's a very large part of
ARM ecosystem it's not all of it, there are also chip vendors and system
integrators who have made deliberate choices to minimize out of tree
code just as we've been encouraging them to.

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqepRoACgkQJNaLcl1U
h9DSpQf+JEEi44Jrn3kjFOj4dMxk0MBOPjZWEOsY0OIMHxH0Q60AWRscyhbhiJhg
6sp8AyyT7ZL0UUcO+Pk1gNcS6MxLSSNEVNYDBWV5YUoFAXQdTKLhI8BhsoIrNgZt
a+GoIo7QdY/8mnnEmN3uYQcdGZRyiwm0YnXX5mLbzFlG5YgseS7H/ZJGICGP99ik
GLECi2uWuuYsfxy+E+mWTv6WtBbEol/cFQ0Rmnk6msSRgpzvlAFnyVXdKiBcGpNT
KbtvL9noeb+zlqWMPrt2MLKACqKN9Giih9+3ncZ0qK6fhlsdSCCbHTsUC84YyYkh
tNTXh8VRb49RCvWXL4oROveyLf1Tuw==
=WBKz
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
