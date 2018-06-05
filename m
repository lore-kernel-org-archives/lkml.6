Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2109092-1528161937-2-11494603461459118341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528161937; b=XUOJzZdrKiT3QhCcCcQcZvm05ujv9NvYwV19C12cimRUY5SRGb
    bJSauhL3Jr3a/sxOiUNXg/9PM6iMviF+o6HrbgI6aRbdUl22JfcNpo1kn3/QOTeK
    axvyvGq/l8E1bz7ZifOPR6usPNzU75ZDcPHd4GPxj6Vle+Ti5W6K+JDmYmw36kB0
    lke048hOdaZWkJuoykz3vKHcJ2KcZaN/Y0MVXWfVQ1DEsvP4DaMC41A3UKLXvYV4
    fOrXOy9kNdMJ77PgdlqxBQ7b3l8cdAPHlMU1TRXU0v9zYrqJHmXedFvWZhAFMHld
    X4cYAp8eFmAQuBgijgPysJhJz8ehzPKpW2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1528161937; bh=ykEaogApXXBKo7s84JM0z/A0Sl8ZD5
    bLkiMideHmoBo=; b=lvyiHCMnUfckXA9oZzDKGs8VY2wQ0JjAKFdvfVIX/ksbZS
    NHSL5w0rcEgH/4CppUM4HJ9CIBUOFkhOA1If2Nzczjcd8MOtVp+KYXBba1TgQc60
    Ew+LyQ2pVcbbz34eb7Af262fzC04SU/rLn3KZDs7RWeFoZ8Dyh9pszsDk694qtRJ
    qZ3l3x9XqLxXkONTL0XZ09/L/OePa1/s+eQjpvswuihyG98xs0I73yhhdovB1PbF
    B7d5++lQLCD7RrR3fYNXx4miKFBvX4AEeg6V9cIiYu3IqMOHal+p6UoRntx6OsvM
    gtXQxJm5V2v2HSAi3wMRADO5B/li9REM1otgcEng==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TLCzlzqm
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
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TLCzlzqm
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
X-CM-Envelope: MS4wfBvYH/GAvmySUiK+3wAoyrbegr7yGXM5qoS8xwm65ZUWkXc3zpkFWBwEdXOwyyYXaZ3wBp8bVP89J56+dtOkqhDRfLSH2yumKarY7Y6ZYJQ/KWnGCLS7
    BC3LYwhZFY5TFHtRo7Ay36/jPHqVcwjgqMD43jqU2cZ+aWwVpesMUqy2GPtiLjSW8vB+CSGS2V20GyRyQPBQEQFX2xLPe2VIDMKIEMZ9vAgwb9PYmlUlBc0s
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=7-415B0cAAAA:8
    a=Lbawxb-lLpeUug0o3FIA:9 a=CjuIK1q_8ugA:10 a=KDzECzq9lCLL6Ub11hkA:9
    a=VwQbUJbxAAAA:8 a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10
    a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeFEBZe (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 21:25:34 -0400
Received: from ozlabs.org ([203.11.71.1]:45773 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbeFEBZd (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 21:25:33 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 5 Jun 2018 11:25:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the xfs tree with Linus' tree
Message-ID: <20180605112531.23b392f3@canb.auug.org.au>
In-Reply-To: <20180605005904.GY10363@dastard>
References: <20180605103403.3e5b2c91@canb.auug.org.au>
        <20180605005904.GY10363@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fw2ZlOu+ZpCr0EG3KSdrqIa"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/fw2ZlOu+ZpCr0EG3KSdrqIa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, 5 Jun 2018 10:59:04 +1000 Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Jun 05, 2018 at 10:34:03AM +1000, Stephen Rothwell wrote:
> >
> > Today's linux-next merge of the xfs tree got a conflict in:
> >=20
> >   fs/gfs2/bmap.c
> >=20
> > between commit:
> >=20
> >   628e366df11c ("gfs2: Iomap cleanups and improvements")
> >=20
> > from Linus' tree and commit:
> >=20
> >   7ee66c03e40a ("iomap: move IOMAP_F_BOUNDARY to gfs2")
> >=20
> > from the xfs tree.
>=20
> We should have seen this before the gfs2 tree was merged into Linus'
> tree. Does that mean the gfs2 tree is not being pulled into the
> linux-next tree?

It is pulled in, but the above gfs2 commit was only committed to the
linux-next included branch overnight and then Linus was asked to pull
it before I got a chance to build today's linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/fw2ZlOu+ZpCr0EG3KSdrqIa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsV5osACgkQAVBC80lX
0Gzz/Af/R8kRCCn7j6NYrwbebbUNOJzeT2GtSY1PCf+Jk9pVkY19vL/XrCTRl4CF
hHL3MPQVwoXniBLNzHNJXLt+Jvth8GG2Z0aXVwk15Qi9VSXWbpQt4XJXA73GzHCK
42uBHsJXsRWoP9n/q5tDZ+1gApWk+5NZJwhP4emzQcdJjT2dBl0FRKYyQvDXJNgd
mUAE17UKpHUZqVrMC3/8+4iPCs/lIortOv9V9NCd/p/1mSu4QHI5mi+sCzRmqNJo
BxccOXwA42ppudSzDQUzmqb9SsIPGUv95b6mYgnJtcfTEAVNH+Dqm9n9ccloPfJr
Et6B8TS/Ht+5sa4e3uNvhDxHNDMhZQ==
=V2hG
-----END PGP SIGNATURE-----

--Sig_/fw2ZlOu+ZpCr0EG3KSdrqIa--
