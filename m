Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1288896-1520246553-2-12068292226376661788
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
    t=1520246553; b=OU2JWJEUbqy+h3mkFC8czVB6ed3cK8RHptbYUd5NwPDxuIf
    6gfl/HlTHGklBUWtx3oKgejnB4asnFe+r98k0YzfzgFjUeBOj48MwHg7vRT0WJUm
    Fxj8eAu2OgjPhOQuqqU87hzfjxR0sGcrZknPn8QUNPu0f2PAPrTO0N9Dgn3X0PWF
    Zbfgo6G/zqPc1jKAXUqx+TQJYI+qe92jnxjD+TxFhDELXU4npu2uXDpTRUzhpDS/
    VcUoTBdZDyw7Q8UpTFYNXqZ+hrgrKgsuOU9UamD7snYxtXB8BgfuEODJ5FPWhfou
    igBncS5UdaJmMVMc9B7fmnYsxotgn+5Zkg5juJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520246553; bh=/h6cxqKKt9G9KSuMtRx+sJG1+n
    Ptxyn7UCqNCXBZOlU=; b=p2qCVchHB+dexzHB2fnQuEhYLGHe0TG+xucf8cQe2G
    Ez6xCM1IAxSOSipSXpjjYGBqkcMqiar6wFRjBLjYkCdfYrMT3PhKoUKZfT6sivuv
    r8AL+A3W7LIeyUN/OScNtIz4I0AWXPU0dUmfVQ4K5O4h9+BQglfvv5LYxbaGKfhp
    b/AV1yZ16KYvrjTRK/6mBMKduwL2Hp4Fj0EtPBf11MUD9NfzBt5uA6CnTzV0Lf3J
    kV76o+QSZddIrJpJ3eF5RTHjXgZ72TjIcTAjV9TUNTm4V5hNxMSrIusFPV26700u
    sqfyWwENWLBeeVX6gvw0HunAifxM9tF/kmohlv5xOuVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=Evwle3gW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=Evwle3gW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933444AbeCEKm3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 05:42:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54156 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934353AbeCEKmY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 05:42:24 -0500
Date: Mon, 5 Mar 2018 10:42:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH AUTOSEL for 4.9 113/219] ASoC: wm8978: Add OF device ID
 table
Message-ID: <20180305104222.GF8588@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-113-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline
In-Reply-To: <20180303222716.26640-113-alexander.levin@microsoft.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 03, 2018 at 10:29:01PM +0000, Sasha Levin wrote:
> From: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> [ Upstream commit 5cf015d9cb02c360582b624497b0a1716881cf28 ]
>=20
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
>=20
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.

Here also.

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdHw4ACgkQJNaLcl1U
h9Be9Qf9Ha7eb0bmwkXor6eEYEwTCcogANM+JPjzrsl+QI5SBJZ7mdR8ejydY5Fb
MBZnNwJs+QGnGKNrIODzRlsqk3mM9FzczUkykQOzGRbWCmrs+nMOzDVv7z4/9nZz
W9w5JB6wsWb95/F8QfvUlG/yyNR/cfP8lAG88vXOVwBF/+WyTmDvVvMHW+xOBgQE
Q9mb0AXPC55kLuusarJwzzqvD/RBMvK/qZ2gtwW5nybwgI1RgSQm8iobEoendI3N
jzylNHhreshzVwWKuCIn25Y4vV/unXs+RW+ib3gQuCZrfdsy9uufrwoVmALhLFK1
Qmukyb05CMT0lJncePE/B2GdrdstnQ==
=epbp
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--
