Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA96CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4002089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LUPfxte7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4002089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeJBOJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:09:15 -0400
Received: from ozlabs.org ([203.11.71.1]:33447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeJBOJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:09:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PW222XwTz9sBq;
        Tue,  2 Oct 2018 17:27:22 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538465242;
        bh=pjEbmcsL4wEa3W4z4ZOo0qUJomeyX2AmjJWLl58MhYY=;
        h=Date:From:To:Cc:Subject:From;
        b=LUPfxte72hYVI0eZS5bWHJ/IAGPTokD+L6KrieHkLFx5xZHPSnRLsKzVA1WAxkSFT
         E5PwEtb6JlxIQMH5C5ciUTcuKg6tEVRFn+EX1u+DYrmH+5d0rAFAo8PwOIYSXOfNNU
         h4FB46yOwQXmrwI2oS0gIljDXrWmrFIzvMUDZMgwK+ZjCMpc2ZXsLBghWuLzsgbm+Y
         Sj27HNWd1ZqpToXfleiIayV0H1BN/ZuwAfqjm5bEFEyXkcWJDqG0UGkWllBBosVoXz
         3tyZVdYjbbsPkeh0XQwaCo75HBpsKUDPF8Z4MfeBPjSJ7/9fkb244gxpgtwp1OsA0J
         aOBrI3yFT15xg==
Date:   Tue, 2 Oct 2018 17:27:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhong jiang <zhongjiang@huawei.com>
Subject: linux-next: manual merge of the akpm-current tree with the xarray
 tree
Message-ID: <20181002172721.03cdde07@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LnQj7meKz4IQTVXZ5Msa8Fg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LnQj7meKz4IQTVXZ5Msa8Fg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  include/linux/radix-tree.h

between commit:

  be18dc56ed20 ("xarray: Define struct xa_node")

from the xarray tree and commit:

  e4618700a039 ("include/linux/radix-tree.h: use DIV_ROUND_UP instead of re=
implementing its function")

from the akpm-current tree.

I fixed it up (I just used ther former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/LnQj7meKz4IQTVXZ5Msa8Fg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluzHdkACgkQAVBC80lX
0GxaGwf/ZUxDOfpjqrqU96V1xONo/ok/wDY20Ousdm7h6TdRLN9zlbkDNJgIwtKf
BZ46dmoS1wGSIq7k4SSDcqZUMKmwUz5TDAksW1gMngLrYUb5XjEkpBwOoN26k0nM
FsCDBO2IMfefFHzNqluQ6FSTzEpD7LYlhX2jT77jzSLunq58n4L7FOkIEdWPtd70
n2OcDwjgJwbjWQ9EihOWYsjsW+ZNNaYtxIlgkBW25h3IwynjM1mUi71iCYcbIds0
5Gvbo7iAX7f9DIdxtasGcU5soRuCKlGOBstgTApHoys4brwH74QvUnGK/N69bHq5
hADAketrv1eWJfTiwJudnhRplAMREw==
=iQno
-----END PGP SIGNATURE-----

--Sig_/LnQj7meKz4IQTVXZ5Msa8Fg--
