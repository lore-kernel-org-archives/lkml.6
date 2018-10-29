Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193EBC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E5020851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pCWkfj+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E5020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeJ2Ryz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:54:55 -0400
Received: from ozlabs.org ([203.11.71.1]:38917 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbeJ2Ryz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:54:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42k7yg215zz9s2P;
        Mon, 29 Oct 2018 20:07:05 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540804027;
        bh=8dyF3MgoI7PwKVYxVaqdjLARlRNjWzO7VImUYT6yRV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pCWkfj+r7hic3+11c8FjFFO9SPlLiCIreajZT0/H6/EMsjeRGTyhEj1AOgVukwS1e
         unixZiqm8V171V7UkzdEOwD8XgepZ/YBxP0oy79WxomNYlLdt7qDrIUAoSGXzB+ZNa
         8wl8SipWzL4sU+lhmK6TwunArcp/H3uqsT/RpEmzSsXqMdJVmaoXuRNcSCM9dvyUC6
         De1S6mOWFlvwQoHeIYcDFozqorMe3BDt3lS7VY2oj2Rr+PnmPaUApfLUXxhi9hk7XI
         hmkD5aH62nBPbVgupiGdWOqYpI3C3flSvY6DNvjBqr0Hoygf7hAU9BOfWaYVuIkZyw
         gRdAhF5doCK3A==
Date:   Mon, 29 Oct 2018 20:07:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20181029200620.75f71e94@canb.auug.org.au>
In-Reply-To: <20181029153334.7c8d16cc@canb.auug.org.au>
References: <20180910133525.28c5dd20@canb.auug.org.au>
        <20181029153334.7c8d16cc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3rSs4Wq3svp7df6CTRF.jzr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3rSs4Wq3svp7df6CTRF.jzr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 29 Oct 2018 15:33:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi Al, David,
>=20
> These have returned, so I have disabled CONFIG_SAMPLE_VFS again.

Here is the current set of errors I git today (this is from a PowerPC
allyesconfig build native compiler on a PowerPC64 LE machine):

samples/vfs/test-fsinfo.c: In function 'fsinfo':
samples/vfs/test-fsinfo.c:37:17: error: '__NR_fsinfo' undeclared (first use=
 in this function); did you mean 'fsinfo'?
  return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
                 ^~~~~~~~~~~
                 fsinfo
samples/vfs/test-fsinfo.c:37:17: note: each undeclared identifier is report=
ed only once for each function it appears in
samples/vfs/test-fsinfo.c:38:1: warning: control reaches end of non-void fu=
nction [-Wreturn-type]
 }
 ^
samples/vfs/test-fs-query.c: In function 'fsopen':
samples/vfs/test-fs-query.c:32:17: error: '__NR_fsopen' undeclared (first u=
se in this function); did you mean 'fsopen'?
  return syscall(__NR_fsopen, fs_name, flags);
                 ^~~~~~~~~~~
                 fsopen
samples/vfs/test-fs-query.c:32:17: note: each undeclared identifier is repo=
rted only once for each function it appears in
samples/vfs/test-fs-query.c: In function 'fsinfo':
samples/vfs/test-fs-query.c:38:17: error: '__NR_fsinfo' undeclared (first u=
se in this function); did you mean 'fsinfo'?
  return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
                 ^~~~~~~~~~~
                 fsinfo
samples/vfs/test-fs-query.c: In function 'fsopen':
samples/vfs/test-fs-query.c:33:1: warning: control reaches end of non-void =
function [-Wreturn-type]
 }
 ^
samples/vfs/test-fs-query.c: In function 'fsinfo':
samples/vfs/test-fs-query.c:39:1: warning: control reaches end of non-void =
function [-Wreturn-type]
 }
 ^
samples/vfs/test-statx.c: In function 'dump_statx':
samples/vfs/test-statx.c:164:29: warning: format '%llx' expects argument of=
 type 'long long unsigned int', but argument 2 has type '__u64' {aka 'long =
unsigned int'} [-Wformat=3D]
   printf("Attributes: %016llx (", stx->stx_attributes);
                       ~~~~~~^     ~~~~~~~~~~~~~~~~~~~
                       %016lx

--=20
Cheers,
Stephen Rothwell

--Sig_/3rSs4Wq3svp7df6CTRF.jzr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvWzbkACgkQAVBC80lX
0Gx8XQf+NPQJYd61cT0HfSNAiw8R52N7vLfN50UP0qkPfjbKhiyeK29bw6Uv6s3W
fYLHs3Ce+d1UVkFCTs2r7Qxs/IUqUbQDxYAQHjw979WU3MqvingubTvwpaqAl/W1
N/63oJ1ACfi2afqxra5wD76+hXsgtaPSMMb4dClVH2PuDP0AYK+REpuwRGdrsb37
GKw9fZ/rE5J35duTVMzm271SWnobq2Dq8NEP96BQrwnNtpDPJBZ1kT3Ai37cmmfp
yrjzVc6khvKmtoRjz7p4LmiVu0TMmR3f+8BaTFlrtQELyRjOrNuj5mTE96pW2JSr
a4XQ+8zF39pR5DnS7TiSDkheBHtshA==
=fAJ3
-----END PGP SIGNATURE-----

--Sig_/3rSs4Wq3svp7df6CTRF.jzr--
