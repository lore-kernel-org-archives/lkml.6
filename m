Return-Path: <broonie@sirena.org.uk>
X-Cyrus-Session-Id: sloti22d1t05-1315923-1520371895-2-14707481457177737470
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
    t=1520371894; b=Rdsk3xd/XaTShgEdBtEZb7y4BOXS7tX3QWCQasETWAyDxJz
    /QdjapOlYZSocmQbP+aEGQzNFfBaOgLDeBvNgz9vaidHQPiyUhuhLqo3lwg6s/FZ
    H18ZBB8B4HQI7nwmAiwfqVxK0J5LvQ05eh5vBC2nqviEyLTpBqg0mAduSS9UpaR6
    Sm7H+PEEGJMejleJk9RlGRCM+8PowRnB9V6V2qYYbC4xWWwioaVpoFVS7Y4i1bKD
    dcGYiv4Hdukq5cbiJjyLdxccXVcDbxdJQHACEAPCX5llU17Ew0N2hJS9YtOzI0eU
    09t94cs0zKZYFXF9sDfscJgjYDbXqVmjYVcMQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520371894; bh=+q3CaP/v3hJS9mpa7ttlyqUNS/6d6GuvbW8va7VKSaw=; b=h
    my7zX2oxOBVbuYL2Q3jRsVfmq11wyeemZtWOZ6e63RR1EcI+x2vgcVbFT9YoLSv6
    PmcuCidvF3piYAGI3QjBcpk2yNyh0W3KQn6cpAAnoOrvriHAQw0Q5dHORlcu6Vgr
    YLAg+3mq0+N75W20bfXhSVp5rnyIPyVtnm2INsPvI1YW2luT0DgwKwWGCmynCdjW
    iF2o/xp1mcNQGyaJUwGGGliLaA84pteo4nC/XvOkAd3K0pdaxvZOBCKWYUHh+nPy
    6HxqD75t+OEG4+GCHwNIJ+m22JmeR7CZDCHX8yORPBjhARTTmPXUHjk12HNa8NDX
    D+niWaW9zls0Y1VzNkiwA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=V9VK9om2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=172.104.155.198 (heliosphere.sirena.org.uk);
    spf=pass smtp.mailfrom=broonie@sirena.org.uk smtp.helo=heliosphere.sirena.org.uk;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=heliosphere.sirena.org.uk x-ptr-lookup=heliosphere.sirena.org.uk;
    x-return-mx=pass smtp.domain=sirena.org.uk smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=V9VK9om2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=172.104.155.198 (heliosphere.sirena.org.uk);
    spf=pass smtp.mailfrom=broonie@sirena.org.uk smtp.helo=heliosphere.sirena.org.uk;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=heliosphere.sirena.org.uk x-ptr-lookup=heliosphere.sirena.org.uk;
    x-return-mx=pass smtp.domain=sirena.org.uk smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Tue, 6 Mar 2018 21:31:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Alex Shi <alex.shi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
Message-ID: <20180306213129.GG13586@sirena.org.uk>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <20180305124638.GG8588@sirena.org.uk>
 <20180305130859.GB17802@kroah.com>
 <20180306142634.GC13586@sirena.org.uk>
 <20180306172525.GA6618@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c7hkjup166d4FzgN"
Content-Disposition: inline
In-Reply-To: <20180306172525.GA6618@kroah.com>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--c7hkjup166d4FzgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 09:25:25AM -0800, Greg KH wrote:
> On Tue, Mar 06, 2018 at 02:26:34PM +0000, Mark Brown wrote:

> > I'm not far enough into the details to comment on the specifics here;
> > there's other people in the CCs who are.  Let's let people look at the
> > code and see if they think some of the fixes are useful in LTS.  The
> > Android tree does have things beyond what's in LTS and there's been more
> > time for analysis since the changes were made there.

> I suggest looking at the backports in the android-common tree that are
> needed for this "feature" to work properly, and pull them out and test
> them if you really want it in your Linaro trees.  If you think some of

This isn't about getting anything into Linaro specific trees, this is
about getting things into the LTS so that people who are doing the
responsible thing and keeping up to date with LTS get the fixes. =20

> them should be added to the LTS kernels, I'll be glad to consider them,
> but don't do a hack to try to work around the lack of these features,
> otherwise you will not be happy in the long-run.

> Again, look at the mess we have for x86 in 4.4.y and 4.9.y.  You do not
> want that for ARM for the simple reason that ARM systems usually last
> "longer" with those old kernels than the x86 systems do.

Like I say let's let the architecture people review.

> > > So that's why I keep pointing people at the android trees.  Look at w=
hat
> > > they did there.  There's nothing stoping anyone who is really insista=
nt
> > > on staying on these old kernel versions from pulling from those branc=
hes
> > > to get these bugfixes in a known stable, and tested, implementation.

> > I think there's enough stuff going on in the Android tree to make that
> > unpalatable for a good segment of users.

> Really?  Like what?  Last I looked it's only about 300 or so patches.
> Something like less than .5% of the normal SoC backport size for any ARM
> system recently.  There were some numbers published a few months ago
> about the real count, I can dig them up if you are curious.

Really. =20

The Android tree is making non-trivial modifications adding new features
in core bits of the kernel like the scheduler - that's got an impact
which will have follow on validation costs if it's not introduced early
on in the process.

As I have been saying not all the ARM world is the mobile SoCs you are
focused on.  Take for example Atmel who's tree I happen to have to hand
right now, their diff in their v4.9 tree[1] is ballpark similar to the
Android tree in terms of size, smaller than the v4.9 and a similar size
to the v4.14 one.  It's only about 50k lines, about 20k of which is
wholesale removal of a staging driver, another 7k is new DTs for new
boards/SoCs and the bulk of the rest is things like new drivers with few
core changes (spot checks suggest that much of what's added is either
already upstream or on the way).

You can quite happily use many of their parts without ever taking any of
these changes, and it's not just them either.  Personally I've got a NAS
running a standard Debian kernel (which has very few board support
backports) on a sunxi board, works perfectly well and has never had
anything else running on it as long as I've owned it.

> > Yes, there are some people who are stuck with enormous out of tree patch
> > sets on most architectures (just look at the enterprise distros!) - but
> > there are also people who are at or very close to vanilla and just
> > trying to control their validation costs by not changing too much when
> > they don't need to.

> Great, then move to 4.14.y :)

> And before someone says "but it takes more to validate a new kernel
> version than it does to just validate a core backport for the
> architecture code", well...

Like it or not that's the reality of the situation.  It's not that
responsible testing of such changes is trivial but it does really help
people direct their testing and manage their risk.  It's essentially the
same discussion as with the enterprise kernels, and it's about as likely
that people will change their views in the short term.

[1] git://github.com/linux4sam/linux-at91 linux-4.9-at91

--c7hkjup166d4FzgN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqfCLAACgkQJNaLcl1U
h9AbUgf/YP+g0YJ9ND2sXpz6Fd/WFPuVu2tVcfoiFeNeOY7ug94zjnWt7FXzB7SX
YDL6JYK2kjlb3KR841gy4NrsOTMwfajuehbuq6SsqSv1aVLAlSkY1QjnBykhW7V4
FCoHHjYMgiXHOAQriq/gw022wC4YxTog0gIF+SrpCwh++Fs5cQaSvG/2yXDN56/f
8d2j0s3oUk3OJgRuw6GfpPGQc8lNd4tehQiOUdLWyubVLycYrwronYqS2OMhNdxN
HPV0z4eDEWKtl+anz4HCHz64j9m+ICwx86S+cBm32OJd4QXlFZ9dhRGrMCpxF0Kw
ryRdAV2pN28RQcK9xL5sixE3DEgqgg==
=1Vb/
-----END PGP SIGNATURE-----

--c7hkjup166d4FzgN--
