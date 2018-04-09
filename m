Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1942698-1523304771-3-520262167582421690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523304771; b=AN4VYJWIOOLoHn6hwebsH0AD5qAd/1WQX/3l9c69rwPnX3Jr6h
    5sU0fXr1Z0uw/L8Z32zNuHa3PrLcbsENvUbR3Y0cJpBQB962Gh+DqmTkqM6X8RK2
    RrBSKyHqBXoD4RK9kGYDq475HaRJcdDWDXmJAIdLoNo4BvOwj1Ldtsagj3uhkL18
    /mNtgna7djqzLJyiZkrXfO93mzYuYjR1llPKvbrUqUP5Ub1r4mmfaPPqUe7UUtBo
    PbV2iElTgjuSqDbh6O/UH5AcbYF9eLTI1spnkV5uUaxBUWqTAeLjJ/Kz8Q29GDWo
    /pnPbulbPv7pVhL8lBEFs4X5uJcoldSquKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523304771; bh=pQ5dwcJHJZPsvTmJCfuqqB3Dqz/p/r
    ke2sfcnmD9Rwg=; b=Cf7J+6h63K51/9PsKCkRDK4uVtJu/7CHgBJUn1K708Wh4j
    bzFfaFonEV+Gc6uuUDVaJtuoprRQ3/1Er/UsDc8cLHCXjkmLuFam9pixeE58S4Ka
    Wn4TIdvTggnO0/7hnol8CbDeLVI32KPFtbtmACpJFFK/6iZ1Go2a9osCPlDiZXSP
    w/ChKXpeUqBb4rj6vYUh3y3JbkCr/NjaSQSaRQrUda7CQB1l4TOmMFIczKYlVkTV
    Ld9Vd7QVs3XM6MuubNcnaDtseb8HL8bm6dFgcUEPecJXKKHUZWgcmTtRo00qp/co
    KqQXULqsgnQoNnvmLyAnFUJxk3EySb9+8VX9Nn+A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG+XpFmeyd+teAsQp7SG1sxsLdVgFTfvQsEcd7y17LleXyFN5VGELZqKruEl6yHbNabvGmj0NKb196Jt++geHEs6eLA2j+w09HzSgjr75QmdbA+zYmqL
    /7J/NNgDNpcfd9f5xrqdEzotUOFJ0pw20LwxQrqzm3UfXppAsWEVhJXtpPNGRLlgnxctDKqMHNoqtPaLrTHrTlE+opPk6ieFXq76v2ai5yccnM1Tyzd1bAy5
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=ER_8r6IbAAAA:8
    a=V8U9s74bP8gDfGRt88MA:9 a=QEXdDO2ut3YA:10 a=TvA8Ubx5Z0HwFapXjjgA:9
    a=ONNS8QRKHyMA:10 a=9LHmKk7ezEChjTCyhBa9:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbeDIUMs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 16:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752718AbeDIUMs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 16:12:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31ADE21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 9 Apr 2018 21:12:42 +0100
From: James Hogan <jhogan@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.15 048/189] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Message-ID: <20180409201242.GC17347@saruman>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-48-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20180409001637.162453-48-alexander.levin@microsoft.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 12:17:24AM +0000, Sasha Levin wrote:
> From: Paul Cercueil <paul@crapouillou.net>
>=20
> [ Upstream commit e6cfa64375d34a6c8c1861868a381013b2d3b921 ]
>=20
> Previously, the clocks with a fixed divider would report their rate
> as being the same as the one of their parent, independently of the
> divider in use. This commit fixes this behaviour.
>=20
> This went unnoticed as neither the jz4740 nor the jz4780 CGU code
> have clocks with fixed dividers yet.

FYI this one isn't strictly necessary for backport since JZ4770 support
is new in 4.16, but its probably harmless too.

Cheers
James

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrLyToACgkQbAtpk944
dnqnABAAoXM5BPPPtuK//G4tlXF/zFL83WJr6nFQ5NjhueEyvO8j9pNK+Q4mL4Mr
wQSGY9v+1Sy5MIXgD0dRPdCadvza2GeTm7Futg+B2i/co9FQt/sprV1gMogrVVO7
0GeyXcak7LRVL8hnwEgMwMXrgOjsTXYsZqAAGllwI2A9UiTGMtjxlatbMlDzGmOY
eEal+Yja9Sf1R28VAk2Xw3YKtrD5WQ8MGg88gzxz7pvUkmFAdb27XJLf4PVZn7kM
lMO/KH8R+pmln5XfLspx2NZQOuqPuVMT4LYx69fkM8ZZhQHryo79mKnSRvWTEpr3
OqLmfqfzW2lF5rN8+135ePt+E2oZ07k36YI5jG00RaXmrrSibY0osQQH/vP2yT1n
2mpEod89Wdt+PqKSbM6B5+96YgejEsZBBFqyZXp7mvKf/4FQRRlCGVv/requayT9
ACreXW+XPdbWm8Ib/Ps/1x/yEl5/lWDc35qEWO3ZaJFAjUrOsN8MHRlBE2B8xblE
9lx649jtjb2eKHqbesPSRSU4aWhGJhcpp7hHOsJ78j6PMEP44Q/FvEB64+n5YsVW
z5hKIkKZTa6xJ3bv5eE8p7v+F4YJYd1TA2raNjef6AtssBSxIr0dq71HS+5cfTbH
jCLyIfLeFfHs1XyzUBCNNNQM5v/IvW14P+pLgYyhVk77O7FmwCk=
=K9v0
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
