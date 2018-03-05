Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2498535-1520281755-2-12443291205076961542
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
    t=1520281754; b=IWGNbfzHw/xlWmmYBl/tQJDRKln225IK7BL3FCXcBDjX0zz
    UXw8oVBhkblssoGAKDgEMzooN10XOExw+wNlsmMC/+wdn3JUdeod1YWQ4zZBYmDm
    /JfGlxMqeaO3E7SZPT+sSezXCUY99D3V7uCWDzN2eT3Vpwr7QpC7/MJB/O4kg/oI
    MfC2Vks832d8zAKOIXKS/77/w+76bZ9mij/mJ8dwDUNWLxRxn4EEpzwOxRDULPhA
    xLM+3Wv4F2dGMuBxgeGld/WqmbPl2ug80kB1HyfubDeUDOcPzcxL2/rxXbnmjkDf
    pBBxdy/u8Rk7AXhmAkOWKim7C1VS9vaEdLz2zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520281754; bh=Vaw2lRQCwSxXawjQ4uBcKZQKxG
    3peuMdFs3O3eTb8kg=; b=UhG+x8kIsxRGK7rXgnReVF/s5so2O/MdXJhJsD+ivv
    jP+mk7u7F3d7YDBCdUlPAlGnTZOOulieePpabR9359jO8nsJCQ/5p/gdKetFAFhc
    mRHxEBHpMtKmTzFc7fgyKSE/2hAbh1+fiDeahssLWOnex+iIQn3aTUbvvfnT3wbI
    dRsWGBAhQx3+7bJ3PU9Z7rhHvYw2fHtSCG6N5tDHxlK9i0otw9xUApdqArPVtoD6
    /fmKV62TfsyMJQ+41rrbIL0u5xwmazdglTGhwwq6tFvlv/HpECneLiuCba3MYg44
    /r/fPfKB17a4IDDUMezT+Hjo7gZdp9FkGn6oBtHiOrIg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=LlETqBZt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=LlETqBZt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeCEU26 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 15:28:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbeCEU25 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 15:28:57 -0500
Date: Mon, 5 Mar 2018 20:28:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH AUTOSEL for 4.9 111/219] ASoc: rt5645: Add OF device ID
 table
Message-ID: <20180305202853.GO8588@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-111-alexander.levin@microsoft.com>
 <20180305104203.GD8588@sirena.org.uk>
 <20180305200927.rdn35ktxxsnx2hu2@sasha-lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yUmmepPgoWmUqRhm"
Content-Disposition: inline
In-Reply-To: <20180305200927.rdn35ktxxsnx2hu2@sasha-lappy>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--yUmmepPgoWmUqRhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2018 at 08:09:29PM +0000, Sasha Levin wrote:
> On Mon, Mar 05, 2018 at 10:42:03AM +0000, Mark Brown wrote:

> >As the commit message itself says this is not fixing anything, it's
> >defence against future changes.

> I was under the impression that this refers to future HW changes rather
> than code, I'll drop all 3. Thanks!

I think there were more than three - I stopped replying after a bunch of
these in the same pattern.  ICBW though.

--yUmmepPgoWmUqRhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdqIUACgkQJNaLcl1U
h9BmEQf+OQtcBqlzzZBNdkOWGyZVCmONRgdTpO7ewiIxF5pzr+2XrgJwtJmj2Fej
Hrkt9SEJaMw1zkX86H6At/4o3LJ5ish/7CaZFdn+bNLNow/r3luNOmXj/YiSKF5O
7oBgz+TVYVRxLb3NQ3kt0C4CfJSWjVi4cUueXPHoYl0ij22SavUOeYDswfk5BuAs
vrc31EttGAb2AvOy1FfnuLBgxahmdoZLPkN7JitWIiudybgnp3In225s6jLnAxKq
N61uV5VyjBulHzq66e+AjU4s6lm2dTIkXHDAd+rwOt4m2PGzoDqWJfl5zH4nz4Ek
tRoXdLFoplk/lYZbBACHLNd//mrSDg==
=J4Ts
-----END PGP SIGNATURE-----

--yUmmepPgoWmUqRhm--
