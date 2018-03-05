Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2569030-1520282140-2-6334629823453607303
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
    t=1520282139; b=G4O9EQZX4SCSi8evvYtk3L5dfUA6i0Rspl8VVlBMz4WDmBU
    nwBu/0w7HesTUP/jje9aDf6WKwNWmYXUl+35McRVvsjeudw7RUnT47huA7NZ5PcC
    VC/o7jefvgV3B8ZB7MdYp/ZoA1GS0cJoSBHmZxusrL5yxUBfSdowXNvVFLu1cGgo
    U/Fw4EQuitn1PmltMY6coqBPUjRbSztKGVjdJ3xB1aIz7smPlv/Bb+TC09PcLTjk
    2j8VP7wUt4uKuKo8prw2Z2ibDiMwaZTZRQyilvTwpb0Jc/Wt1wIbFx9P3x6hMJOH
    lqTKmaVviDkmi94EOEFSllRPdrvMPac2cFaXzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520282139; bh=fOqP6ZWOzIfsLfY6P+IshXje9z
    SVciwOoFdRRWzDFzM=; b=g7JvNJ1vd2lMSUAlthzU2vBy9/GzNuu1UVhDzTiMDO
    CgQdp1Ws5SjRVJC1Ik8yTqASh7/W9CEmahsv77DeK/7FGywnbDwGiw7f0LxyP2Kq
    YAMXXQ0QYdWPI+dlcCRrpqc6zutcVAXSguE8SCtyXotse2F4IdFkymGV3stqTOdH
    AnoKQmoQEk1C5wC626MURjbuOVOes2VoEDN+1rfwDbxWwPjexgisImtSUnEQG6rw
    exm10YNJc0GkQUjX92Y5+pshHtnacwFH6rwdpTura9RAHcPUHhETyd9EBXpi+6r8
    BMczSYKjdwQUan2nJU0XHwCETblrfpi6qO7PbkO6X4zw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=mpyT8+0v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=mpyT8+0v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeCEUfg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 15:35:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33244 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeCEUff (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 15:35:35 -0500
Date: Mon, 5 Mar 2018 20:35:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.9 002/219] spi/bcm63xx: make spi subsystem
 aware of message size limits
Message-ID: <20180305203533.GP8588@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-2-alexander.levin@microsoft.com>
 <20180305102310.GC8588@sirena.org.uk>
 <20180305200744.afw64js6wnmyfqrb@sasha-lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QAdlk5ze2izLk3Ap"
Content-Disposition: inline
In-Reply-To: <20180305200744.afw64js6wnmyfqrb@sasha-lappy>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--QAdlk5ze2izLk3Ap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2018 at 08:07:46PM +0000, Sasha Levin wrote:
> On Mon, Mar 05, 2018 at 10:23:10AM +0000, Mark Brown wrote:
> >On Sat, Mar 03, 2018 at 10:27:56PM +0000, Sasha Levin wrote:

> >> The bcm63xx SPI controller does not allow manual control of the CS
> >> lines and will toggle it automatically before and after sending data,
> >> so we are limited to messages that fit in the FIFO buffer. Since the CS
> >> lines aren't available as GPIOs either, we will need to make slave
> >> drivers aware of this limitation so they can handle them accordingly.

> >This seems really aggressive for stable...

> Why so?

It's exposing more capability information but it's in the "how did this
ever work without the fix" range, and I'd worry that this might cause us
to do something like start exercising handling code in client drivers
that had never been tested.  Not that I can immediately see any client
drivers in mainline that actually pay attention...  :/

--QAdlk5ze2izLk3Ap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdqhUACgkQJNaLcl1U
h9D7/gf/QX2XDYtZLnyN9uRvKbI4nbHMCFgn4fLytd68R1wr6GzfzQjrX7MFAhnz
PiOKvPIO2rZ5sX/kQg8H9Z1idA02gPNTsEtSglA35GHpM8QW3rsI9t60lKlpt5nm
0IBjS4suC7GGOk9g1Fl5svEDylCZH8uy6yzd4xrdcIvDGtya+9qKVn3iAvNNgLNe
VHpI7cv23tcQg+dISYnlyopUeNZP6kCN+UIadaT+HlyAjevKf+7XT1BSo3hP1LfK
uheiTiDdeuLNsgymMJ7+Dt9KhL0wOvcU4dT/kQ1JOE2PdjZzS/VDMTwNR9MiBKGi
dcebe+aHmW4XfPcgetxZKLftpRGhYg==
=ChrD
-----END PGP SIGNATURE-----

--QAdlk5ze2izLk3Ap--
