Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AF2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD4A2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MPm0dnJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBKGnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:43:06 -0500
Received: from ozlabs.org ([203.11.71.1]:46779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfBKGnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:43:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ybnz23Mdz9s1l;
        Mon, 11 Feb 2019 17:43:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549867384;
        bh=Vwv8phGTalxKE1XeBUGWEzoZimlBLssOaKwM3Yqn3Po=;
        h=Date:From:To:Cc:Subject:From;
        b=MPm0dnJkkuzgI6hdbfKyNDu74mrDNdkWU97MP3QtmUpeX4su725b6V2T2eY563q/w
         VtSx+NIHGNqYv2ejVzGBxkj9vZyx6g2NINSMjposPbOOucAI9GRDTbe9G6FWsrdx+q
         WXRagt0CmC0A6tB0hScUQURwezPRiRWZ6I/53nKAOAPIFelbf951vR0OImhEJiIHm+
         hURF8Sct54+LP+rG7fwr7HzRpGYWxXIilWzq4+Dv6TQXH9qRnUe6/EFc66tecZN2lG
         q6Qg4MPCTqkGAfO9TSVmTTAnVPaTsD6vEWFSHViTLau5rzPBBh2eNKesDtLi3RRFvO
         wCOQsicQg0AUA==
Date:   Mon, 11 Feb 2019 17:42:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: linux-next: manual merge of the akpm tree with the mips tree
Message-ID: <20190211174256.14d38238@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/o6Ck2HvIdXu=uqY=vDyTOOu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o6Ck2HvIdXu=uqY=vDyTOOu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/mips/mm/c-r4k.c

between commit:

  3315b6b336c8 ("MIPS: Delete unused flush_cache_sigtramp()")

from the mips tree and commit:

   "arch/mips/mm/c-r4k.c: do not use mmap_sem for gup_fast()"

from the akpm tree.

I fixed it up (the former removed the function modified by the latter, so
I just dropped the latter patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/o6Ck2HvIdXu=uqY=vDyTOOu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxhGXAACgkQAVBC80lX
0GxTsAf+IqKacXcl9Ff/x8EdFwHTzUJEBSzBQc4Bod/q+l0M5Nnbam9vpGiPWsHB
+pkKEpE4txCN9VgHlrV/2YLT7FsJimP9uXC3PyTfUkUvPIiKPFmHTO5QdQVLnU+i
XwdkpA2JWsjKT3cm0/0RP8l7p3H5o8ykoQR1GvpF5xI82CKd83offvhXKQ/GX8Zi
K+qX9V98hdEWAN44bsxOxIaOuVbcRTSCVeF6lPPEf11uGqBvtNn5kz+WDn7NKeVo
lSbQXfuD68rItAzpiLZMXluHJ1nGI4MRPH/+COvR/yEYjq9CEzZ3pNpm8XBWQZcw
XZ042Mgo18NLLZJgF/g/axfjgAxYfg==
=KZfO
-----END PGP SIGNATURE-----

--Sig_/o6Ck2HvIdXu=uqY=vDyTOOu--
