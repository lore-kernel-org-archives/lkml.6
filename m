Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE79BC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9D020862
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ARKdw6q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9D020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeKHNEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 08:04:38 -0500
Received: from ozlabs.org ([203.11.71.1]:43149 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbeKHNEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 08:04:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42r82S0rZ1z9sBZ;
        Thu,  8 Nov 2018 14:31:10 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541647873;
        bh=/Zjsv1ciK+eLtbGgNd7r7Gmr8ruTJtS0SMJQTjbkJQg=;
        h=Date:From:To:Cc:Subject:From;
        b=ARKdw6q+DqvBpP2ves0UlGy9Iz+UqUSlMsxT6s3f6EeHqJu3b/G7xo2HG+EWn2G5W
         KA+WYgjOFZFB98L5zj3Deoqd90S+xCaQ6Lk9tnzliSFlbWi9c9YIEYJqAq7yc9/2ir
         fV89Jm5McVaZE8Mmv1DO5uHjUZQ+RFgyP+Y5y9tj1VKTGhOSh6uMKYPf29FyINgc92
         tVSlTFHlCaAap9FVBbl3gTzuWbcXi6ZCrTT6THEvnTrZz6Geyi8et4c72IY7fJjuvN
         caqsHwUYOhkvHgj0tYFQb8bBP3qyFLDnRm55Ycp5NNng+Voxg0bBmwV4c3JyjYSsmL
         a9kN5uMtKUCKQ==
Date:   Thu, 8 Nov 2018 14:31:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        David Miller <davem@davemloft.net>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20181108143109.7dcc0a3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8Rf2OoNeWgxex_6+iw=vZGy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8Rf2OoNeWgxex_6+iw=vZGy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

After merging the block tree, today's linux-next build (sparc64 defconfig)
produced this warning:

/home/sfr/next/next/drivers/block/sunvdc.c: In function 'init_queue':
/home/sfr/next/next/drivers/block/sunvdc.c:788:6: warning: unused variable =
'ret' [-Wunused-variable]
  int ret;
      ^~~

Introduced by commit

  fa182a1fa97d ("sunvdc: convert to blk-mq")

--=20
Cheers,
Stephen Rothwell

--Sig_/8Rf2OoNeWgxex_6+iw=vZGy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvjrf0ACgkQAVBC80lX
0GwPJgf6AlcFUIap8e6QJGIdYVB0phr2I82HOPXyCtRnDI8+00UHIjuWgapa/OCi
am8sTv6Wt/OeswvbmkTvpCVf1pL7Zl7zb1lV0t7RrtP0k6LFrReepD/8RG/Hp8cq
AobM+9+qSh2CIuehHQzuXHBbsxxN3+KgF04FoSyV4PdUkL90n7uk+6O/5CmjT3Zl
dDOGHZ8XKVfl78MmN7dhq/wyYYi71k0mCKUGkiLqeoEx0MjDp7mabsk1Ome8X2So
rWIp52jE362THoqF0jKQnmEdR9sAsrDFfpyTZ70mwoDNGHfkLUraw/K8BfwHpqco
0RP1YJNs6x151E+1Gs9qq1yXcqsYRA==
=5y6+
-----END PGP SIGNATURE-----

--Sig_/8Rf2OoNeWgxex_6+iw=vZGy--
