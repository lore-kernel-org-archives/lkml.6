Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BACAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C9720671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lfpmewrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C9720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeIXGTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:19:51 -0400
Received: from ozlabs.org ([203.11.71.1]:37937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbeIXGTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:19:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42JPwv58Vpz9s7T;
        Mon, 24 Sep 2018 10:20:15 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537748416;
        bh=mz7NXfTcVL4Eu5EZ0PNFLeKRdH3+mgwdqFoTr3rj8j8=;
        h=Date:From:To:Cc:Subject:From;
        b=lfpmewrsrLzKukY0UH++7uMK6aXFnEi6s+NZXQXkqsHkYa2AOPnn0UhgsQfZmJRA/
         Px02xI4t9k9PbI3vrqYtwNFFjFfygG8KpM2de5xJkSKR6vlsAyevXhCfdVV+A4NbRm
         e392zfrGDwlX50zmWB2ZoyaBNuATsRfYkXGVXTSGIZ9FBHHIwOlb3ApZMZXdOo2MAA
         +vETl3Ak8s93vSs9QCEbIJ2QOsf5+08U0Di6k19IxnvuMDFHOzeyFKOW/rbad8B2g8
         JtcymggnciKB16XiP3aYjHDdqXmGLuOO/2z0RvhJFOA3b8suiocLxM0zlyXNoAUiMZ
         qA3LcNbHvQm5w==
Date:   Mon, 24 Sep 2018 10:19:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>
Subject: linux-next: manual merge of the bpf-next tree with Linus' tree
Message-ID: <20180924101956.4024470e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BenR638O_rk0vljbXVo+1Yz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BenR638O_rk0vljbXVo+1Yz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/lib/bpf/Build

between commit:

  6d41907c630d ("tools lib bpf: Provide wrapper for strerror_r to build in =
!_GNU_SOURCE systems")

from Linus' tree and commit:

  f7010770fbac ("tools/bpf: move bpf/lib netlink related functions into a n=
ew file")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/lib/bpf/Build
index 6eb9bacd1948,512b2c0ba0d2..000000000000
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@@ -1,1 -1,1 +1,1 @@@
- libbpf-y :=3D libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o
 -libbpf-y :=3D libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o netlink.o
++libbpf-y :=3D libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o ne=
tlink.o

--Sig_/BenR638O_rk0vljbXVo+1Yz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluoLawACgkQAVBC80lX
0Gzotwf/V7CQ726XCmE/S04vLxUcCAFZ2c3EQdq7Gv9VxUftcpSObjCYXHUpHsBE
yuRaP+x/x4x46zWHILRmJtRC8bBiyDd9pT/2SvFSed+mZ3rk1oGneqe5VdnsINXr
xEXgWB20DhjJCdmT6diwO+2gI791JnxCUVB/STlivEJfDAWAlPOfxi7YjDPoCeJ/
+wQqpbb/n//zK/u/rM3afIJSEy9kvfBfTIdiI/1PF9tUWc5IA0rbwVGI1CNDH1dq
JJhhYAC8CMi+854ukLCqNUSEYsN//VClHQRAZT/kGHzJV5GlW9FlaRzCWQypVb0e
W2hj4eZAQp0XoAtmjk+wUaEsxYsu9w==
=ODdk
-----END PGP SIGNATURE-----

--Sig_/BenR638O_rk0vljbXVo+1Yz--
