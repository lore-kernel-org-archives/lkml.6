Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D8DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEEF207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GXJjfGRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfAXDrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:47:18 -0500
Received: from ozlabs.org ([203.11.71.1]:55709 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfAXDrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:47:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lSlS26tTz9s55;
        Thu, 24 Jan 2019 14:47:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548301636;
        bh=wG6JEPGdmGQlnuc5omTJ9Lyzwc65wIdfuazQ7uWPpNI=;
        h=Date:From:To:Cc:Subject:From;
        b=GXJjfGROuEzZJOhoh1FBnjqBRWFgff5pmsU4Kfmd80Zd7WXgbm1/REYQ8oZ825iZ5
         cA03oEz5wl5zvSrdKmfZlwd0XQDBGpuso81AMUAHPCvdihY+/efjt770WsMuOReWW2
         bMV+ACEzvCpLej23T4QhV+lz335SqXizvssdyOK0uMcfv16poHl8YbWx5HfizbdifU
         OKx4TmLVA5BD6JjCubuwG3lDUX2RdB6f7Ep82fOD+LRX6c9eRGE4uQgEg9rfJSjIhp
         YXgSlnpb+rTTgAezCfJoLCFj7eHwcaP9mrsz4ZLYub73QnvN1g0LsX6ZhnqYp3CvS0
         IxFqy/UIwwFLQ==
Date:   Thu, 24 Jan 2019 14:47:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
Subject: linux-next: build warning after merge of the extcon tree
Message-ID: <20190124144713.4330ec34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Qz.oxVF1fMg4gYXz078cjHL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Qz.oxVF1fMg4gYXz078cjHL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chanwoo,

After merging the extcon tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/extcon/extcon-ptn5150=
.o
see include/linux/module.h for more information

Introduced by commit

  58963276749e ("extcon: Add support for ptn5150 extcon driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/Qz.oxVF1fMg4gYXz078cjHL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxJNUEACgkQAVBC80lX
0Gy8AAf+JOdLe5KesDkaE3AnUAYa10Y59avkjtPq19tfPBkCBpzfVG/foTbuZs6j
VCvTrdz2es5R2ck6RODZzAOqii/j2GBfX30hKsQ4owaPjUb10wZQjSgCLr8joR1h
zjPeDGe0fGJbTBRmgK2gLBEdmRvU8hmyDshIclykvuynAG6aMu1Up0fo8r+h/g5W
V9J5SXiwtF61dcLreJtq916mycS8/g488WnKuXgnehScHzwrFA9OeZ3ERzw7WYQu
NsM6EXuRH46eUfe5bZod30eXXT8PWf20hsls0F3Y0SNFRwdWtU2p6rurMvmdPS9h
D/80Eawg3/h/QIZ75R8d2Jmcml01rQ==
=gDAh
-----END PGP SIGNATURE-----

--Sig_/Qz.oxVF1fMg4gYXz078cjHL--
