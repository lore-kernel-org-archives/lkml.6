Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-641093-1520350898-2-11786482953490390627
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
    t=1520350898; b=ZGbRgofYeb1ZsYlhexPNc9l5VWcQvXxNQ63G3uQaxoOI6+b
    jrQEzA5P+YmQSEU2zmnHpiF0RfuOEBY/WwWfoZeP2/PpFSIBr94eIC54GDueFEWd
    nwmfhCW2BhS2oJ20C/0REXyZAryPpSpFpZJa4BKGonYNNYxZ1VMqAnBZsgwoDyYi
    mZbmet84wQiFiJI3WpSuZhLZeDC1r43PkvW6Nu8VpNrmz995spe7OUxPjoYSeALk
    J3g7rv2gfyNdwFL6Sweumr5CR4UfzRCqnLG794sAHpBfzWJ0/B62ZNOC9ZQGg+0b
    sF5OOiKjwrgodgg/h02YO6xC6aysCxjDt4xY2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520350898; bh=WvzizHzNJuOb0SBb50XuUdHcLP
    hcq/jCVyQVxMY9P94=; b=D0H4MQaCtlZOHcNvHtIzbG9weLP4EKiLjoXQoSGD9g
    UrbdnM7U9k1icfCCko1whfPDeRc7h19x+KkBtaZpGnPqq8mkdzCeMfOYUe7Mg3qb
    fEHJWQTHxnclh5ZsmAkGwLSvpvYDITBQNHTy+WBAvUBZvUQTfyLczwB9V1KqHyrA
    QGIB0XULleXK7qjeahwrCcSM7TjNW+PrB08FVHIguTEjKYIeh40Q2y3rHcCqvU0R
    KEe0Q3tkPgCg1ud5ipXsUIUGVFAzsrjPtoPrUxK3SS04I8hjaNwVwWLAhGhK2M4i
    FFL1lbIAzszMoW3qbpTyuGTVMZb/5NKLKBGHtR3qB6tQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=sPTikNp9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=sPTikNp9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeCFPjr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 10:39:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbeCFPjn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 10:39:43 -0500
Date: Tue, 6 Mar 2018 15:39:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.9 002/219] spi/bcm63xx: make spi subsystem
 aware of message size limits
Message-ID: <20180306153940.GD13586@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-2-alexander.levin@microsoft.com>
 <20180305102310.GC8588@sirena.org.uk>
 <20180305200744.afw64js6wnmyfqrb@sasha-lappy>
 <20180305203533.GP8588@sirena.org.uk>
 <CAOiHx=mmwzDeHq7Vsz-C+ButW34-b1HJgEhGManfz3Cs3WRm8w@mail.gmail.com>
 <20180306142012.GB13586@sirena.org.uk>
 <CAOiHx=n6yEB8Yq6rDjYKdfos0Ha6=8uLY1H-cwduw62d4nWTtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline
In-Reply-To: <CAOiHx=n6yEB8Yq6rDjYKdfos0Ha6=8uLY1H-cwduw62d4nWTtQ@mail.gmail.com>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2018 at 04:33:34PM +0100, Jonas Gorski wrote:

> I would assume that this is true for most systems with a limited SPI
> controller. I would hope that most board designers are sensible enough
> to not add devices that won't work ;-)

With things like firmware downloads the problem is that they can
generally work, they're just horribly inefficient since you have to
chunk them up into multiple operations rather than just pointing the
hardware at a big buffer and letting it get on with things (same problem
as with flash really).

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqetjsACgkQJNaLcl1U
h9BYqgf9Hweq1HR3HmxLk0MmjWrT2oaq3qvHsUvT6ZR2vny/Mmsm7J8kMRp72pDd
UMYnofaiHg5GuXiAufMPhS9sI0t+SwOlnpFVjo+McPYf42+n6OaktM7BQl3kZHA+
wg5x9+/9fQNpSbLtkLkS2SusjcQl8+mWzJct6/UTGTVFimZ/GK2rZFYguIwKIEjw
6pLBRggKwQQQZgPhyXPS4A4aU14znuJul4Z6XXHpDkfv3RD61FqWKyeUxnS3PP9S
qRtHYMkrq7jGrK7LwkG1eadSsroc2efFWzAaNIrikMxbrCn6iMRe/GRN92BpSUby
Joq51JefBCV+hcFCaCqoZ7+8GhkTXg==
=/sMz
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
