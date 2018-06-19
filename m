Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EB52083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="lUiZ+BO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EB52083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965576AbeFSIhP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:37:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35093 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965400AbeFSIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:37:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so20481749wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=DKsYBbXyY9JvwIyoNUTwHg0qswjhMAFilzmYhZ6yjEg=;
        b=lUiZ+BO2Cwo0ePKdF5helYOPouO1hu9kSdZ0eR3fmdMAtya1C8ZjveYI4AwjvTBw7w
         t4P4eLpYcpb0wbpdeeXHoTzGZ6LP1PW0ozJiYq/XqLA6y5SvyrYELegVhsGKK98XEbXd
         C7DfbW9qUZ0hQTmfIuqiAmyAR2r940gqTtEBl07H8GbSvAnWYw9j+/0dq5fxtjstSQU5
         E0Lg+FAeinrj1th8kCtqFIfSjfIq71+KhnPA4c1BWSZVMEKR2H5DtolAANATYpQvZ/3e
         Q3u38eGxPLLKv8+NYXMQMcaqq6K5p3AHSzbOg763DV4lLp/6IwYmp4blCpcwJaGpvTKN
         HWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=DKsYBbXyY9JvwIyoNUTwHg0qswjhMAFilzmYhZ6yjEg=;
        b=iM366Y69gtmEtDx4OablCcENu3s0y8VvGbdEXUcFwPpk1fG9dcbnqhKU6TODZfI8jF
         uHrb+9//+Z73cDGCCuTMCr6EE1VZPp2PhXRKnm6RmmXYaFIUGQ/RYouAfLzlXC/Rn8xT
         kRj+2Ank9qkjsr0ILwXN/8j2rllqdjAkn1GDXWDWNLxwWBDh4/TpinNXbE3rWsH4fzey
         ziwSSBgDr+yIuYZ0zFD57y9N5MBrwIv0bKYNFPLH8hQUwmL2fvJBvelqA9znvTVV1eek
         AJxtPxvVMMsyRasfQnVjpQJQvNmF4DzsvDKWYGCYufs9KOKoIlmIQ9DgDZVEd6I0o2OS
         1xwQ==
X-Gm-Message-State: APt69E1a2hLX6yvbwPyUAfq9f/+WVk5dTA1bY3rWtyNmdmM+gtdOK2G+
        Q+hJsfp+YAd6jOzJDjTktAu0Pw==
X-Google-Smtp-Source: ADUXVKKQiibQQ+Xp2nRM1s0BYUIo6DHvnIc/S9gaIK9Z+kWbySK7rMavP70tUVns7SiyoJ5yUNf0KA==
X-Received: by 2002:a1c:3fc2:: with SMTP id m185-v6mr10644759wma.37.1529397425400;
        Tue, 19 Jun 2018 01:37:05 -0700 (PDT)
Received: from [74.125.133.108] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id 137-v6sm14016623wmv.28.2018.06.19.01.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:37:04 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] arm64: zynqmp: Add support for Avnet Ultra96 rev1 board
To:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <80d21c84d427cb6b4122efd3dea7f1c4ab4cf2be.1525261987.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <dcee0f07-967a-034b-1d95-576e0b458a89@monstr.eu>
Date:   Tue, 19 Jun 2018 10:36:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <80d21c84d427cb6b4122efd3dea7f1c4ab4cf2be.1525261987.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6zrnCMMaOPas4drc4d0BGaJruzJCwcT4r"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6zrnCMMaOPas4drc4d0BGaJruzJCwcT4r
Content-Type: multipart/mixed; boundary="mwZ8ia8sao6vWVPeO1Jym8xxE6Onedmee";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <dcee0f07-967a-034b-1d95-576e0b458a89@monstr.eu>
Subject: Re: [PATCH] arm64: zynqmp: Add support for Avnet Ultra96 rev1 board
References: <80d21c84d427cb6b4122efd3dea7f1c4ab4cf2be.1525261987.git.michal.simek@xilinx.com>
In-Reply-To: <80d21c84d427cb6b4122efd3dea7f1c4ab4cf2be.1525261987.git.michal.simek@xilinx.com>

--mwZ8ia8sao6vWVPeO1Jym8xxE6Onedmee
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

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

Rob/Mark: Do you see any issue with this patch?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--mwZ8ia8sao6vWVPeO1Jym8xxE6Onedmee--

--6zrnCMMaOPas4drc4d0BGaJruzJCwcT4r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlsowKkACgkQykllyylKDCFc4QCfXdIDkzbxUIbcNV6Z0DxWCU2p
vqIAn1pe9S1OC3T79+ojvHafVdMabd1z
=zd4f
-----END PGP SIGNATURE-----

--6zrnCMMaOPas4drc4d0BGaJruzJCwcT4r--
