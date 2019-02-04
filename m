Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A64C169C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57112177E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KVeV3xzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfBDABK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 19:01:10 -0500
Received: from ozlabs.org ([203.11.71.1]:54193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfBDABK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 19:01:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43t7CR0Sdjz9s3x;
        Mon,  4 Feb 2019 11:01:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549238467;
        bh=IYwB3t+LbpMm3QCVBjL46agHYQux0f7dW1PQxJxJhYQ=;
        h=Date:From:To:Cc:Subject:From;
        b=KVeV3xzwAJMPDf4QY8tM/pozuzJTFjPKpg1kkKDxBhiqAz6QHOA+F1Ejyl/fs0R5u
         lndKGxWFtZoLoKie8lRLrZUfiFSURI+sCeDmtQb+9r9GygmytgMfuk+oxZvEOYPQe6
         dAzveXrOzM8sQeUE7bow/AEEWzfJ/uVS+/1zMjkNoXLwxN111/iS9AIwe4aG3scmyG
         H13qO9RT38rNwBenUsG1+iW8+4SYbpBz7VzF2ums3ZrtT8ZuWIsbbzVLfqP+isSbOU
         NKTcxHtjowOJVHblEacaC6Ao8nu/YQEXukCxbpuN+agCNQLfIQJgo9y2HWbApcCL+h
         bcFqw3YN55EOA==
Date:   Mon, 4 Feb 2019 11:01:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: build warning after merge of the crypto tree
Message-ID: <20190204110106.345c3e21@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1lqagE=XXd0DpGg6hohh3uM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1lqagE=XXd0DpGg6hohh3uM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

After merging the crypto tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/crypto/qat/qat_common/adf_transport.c: In function 'adf_init_etr_da=
ta':
drivers/crypto/qat/qat_common/adf_transport.c:501:1: warning: label 'err_ba=
nk_debug' defined but not used [-Wunused-label]
 err_bank_debug:
 ^~~~~~~~~~~~~~

Introduced by commit

  f0fcf9ade46a ("crypto: qat - no need to check return value of debugfs_cre=
ate functions")

--=20
Cheers,
Stephen Rothwell

--Sig_/1lqagE=XXd0DpGg6hohh3uM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxXgMIACgkQAVBC80lX
0Gz9PQf+KalnOtLSHQ1AxBFmCNlj1d9Pp/xkZRqGfWaRLFaMWoSRnkK/zgWwdhmO
pGuWRbTTfhh4TK5elG8Za+z8rIgIoSNxip7d9su4wda+KJey8yWbOD2bGLAr2618
lkJXX7+rLo9RKvNlx4HSfDsCU9VN12HVVqYM0ot5FIJqg8c3ucYe+vkdjgLG7PQE
37JctlpAxNC68k3PzplupRnjInrpryWVO4ifWxHsbr7cx0NLISW+XVQ4R8kvH9Ae
TnPZ2mkpqSD4AUFgqdEPoBU8qE1y+8EsXg9IAINou+6F5giHNjTZs443XU2tHOqD
YttzCnhQ8XiDSHriUCPyu7ROseysUg==
=6G/t
-----END PGP SIGNATURE-----

--Sig_/1lqagE=XXd0DpGg6hohh3uM--
