Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-445509-1520346017-2-13413094276131161173
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520346017; b=ww9E1i5qIiS5zQ65Oy5G44PiHyb6ZeaM2p4Wgtpdk/2aBfS
    I5ONkvzSm3bZEsqe0iNevfTiXLb78lqWMVbJ/VOp9RyI8pwIz5VInV7ewZgcHP4G
    5gcYgGPrXYI1PCdnVkcsn0Iln9LIRatPm4vPBrTqg/cGrD/mQ8oF8rIgNgcMGbBJ
    b3ltetJNHENeQ73Q5JoprlTSKrQVUV6Od2k5hSXV23igYc3d3ErrunGyxp0SI2Rs
    w/rNDssvxpHkIF4suFejGNNbqFmpLGRezpHQaOemgtopCHGPbh3A3BpQ2wiHrNJu
    Y+KQ3Aw+BlJY6O47c0rBHFukPg+raIKwUsL12IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520346017; bh=6WHs0U0t1JzSW1p0l29MyjEV29
    dBvELf0h8aMaKg2MM=; b=oyDRUU3gR2cR/K3vvrBab2/hbogoSLNWD4TIVbT3Iv
    Yv8dpeGBopAeQoreAT41xnbsAC4xc3wvhbXS1o2chRIP8g6UdfCNZQ/zdQE7okkQ
    8UAjLw8bd0+V22pW+yGz7o4BUJ2GENKKj+JMKgCkzQYPOaOQwT/Pnxp3nsIW6uRm
    KuMOGTLZMx39BrYNKWYaDfQ1tZvbzCLOU3pTV7a+D4dS9BlfME+Z0xVPIUd+xueQ
    sKLIai8zYw7x7h5LdPfecZU5LeMUYvOVz119VUstSMDPsjjX80ryA+GCk85GXf8n
    xc3Xm+RUwXmf/2uqyiLzokFbm315TNtBK+itfGNFPuHA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=pN50oTVT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=pN50oTVT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeCFOUP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 09:20:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41162 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeCFOUO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 09:20:14 -0500
Date: Tue, 6 Mar 2018 14:20:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.9 002/219] spi/bcm63xx: make spi subsystem
 aware of message size limits
Message-ID: <20180306142012.GB13586@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-2-alexander.levin@microsoft.com>
 <20180305102310.GC8588@sirena.org.uk>
 <20180305200744.afw64js6wnmyfqrb@sasha-lappy>
 <20180305203533.GP8588@sirena.org.uk>
 <CAOiHx=mmwzDeHq7Vsz-C+ButW34-b1HJgEhGManfz3Cs3WRm8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <CAOiHx=mmwzDeHq7Vsz-C+ButW34-b1HJgEhGManfz3Cs3WRm8w@mail.gmail.com>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2018 at 02:42:43PM +0100, Jonas Gorski wrote:
> On 5 March 2018 at 21:35, Mark Brown <broonie@kernel.org> wrote:

> > It's exposing more capability information but it's in the "how did this
> > ever work without the fix" range, and I'd worry that this might cause us
> > to do something like start exercising handling code in client drivers
> > that had never been tested.  Not that I can immediately see any client
> > drivers in mainline that actually pay attention...  :/

> I would assume that most spi client drivers use short messages, so
> they aren't affected unless the max message size is really short.
> m25p80 on the other hand will do arbitrarily large transfers/reads, so
> there it was supported first.

There's a bunch of SPI drivers that do firmware downloads which I'd
expect to be affected, the limit the device has is tiny so it's
relatively easy to bump into it.  It's very rare for devices to be so
limited so unfortunately client drivers don't generally check though.

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqeo5sACgkQJNaLcl1U
h9AQlAf+PKFnqNyb0gydb+DCmkATY/te2KH/VI8Vgq9KpYSJpDIlHPvRjq0PC6LZ
WFxb2+swqs0nOo6zDvMulFnxGt4oP5DimepjOm8ttZj54Htn8vUE+A/p3u6bD9fm
7u9X/O/RmtWDhwuANqxrjd4WAKSYv291ImqfOqSZ4D17PxuPZz9PMvxKstq/kIyD
QhqBxiBey/6wMTLatm4qdmbqoKVn5RdOdWZN7w12w6YBb41H95VL4q/AHFthartp
uocMEmMJf5omrqueS5QMzIDiS2haHE0Ldnuf1Q2rLaSM/+rkgICe5Ii7BOAvAH76
ORHfnPgSOlEBM63AyBr+rW65Bz24eg==
=i/6N
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
