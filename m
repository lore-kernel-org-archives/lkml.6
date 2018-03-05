Return-Path: <broonie@sirena.org.uk>
X-Cyrus-Session-Id: sloti22d1t05-1600140-1520254003-2-12591067120463961140
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
    t=1520254003; b=N5NSc/zjZGxsOwFgpi+GuGWfG7SLudMCd472KKBgw6Fi7dU
    be3Olr32M+CVM1+LySBtj6nNzyCCGSf91BTiPP5SKq/sFzttwvf0CEzeDDnuqr+F
    y8oWZtDBj9uVX2WcQ8P8vYl6Z8X8ed81otQJ+3h/fWbn0QfrNjic/mfMuMVj7bLb
    8tXB9x6x65sGVLdms9CHbriXiBfa4nkg2wzalsV8tSdtmz2iGLbfsalE/G34wvcu
    fbQdAsecGe87MEEw3dw6/Gfh4NBMqFG88VvmAqmka6ADIvwQb51aTV4Ymq0OCxpO
    +vESnLF4m/O0/OJ9mRSORQcD/a8fEl5x3XqjDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520254003; bh=JGG2eR9yDTBe9cPihVd8eYM5zwWXAAsPTUCnrBS9Was=; b=R
    TpJXzl3D+GOuZ4V6dgO0k5y50Z2mezFrWt9JG2EuadvZ9S4xnKYk3Ud3+CcfQEjM
    hS8Pwe4t8aNyyXg7ExoQlQVuK6F1rkl7CG7JD4OMON8DB6yhYm9Uyn7JOJqUAn/M
    riK4681AaazjpMpfk49yz+Vl6+7GDIj63YyS6We3Ofnk2MBFdz/3nDfdHzvJT5Qh
    TknGD8e16eIxKHuXbSvNP/7LdJlPRLb0IWZaqLIIdJ+Aaf8xGxusvIIq/mYZNTbq
    BfvDVQfUe5UTprnzWRBaYCXbVLpSGQH7sgOzdRG/JRhz6RvoDIUl8JfgMZbkK2U3
    qbHbs+MxstAinvj3zZtoA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=sAt+5t9K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=172.104.155.198 (heliosphere.sirena.org.uk);
    spf=pass smtp.mailfrom=broonie@sirena.org.uk smtp.helo=heliosphere.sirena.org.uk;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=heliosphere.sirena.org.uk x-ptr-lookup=heliosphere.sirena.org.uk;
    x-return-mx=pass smtp.domain=sirena.org.uk smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=sAt+5t9K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=172.104.155.198 (heliosphere.sirena.org.uk);
    spf=pass smtp.mailfrom=broonie@sirena.org.uk smtp.helo=heliosphere.sirena.org.uk;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=heliosphere.sirena.org.uk x-ptr-lookup=heliosphere.sirena.org.uk;
    x-return-mx=pass smtp.domain=sirena.org.uk smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Mon, 5 Mar 2018 12:46:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Alex Shi <alex.shi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
Message-ID: <20180305124638.GG8588@sirena.org.uk>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Content-Disposition: inline
In-Reply-To: <20180302165415.GB8704@kroah.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 02, 2018 at 05:54:15PM +0100, Greg KH wrote:
> On Fri, Mar 02, 2018 at 05:14:50PM +0800, Alex Shi wrote:
> > On 03/01/2018 11:24 PM, Greg KH wrote:

> > > And why are you making this patchset up?  What is wrong with the patches
> > > in the android-common tree for this?

> > We believe the LTS is the base kernel for android/lsk, so the fixing
> > patches should get it first and then merge to other tree.

> But you know that android-common is already fine here, the needed
> patches are all integrated into there, so no additional work is needed
> for android devices.  So what devices do you expect to use this 4.9
> backport?

See below...

> What is "lsk"?

The Linaro Stable Kernel, it's LTS plus some feature backports.

> But really, I don't see this need as all ARM devices that I know of that
> are stuck on 4.9.y are already using the android-common tree.  Same for
> 4.4.y.  Do you know of any that are not, and that can not just use
> 4.14.y instead?

There's way more to ARM than just Android systems, assuming that getting
things into the Android kernel is enough is like assuming that x86 is
covered since the distros have their own backports - it covers a lot of
users but not everyone.  Off the top of my head there's things like
routers, NASs, cameras, IoT, radio systems, industrial appliances, set
top boxes and these days even servers.  Most of these segments are just
as conservative about taking new kernel versions on shipping product as
the phone vendors are, the practices that make people relucant to take
bigger updates in production are general engineering practices common
across industry.

I mostly talk to chip vendors so I can't off the top of my head name
specific end products with particular kernel versions.  What I can tell
you is that many of the chip vendors care deeply about LTS because their
customers demand it - off the top of my head at least Atmel, ST and TI
ship vanilla LTS kernels with no Android at all into large market
segments.  Some of these chips couldn't usefully run Android so there's
just no Android support, some also have Android available as an
alternative.  Some of them even have very complete upstream support
available with barely any vendor patch required at all (none in some
applications).

Things that are functioning well will inevitably be less visible -
that's good, that means there's less of a pain point there but it
doesn't mean there's not still a support need.

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdPC0ACgkQJNaLcl1U
h9DFPgf+I4W8f3rPq4ujnXX5LdtL6al/nY4Mq8DXWIgEDz2fmYHDo0DO6EkQgNxc
8cMZC25gT6JHAOZdbxGc/caLM1qVHGTsc/bSg/i0eIYkoWFCXxbT69Yyhczc/dNd
0JvkmwGEdclfxbi+3XeG4vXjyZOnpYat+a5dVEkTXZclRkGkH/xgo5axOO6vhCM2
lmQC5LQU/tc0lONC4M7M52EX+lItbcPpdRAlfIrhQINMqWGPPRfG5jdpQq0vlcsU
BGwVufNKUM7JGsKwqFTtiOR4nYrZM5tH3ilux4LcHpmsoAkBDz0P+G7+3MoN1fx3
pMGkINFDSAV2cZAtOk3AQxbnAegTiA==
=oMpy
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
