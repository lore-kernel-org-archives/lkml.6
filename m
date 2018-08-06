Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3613C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 04:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF7D219C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 04:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CULeErlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF7D219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeHFGy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 02:54:57 -0400
Received: from ozlabs.org ([203.11.71.1]:57621 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbeHFGy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 02:54:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kQB06R48z9s0R;
        Mon,  6 Aug 2018 14:47:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533530858;
        bh=Mc8ihrNTPiuJtJSGbSzt5fH/WlwBbxQKaF+rE0Or3cY=;
        h=Date:From:To:Cc:Subject:From;
        b=CULeErlGITycS3t7hxTzcFqbM5sSJkm/RwpRoqckZWxXLEJMLanNrcR2OOmY9U2pn
         Bfw9GG9RcTFIiihpZB8ffIFiklXFrFatLYxnujsF1P80MhCt5zQcDXzyFoFgj25dHI
         jvaLxNiIi4kJwvuWTa2PvQIYhx8fT94J7jY/auUEywmHZBLDOMl8hbxpwzas7zpD2e
         KNgEcCB+l+bp5JNkcmso2SJM3ImV1nW0jR5NiJeylxeRsOSb3yQiAWDH/odzbyJEnT
         UYxba1ojLCtur6WuQLP8/60DyJLU5xnzSgve2cmSblcbVeZdezWjLMpxvtmAvI0/qB
         t/7zWqtRya18A==
Date:   Mon, 6 Aug 2018 14:47:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the tip tree with the kbuild tree
Message-ID: <20180806144736.4fbe1e51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7+BWlk0jVWhykzLsh17oL/V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7+BWlk0jVWhykzLsh17oL/V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got conflicts in:

  arch/arm64/Kconfig
  arch/openrisc/Kconfig

between commit:

  1572497cb0e6 ("kconfig: include common Kconfig files from top-level Kconf=
ig")

from the kbuild tree and commits:

  78ae2e1cd845 ("arm64: Use the new GENERIC_IRQ_MULTI_HANDLER")
  c5ca4560de0f ("openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/Kconfig
index a3de6ad666d4,3d1011957823..000000000000
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -278,9 -265,10 +279,6 @@@ config ARCH_SUPPORTS_UPROBE
  config ARCH_PROC_KCORE_TEXT
  	def_bool y
 =20
- config MULTI_IRQ_HANDLER
- 	def_bool y
 -source "init/Kconfig"
 -
 -source "kernel/Kconfig.freezer"
--
  source "arch/arm64/Kconfig.platforms"
 =20
  menu "Bus support"
diff --cc arch/openrisc/Kconfig
index fee9d91a66e6,dfb6a79ba7ff..000000000000
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@@ -71,9 -69,10 +71,6 @@@ config STACKTRACE_SUPPOR
  config LOCKDEP_SUPPORT
  	def_bool  y
 =20
- config MULTI_IRQ_HANDLER
- 	def_bool y
 -source "init/Kconfig"
 -
 -source "kernel/Kconfig.freezer"
--
  menu "Processor type and features"
 =20
  choice

--Sig_/7+BWlk0jVWhykzLsh17oL/V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltn0ugACgkQAVBC80lX
0GxJYQgAmyCviLG+CL/If0djfbU4oRNBG1DbBrduE5u3Vyv5wwNpHC3+KavrRnKE
qPOgOZhkGEZ+rw+zI3h10hS/ghdJX5aisoC0iIuPghxzyvkEBydKz1KZzYCfjv4y
KNh64YPbpDz8uzCA9Saic8NTKYGzM9UxzWZ4av+FNszshwm0oJcOsgCm58ifvFN6
e6qOcVO8UGLfaSFGz4Wcg8Oy8sj9ImE7tF9JkD57Ytxjs0bboTdcSR1rUJz8e1BI
JZwEMOb7FfyLOOifr/bTh6Tr0tdwtWRo9i5Vf+6k5mGMbYLpxzdeL7OuXn3Ihdbx
3gJDs3NFFvy1lYj+CO6Pk8lITBkO2A==
=B6+M
-----END PGP SIGNATURE-----

--Sig_/7+BWlk0jVWhykzLsh17oL/V--
