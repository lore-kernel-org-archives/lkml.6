Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1288896-1520245396-2-1641138319851226094
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
    t=1520245396; b=ABVSAAfcrCHOxQB1f7XOEYzpaKk0NW497oKjVp4854lqVA0
    q8CPva3Apn0m/P36KoXFWKWciWFnYBtO4o3G0a1/JC3YJPfLjmqVxpO4aaGgzUeq
    xHDJD5TDS4tDqwfrbwMU9HhmWCbg7136PhvAdzEiELU8DELNVAV6ZVrqtU9/cUxz
    zlDKAiv4LSo9SDi5HxLYYH7hehH8JK7Dlplt92BKrigf8WviiZFsx0Dp7/e5G+Mj
    5UBl2qpas33r37fT1fkLu3afGfaUnvkiXyCfNhhnDYk/O/UnKSBGmnqF4GCgjhkB
    +YJJhCKzdNm09lMNMzXSMarpL1CBZkDQS79ZQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520245396; bh=oXWrH+O7pSRgiHExSu7xrblJPj
    D2WaP/UwPHmEeJZug=; b=rymje+lGAdrjgNPOdw3ej/BmNKJvfm4ypTabkYyzQY
    DGnVjO2z6Tp38WpT6lqoQ7aPWvQ+pjhda82Olij755zplgb7XT7lR6OyFI0z3ThH
    0cS67DyGc01XErRfG7lHhBPYyZEhfo0ki0IzBXTfIClx4uIeDK6HgDEoE/dB7IZm
    ajd83sHT0sZmqUUFOOCNLFWbcClQ4Y0g4Cins4ekDDX0H3kqEgE4oY5eswS25pVc
    1LpmY52OC+QpnOJQGPyAldpYbrv3UOGCeNJjS0D34jk7kaOvy0xLkYALhwqNFAlL
    riqq398CI1NRo7lQ1AlmYWQuUcnZA6fMpUXDgiKDPpTQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=j3pVtheU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=j3pVtheU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933447AbeCEKXN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 05:23:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50166 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbeCEKXM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 05:23:12 -0500
Date: Mon, 5 Mar 2018 10:23:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.9 002/219] spi/bcm63xx: make spi subsystem
 aware of message size limits
Message-ID: <20180305102310.GC8588@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-2-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
In-Reply-To: <20180303222716.26640-2-alexander.levin@microsoft.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 03, 2018 at 10:27:56PM +0000, Sasha Levin wrote:
> From: Jonas Gorski <jonas.gorski@gmail.com>
>=20
> [ Upstream commit 0135c03df914f0481c61f097c78d37cece84f330 ]

Why are there so many more patches for v4.9 than for more recent
kernels?

> The bcm63xx SPI controller does not allow manual control of the CS
> lines and will toggle it automatically before and after sending data,
> so we are limited to messages that fit in the FIFO buffer. Since the CS
> lines aren't available as GPIOs either, we will need to make slave
> drivers aware of this limitation so they can handle them accordingly.

This seems really aggressive for stable...

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdGo4ACgkQJNaLcl1U
h9A5NAf/XWUTCTeu0EARe3vqfY1DRoauR6YUM/0FkEes8wmuiBXdjTp7/85hDIbF
0GrFP06XOnHFOPMuwprvtg/qnDyNtxrY1zeJ6Vy3YCuiu8V+Z5W853Gqf9zzG4LA
PryDZIvhWAKlgwOy7jDxTK+H3j4+p6OkdgdR814mU94ZW9RkEVhm/Y0freJxnRk/
VJNuIAYzLFd0gB48Sn/LfXWMLfy30ibO4PaSAoqtpPiSAPg4H84msVt6sLnjhTBh
jrCggv/gaksfXFM6gw1pTMoXRi2RHeT2STFolZrARl8j7suVCkaPvTCW5tNzW/0o
8xpf4lOQoTqy5kDBHoq9TF4SnIaGvQ==
=dEEQ
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
