Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F52C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4622087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="i6/3kUjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4622087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeGKIKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:10:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34521 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeGKIKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:10:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so17111025wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=T0pCz+4CQvxmORc5Kfw0q6uK3HrvwfLS1725zpLiwSw=;
        b=i6/3kUjI/yfwCov72VESsAVntYMWAykjU7bPqfeyEPx/VYRD1rkoBM2ARdUEolWRWL
         ldXW3HTJmqsPAtR0tuSuRfvabPvzT+lZgUEovSawXfMHBpZO/5HJ/fOgivYDtkTOHVqG
         K/Akj5LNr42/5BUwMs6CppIZdzT63jCSRr4KMCXeHawgT7WV/d2Zw+jA8yEzwibRSmyd
         0tczCJElDSGQyXMzMLFe/jgOq8b6LjzY0s4XfKjrBqZwnDU231KMd1YkjuU0E12mP6UC
         kxceERX3arQsB42VTATPcIAxzVZbGjpGEGGHvL8WD6ftxWGCZlQMTzuRJd46jqoWLDe6
         ll8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=T0pCz+4CQvxmORc5Kfw0q6uK3HrvwfLS1725zpLiwSw=;
        b=fhU5mMB2TA0Y31wzocMzO1LT6UMKvxbXGe5rJcaQzbz2oaIl0eBJRkBIkkYX89KCbS
         vr3o4aWvwmImckySf4QChKo6Y7H0zrDdTft3ORKFqjS94KfLz8myz+NY9tJIjKygLwU+
         GxH46DWgE/lK5WJ4lTrH4l8P4RlkCVAllWXAOtQZ2DCjXq9a1oZH35OTDQeygEFDpUXX
         cgoRXr0qiapGJxgHupidqTuTUbnmPJdbwci1y+yE+D8+h8CIBoUmMNIM5XUHuXtUksAJ
         pxyA+jdDVhfQ6K9d6hbVHqtIK/3QaM5Jq3HEVJLL9e0EUXCbjo04lZAsczs9FjvZ9PBJ
         R6ZA==
X-Gm-Message-State: APt69E3VlAi/IUOXgzVQbTHcgf/d6bE4YCeEqI0BCaAn8pnEVyDAT3ye
        h0qbqF5/o103D9t9oXQwmqGDBg==
X-Google-Smtp-Source: AAOMgpdkKmzH85xF9TXj9um7WumacR/oyl5DNzFk9obYsPLUeCGALFDO4HkRnZ7QHp0LfdgeU7scJA==
X-Received: by 2002:a5d:4643:: with SMTP id j3-v6mr19459040wrs.52.1531296436750;
        Wed, 11 Jul 2018 01:07:16 -0700 (PDT)
Received: from [64.233.167.109] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id b198-v6sm1564957wme.11.2018.07.11.01.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 01:07:15 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] microblaze: warn if of_iomap() failed
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1531125764-25816-1-git-send-email-hofrat@osadl.org>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <672801f1-7585-981b-5a12-ac5128795b9f@monstr.eu>
Date:   Wed, 11 Jul 2018 10:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531125764-25816-1-git-send-email-hofrat@osadl.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qJ17AOP5HCVNyGQ9BM1GB90kpZceZVC7i"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qJ17AOP5HCVNyGQ9BM1GB90kpZceZVC7i
Content-Type: multipart/mixed; boundary="R3sQzsAJZUgjzBBRji32657e87whC7FCk";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <672801f1-7585-981b-5a12-ac5128795b9f@monstr.eu>
Subject: Re: [PATCH] microblaze: warn if of_iomap() failed
References: <1531125764-25816-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1531125764-25816-1-git-send-email-hofrat@osadl.org>

--R3sQzsAJZUgjzBBRji32657e87whC7FCk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9.7.2018 10:42, Nicholas Mc Guire wrote:
> of_iomap() can return NULL. The function is void thus error propagation=

> is not possible but at least a WARN_ON() seems warranted here as a sile=
nt
> failure might lead to a hard to understand system state.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>=20
> Problem located with experimental coccinelle script
>=20
> Probably this should be a BUG_ON() as this is such a low level fault th=
at
> continuing operations probably makes little sense.
>=20
> Patch was compiletested with: mmu_defconfig (implies CONFIG_PCI_XILINX=3D=
y)
>=20
> Patch is against 4.18-rc3 (localversion-next is next-20180709)
>=20
>  arch/microblaze/pci/xilinx_pci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xil=
inx_pci.c
> index 14c7da5f..7fa72ff 100644
> --- a/arch/microblaze/pci/xilinx_pci.c
> +++ b/arch/microblaze/pci/xilinx_pci.c
> @@ -157,6 +157,7 @@ void __init xilinx_pci_init(void)
> =20
>  	/* Set the max bus number to 255, and bus/subbus no's to 0 */
>  	pci_reg =3D of_iomap(pci_node, 0);
> +	WARN_ON(!pci_reg);
>  	out_be32(pci_reg + XPLB_PCI_BUS, 0x000000ff);
>  	iounmap(pci_reg);
> =20
>=20

Applied.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--R3sQzsAJZUgjzBBRji32657e87whC7FCk--

--qJ17AOP5HCVNyGQ9BM1GB90kpZceZVC7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAltFuq4ACgkQykllyylKDCGGZACbBwPA9gUenidZqADqEzmjE9oc
t4sAn1wACUhpS8XluMZusGYp4rGME8vf
=paMC
-----END PGP SIGNATURE-----

--qJ17AOP5HCVNyGQ9BM1GB90kpZceZVC7i--
