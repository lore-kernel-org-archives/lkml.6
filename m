Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A0DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018C22080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ubhccRLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfABBSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:18:45 -0500
Received: from ozlabs.org ([203.11.71.1]:40669 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfABBSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 20:18:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43TtVB0pzVz9s4s;
        Wed,  2 Jan 2019 12:18:42 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546391922;
        bh=xj7ISfSNnIbNRH0H0T2RZ9Cpd99ZvUg5AatOWMZUhxM=;
        h=Date:From:To:Cc:Subject:From;
        b=ubhccRLmOAnK5vdF/sTL0iOiLKhFva33ANK8l2xuzYmbAZcl1nEuYxDMgeYNpuT/S
         plZ3d9X/Sku5AE667Zr7K+iaTVTIR+6FML21EMG5t9aQI1/iU3/Drh64ITKf4TIL1s
         mUpPIqWtbRhsZmoicrnumr86BoC1MH9rUjCz7bCVI5VQuaGIK/SONy4BWTZUqTwsYl
         MvFJytNlDRrZSPT/m6U3dJEVz/o7vXWKeXUx97fisCQLaeaS4eSk/wemqHoOvSqScU
         3hDFLDr35LJqsgMAihfJRaQuVO1+gyub4xOOol0LogZ4zFnJar5gncf88NBzQpAXBF
         HPlyWhxc4K+mg==
Date:   Wed, 2 Jan 2019 12:18:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Tejun Heo <tj@kernel.org>
Subject: linux-next: manual merge of the vfs tree with Linus' tree
Message-ID: <20190102121841.3d792549@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R/y4_dkLueN0Lg+3Gk8wlEh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R/y4_dkLueN0Lg+3Gk8wlEh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got conflicts in:

  kernel/cgroup/cgroup.c

between commit:

  e250d91d6575 ("cgroup: fix parsing empty mount option string")

from Linus' tree and commit:

  b3678086951a ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")

from the vfs tree.

I fixed it up (I just used the vfs version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/R/y4_dkLueN0Lg+3Gk8wlEh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwsEXEACgkQAVBC80lX
0GyL3wf/bJDNKj6NlcAKzv628k0O49J4jvme5E9XX6KSC2QkYyEvHb7EPSGGMYIp
YOBfeoMq4ya0I1a7iCRX4Y+o/MMK9q+KAR3qsZ5nbTBV7UdpCQjBKEy+N5dItjEI
NFPUQhXAiJDAO4z0Ppy4Fv1YzG+fQNptXWm7utnwJ7ed9Lpb8aQpCJ5TZKfEKd9H
eW2xLeQNSGhYrGK1MTrz83sDkRqQI+agJzOqtaeDF+8DaKMv8PKz1ZktHChAvG71
4QA7osVQUWEruQcbjHw0vvtdTcRrFl/X8ZzFTe3fAFUA9wh8KpMLLueXdC/AZ+iO
ffdl7+Riz31IMplPbXV2hD50JvNIWg==
=+XpJ
-----END PGP SIGNATURE-----

--Sig_/R/y4_dkLueN0Lg+3Gk8wlEh--
