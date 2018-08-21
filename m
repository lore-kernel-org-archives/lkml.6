Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C92C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C942088F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="rmOCre3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C942088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeHUJny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:43:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44275 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeHUJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:43:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so380977wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=jmEGRR6HlpBVh6BQJGhyFCX3iFiiXyVbR/UdBDAJRRQ=;
        b=rmOCre3He+wsbsAwuDDujdkpfiHi2+fv4Ir3FVq/TnyxrjTSi31xnc2AB3BTzbj5mo
         +k8FsVFe+Y6p0ay0X8nE68XV2Oe9qeW1A7+KoXxisfPC6JdO0NJ0xhyf1IfZo7n83wKN
         M738Fktjj23M6NfvQvOPWpTgtfGEcv1J/C2GaWqgg1hb/gG+hMkK8YC5TLjkQLA28BDK
         Q80p7ZkjhjDRK6xfZyUiRTyY228c/7Fr5OUnYbTCVvxYmHLNjZ6jkyHo2GNjN8qz5V+J
         WnBfpC6eWkyLTz6TTsqOvncFxdNAiz945K8epc8/iDbfyGVcyRjU6HlwGBI48be/TfFr
         EF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=jmEGRR6HlpBVh6BQJGhyFCX3iFiiXyVbR/UdBDAJRRQ=;
        b=tx21Yf+UXZcsnWlx4cJwF674bbrdLWHmQ1mtl1weofT14NMhjRQzpzZ0LQzhxO1orQ
         Q1p70zA/O7PEpJE+KwgEP0/OOnff6OKCQrisZ1InaHGVwmSLqyUEOnwKz5DbOpZ2WiFM
         O+1tvLmnO6792auua8l+KZyMqO4pvmvj73CTfCnYsB3LVEG1AezW7WNXLyNjK0GS7qTi
         rGD9XiTNb/CJ00riWK+zZ/WgedLXt7okVZulA4AynE9ftjj0IREn5Li4A62XzamxBdiU
         EO4nQnH6PDdmGJ1OwU45bHyEQ+vEdpuQ74UNxuZTvA712ScZe1Ya0YAry4oxS2pMbE1s
         zqPg==
X-Gm-Message-State: APzg51CP2J1Sk39cXi/rdAaUMD0C2QHYJmYRdct83tIQIX6ysPG1kTXs
        pBsg0u+JXDdkZLRzgUEVoheh9l7077rtVw==
X-Google-Smtp-Source: ANB0VdZXyF2VXVZruca0abIqrv252YcJsVa8yW5TaKc6dwqXrnJjcC/P1bNM7OVu36nv/QtQ/owjag==
X-Received: by 2002:adf:ac6a:: with SMTP id v97-v6mr4869684wrc.7.1534832704205;
        Mon, 20 Aug 2018 23:25:04 -0700 (PDT)
Received: from [64.233.166.108] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id m207-v6sm1469561wma.31.2018.08.20.23.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 23:25:03 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] microblaze/PCI: Remove stale pcibios_align_resource()
 comment
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>
References: <20180820094729.362-1-lorenzo.pieralisi@arm.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <90363c9d-4084-dd2f-9956-42de2841bfc6@monstr.eu>
Date:   Tue, 21 Aug 2018 08:24:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820094729.362-1-lorenzo.pieralisi@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d8Es5vfkPIxYq7uszv67lK9J3s4ZutWir"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8Es5vfkPIxYq7uszv67lK9J3s4ZutWir
Content-Type: multipart/mixed; boundary="HAg1AB6g4t3iNbjQvkTTAZOSi4gvEug0y";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Bharat Kumar Gogada <bharatku@xilinx.com>
Message-ID: <90363c9d-4084-dd2f-9956-42de2841bfc6@monstr.eu>
Subject: Re: [PATCH] microblaze/PCI: Remove stale pcibios_align_resource()
 comment
References: <20180820094729.362-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180820094729.362-1-lorenzo.pieralisi@arm.com>

--HAg1AB6g4t3iNbjQvkTTAZOSi4gvEug0y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.8.2018 11:47, Lorenzo Pieralisi wrote:
> commit 01cf9d524ff0 ("microblaze/PCI: Support generic Xilinx AXI PCIe H=
ost
> Bridge IP driver")
>=20
> and
>=20
> commit ecf677c8dcaa ("PCI: Add a generic weak pcibios_align_resource()"=
)
>=20
> first patched then removed pcibios_align_resource() from the microblaze=

> architecture code but failed to remove the comment that was added to
> it.
>=20
> Remove it since it has now become stale and it is quite confusing.
>=20
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/pci/pci-common.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci=
-common.c
> index f34346d56095..2ffd171af8b6 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -597,19 +597,6 @@ static void pcibios_fixup_resources(struct pci_dev=
 *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resourc=
es);
> =20
> -/*
> - * We need to avoid collisions with `mirrored' VGA ports
> - * and other strange ISA hardware, so we always want the
> - * addresses to be allocated in the 0x000-0x0ff region
> - * modulo 0x400.
> - *
> - * Why? Because some silly external IO cards only decode
> - * the low 10 bits of the IO address. The 0x00-0xff region
> - * is reserved for motherboard devices that decode all 16
> - * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
> - * but we want to try to avoid allocating at 0x2900-0x2bff
> - * which might have be mirrored at 0x0100-0x03ff..
> - */
>  int pcibios_add_device(struct pci_dev *dev)
>  {
>  	dev->irq =3D of_irq_parse_and_map_pci(dev, 0, 0);
>=20

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--HAg1AB6g4t3iNbjQvkTTAZOSi4gvEug0y--

--d8Es5vfkPIxYq7uszv67lK9J3s4ZutWir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlt7sDgACgkQykllyylKDCGhjgCeKjqyZmbyVEnAFglymMYC5F1p
jDQAoIIaUQs+8cz/04gx/FH4FfZBE4RI
=x0Ui
-----END PGP SIGNATURE-----

--d8Es5vfkPIxYq7uszv67lK9J3s4ZutWir--
