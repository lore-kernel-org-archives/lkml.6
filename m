Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08936C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CC120881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtsMYaKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CC120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbeGIJ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:26:24 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43189 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754214AbeGIJ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:26:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so34562507oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1hifeIl42OufN1eNDMS/SneCDDtbeuphNImOZxIAQIU=;
        b=KtsMYaKilfudRnVip12fvSCcWltWKGWRld2WDGEpaf03fxLhVefM9BEthb97M1YcLX
         tiZ+IGIcPIFmoq2oQORx4eE7oc5ZGg5tAKfR2bLT3H7eFn+NT19nwK2pzSG5YBVaPbjb
         87/7IzEVORfzxS5cDx2vSwtQRwkRyFGcMMYms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1hifeIl42OufN1eNDMS/SneCDDtbeuphNImOZxIAQIU=;
        b=OMNiBZooJEK7t5nwm6QuVTVyiVMJcd2N2/psGNOQpMtX/KoUfZP8cm1hld+RKYTfg0
         pdHXO9fXfi4bR8FY301xaP1m/qKeKmni3/dyg/HR+RwvjSHw2bh6UfaaJtSZTdYExvRC
         mzSEZ/biniSVW8JpzHfQOz16Bks5EeeBO1XBjJOu75Ib3uypTfmTs9tPxN9WXzotq70K
         VGpY8bAc5q57Cs2lpQleW+laAZI41Bz+RcwMuZdg24ZdYw2eZPQtCP01yS8e0ed8B4iW
         FmC/j6fcTQvWhfFLoWfwF18S+/f1nhJos4nk2C4wkbLuYPZtC/RbC8/hOkjJNBCON6JE
         ku6Q==
X-Gm-Message-State: APt69E1krbgcBVQNfOEvludlgAqX9rAY1YphY+T4s9uFrTzT1G/vNljb
        +aM4MGUiVBNELZUTJkE+eQGzH1+fU/HGsxUlTFIPHA==
X-Google-Smtp-Source: AAOMgpdraLj/EtvHziPm02rU7oo8aDyRAomtUSOhfWRcfrNME/D84OUQ7vzr9bo2Qfcoo9L1fJPTh9EVVtsG4aZBJnc=
X-Received: by 2002:aca:e142:: with SMTP id y63-v6mr23361696oig.128.1531128381842;
 Mon, 09 Jul 2018 02:26:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 02:26:21 -0700 (PDT)
In-Reply-To: <d49c27421b2166dc5d535fb448e6cc11475a2a79.1529908086.git.baolin.wang@linaro.org>
References: <a469ed55cb7c43901eaa8881cdd2a8845616d987.1529908086.git.baolin.wang@linaro.org>
 <d49c27421b2166dc5d535fb448e6cc11475a2a79.1529908086.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 9 Jul 2018 17:26:21 +0800
Message-ID: <CAMz4kuLWAT0aXy=xNPaeBDdixZCxUoE+joWsLMXb6MrmRiBr1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvmem: Add Spreadtrum SC27XX efuse support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, freeman.liu@spreadtrum.com,
        Baolin Wang <baolin.wang@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 25 June 2018 at 14:31, Baolin Wang <baolin.wang@linaro.org> wrote:
> From: Freeman Liu <freeman.liu@spreadtrum.com>
>
> This patch add the efuse driver which is embeded in Spreadtrum SC27XX
> series PMICs. The sc27xx efuse contains 32 blocks and each block's
> data width is 16 bits.
>
> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v1:
>  - Fix one typo.
> ---

Do you have any comments for this patch set? Thanks.

>  drivers/nvmem/Kconfig        |   11 ++
>  drivers/nvmem/Makefile       |    3 +-
>  drivers/nvmem/sc27xx-efuse.c |  263 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 276 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/nvmem/sc27xx-efuse.c
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 54a3c29..0a7a470e 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -181,4 +181,15 @@ config RAVE_SP_EEPROM
>         help
>           Say y here to enable Rave SP EEPROM support.
>
> +config SC27XX_EFUSE
> +       tristate "Spreadtrum SC27XX eFuse Support"
> +       depends on MFD_SC27XX_PMIC || COMPILE_TEST
> +       depends on HAS_IOMEM
> +       help
> +         This is a simple driver to dump specified values of Spreadtrum
> +         SC27XX PMICs from eFuse.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called nvmem-sc27xx-efuse.
> +
>  endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 27e96a8..4e8c616 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -39,4 +39,5 @@ obj-$(CONFIG_NVMEM_SNVS_LPGPR)        += nvmem_snvs_lpgpr.o
>  nvmem_snvs_lpgpr-y             := snvs_lpgpr.o
>  obj-$(CONFIG_RAVE_SP_EEPROM)   += nvmem-rave-sp-eeprom.o
>  nvmem-rave-sp-eeprom-y         := rave-sp-eeprom.o
> -
> +obj-$(CONFIG_SC27XX_EFUSE)     += nvmem-sc27xx-efuse.o
> +nvmem-sc27xx-efuse-y           := sc27xx-efuse.o
> diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
> new file mode 100644
> index 0000000..07c210c
> --- /dev/null
> +++ b/drivers/nvmem/sc27xx-efuse.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Spreadtrum Communications Inc.
> +
> +#include <linux/hwspinlock.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/nvmem-provider.h>
> +
> +/* PMIC global registers definition */
> +#define SC27XX_MODULE_EN               0xc08
> +#define SC27XX_EFUSE_EN                        BIT(6)
> +
> +/* Efuse controller registers definition */
> +#define SC27XX_EFUSE_GLB_CTRL          0x0
> +#define SC27XX_EFUSE_DATA_RD           0x4
> +#define SC27XX_EFUSE_DATA_WR           0x8
> +#define SC27XX_EFUSE_BLOCK_INDEX       0xc
> +#define SC27XX_EFUSE_MODE_CTRL         0x10
> +#define SC27XX_EFUSE_STATUS            0x14
> +#define SC27XX_EFUSE_WR_TIMING_CTRL    0x20
> +#define SC27XX_EFUSE_RD_TIMING_CTRL    0x24
> +#define SC27XX_EFUSE_EFUSE_DEB_CTRL    0x28
> +
> +/* Mask definition for SC27XX_EFUSE_BLOCK_INDEX register */
> +#define SC27XX_EFUSE_BLOCK_MASK                GENMASK(4, 0)
> +
> +/* Bits definitions for SC27XX_EFUSE_MODE_CTRL register */
> +#define SC27XX_EFUSE_PG_START          BIT(0)
> +#define SC27XX_EFUSE_RD_START          BIT(1)
> +#define SC27XX_EFUSE_CLR_RDDONE                BIT(2)
> +
> +/* Bits definitions for SC27XX_EFUSE_STATUS register */
> +#define SC27XX_EFUSE_PGM_BUSY          BIT(0)
> +#define SC27XX_EFUSE_READ_BUSY         BIT(1)
> +#define SC27XX_EFUSE_STANDBY           BIT(2)
> +#define SC27XX_EFUSE_GLOBAL_PROT       BIT(3)
> +#define SC27XX_EFUSE_RD_DONE           BIT(4)
> +
> +/* Block number and block width (bytes) definitions */
> +#define SC27XX_EFUSE_BLOCK_MAX         32
> +#define SC27XX_EFUSE_BLOCK_WIDTH       2
> +
> +/* Timeout (ms) for the trylock of hardware spinlocks */
> +#define SC27XX_EFUSE_HWLOCK_TIMEOUT    5000
> +
> +/* Timeout (us) of polling the status */
> +#define SC27XX_EFUSE_POLL_TIMEOUT      3000000
> +#define SC27XX_EFUSE_POLL_DELAY_US     10000
> +
> +struct sc27xx_efuse {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       struct hwspinlock *hwlock;
> +       struct mutex mutex;
> +       u32 base;
> +};
> +
> +/*
> + * On Spreadtrum platform, we have multi-subsystems will access the unique
> + * efuse controller, so we need one hardware spinlock to synchronize between
> + * the multiple subsystems.
> + */
> +static int sc27xx_efuse_lock(struct sc27xx_efuse *efuse)
> +{
> +       int ret;
> +
> +       mutex_lock(&efuse->mutex);
> +
> +       ret = hwspin_lock_timeout_raw(efuse->hwlock,
> +                                     SC27XX_EFUSE_HWLOCK_TIMEOUT);
> +       if (ret) {
> +               dev_err(efuse->dev, "timeout to get the hwspinlock\n");
> +               mutex_unlock(&efuse->mutex);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void sc27xx_efuse_unlock(struct sc27xx_efuse *efuse)
> +{
> +       hwspin_unlock_raw(efuse->hwlock);
> +       mutex_unlock(&efuse->mutex);
> +}
> +
> +static int sc27xx_efuse_poll_status(struct sc27xx_efuse *efuse, u32 bits)
> +{
> +       int ret;
> +       u32 val;
> +
> +       ret = regmap_read_poll_timeout(efuse->regmap,
> +                                      efuse->base + SC27XX_EFUSE_STATUS,
> +                                      val, (val & bits),
> +                                      SC27XX_EFUSE_POLL_DELAY_US,
> +                                      SC27XX_EFUSE_POLL_TIMEOUT);
> +       if (ret) {
> +               dev_err(efuse->dev, "timeout to update the efuse status\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sc27xx_efuse_read(void *context, u32 offset, void *val, size_t bytes)
> +{
> +       struct sc27xx_efuse *efuse = context;
> +       u32 buf;
> +       int ret;
> +
> +       if (offset > SC27XX_EFUSE_BLOCK_MAX || bytes > SC27XX_EFUSE_BLOCK_WIDTH)
> +               return -EINVAL;
> +
> +       ret = sc27xx_efuse_lock(efuse);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable the efuse controller. */
> +       ret = regmap_update_bits(efuse->regmap, SC27XX_MODULE_EN,
> +                                SC27XX_EFUSE_EN, SC27XX_EFUSE_EN);
> +       if (ret)
> +               goto unlock_efuse;
> +
> +       /*
> +        * Before reading, we should ensure the efuse controller is in
> +        * standby state.
> +        */
> +       ret = sc27xx_efuse_poll_status(efuse, SC27XX_EFUSE_STANDBY);
> +       if (ret)
> +               goto disable_efuse;
> +
> +       /* Set the block address to be read. */
> +       ret = regmap_write(efuse->regmap, efuse->base + SC27XX_EFUSE_BLOCK_INDEX,
> +                          offset & SC27XX_EFUSE_BLOCK_MASK);
> +       if (ret)
> +               goto disable_efuse;
> +
> +       /* Start reading process from efuse memory. */
> +       ret = regmap_update_bits(efuse->regmap,
> +                                efuse->base + SC27XX_EFUSE_MODE_CTRL,
> +                                SC27XX_EFUSE_RD_START,
> +                                SC27XX_EFUSE_RD_START);
> +       if (ret)
> +               goto disable_efuse;
> +
> +       /*
> +        * Polling the read done status to make sure the reading process
> +        * is completed, that means the data can be read out now.
> +        */
> +       ret = sc27xx_efuse_poll_status(efuse, SC27XX_EFUSE_RD_DONE);
> +       if (ret)
> +               goto disable_efuse;
> +
> +       /* Read data from efuse memory. */
> +       ret = regmap_read(efuse->regmap, efuse->base + SC27XX_EFUSE_DATA_RD,
> +                         &buf);
> +       if (ret)
> +               goto disable_efuse;
> +
> +       /* Clear the read done flag. */
> +       ret = regmap_update_bits(efuse->regmap,
> +                                efuse->base + SC27XX_EFUSE_MODE_CTRL,
> +                                SC27XX_EFUSE_CLR_RDDONE,
> +                                SC27XX_EFUSE_CLR_RDDONE);
> +
> +disable_efuse:
> +       /* Disable the efuse controller after reading. */
> +       regmap_update_bits(efuse->regmap, SC27XX_MODULE_EN, SC27XX_EFUSE_EN, 0);
> +unlock_efuse:
> +       sc27xx_efuse_unlock(efuse);
> +
> +       if (!ret)
> +               memcpy(val, &buf, bytes);
> +
> +       return ret;
> +}
> +
> +static int sc27xx_efuse_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct nvmem_config econfig = { };
> +       struct nvmem_device *nvmem;
> +       struct sc27xx_efuse *efuse;
> +       int ret;
> +
> +       efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
> +       if (!efuse)
> +               return -ENOMEM;
> +
> +       efuse->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!efuse->regmap) {
> +               dev_err(&pdev->dev, "failed to get efuse regmap\n");
> +               return -ENODEV;
> +       }
> +
> +       ret = of_property_read_u32(np, "reg", &efuse->base);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to get efuse base address\n");
> +               return ret;
> +       }
> +
> +       ret = of_hwspin_lock_get_id(np, 0);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to get hwspinlock id\n");
> +               return ret;
> +       }
> +
> +       efuse->hwlock = hwspin_lock_request_specific(ret);
> +       if (!efuse->hwlock) {
> +               dev_err(&pdev->dev, "failed to request hwspinlock\n");
> +               return -ENXIO;
> +       }
> +
> +       mutex_init(&efuse->mutex);
> +       efuse->dev = &pdev->dev;
> +       platform_set_drvdata(pdev, efuse);
> +
> +       econfig.stride = 1;
> +       econfig.word_size = 1;
> +       econfig.read_only = true;
> +       econfig.name = "sc27xx-efuse";
> +       econfig.size = SC27XX_EFUSE_BLOCK_MAX * SC27XX_EFUSE_BLOCK_WIDTH;
> +       econfig.reg_read = sc27xx_efuse_read;
> +       econfig.priv = efuse;
> +       econfig.dev = &pdev->dev;
> +       nvmem = devm_nvmem_register(&pdev->dev, &econfig);
> +       if (IS_ERR(nvmem)) {
> +               dev_err(&pdev->dev, "failed to register nvmem config\n");
> +               hwspin_lock_free(efuse->hwlock);
> +               return PTR_ERR(nvmem);
> +       }
> +
> +       return 0;
> +}
> +
> +static int sc27xx_efuse_remove(struct platform_device *pdev)
> +{
> +       struct sc27xx_efuse *efuse = platform_get_drvdata(pdev);
> +
> +       hwspin_lock_free(efuse->hwlock);
> +       return 0;
> +}
> +
> +static const struct of_device_id sc27xx_efuse_of_match[] = {
> +       { .compatible = "sprd,sc2731-efuse" },
> +       { }
> +};
> +
> +static struct platform_driver sc27xx_efuse_driver = {
> +       .probe = sc27xx_efuse_probe,
> +       .remove = sc27xx_efuse_remove,
> +       .driver = {
> +               .name = "sc27xx-efuse",
> +               .of_match_table = sc27xx_efuse_of_match,
> +       },
> +};
> +
> +module_platform_driver(sc27xx_efuse_driver);
> +
> +MODULE_AUTHOR("Freeman Liu <freeman.liu@spreadtrum.com>");
> +MODULE_DESCRIPTION("Spreadtrum SC27xx efuse driver");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.9.5
>



-- 
Baolin Wang
Best Regards
