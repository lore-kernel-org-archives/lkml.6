Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9906C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD9620869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DtyyFFcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD9620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeIEGWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 02:22:02 -0400
Received: from ozlabs.org ([203.11.71.1]:46561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIEGWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 02:22:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 424mw40vgyz9s3Z;
        Wed,  5 Sep 2018 11:54:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536112452;
        bh=bjfhgGxOK+ouw21QVz2khjcGZfqK6Jh5Og2+DndW6iY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DtyyFFcKE9AjCCFQLKBOfFL262J27S6rRzWSHjiUU+ioJkz4i0Y2sAToO8xQPhrFL
         4lYtaNMmKSQTa2Pc1aft1OFb1Nn97CH39+1TBN6Ryy9RW9UOfx1VaahSrePHDIGgGl
         X0vaGQVpTtH8mlgmCcCD4+WCdY8gnp+s+NBO/ixaH1lS8l2fhNv/8dtLPMMK6MvfIB
         CPcmkdYD086e0jmeet0V1v9Kv+HzFwqxu+k1ckcsHtXhNJksMaYwD+5NsDknnU+FAP
         1ofe6/6n7WcKkitQ86hXFaLn6UXTwwHfRaVBQ17nui9QWwCtLkqxg+aBcoAVWIDETb
         vf1wlnGxipuYw==
Date:   Wed, 5 Sep 2018 11:54:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the devicetree tree
Message-ID: <20180905115411.0c52399c@canb.auug.org.au>
In-Reply-To: <20180905103906.232545a4@canb.auug.org.au>
References: <20180905103906.232545a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0/BLZllQuEWZoEPwDtwElt0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0/BLZllQuEWZoEPwDtwElt0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 5 Sep 2018 10:39:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the devicetree tree, today's linux-next build (x86_64
> allmodconfig) produced these warnings:
>=20
> WARNING: vmlinux.o(.text+0xf40a16): Section mismatch in reference from th=
e function of_fdt_limit_memory() to the variable .init.data:dt_root_addr_ce=
lls
> The function of_fdt_limit_memory() references
> the variable __initdata dt_root_addr_cells.
> This is often because of_fdt_limit_memory lacks a __initdata=20
> annotation or the annotation of dt_root_addr_cells is wrong.
>=20
> WARNING: vmlinux.o(.text+0xf40a1d): Section mismatch in reference from th=
e function of_fdt_limit_memory() to the variable .init.data:dt_root_size_ce=
lls
> The function of_fdt_limit_memory() references
> the variable __initdata dt_root_size_cells.
> This is often because of_fdt_limit_memory lacks a __initdata=20
> annotation or the annotation of dt_root_size_cells is wrong.
>=20
> Introduced by commit
>=20
>   bb35ea5c7c30 ("of/fdt: avoid re-parsing '#{address,size}-cells' in of_f=
dt_limit_memory")

It turns out that section mismatches are fatal errors in some configs (like=
 powerpc allnoconfig), so I have added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 5 Sep 2018 11:50:29 +1000
Subject: [PATCH] mark of_fdt_limit_memory() as __init

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/of/fdt.c       | 2 +-
 include/linux/of_fdt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index fef4b2c8a171..fe78bed8925f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -39,7 +39,7 @@
  * memory entries in the /memory node. This function may be called
  * any time after initial_boot_param is set.
  */
-void of_fdt_limit_memory(int limit)
+void __init of_fdt_limit_memory(int limit)
 {
 	int memory;
 	int len;
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index b9cd9ebdf9b9..19ebf22a7862 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -46,7 +46,7 @@ extern char __dtb_end[];
=20
 /* Other Prototypes */
 extern u64 of_flat_dt_translate_address(unsigned long node);
-extern void of_fdt_limit_memory(int limit);
+extern void __init of_fdt_limit_memory(int limit);
 #endif /* CONFIG_OF_FLATTREE */
=20
 #ifdef CONFIG_OF_EARLY_FLATTREE
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/0/BLZllQuEWZoEPwDtwElt0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluPN0MACgkQAVBC80lX
0GzS7Af/RBQCMN/bP3s0wDxbRCf525BXEQntekpzz5H5khG4+vlJ4TAFTdI8G59K
J7ICzb+Ub5GDC7h9y5075BMx8UT9+H3s8dV9xg2OEWEFFPZSG0W5LjgJx+SJ/Vt5
6DLRczr2paZxTU+6PxR6aa8PlDHg84ecsU0jgeEkR7TuMR1nhFfBGkRaP2aQLGVJ
mwg36pu1EbK8w3Rg5o2PwF8GL5S2uRmghwfQRq+uk2Jtz64UtAa0lmuymEEf8h1o
Mzy7cj5oUQjpln+4zVyLiVCV+7Cfz77rDPswSKNlpI9bw9GOVZk7kz7wj0EsWju8
L12KdrR9G6Pu/bUCJYUxAl6rR6XEpw==
=Egvw
-----END PGP SIGNATURE-----

--Sig_/0/BLZllQuEWZoEPwDtwElt0--
