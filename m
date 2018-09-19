Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C155B208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C1E2zdGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C155B208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbeISMHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:07:30 -0400
Received: from ozlabs.org ([203.11.71.1]:56933 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbeISMHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:07:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42FVP23rMHz9sBx;
        Wed, 19 Sep 2018 16:31:02 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537338662;
        bh=acrS/RY5NCFRV4L6qp52jv7xwqucbjgIJz0MxC4EGVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C1E2zdGS3CFyfkWjmff4iCgtj8HuRDtdQn5e2u5DMx9vOvM52e9V5CPLIH+cnM5Uo
         0u7QXMJzBwzxcPepUc3Uxx73rkOIiwa3n0nuZhDPib/mTHF8+is6cPq/CPL8VCejCf
         9y8SCZqReMkVv86IniwxqH339fQtqBbEH4g8mXNm81SztEQqVgDkjq92Xps9pjgJ+S
         l1KYHLefyTZWDUoGjkTeO5pa0tufyVpbjvXKL8y1hZVbn2URRLJ/VO2dRpKQRH2N29
         2ufN16VMThnUtgTYGFkcFUQHl89kZR3PbT6bNlc2En5e4VKayIBEi2f4NALF/MQgwu
         PfTKlFQ1KdZYg==
Date:   Wed, 19 Sep 2018 16:31:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20180919163102.1a0adefb@canb.auug.org.au>
In-Reply-To: <3565.1537336860@warthog.procyon.org.uk>
References: <20180919094847.2103082b@canb.auug.org.au>
        <20180919073826.02370812@canb.auug.org.au>
        <20180910133525.28c5dd20@canb.auug.org.au>
        <15925.1537309041@warthog.procyon.org.uk>
        <3565.1537336860@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZJ0kv3G641rgu3qYMev8HnC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZJ0kv3G641rgu3qYMev8HnC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, 19 Sep 2018 07:01:00 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > > I think the problem is that I haven't allocated system call numbers f=
or
> > > any arches other than x86 - even the x86 syscall numbers are provisio=
nal
> > > until the patchset is taken upstream.  I'm not sure of the best way to
> > > deal with this - make the samples dependent on the X86 arch? =20
> >=20
> > But the sample programs are built with HOSTCC, so you can't depend on
> > ARCH (since I, for one, am cross compiling).  Maybe SUBARCH.  Better
> > would be to use either Kconfig's shell primitive or some make magic to
> > figure out if the syscall number define's are defined. =20
>=20
> I meant put the dependency in the Kconfig.

Yeah, sure.  Kconfig now has the ability for that dependency to be the
result of an external program "$(shell ....)", so you could have a
script or program that checked to see if the syscall numbers are
defined and then have the Kconfig symbol(s) for the tests depend on that.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZJ0kv3G641rgu3qYMev8HnC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluh7SYACgkQAVBC80lX
0GxYPgf/bF74y30ZUjwdoFuUqy4+blmM+81kFJkuEtiNT+PQRFDjrzAxZvIGAJX+
EVNSHZAl6Wfy39W0gCGA6K0GB3YWaNYqlZXjxLPlb28Z910dCjxl44z+cDQ/0qTx
eooBlAH0z80gFw3MZqPErWf40rV0e0AuILJ6QE7o3qc7+tw6jP+3CiKJshuZFvm4
RQG54g7Zxva8Nc9180iq68ag8PtYK6f8PzHeCruLU4sDgj/hMeHUcl/EdrCJFf45
MLxBb5B+kdMUqoh3ByBp2L6GlmWhiNjH4X1veIqUL+CXlJbKyKVseAgBFutnJkbw
9vgLxBtjLIS4vcMYSNbw0Zi3Uk1PHQ==
=qN9e
-----END PGP SIGNATURE-----

--Sig_/ZJ0kv3G641rgu3qYMev8HnC--
