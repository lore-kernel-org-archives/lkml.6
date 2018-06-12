Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0E003C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D172086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8GTqpuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D172086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933380AbeFLMRR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:17:17 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44504 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932412AbeFLMRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:17:14 -0400
Received: by mail-lf0-f66.google.com with SMTP id 36-v6so35628615lfr.11;
        Tue, 12 Jun 2018 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uxHkWeVDKDUq3oWOdHMGHyJ27XYM1opXlswCW+qXf6E=;
        b=J8GTqpuW8uOSEdBJZr/DprvMRS/ha+6tAKIjJ185a0RDbOiAKWPOPFFE5M3NA2CHpB
         eg5CpCgM5SMG+28DUFf5lYfSRBFIjTzCjg2b1cgziEk6whuYGoA6ooJosoKus+1z+MHM
         ugAL/RQCUJVBBk2N53KtCTt71f9CeWg5wOxYDglgdooAnXMNiqKf/T2QVxfM2SW/YiDT
         MlWGX+P9rNqZpC8iOsSwjlLBjPjIVHO//KBb6Ng7HOp8pTJNCObO2P7x4QEOmWC1b4nx
         K6dyWEHifDnIokSqYoQk0iHMiax75nOg6we71Z/6O0JVHdGrPlIuswsfRwPj8mM96YVn
         d3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uxHkWeVDKDUq3oWOdHMGHyJ27XYM1opXlswCW+qXf6E=;
        b=UnC5gV4+cZjWpVeaFx6mHXjSLAZFfNPbjIRt41+QlNqzqom2GDrwII0FbMSS4WFr0F
         765xMOmIBCKwLazL5SKgoLrftqoBFxqF7amt/czl8jEra+6+nVgAnqTZ2fEZEqnVWepC
         yR6m8odI5JjZ241Qp61/GUU55D6WhRM1dSBoWATHxr/ORC06YDSsnWAZ4LV6DjNiMnP2
         DIEYZY78XMdLAV2TuYKf/Tk01rabaVBtwpquhZ1Z061vU6/fLy6o6c2cCLvUiC09SHHE
         3Aka9m8MPdVaggE38WaPnmCSetpC2iPaWUmUi2EZmn5D+BEvrOH29x8t+yAvglkbuG0g
         PtTw==
X-Gm-Message-State: APt69E0StmrW+niD/JrzAoos12eGxN83KHgaV9uldMD/Uhv18UCMcaRA
        /PLlOpvsw94T8EvC0egcFmE=
X-Google-Smtp-Source: ADUXVKIjvae/Qdl4Jex5BCYoQ9EYOncdlG0ESH378tQpXJTd5rVWStvHRwMhyiMxjCSq5p92+pbPvw==
X-Received: by 2002:a19:920a:: with SMTP id u10-v6mr82839lfd.33.1528805832974;
        Tue, 12 Jun 2018 05:17:12 -0700 (PDT)
Received: from dimapc.localnet (109-252-55-139.nat.spd-mgts.ru. [109.252.55.139])
        by smtp.gmail.com with ESMTPSA id v14-v6sm3391ljg.66.2018.06.12.05.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 05:17:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver
Date:   Tue, 12 Jun 2018 15:17:09 +0300
Message-ID: <1545813.ZRopxvRBbF@dimapc>
In-Reply-To: <20180611205224.23340-5-stefan@agner.ch>
References: <20180611205224.23340-1-stefan@agner.ch> <20180611205224.23340-5-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 11 June 2018 23:52:22 MSK Stefan Agner wrote:
> Add support for the NAND flash controller found on NVIDIA
> Tegra 2 SoCs. This implementation does not make use of the
> command queue feature. Regular operations/data transfers are
> done in PIO mode. Page read/writes with hardware ECC make
> use of the DMA for data transfer.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  MAINTAINERS                       |    7 +
>  drivers/mtd/nand/raw/Kconfig      |    6 +
>  drivers/mtd/nand/raw/Makefile     |    1 +
>  drivers/mtd/nand/raw/tegra_nand.c | 1248 +++++++++++++++++++++++++++++
>  4 files changed, 1262 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 58b9861ccf99..c2e5571c85d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13844,6 +13844,13 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
>  S:	Supported
>  F:	drivers/input/keyboard/tegra-kbc.c
> 
> +TEGRA NAND DRIVER
> +M:	Stefan Agner <stefan@agner.ch>
> +M:	Lucas Stach <dev@lynxeye.de>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
> +F:	drivers/mtd/nand/raw/tegra_nand.c
> +
>  TEGRA PWM DRIVER
>  M:	Thierry Reding <thierry.reding@gmail.com>
>  S:	Supported
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 19a2b283fbbe..e9093f52371e 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -534,4 +534,10 @@ config MTD_NAND_MTK
>  	  Enables support for NAND controller on MTK SoCs.
>  	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
> 
> +config MTD_NAND_TEGRA
> +	tristate "Support for NAND controller on NVIDIA Tegra"
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	help
> +	  Enables support for NAND flash controller on NVIDIA Tegra SoC.
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index 165b7ef9e9a1..d5a5f9832b88 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        += 
hisi504_nand.o
>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
>  obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
> +obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
> 
>  nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
>  nand-objs += nand_amd.o
> diff --git a/drivers/mtd/nand/raw/tegra_nand.c
> b/drivers/mtd/nand/raw/tegra_nand.c new file mode 100644
> index 000000000000..dd23a5eb6af3
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/tegra_nand.c
> @@ -0,0 +1,1248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Stefan Agner <stefan@agner.ch>
> + * Copyright (C) 2014-2015 Lucas Stach <dev@lynxeye.de>
> + * Copyright (C) 2012 Avionic Design GmbH
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>

The "delay.h" looks obsolete now, maybe you could drop it.


