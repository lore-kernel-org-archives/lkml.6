Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2109003-1528161649-2-7994431666184666803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528161649; b=iwalwY7k7KC55IwFS5yvuaDmRAlsBzSMYUL8dDJ4ptK4qWhjrk
    57MjboMiAsxIfY3BvQ3NehftSqr6o/ZEpaqTmAMmQnR7fB9ovOdHsQFMgjOiw4kK
    gMCt+NlWLBhH2tnYcXV+2gLcDUh+txpmw+FV/NB/AqD71VFf/wrE5oJ3/BwQnqe9
    TfLHIN1dwwF7tJOnL6k1GRFubrJ0nhsZtchFLnJgTpUqlSQLPNCUwUgwMYcKYGuM
    lUs+D5ySKgOttjn/zEOax9dphnkFiIABS+IuBHHgkwtS4hVDXcXOHVqz1Zxf6x4g
    b6e1S0kBVznOLGgFWK/kdeuKsJfX73o8DobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1528161649; bh=aYwxinhjwFpIn9ZOOPXbuE12xXuse5
    t3qZop3ytE/aQ=; b=kmlwGNQiX9PBulCJA5TrmdFXQx7KwQbtfaJyeNDzB+8m02
    pn4JWrtCwiP+1AvhZ0vK/EJSGa+2xYJfE8QRnZyve/NuG3K/6gMaHBaQ77C0t+YS
    usDxL31RKJqM/DwmFLs1/gIk9q5HFELl5J8DD0JDt6FSIbRax2PV8YNxVXgGzKcW
    ljhbrHVg4BWsjxajTOu2chDklSmgNUseMdtAKhnP4SGDAo2DFpG3uH7rrXRuUNB5
    3Qz1IlNl3i0TROijd0yIjB8fII7SNIaMgzG0BugYAKbl6bWgxdlG/UuxJMjRi9xl
    WmvBl7tNZOm/mziGKhTfLSFLXVk4tJil+L4hKVDw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rJg8NeMT
    header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canb.auug.org.au header.result=pass
    header_org.domain=auug.org.au header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rJg8NeMT
      header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canb.auug.org.au header.result=pass
      header_org.domain=auug.org.au header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLKzeqsDlpHdBqGo3qt5opkyGiunXdYXdis4e6KWtAYlWUtof4DAa0FOGR4LfXH6T5Oa+ERhtOpnYMhgfMw9ZbcZywV1GgJ3+T43cyIH5ucXeFDJ0HOj
    wQVrqIAoIuu5hwAJt5l05PED4kjnpvV5UeRM4aWjan7e26K4bFZYPDjLSaLi1945GfUkLHOo9RwHgJnePTCQ8csW+UbjgePiwNwN4qFVVI/N0cID0o9ENsG+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=rOUgymgbAAAA:8
    a=0ZgL8Q9cmlciD-K-3ykA:9 a=CjuIK1q_8ugA:10 a=7De0CcTirsDBoq5tRhwA:9
    a=VwQbUJbxAAAA:8 a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10
    a=MP9ZtiD8KjrkvI0BhSjB:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeFEBUq (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 21:20:46 -0400
Received: from ozlabs.org ([203.11.71.1]:52177 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751242AbeFEBUq (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 21:20:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 5 Jun 2018 11:20:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the nvdimm tree with the jc_docs
 tree
Message-ID: <20180605112042.54e7c30b@canb.auug.org.au>
In-Reply-To: <20180509180539.57a360e7@canb.auug.org.au>
References: <20180509180539.57a360e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UGmytnCoi_R9vRLCVZW4Bsg"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/UGmytnCoi_R9vRLCVZW4Bsg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 9 May 2018 18:05:39 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the nvdimm tree got a conflict in:
>=20
>   mm/hmm.c
>=20
> between commit:
>=20
>   ad56b738c5dd ("docs/vm: rename documentation files to .rst")
>=20
> from the jc_docs tree and commit:
>=20
>   737b47a6db70 ("mm, dev_pagemap: introduce CONFIG_DEV_PAGEMAP_OPS")
>=20
> from the nvdimm tree.
>=20
> I fixed it up (the latter removed the comment modified by the former,
> so I just did that) and can carry the fix as necessary. This is now
> fixed as far as linux-next is concerned, but any non trivial conflicts
> should be mentioned to your upstream maintainer when your tree is
> submitted for merging. You may also want to consider cooperating with
> the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This is now a conflict between the nvdimm tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/UGmytnCoi_R9vRLCVZW4Bsg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsV5WoACgkQAVBC80lX
0Gw6Sgf/dVlFiCI5OZAkqmBPxO9x7GDJRL3Nknl6UL3shpM4oSZxjXhvkNDjZf+t
9ok7gUq0E93W2fp7ON26+mSpfH2GStdlaHSJoVDzQwbzjmIi1BWm4FK8tWU3HoGJ
OIalPoiax/RaLQr6hNzdhAQJTM2046x5SKFA0C/XolQXRkUcJloJb40QZArUq4yu
NnJQdIIUs09oFfP6zb6VhNFFR2PEBGu5miX0Fs/02WG7Q8uxBMrNQSfdrnE0MoOt
iYhs7p+uJEfHf8qzBf3Xpy7Rgr3M2XL1YsOEZ0bX6+j+V8UNxwkn1pkTFnwFAmcf
Z+T6FjVHySkar6J2gwAoC0130RkcEw==
=Hy4y
-----END PGP SIGNATURE-----

--Sig_/UGmytnCoi_R9vRLCVZW4Bsg--
