Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C922146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pD/yQjgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C922146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeLFXCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:02:49 -0500
Received: from ozlabs.org ([203.11.71.1]:58255 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbeLFXCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:02:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439rjL4jYNz9s55;
        Fri,  7 Dec 2018 10:02:46 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544137366;
        bh=F7voqivZBIKK/T9jubRI69+twL+j9Q91GcraLeBfvbY=;
        h=Date:From:To:Cc:Subject:From;
        b=pD/yQjgrTF8f8kdj7g2kW52BfL8hnmOgQXo5Xb3LHJEsmDGCYwyT4vjjgvqTNISJK
         uYf2uxcsirj/5YKW07Wwpi+k1OLzvy+3Hdye+E0vbdeNi8+RwjeTtKLM58NHHJ0bNj
         OuPCfl3ngFalVMR5ICTPF9emnSiWyW3SvXerDMSv2ofhQabd8uR6WJLFlPfM5LO6bY
         nuChsW86VJk1h156DwJfBsajP9wTGV2l3MHhSLXFeMnbguf8+nZ0bPooLvlzG5yXQH
         cINPpFxkDlsAlou1syVBnjbE3etjifSrcP9KxeFQd0hvo6stsnnRAg4Uq7S2RBe/5h
         ZtAUoeo8UNuxQ==
Date:   Fri, 7 Dec 2018 10:02:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the risc-v tree with the dma-mapping
 tree
Message-ID: <20181207100246.4b19e808@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/q0pY_V.i1ErhzhB7hCMlyuf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q0pY_V.i1ErhzhB7hCMlyuf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  Documentation/features/io/sg-chain/arch-support.txt

between commit:

  7c703e54cc71 ("arch: switch the default on ARCH_HAS_SG_CHAIN")

from the dma-mapping tree and commits:

  1df4d3866118 ("doc: features-refresh.sh for csky")
  1b9f89553571 ("doc: Indicate that xtensa supports sg-chain")

from the risc-v tree.

I fixed it up (I deleted the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/q0pY_V.i1ErhzhB7hCMlyuf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJqpYACgkQAVBC80lX
0Gx9IQf/SDDCgiKzOXEGFK7YE/2iR6pKaoEsOO281re/W3W8O7rI7v8iwdW+VGiz
4uYlY18i/qAiGFytqimNtF5GZvy5ujQlzhskSK6gqufZllaX+ud5PqeqHgOD4sp+
UoKXykwOl1fSui+ZIb4d3mxh4YZh+tV2XoakSiSQ0eVIDvwwHgK+1FBL9u0zuCE7
9/YhNppLVvwm7C+Wwx4tD/eRYV1Fg+MZFIGkzLTKLo0aQpUhWcMGSdWA/etW3L6R
JDl07wDlhbHOL/D3ZZPu7/CepZkJdX5Y7cgSij1KC4o6Kz60DhnZ6EVt2LvWx/A9
540krDS3RqVxS9q26xIMBW0DX9nrCw==
=6hOn
-----END PGP SIGNATURE-----

--Sig_/q0pY_V.i1ErhzhB7hCMlyuf--
