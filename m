Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA461ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CC520858
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="0MhhtBeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CC520858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbeGQPPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:15:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39821 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbeGQPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:15:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so1786864wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=Jr3ZXAaZp+fG0BsDre0SQu8BcOQv47QE2HDUkPeXCfo=;
        b=0MhhtBeDOYTi+q5SkBNbQAwzLejnXfmqjPSoSYXdo1/FhnrfHDuTTfr5djTvXoJ4z0
         dyheeCbiLRCEOaCZ59IAXKTgVp5SQyfIPLDpaNUPAFEzl7o0Sav7Y76YT4gVhpA7Pc3f
         ommxZjW5HVd37VJcvg/4OfG7cNaQVI5zVsXnR1Yj0vGQxVwJ9RVaP8bNUjvBW9XqIGV7
         MdAnhny7wxMGjSpesI2PHxHFSjas/k8we4MS2HqRaW1tVjjyEHmqK1/SJL9ko5PFbr9O
         UQn9r6hglHY4I1EySfkLEFZFlfwkmgl7DGUCe9mgqqg0cms+Piiqueqqm41myh1QnyCg
         cXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=Jr3ZXAaZp+fG0BsDre0SQu8BcOQv47QE2HDUkPeXCfo=;
        b=HLAaczJDja0d0y/tB1ZZhq/rSX/NFNkTVcgqcHIsRks2EtunnPonQzCU1L43KTXXcc
         Eoi+F2xBbQxBzSf4/hN15jCvC3m0XaFnk48vJnp8LQqxGRMQs+MtB1TGnpEQHJoegovw
         ju/6++LNUXhX0bAlz4nzVGmq3XyQfxBpYkGEuypXLwv6hnmTaIQ6xS7JuX0RpBKnVepP
         kWB4Vazsw953p73kporUrHE+z9ojEv4kt4ga1ZDyxDL4YeRfhEFZllWugDSYkaiS4sDm
         CJ139BKaDpflJEmJVMOfb7y7NvSPLQ1qtOB4Hu5BjtR/bnmvgta01PhijjmfI0rIpL/i
         IQ4g==
X-Gm-Message-State: AOUpUlHewx02NmgUI3sybVzb6KZ+1Mxjai12T5m5/FmcLdrLRoLT4TjU
        7NcJ2W7HeiYSLi1ZjE6QhM2Xreg1NBg=
X-Google-Smtp-Source: AAOMgpfEyh+IGa/XmA1xasrGReDrhRYzaP/ikYanRFOwUEJIKRQq8Xrdw4+oJ5YEpjmZy3uwxXvRdA==
X-Received: by 2002:a1c:2142:: with SMTP id h63-v6mr1614983wmh.51.1531838570578;
        Tue, 17 Jul 2018 07:42:50 -0700 (PDT)
Received: from [173.194.76.109] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id m17-v6sm1824296wrg.65.2018.07.17.07.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 07:42:49 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] arm64: zynqmp: Add support for Avnet Ultra96 rev1 board
To:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <80d21c84d427cb6b4122efd3dea7f1c4ab4cf2be.1525261987.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <c94812e7-b213-2a3a-30c9-c0f88ecbefb1@monstr.eu>
Date:   Tue, 17 Jul 2018 16:42:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <80d21c84d427cb6b4122efd3dea7f1c4ab4cf2be.1525261987.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Q4VoWRSlmvPqtZehKNftJlcapFmqIaoIV"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q4VoWRSlmvPqtZehKNftJlcapFmqIaoIV
Content-Type: multipart/mixed; boundary="fL0VbY7oosjZ8vhlV0HbmmaeaYZUnY7EE";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <c94812e7-b213-2a3a-30c9-c0f88ecbefb1@monstr.eu>
Subject: Re: [PATCH] arm64: zynqmp: Add support for Avnet Ultra96 rev1 board
References: <80d21c84d427cb6b4122efd3dea7f1c4ab4cf2be.1525261987.git.michal.simek@xilinx.com>
In-Reply-To: <80d21c84d427cb6b4122efd3dea7f1c4ab4cf2be.1525261987.git.michal.simek@xilinx.com>

--fL0VbY7oosjZ8vhlV0HbmmaeaYZUnY7EE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2.5.2018 13:53, Michal Simek wrote:
> Avnet Ultra96 rev1 board is commercialized Xilinx zcu100 revC/D
> internal board. The patch is reusing zcu100 revC files but changing
> model description and compatible strings which are used for example by
> libmraa.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
> I choose this option because there are houndreds of zcu100 boards
> created and this will enable support both versions.
>=20
> Record avnet prefix was sent by separate patch.
> ---
>  arch/arm64/boot/dts/xilinx/Makefile           |  1 +
>  .../boot/dts/xilinx/avnet-ultra96-rev1.dts    | 19 +++++++++++++++++++=

>  2 files changed, 20 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
>=20
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/=
xilinx/Makefile
> index d452f80e7601..60f5443f3ef4 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D avnet-ultra96-rev1.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zc1232-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zc1254-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zc1275-revA.dtb
> diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts b/arch/a=
rm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> new file mode 100644
> index 000000000000..88aa06fa78a8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dts file for Avnet Ultra96 rev1
> + *
> + * (C) Copyright 2018, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "zynqmp-zcu100-revC.dts"
> +
> +/ {
> +	model =3D "Avnet Ultra96 Rev1";
> +	compatible =3D "avnet,ultra96-rev1", "avnet,ultra96",
> +		     "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100",
> +		     "xlnx,zynqmp";
> +};
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



--fL0VbY7oosjZ8vhlV0HbmmaeaYZUnY7EE--

--Q4VoWRSlmvPqtZehKNftJlcapFmqIaoIV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAltOAGIACgkQykllyylKDCFsxQCfYH1+JYQnMNxB4JzugDdMInPa
bp8AoIe6BsggR0prRIkOpRrQTJnBpySl
=b6+P
-----END PGP SIGNATURE-----

--Q4VoWRSlmvPqtZehKNftJlcapFmqIaoIV--
