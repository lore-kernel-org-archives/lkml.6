Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1293-1519300943-5-706723934237230692
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519300943; b=nDCrC5nrsZY6tpO3VToZXp00FzAUBqUEygm/0A0M+VFNLJK
    LHyDl3oAZktHV9OXMJ8A0bAL9xES5MWUMSZx7sIioN60vLcEi/nZy/G90mGWwZwl
    a3PoySGoDu4yeaR6lOCGZ7DBxH6kTRxwhAeA68O9jR378fcnrFYZZXSQox9RDfCc
    BNCm8eOkRArZLhAgreWelN9IzL55ZB/iR4tKw/h64IBTFZsAj5+NxEw2QVOlx6Rg
    wVQhqLtBaLXdn2aiUyEL6KbZuPxoX2F4zqdcRT4R1HEv/v0g4iaMQommTZXy9wR0
    4aNTNpSMQSC3S+zac+TDfc6pTjZdYeIEQAa8Kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=arctest; t=1519300943; bh=MNltFyud+harjcJMJWS9M1vPw/
    2I1YaTZZ8Y/Ap4cg4=; b=leCJx9xxuZ0fvuzbVXsTNGFS+vcfa5sTQyXcPvvXwJ
    lys2adAcQFFaogH4GmYXjrcuW1K4xcjLhXg6UU95+ebM4pqsLojpZhjQgpOP2se8
    Mq7M4IKpy/MDUcKGLcR2jMq4SA1s8lqjJ/BXtwVcndnoJD3JnyCIHWjWW7aYn+s+
    bWv5uPkKSoSRlaJy001XwDv4CdMjZsuKDG7wi3Zmj1QR1AmPK/odk9SHrzl8BNDb
    oP9IanR9mfeMVvG8NBT2ZNBNGJcXmdfq//5Xxj/EZPvGYv1WlasaG0yuVs/7NK3q
    JtNe2+3z0S9tsT8pSU885h+WgIrxA1R4XK5TohJe8DLg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753770AbeBVMCU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 07:02:20 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:35466
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753749AbeBVMCU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 07:02:20 -0500
Message-ID: <1519300931.2388.17.camel@debian.org>
Subject: Re: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
From: Yves-Alexis Perez <corsac@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 22 Feb 2018 13:02:11 +0100
In-Reply-To: <20180222110835.GA22572@kroah.com>
References: <20180221124432.172390020@linuxfoundation.org>
         <20180221124433.618725458@linuxfoundation.org>
         <87k1v5rg66.fsf@concordia.ellerman.id.au>
         <1519292030.2388.14.camel@debian.org> <20180222110835.GA22572@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-AvVV+t+Fx7N17lJeg0AF"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-AvVV+t+Fx7N17lJeg0AF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-02-22 at 12:08 +0100, Greg Kroah-Hartman wrote:
> Did you look at /sys/devices/system/cpu/vulnerabilities/ to see what the
> files there say?

Unfortunately I don't have access to a powerpc box where I could run a new
kernel and try it on. I'll check with our ppc porters and see if I can get
access to something.

Regards,
--=20
Yves-Alexis
--=-AvVV+t+Fx7N17lJeg0AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlqOsUMACgkQ3rYcyPpX
RFsIZgf/ZxArZerGGKMHnfpY8O7aw8W9gg1E6vMw/M5xtySsZjqkEF266Da4TI8x
ePt+sABfiMVXm8KVw8BgCgO99VesjCYfUJA76D2xx2LzCONNEOp+nvI87Alq6BWp
F208QESLS4O3lYpdx+JhDC2vUBqpWVTEzWhpwq2y6ut1RsNFBoAEgKuqbwYcvuSo
gF2pfBO1/RikpLF1lu2r9LSnoQDWeZBuVgDtzR966AMxodiX9yOVPm4kDgtH26UV
LnuLp5X0W9Ul1d0AtU5DotOMY6enjwwLiQmQJDlK4X88cFDrs1Brq7kpt0PaBgjZ
KA8satFTWYewrv7hA8Gsz1eGKhvTJw==
=xbpX
-----END PGP SIGNATURE-----

--=-AvVV+t+Fx7N17lJeg0AF--
