Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A001AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D55A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E7b/toGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D55A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937146AbeFSBxj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:53:39 -0400
Received: from ozlabs.org ([203.11.71.1]:38343 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936834AbeFSBxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:53:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418rbM6dZ9z9s0W;
        Tue, 19 Jun 2018 11:53:35 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529373216;
        bh=BI+0Q16F3rLP13hmZq/110WbXVLh/+fqSjMGRzL+k6k=;
        h=Date:From:To:Cc:Subject:From;
        b=E7b/toGyQENbgVtEfwtmqx1AOag9WDVUZeUr58SeJgpRatY95ISq4Ug4u/Ad9M5/L
         I0/GS5JbH0dDNarKkfffxFqD5Xelpltr+JxFHLi2OcJ6+yqtE9SKPzhH0tYe0rhrpU
         qsGXOH+GRzxizuWN0R56CkwDok2n0AIMYfVYU8YC1uygwbqNoXKQWQ0/HNfLgbtsUy
         tCkXA4iizAPF3WJYUpQpTrr+BGE1NODKn4RvzPOz3OEnPUnqwUMImRJVuwnWdkSDBl
         uFUGW/6qk14F2Sva7qSdX31Qs9FK5dYlhNXDqZkhyYiLAv2T/v86Z9Xp54SRWknTbk
         /HiG3waImKBPA==
Date:   Tue, 19 Jun 2018 11:53:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build warning after merge of the vfs tree
Message-ID: <20180619115335.59ad4e8d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2nBrgHGOdhIXZyxi7vtU15b"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2nBrgHGOdhIXZyxi7vtU15b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

In file included from arch/powerpc/include/asm/thread_info.h:27:0,
                 from include/linux/thread_info.h:38,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:81,
                 from include/linux/spinlock.h:51,
                 from include/linux/wait.h:9,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from include/uapi/linux/aio_abi.h:31,
                 from include/linux/syscalls.h:74,
                 from fs/statfs.c:2:
fs/statfs.c: In function 'fsinfo_generic_limits':
arch/powerpc/include/asm/page.h:38:20: warning: large integer implicitly tr=
uncated to unsigned type [-Woverflow]
 #define PAGE_SIZE  (ASM_CONST(1) << PAGE_SHIFT)
                    ^
fs/statfs.c:448:25: note: in expansion of macro 'PAGE_SIZE'
  lim->max_symlink_len =3D PAGE_SIZE;
                         ^~~~~~~~~

Introduced by commit

  4afa2cf6f155 ("fsinfo: Add a system call to allow querying of filesystem =
information")

--=20
Cheers,
Stephen Rothwell

--Sig_/2nBrgHGOdhIXZyxi7vtU15b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsoYh8ACgkQAVBC80lX
0GyphggAgniJkJG+PXU3KCpVLmtq/4XokZdimnm98gUWRyF/u61lKN12+m9fPkAI
gZK+Jsa87VytZqlAIiv52XgGjbakY4xb0uFU8xBhivXn5bVvOFoyxGYtMSMfw4wp
dX9w80t+rpVvKVv69L53nYoDyhsLIHB52SI5vqieIbsuhZtLxOxz5EFJhk4+dmw8
9qN/8+jlQeT5j/0gBFNhk212bMflFVm6JxO3nwpa6drYt730HO3vLLZ4CG1gEEBN
eHSPtSOFa4SfdN2zW2v5PUOaEENyOZbPTNldwTPaNQVALn/Bc1cImIkybsChhRy8
mW7CR1a4M8pDMbCDg1il7zdaBnV1kQ==
=HPGs
-----END PGP SIGNATURE-----

--Sig_/2nBrgHGOdhIXZyxi7vtU15b--
