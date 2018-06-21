Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A142C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F131C20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="GOOPm/6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F131C20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933288AbeFULwD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:52:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55563 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeFULwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:52:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so4661660wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=nCfTQ3HO1q3DYaJ9p9byFq9dMNVavyDRQ/o75lvFDA0=;
        b=GOOPm/6nZkoOYP1IuSy1YtqdhMlKIchoT4/8XmJkue4QgvSby4w1daYSXwQvn74uCz
         Vh1aimw6+4y1+5MYb2UoCaDFieIZYF1HjBNCyyknsdpDX6Pni4xANuQclZ+83QHiNlAo
         J+HKIkY+lzhbWu7CXGWeEmhVHVm08uvTucljknmEnJ34W4RaaSjl92DrnjLJ+hdT4djY
         lEeYBRfz9beypCDnd/xHYwAl0tm/JciniTKO5kYibC5jD6kdPhXfNKOsSs0OMQNLt1qP
         tlycsA3L8bo1r2hbGyPQ8K6v6A2HaL0ee1CMEYamKfdZVAgdkf+fH1KwPb934lLv5rVf
         dbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=nCfTQ3HO1q3DYaJ9p9byFq9dMNVavyDRQ/o75lvFDA0=;
        b=Fcmu3SM61mpYK5CkPRxWf5vR3/Ymbfyhb8MYmXT0NFXr5/PnOK9PH87c+rNw+PWuQB
         6muB+egcaONVkhRHGuaBszSQ3n1xpQCslAiEqA9+J1UY7ffx2RvF+xpXfWsxxYAGVu9T
         x2Z4UQ8idi/nGs1uuxQDkuzHKYO1kW5bnzVx+AHOY1RzsYC3Wi402Wdzp6fGFEKU/2nu
         Pm3/z+W5aUeHMBHHEyd5QBuN61N3sVDGDWp9r78TcNT1yhuPe/yWYIGPqQQZEvp+FZge
         MxeqEbCRgYuDguBsaByi2ErNKJOggPp9pmivrEHvMGb94BLMBdndJd3os2fl6t7yCOBZ
         9NsA==
X-Gm-Message-State: APt69E3MAG3w8HJ5wCfrcVRlkTxZKFxwp/9mc+PMNGFn9VB+I3uq0mb6
        73l5G+a0+PmKwoJe0/BuPW/xxLX6
X-Google-Smtp-Source: ADUXVKIi+YGitU7K2pNlGGPfZGVpuy6mqVGUHt/DG09qF/pwem7Bf5jVwBWbi99faIUsvr1zcJvntQ==
X-Received: by 2002:a1c:dac2:: with SMTP id r185-v6mr4689023wmg.31.1529581920326;
        Thu, 21 Jun 2018 04:52:00 -0700 (PDT)
Received: from [64.233.167.108] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id g88-v6sm7042521wmc.27.2018.06.21.04.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 04:51:59 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 2/2] microblaze: consolidate GPIO reset handling
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180619213620.14146-1-robh@kernel.org>
 <20180619213620.14146-2-robh@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <210dabef-21fa-8b39-0191-977b5175e1f1@monstr.eu>
Date:   Thu, 21 Jun 2018 13:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619213620.14146-2-robh@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lVh5aFGZOVqxT2vZf4znyXy2AxoHMHtq0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lVh5aFGZOVqxT2vZf4znyXy2AxoHMHtq0
Content-Type: multipart/mixed; boundary="H5oZDvDcLMaR0AbNjaOwkSl8FzirdbwAt";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <210dabef-21fa-8b39-0191-977b5175e1f1@monstr.eu>
Subject: Re: [PATCH 2/2] microblaze: consolidate GPIO reset handling
References: <20180619213620.14146-1-robh@kernel.org>
 <20180619213620.14146-2-robh@kernel.org>
In-Reply-To: <20180619213620.14146-2-robh@kernel.org>

--H5oZDvDcLMaR0AbNjaOwkSl8FzirdbwAt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.6.2018 23:36, Rob Herring wrote:
> Now that platform.c only has the GPIO reset handling left, move the
> initcall to reset.c and remove platform.c.
>=20
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/microblaze/include/asm/setup.h |  2 --
>  arch/microblaze/kernel/Makefile     |  2 +-
>  arch/microblaze/kernel/platform.c   | 22 ----------------------
>  arch/microblaze/kernel/reset.c      | 11 ++++++-----
>  4 files changed, 7 insertions(+), 30 deletions(-)
>  delete mode 100644 arch/microblaze/kernel/platform.c
>=20
> diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/incl=
ude/asm/setup.h
> index d5384f6f36f7..86d2663d3fd0 100644
> --- a/arch/microblaze/include/asm/setup.h
> +++ b/arch/microblaze/include/asm/setup.h
> @@ -26,8 +26,6 @@ void microblaze_setup_heartbeat(void);
>  extern void mmu_reset(void);
>  #   endif /* CONFIG_MMU */
> =20
> -extern void of_platform_reset_gpio_probe(void);
> -
>  void time_init(void);
>  void init_IRQ(void);
>  void machine_early_init(const char *cmdline, unsigned int ram,
> diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/M=
akefile
> index 7e99cf6984a1..6c4c54826aae 100644
> --- a/arch/microblaze/kernel/Makefile
> +++ b/arch/microblaze/kernel/Makefile
> @@ -17,7 +17,7 @@ extra-y :=3D head.o vmlinux.lds
> =20
>  obj-y +=3D dma.o exceptions.o \
>  	hw_exception_handler.o irq.o \
> -	platform.o process.o prom.o ptrace.o \
> +	process.o prom.o ptrace.o \
>  	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
> =20
>  obj-y +=3D cpu/
> diff --git a/arch/microblaze/kernel/platform.c b/arch/microblaze/kernel=
/platform.c
> deleted file mode 100644
> index b9a414552d9b..000000000000
> --- a/arch/microblaze/kernel/platform.c
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/*
> - * Copyright 2008 Michal Simek <monstr@monstr.eu>
> - *
> - * based on virtex.c file
> - *
> - * Copyright 2007 Secret Lab Technologies Ltd.
> - *
> - * This file is licensed under the terms of the GNU General Public Lic=
ense
> - * version 2. This program is licensed "as is" without any warranty of=
 any
> - * kind, whether express or implied.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/of_platform.h>
> -#include <asm/setup.h>
> -
> -static int __init microblaze_device_probe(void)
> -{
> -	of_platform_reset_gpio_probe();
> -	return 0;
> -}
> -device_initcall(microblaze_device_probe);
> diff --git a/arch/microblaze/kernel/reset.c b/arch/microblaze/kernel/re=
set.c
> index bab4c8330ef4..fcbe1daf6316 100644
> --- a/arch/microblaze/kernel/reset.c
> +++ b/arch/microblaze/kernel/reset.c
> @@ -18,7 +18,7 @@
>  static int handle; /* reset pin handle */
>  static unsigned int reset_val;
> =20
> -void of_platform_reset_gpio_probe(void)
> +static int of_platform_reset_gpio_probe(void)
>  {
>  	int ret;
>  	handle =3D of_get_named_gpio(of_find_node_by_path("/"),
> @@ -27,13 +27,13 @@ void of_platform_reset_gpio_probe(void)
>  	if (!gpio_is_valid(handle)) {
>  		pr_info("Skipping unavailable RESET gpio %d (%s)\n",
>  				handle, "reset");
> -		return;
> +		return -ENODEV;
>  	}
> =20
>  	ret =3D gpio_request(handle, "reset");
>  	if (ret < 0) {
>  		pr_info("GPIO pin is already allocated\n");
> -		return;
> +		return ret;
>  	}
> =20
>  	/* get current setup value */
> @@ -51,11 +51,12 @@ void of_platform_reset_gpio_probe(void)
> =20
>  	pr_info("RESET: Registered gpio device: %d, current val: %d\n",
>  							handle, reset_val);
> -	return;
> +	return 0;
>  err:
>  	gpio_free(handle);
> -	return;
> +	return ret;
>  }
> +device_initcall(of_platform_reset_gpio_probe);
> =20
> =20
>  static void gpio_system_reset(void)
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



--H5oZDvDcLMaR0AbNjaOwkSl8FzirdbwAt--

--lVh5aFGZOVqxT2vZf4znyXy2AxoHMHtq0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlsrkVoACgkQykllyylKDCHyxwCfTDkCxUhn1L8ufJcd/qy/WZBC
86QAn3oEKZhIeJrFWDIEL6m9vEIfxGug
=92Yn
-----END PGP SIGNATURE-----

--lVh5aFGZOVqxT2vZf4znyXy2AxoHMHtq0--
