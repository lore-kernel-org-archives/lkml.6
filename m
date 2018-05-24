Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1966932-1527166808-3-14985985719121240016
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527166808; b=jjBgCMgfJvqHAkSw8IFzoV6wKLOU6s0NzTivFR3fwbEAMcJUQF
    O05iZemrKZ2RBKsG7/3krG9Hu8wUqXd3SXfsFpoGhaMLlVTSQOuduIpsgiA4zx20
    lc91BUK8OsFpuuWHoaWhtj0nuBCSb/TtweGGXoSONc9ux4CUXDvJFdO9+PezR4Yk
    ZWp/N+pK/uecdIlTgtj6X+4dca8LWdKjxR4FSFMKr6mOkZNp9E8wk+VdtBB06xvb
    Z9Rm3y8TAk45lUX+5lYBvfrPuBQIRgGVzHaYXwyC3KP7o2cZsTNKWAN281i3dCP6
    pgihB7ziDEjemn0xv6Ik0MmfzM3zdUFF5Miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527166808; bh=KNuP6EmkbB1lqGvuJ6MtBIFEI8sEIj
    bBP5QFO2pMT9c=; b=kX9XxUp1Xh5QzpdnC/HN7PTyqbHfNmP4zZy9P7Oki+onO6
    u6urj4BY3wyR9qmEqlKybtnYkPCK8Gd7tSZH+ARn+rVP67X4Ds9JKmgPBAcFMBNE
    8kVHRDf5dpDhRYpy2zRIdf8qliK6QDp+uKcJ7qEspqkqmJL8OygLZrOZ0eSi08zV
    3yUrvJ24Y9/t4D50hY+4Rtmdf2bdjrSvJqWIrxtd3FLhujFNErxhbS3XiVdXbBYn
    I7SzYsFsqFLQIkqJ0+T1uHyHo3MY8Z0Vs6TIIKWWOjbpUBQuj1VumKOL9ySBIbkC
    CxGAsRaHy11eu8lkwSqyGti/KBSY3R/OdnbCr68w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=rjt7Ty9X x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=rjt7Ty9X x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDRRTwaEjQAQwvrMimZqevb1Zcw7ShGDJe/uqjQ0w2PQfGLVzRRJ1xngowWiY0Wnl+ChMX+ki/Xr0CLQeZVYqgm7/Lyg2NH60W9f7a+zZa5hAtdM5NAT
    PJJdyoGf1xklYkQocIeRQYezLQJPOW7HaI3bI97QeXbZHIEb4IHCBsUYkKFyZYA/r7Ii22OPME3mISbhLsBp1qlhFWwhZ+AQpXFJ4fLYpW/3dpBSMFBr27jd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=2s8kItRQ_wkM4XjvuAoA:9 a=QEXdDO2ut3YA:10 a=xYGpSPXmlKSafbwzmVEA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965078AbeEXNAF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 09:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbeEXNAF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 09:00:05 -0400
Date: Thu, 24 May 2018 14:00:00 +0100
From: James Hogan <jhogan@kernel.org>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
Message-ID: <20180524125959.GB24269@jamesdev>
References: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 04:39:58PM +0100, Maciej W. Rozycki wrote:
> Use 64-bit accesses for 64-bit floating-point general registers with=20
> PTRACE_PEEKUSR, removing the truncation of their upper halves in the=20
> FR=3D1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context=20
> access"), which inadvertently switched them to using 32-bit accesses.
>=20
> The PTRACE_POKEUSR side is fine as it's never been broken and continues=
=20
> using 64-bit accesses.
>=20
> Cc: <stable@vger.kernel.org> # 3.19+

should that be 3.15+?

Cheers
James

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwa3TgAKCRA1zuSGKxAj
8sDvAP9b5xyZTvJTRL1ODiGao0nXlZE58CbdZGfh08Ld5eRiaAEAysXgF3YS4+nm
+cHSReh8L6LfjKCPbHrOsWEht17wgQY=
=+Mrn
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
