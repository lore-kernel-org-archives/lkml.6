Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2521275-1528050407-2-14103210765695344482
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528050407; b=NUyuklwguHW8a4Ezdgs1v0lbFhiA4KE8QsBQsEThhhqPvnuSAk
    jP/aeNns+iBHf/PjZevsS5sKfAIpcLMmz2oAYqwp5zhmNSts2FKXqay27vS98boI
    4ovLhzuDFEW1YttoSXFHmLHWw8InnlBNZ+wo8zDCrNb1ml8LJSGYiXbhiXwTGP2R
    rHbAffKfYzt06s3UXZx+9X0g+NeaxRMUVFpXb/q1BWXn7EGqQ0i2V6zfNgYl54NN
    FXzfk+YdpbQ2smEuBXC2lgPlLYpHxnTOcBH5YgoPce/Puc1LRrlS5r4+jsnineXJ
    R89e9nKpy5nWuIGmzvevcOwzTTnk9qwI7vYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1528050407;
    bh=2C4oJFjtfsamwS19ce11jKsAAFYvd26lnc4TQJ4Qar0=; b=OiLx8p2KN0+A
    qNE4UyZ98BEW6PPrsuHl7VultioUN8o45gbC8T8eqk9UEryWPV1ZZ/t9R1QdGPu+
    lwMuejjT+H7eSBeldiEkBan3lbFmmTusoU0rDdhMRf+dgyZlCQkMp+UfoQRNaRsV
    Bw6kGxA7vNWCICpA9bMLKbk2zfNbw1g81UetrRalB1L8O292fBYEXf8tPKyyGkJL
    9uDQzJ3cfn5p2fy+z+wTsjg6FQe+aaKqFCqjGsutXvJgl0KziVZ3BYyuRu8rjaUI
    XN8HugABiXqZw4gOIvE+iB6XOGc3cz8hLwMrYyKUs5NSMlqd5jOH/Yd3TEuV1ZCX
    P0VsTVFwFg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=HsH48e6a
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=HsH48e6a
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
X-CM-Envelope: MS4wfIvhy/fxEyufJC8JDZXT0JP9t42tZBszhhkf2kN1N2znwL1Lap8dICaYeOAvO6r2RcjSQ7+QXyPkuw5ir3sXSaBvHRJWMweH/cq02gWp0I3IibHMyKuY
    2uDEpoyo+cbGfTKSVnERAkYGRizqGMB6ZKZwjRvkhIGnQuWCaGTSz74h5JT36zMGfQCn382C035cp5FDrnoW5KHxVoESolwlZTzbSxWkwcsv7bjKgug34yIJ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=grrJZppmY_B5W90Tsy8A:9
    a=CjuIK1q_8ugA:10 a=JT6X3brUZn9owZ4tUQAA:9 a=VwQbUJbxAAAA:8
    a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbeFCS0n (ORCPT <rfc822;linux@kroah.com>);
        Sun, 3 Jun 2018 14:26:43 -0400
Received: from ozlabs.org ([203.11.71.1]:43107 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbeFCS0m (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Sun, 3 Jun 2018 14:26:42 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 4 Jun 2018 04:26:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Suchanek <msuchanek@suse.de>
Subject: linux-next: Signed-off-by missing for commit in the powerpc tree
Message-ID: <20180604042626.286a9469@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yrmiNp2hjm5+dqn=Kkh9I8M"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/yrmiNp2hjm5+dqn=Kkh9I8M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cb3d6759a93c ("powerpc/64s: Enable barrier_nospec based on firmware setti=
ngs")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/yrmiNp2hjm5+dqn=Kkh9I8M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsUMtIACgkQAVBC80lX
0GyzXwf+Jvvf6GnqeerEBBIhSq1FMEoGmKS8zXjcNmQSKJHvdnzvJfWMRI/UDibq
Jo3OAt2ZbglG/iVjPUe/SyAtqLt7lIRFXSwO+5FcMCu99cwc1okCfFKA/RcSP3Jt
cj+nJpapb1hL3d6M/NWnPJ8QS+flf+jwgfZ9aoy2nNnWqH4GOP+AwCw/nNLVwS0o
YlG46rW54ulE5pft6x9nqqrE0WvyYxlZoU5hMjgEHgPaPQkMlKGrEI804Y91lvDV
FRbxUtwG62go26PIc0akzEXgGmVeOk6Q8n+PKUSI9uCPfB4zksC4d49U8x8SStHh
okjBK0+Ly2wuTG+L6O9RWU93jzIKHg==
=D5n3
-----END PGP SIGNATURE-----

--Sig_/yrmiNp2hjm5+dqn=Kkh9I8M--
