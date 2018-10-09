Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF386C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC6821479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BDAUQQaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC6821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJIKgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 06:36:36 -0400
Received: from ozlabs.org ([203.11.71.1]:60363 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbeJIKgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 06:36:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42TjFP33KDz9s5c;
        Tue,  9 Oct 2018 14:21:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539055307;
        bh=ghZkerf5GJTT4ZdCOeTFv05yWoNiLQ5zxDpzYrzIzDQ=;
        h=Date:From:To:Cc:Subject:From;
        b=BDAUQQaXtkPnvI7IyP9srqXQ1NXuzEa0ehFy1GgB9/+Jva+7PEET9/777LHzCIzwk
         tQ5eR3HobfqjfGS9emUkmIaUCSOGcKsUTNyB+rGvB2eOEnr+zZcI+L3LhZ9U+xexq7
         PnczUcvkqFp5LnIYJ8jZi2yb8YMgYhujwqbXVyKswaVGFQCrEUI44C40zubhBDr9wJ
         9oldQbdRM0uHZD3VEeUciFGcV1Qp3rBngwiV1WvPUkDNrPhQAeHImfvh6ekdMadqUw
         QJmdE2LC1Fz0EQozkxYTS0cqH7ZdLzytpiwmkXgj+Fckt2p19qkPq0w55W1w3o/xgT
         Sh//aBS4h15Mg==
Date:   Tue, 9 Oct 2018 14:21:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the s290 tree
Message-ID: <20181009142145.210622b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D475+htFO5xCC+D8cK=3Qzq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D475+htFO5xCC+D8cK=3Qzq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/s390/Kconfig

between commit:

  819eafaa7b58 ("s390/kasan: add initialization code and enable it")

from the s290 tree and commit:

  13ddb52c165b ("s390/jump_label: Switch to relative references")

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

diff --cc arch/s390/Kconfig
index a45583f731f0,12dc4c1af96c..000000000000
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@@ -126,7 -120,7 +126,8 @@@ config S39
  	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
  	select HAVE_ARCH_AUDITSYSCALL
  	select HAVE_ARCH_JUMP_LABEL
+ 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 +	select HAVE_ARCH_KASAN
  	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
  	select HAVE_ARCH_SECCOMP_FILTER
  	select HAVE_ARCH_SOFT_DIRTY

--Sig_/D475+htFO5xCC+D8cK=3Qzq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu8HskACgkQAVBC80lX
0GxsBwf/VzUgxuA0VxwVpmoNWoRCSLJlKMlrc7w9K4MWhSt8a7t50+ikb8NFhDLY
f0+KNsl7jbSPut0TBRmB2Tn+SVXxjLr7e5rG3lu/BlY7aVfgOqsdgyqT/tsTjaVy
ksNpuFn5DIKOkRLjMjcrAL5JxmkwRVPBYzhsnD2eOWEkhUDvJL2ZD65IlUapN2Gj
Vxq3IlfrzhFYbSoTF2NEXmsbePvKglP6EQ+nDj/t6/S70ERqfgiy3RYlR95fLi7P
/gbPzT020GAsAi2Y8ZMLm8sBGNVCsrLgswyDiqIeROtysTaySZ7OqmA/1C/mCLfm
YFaIqTLcsg/9vEQrccF1RlFJs4IqRQ==
=NkNW
-----END PGP SIGNATURE-----

--Sig_/D475+htFO5xCC+D8cK=3Qzq--
