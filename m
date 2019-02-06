Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A2CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFDA218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dIDVpZo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfBFVbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:31:01 -0500
Received: from ozlabs.org ([203.11.71.1]:35279 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfBFVbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:31:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vvkp6JH8z9sNG;
        Thu,  7 Feb 2019 08:30:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549488658;
        bh=eb2HyVjtVPdyvb1DRWu036Stt+zInQgJQ+4CzgjdKXA=;
        h=Date:From:To:Cc:Subject:From;
        b=dIDVpZo/xhMH9/E7KymjuBhmHlYgsXH6Lc9REFbVu+lR89OeS2y69vw0qBmha7JEj
         zqtbCvoi+wyNybAdoEyjQCNZDseLJabEKwkli3EDwzobGNZe9/LEPtkT4aRXOjVk7+
         NoIXHkoCm/GMGUlFXezm4PZhhaK7cU8XWMh/+vfW8UgD7nw3x5YT6MRsbryJCs6S4F
         uxiBAaKp/D0e0+Hzgrt4WwfmSsV6I+70ti7buSu/Qqne3CiT9HKfHWxaohhoQ+rgoa
         /hnLtvjg+kxUI3DCg3P6MwJ0qAIfQ5LI6N+5mokoCzdtbe1n9aAz4LCDWjQ9Q/j4+t
         Iveaaz1lUKw+Q==
Date:   Thu, 7 Feb 2019 08:30:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the compiler-attributes
 tree
Message-ID: <20190207083057.05b40e61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hjvuW_iBqyef=vyrnfbgAh2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hjvuW_iBqyef=vyrnfbgAh2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

After merging the compiler-attributes tree, today's linux-next build
(arm multi_v7_defconfig) failed like this:

In file included from arch/arm/crypto/aes-neonbs-glue.c:17:
include/linux/module.h:138:7: error: section of alias 'cleanup_module' must=
 match section of its target
  void cleanup_module(void) __exit __attribute__((alias(#exitfn)));
       ^~~~~~~~~~~~~~
arch/arm/crypto/aes-neonbs-glue.c:433:1: note: in expansion of macro 'modul=
e_exit'
 module_exit(aes_exit);
 ^~~~~~~~~~~

Caused by commit

  b31ca3fcca36 ("include/linux/module.h: mark init/cleanup_module aliases a=
s __init/exit")

I have used the compiler-attributes tree from next-20190206 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/hjvuW_iBqyef=vyrnfbgAh2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbUhEACgkQAVBC80lX
0Gx53wf7B4zCxw5ht8kqQLvI+WQWkDANF4kDEsUCGoHAU7W1iW0T5CJSeVYAMA6L
hAYfWWltoDmh9LAINyfkiV+ik6y4b0i4GHs/mUWFZruPV0UDl8k4gZiRBAlKQn56
Og2BIyom8iSS4qdkb//N0QpzIehAgsoOq54BAGDBBV+yz1vEGlqutnbJVqU2aObW
4GPQ1hn6pGWtxP16ix3flZ6pmDkzk6lclOEUxvPoTXlp3+uhw0HInim1BYooU88v
1W0jHfqdlJe7dhHYca3vcFUoGWKFxoFenZdc9LLQTddX5HtmKBu395DZp9RxrxCW
xSNJmgMZRHAiuZUtPg/6cYHEX81i4A==
=Nvsz
-----END PGP SIGNATURE-----

--Sig_/hjvuW_iBqyef=vyrnfbgAh2--
