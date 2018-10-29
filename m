Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A398C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDC62081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lwjfBf/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDC62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeJ3Ihs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:37:48 -0400
Received: from ozlabs.org ([203.11.71.1]:37421 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeJ3Ihr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:37:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42kWTb3fjhz9s3l;
        Tue, 30 Oct 2018 10:46:43 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540856803;
        bh=f9+TUny0lAepavf3rKDMO0+mxw/2VwAEqrJA6Tj7VKk=;
        h=Date:From:To:Cc:Subject:From;
        b=lwjfBf/9QkW7Xxb3y3R/1k/Yaf8UBTk31FXCxD21shWdjedKW/iocO7vUEzLKJRUn
         8M6Y1aVUMAAf1ZF/bj8+ih+QaasC+UOY9na5rrbFZIatqaf5yL+GbFzV50GptKXhku
         cg8hSvjVRh/V9QMvwb2JuOgGuOkpOjyl8naLPk0LytwISEsiN210jOi+/CkqUYkC1f
         ktiDWTjQ5BKBO6V/Zqu+w48s3F4x4Yk1S9lX0XrJ2Z9RualS+9CBsDnX3BBvFLpU08
         7zV2yEBkgiV85+PD4NqLDxktSwQZXAjYbh6REBG+1vfpLrVJv0qoaFxOVRh7ywO4Bh
         TWUFeCu4pIPsA==
Date:   Tue, 30 Oct 2018 10:46:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: linux-next: manual merge of the compiler-attributes tree with the
 kbuild tree
Message-ID: <20181030104637.382c26d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Txj/sLcRG0RPm7X.OikBPYu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Txj/sLcRG0RPm7X.OikBPYu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

Today's linux-next merge of the compiler-attributes tree got a conflict
in:

  include/linux/compiler-gcc.h

between commit:

  94c7dfd01652 ("kernel hacking: support building kernel with -Og optimizat=
ion level")

from the kbuild tree and commits:

  5c67a52f3da0 ("Compiler Attributes: always use the extra-underscores synt=
ax")
  989bd5000f36 ("Compiler Attributes: remove unneeded sparse (__CHECKER__) =
tests")

from the compiler-attributes tree.

I fixed it up (the latter just removed the __CHECKER__ check, so I did
that) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Txj/sLcRG0RPm7X.OikBPYu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvXm90ACgkQAVBC80lX
0Gxg+QgAkApuu6p1esEjyjkjj9LGWA0Oo087fTpH+Qw++H9X7RvQrDKprReHh8w9
Ni/lPsH1+eAh2bP+PYnIBb7yV5Q5VN3nKWZ6OxLzK+T7PJ0ygnQZCguEz7ROhwu1
IO111AFqzyewfhn3FQAcJTAvOS4iV8QMc2dr3/SoJ0Aolg9LwNe9gQW8B6FhwCn6
Qg7jSgaLdh3rhbqpc/cVfyV29oPDWhKd7JlTTxDasgaQ3MwBDbCGUSTdLofH6BDJ
/wnZazZzjWx45osg+mx/eM7YN8ohAGKsfMYcsFnuFM8mriVfdTHuhOglA5d5N36x
8D1QhmKOlQa2R9STztLu88Wrm1nqmQ==
=u3gb
-----END PGP SIGNATURE-----

--Sig_/Txj/sLcRG0RPm7X.OikBPYu--
