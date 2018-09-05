Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE72AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887D12077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KaFx9YV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887D12077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeIEFGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:06:42 -0400
Received: from ozlabs.org ([203.11.71.1]:45653 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeIEFGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:06:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 424lFQ3s4fz9s7T;
        Wed,  5 Sep 2018 10:39:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536107946;
        bh=5Ypf5UYsn0Wi/WKMBd13JSpyUTEiHrg2kTUAjNxUUuY=;
        h=Date:From:To:Cc:Subject:From;
        b=KaFx9YV8tU01Sndpzhlvrz8X6qHdAILnwbf3iMnV+Bazv/SABETYf7Fx6F/3juCH+
         z2qig31vzHlmCfUActlFdpiSaKlGff7b9DHD1sMUTtHzeyPaw0nH36mUneUd6g9Ypj
         rgQO79pzYIWHbcyM/hwwiV6w9H0itYFee+YTomMohhkZaJTNAt+wVQKoym8Iu0a1Je
         NSDUtcan/sC6GDHHtvBy36pT5TJ+Z00KZdMy5btoXrlxnjOvWIdR/+H/zedHoB6gMX
         FNj22WJT1Y9h3Mf6IoBIgGRitLojnS/d0D9a7B1qvR2zVUj2C+0cg+/JhDZ6ukvhRJ
         dgCSyw6DONguw==
Date:   Wed, 5 Sep 2018 10:39:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warnings after merge of the devicetree tree
Message-ID: <20180905103906.232545a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Kh_LlWW9MmhSB11lcET/Gpt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Kh_LlWW9MmhSB11lcET/Gpt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

After merging the devicetree tree, today's linux-next build (x86_64
allmodconfig) produced these warnings:

WARNING: vmlinux.o(.text+0xf40a16): Section mismatch in reference from the =
function of_fdt_limit_memory() to the variable .init.data:dt_root_addr_cells
The function of_fdt_limit_memory() references
the variable __initdata dt_root_addr_cells.
This is often because of_fdt_limit_memory lacks a __initdata=20
annotation or the annotation of dt_root_addr_cells is wrong.

WARNING: vmlinux.o(.text+0xf40a1d): Section mismatch in reference from the =
function of_fdt_limit_memory() to the variable .init.data:dt_root_size_cells
The function of_fdt_limit_memory() references
the variable __initdata dt_root_size_cells.
This is often because of_fdt_limit_memory lacks a __initdata=20
annotation or the annotation of dt_root_size_cells is wrong.

Introduced by commit

  bb35ea5c7c30 ("of/fdt: avoid re-parsing '#{address,size}-cells' in of_fdt=
_limit_memory")

--=20
Cheers,
Stephen Rothwell

--Sig_/Kh_LlWW9MmhSB11lcET/Gpt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluPJaoACgkQAVBC80lX
0Gzh6Af/QDDMVaAfxbf168H/AYUXHvRK3qNDVmGN/D3m3gHb5Vk3idGK0G+A/yJF
oENDTp1VcQmB3Q7xbl+XfqgPzjpwFlJH3P/3BmUqaVQVg9A+f/sJY+J9tEbhkf5D
lilB3VWnSkXNnL5n2ULtlhfDKO+EZVK+cEAhSvyTKVQQVj7a2n6bFuD/iLvLgGdK
KlQWs+Q3a/fc+i9YsWXoPG8mXtIUPrVMB5B5SNZnBZ/1z7fb/ghuFii1SY2UvQ/t
ILJO02nHQKz7FqQOawVCRkSWn749RXUbDi5fReE5FczDoILijRfARoKXmDFEeCc2
GMQiiFM4ZJwz9vRO6FJ5nbZ6yJGXUw==
=CJet
-----END PGP SIGNATURE-----

--Sig_/Kh_LlWW9MmhSB11lcET/Gpt--
