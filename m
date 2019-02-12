Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69FCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8996D222CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W4Rsbwd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfBLUFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:05:01 -0500
Received: from ozlabs.org ([203.11.71.1]:44071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLUFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:05:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zYXn2ZTHz9s7T;
        Wed, 13 Feb 2019 07:04:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550001897;
        bh=kSYe/vIVQU0QU1J/h/H9y8uuOrhf+8jtiRparsGsjDs=;
        h=Date:From:To:Cc:Subject:From;
        b=W4Rsbwd8vPaiJGY1pCBQxANLtu6HWfZgwBEXv3P9btC2g51VRHlzWtTAmG4wpKp5k
         0P78j5ZXZbWsSfRIbcX6PlyImUn9wZG+61E4DpoDcv2VkuBt3Tt1xSzCQD+Z+Ti3kt
         lqGvwlEnmf6R2cvfB0FKnrY/r/A8Drt1c3CgxkxCUApGu0yZXwVqkCLXT0l8IgZ37p
         uQsGhNgqM/dNpFbzrqas6dApzrPJ0ZuYmAqCN6X6MGuMjLfv2Tx8faxLNFBjw7tFwn
         jddl7ZYIw653AF6mVB0kLSae/Izmk8BmzInsiTwJuNa6lpylbKRRS94HFfo4EYIwDp
         KOZDdZmY2H6gQ==
Date:   Wed, 13 Feb 2019 07:04:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li RongQing <lirongqing@baidu.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190213070450.605a6c94@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/x7pERLkwHhtWK7WjZaP_H/R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x7pERLkwHhtWK7WjZaP_H/R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d1f20798a119 ("ipv6: propagate genlmsg_reply return code")

Fixes tag

  Fixes: 915d7e5e593 ("ipv6: sr: add code base for control plane support of=
 SR-IPv6")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto")

--=20
Cheers,
Stephen Rothwell

--Sig_/x7pERLkwHhtWK7WjZaP_H/R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxjJuIACgkQAVBC80lX
0GzEWAf/UCpvdQ6F1IH55ebIkcMcvShCBIlV7DwI+wrP1YHlBMaLzpyjhdHFoNjV
yXfX6NIJR2ZFGsBM+pMNTuRml6uAcG+Vkk273KkvB2ZA7HE8q5UuFv22SC4Gelf1
0QW7hJUdf0qz4rBppzDUfKwd74CVqS2GOj8N/W5Y5Zw+c6U+jTzi1aM5ch/o2AYt
fEsQXzz5MTLBlNKQjiTH5e8fauVhTgJh99FuK8EgV5LWNkGJqAUQc5EBb8/+PaXN
IYj4yAvaQRAjijyQpGk+CNXYXJZ7szRFdmD8eFJIZ3Ztw5ZihbxSWxQBeFWbuOo5
u241ly28Cjw+9UQwPPtqunF3ogfx+w==
=PRj1
-----END PGP SIGNATURE-----

--Sig_/x7pERLkwHhtWK7WjZaP_H/R--
