Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A1C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0612D2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aaapi5kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0612D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeJHHrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 03:47:55 -0400
Received: from ozlabs.org ([203.11.71.1]:57859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725754AbeJHHrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 03:47:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42T1gm221yz9sCr;
        Mon,  8 Oct 2018 11:38:43 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538959124;
        bh=OMovIYmoGvYKQRFkWPFlSsk8nMQxLQEnomT9lV0EP7o=;
        h=Date:From:To:Cc:Subject:From;
        b=aaapi5kSjP8j4JO5KXioc5em4G3ZAbT3bL5RI2rXKosOhMU5hPKyACKlP/EVvk6wX
         Yl9IpvNaO5lF9xQwvkpzfPgKKyQ1Jl4RaBvEErhSgfHsk4tkG79lGhzRc56pzV1FgY
         kJd5DEQzGcRHL8cuHG5IjaeFJFmldLXo/ZBDLJK2H0WD0fVO6N8n1e+v0z5BqcEJg7
         /PiDreaG1WdUctcBLfGHGlUn0v2jA36vP39Wzf05niORQMOXsth8tfLGFExSj0NBV/
         7/0eGzDPe7DsIUyl7eFe+8F1Cx61lUm9qJY+/19XWjEXBDpphNfK98PVlnqjUkjIP7
         f38cx7DCzr+Qw==
Date:   Mon, 8 Oct 2018 11:38:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: linux-next: build warning after merge of the nand tree
Message-ID: <20181008113842.4bfc8cf9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/I9Y6GbTDCi58uEd7kpHtA+O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I9Y6GbTDCi58uEd7kpHtA+O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Boris,

After merging the nand tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/mtd/nand/raw/nand_toshiba.c: In function 'toshiba_nand_read_page_be=
nand':
drivers/mtd/nand/raw/nand_toshiba.c:54:19: warning: unused variable 'mtd' [=
-Wunused-variable]
  struct mtd_info *mtd =3D nand_to_mtd(chip);
                   ^~~
drivers/mtd/nand/raw/nand_toshiba.c: In function 'toshiba_nand_read_subpage=
_benand':
drivers/mtd/nand/raw/nand_toshiba.c:68:19: warning: unused variable 'mtd' [=
-Wunused-variable]
  struct mtd_info *mtd =3D nand_to_mtd(chip);
                   ^~~

Introduced by commit

  fe8b76ec9886 ("mtd: rawnand: toshiba: Pass a single nand_chip object to t=
he status helper")

--=20
Cheers,
Stephen Rothwell

--Sig_/I9Y6GbTDCi58uEd7kpHtA+O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu6pxIACgkQAVBC80lX
0GwYlwf/QqrgDgHgdZ82UyASexSCjKyQbQPqfLdudcMtB8y9Ed6vd71BT/tHA5ej
7WiQMbJGaR8bJsySurs9p66gntZ7GfE52j6d2TK5mt2kNpOpTjdoy1f5cXHGPrL+
AMQWyb4Rs9P70rM8E9BocUulkBRDmHNYjmyDRVNQRXujdJpFS0LlAFMzakMNHAtm
kPNluQ+YPzf24Ycw1lfYtSlBUHBYcNQt41uYcKAN/bIF3FHyHWN36GgVV+zFUkya
On558YMsmny4J6/ZcAPCU2TYfMPqNnWjp8Mayz9WH9koBUzW3vGXFS+M69pCShq1
8OlM3fNlOkKYyOuTUbdPg651cK+/dQ==
=eI42
-----END PGP SIGNATURE-----

--Sig_/I9Y6GbTDCi58uEd7kpHtA+O--
