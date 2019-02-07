Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6911EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348FB21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aEZR8Px3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfBGWWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:22:25 -0500
Received: from ozlabs.org ([203.11.71.1]:56647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBGWWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:22:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wXqX6w4Bz9s7h;
        Fri,  8 Feb 2019 09:22:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549578141;
        bh=gG7Fl8IGeDyEyzxZlO+MOR7LI8w01mnLK07Bp5lc7XA=;
        h=Date:From:To:Cc:Subject:From;
        b=aEZR8Px3S9cYe/9z81gKOOkg00HawwhCPVWjshspfKcAslb6gm/Hg3VOd7y8sA2A8
         3eF5buKP1k2EDlprvqppoASIlJlQ3kFZGil+hGpyiqiDU9Xva5z6YV44IMUwttYVmJ
         MlKdP6nd7M0Xmg+lzYcsGH25FgKQZrv13fcdMtnL/oMXJ9Twg6k1iEuQFa/YzmuPw5
         wtilBFFt5GXIP2OVOs48DrlCqEzeNzWFF5GrzXWR2n+3LquJJ4LazMXr4ydgePQye5
         VW90Ecx7tt367hl9yGZ+XRLX/OtINb2QBhZ5CzS+Vi7wlaBN0frysRktV84t2OmFHa
         A0hzeys8FsK7Q==
Date:   Fri, 8 Feb 2019 09:22:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Huang Pei <huangpei@loongson.cn>
Subject: linux-next: manual merge of the mips tree with the mips-fixes tree
Message-ID: <20190208092210.653a9bcf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rrF3iid0usznE6OR18/XudT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rrF3iid0usznE6OR18/XudT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mips tree got a conflict in:

  arch/mips/include/asm/pgtable.h

between commit:

  e02e07e3127d ("MIPS: Loongson: Introduce and use loongson_llsc_mb()")

from the mips-fixes tree and commit:

  c7e2d71dda7a ("MIPS: Fix set_pte() for Netlogic XLR using cmpxchg64()")

from the mips tree.

I fixed it up (I just used the mips tree version) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/rrF3iid0usznE6OR18/XudT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxcr5IACgkQAVBC80lX
0GwAfAf+OdzsNJWdkZsZAt0+mLS7IYyWB45KKDXCzrAwK/9i2b1MIjeECKheJUyE
NRbJ6wBN//+b/XbgZq27/nPe0rasyzDCwN6SxOpgCNKpCSl5Ylcbjz97EPdUp1Z8
m6o6mMz8qU/LDBf2khURAPUWO7lMmmj9zTU4RhZa1Rr08Crq1jo8227JEUSt3noS
+d7Uni4EcWoA7J28L3qesoHCo+k31QAivlbkXtXW053lZ9uNWoXQAklWhXQC20Sy
S4opS3eXReLA089SmE8r3O6f8go/56IclzGl76Oeh+tRiYfE65VH7/bpGmSjfueq
4sNwTbG0HFPNCGt3wBy4L+Xygz/0XQ==
=fmO3
-----END PGP SIGNATURE-----

--Sig_/rrF3iid0usznE6OR18/XudT--
