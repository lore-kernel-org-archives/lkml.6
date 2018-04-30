Return-Path: <lee.jones@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525083509; cv=none;
        d=google.com; s=arc-20160816;
        b=VB884TaRNT7eYgdcnK8OwbA2JYsE9ausBu9ONWq8hrk/5uzpclUqP/fGV8p9EFIr7Y
         n2BTxYBQzkPAhfJPbmMf9kU2bVv8+M4YekxYw1QNGXekklwJLbXHSw+6SXMxHoVHodV5
         K2r+bzMWLNHQzqpj/RTIqPANHp8kfsyF7B+hthqw0gaSj0zVga2zDYLaEjCvwQCBcAl+
         dv99j0NwLGdTiQDdHQFu4xIJGeOln0xGP++1wwsdzEbVQ4CrmMqWyBi9czgs9kKhWrpj
         DT0fnYxmMQIlCW/gOa5NKGHOYobHK5K4Wvjz88p42r0hdoKZdKuunT11TWh3vKJAyIjf
         xAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=m2S+0f8HlBOzrZPgFVwHewUaIT8Nvs4lMkiZGlK5OUU=;
        b=ZEBCM3lk2IsM+BgyBvu/rdfNmbHqc8GqVoHF7dDVjBGqDlqB87eOTlKJh9R8jLNEfA
         Pj1cYHwV5uWIIkHCbolvpz4IV9qe/rFyu94DOWJrMPEn6ILFBfS0bcbkMbBkkABkTtIN
         VmQZ64eZug1I4DtFYDMbTClrtdY1isvkBl9sHgPLH6sAJiMMJYkRr5v9aw62W0PCNpC+
         KAe9cig9VZ6n7M0U+CyLL9vlx/MkcwcM3hWa1jGuG6fyMNVUdZ+MXKnxWV5FoD2MKSmU
         unfQwjpnKlCtsTPgsB6wkjY1xrTtirXSgs6SHaomvQRcgUP7HPpuCV8Ftw2PauVRUIoj
         RPMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=MOCOC2eK;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=MOCOC2eK;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpbSHJTeVKKqWEG3g0hCvlP+bZW5fAlYQpt37Mu2RYd/DzwRQaR6hM0OIC6tbFHs+4x00dnvg==
Date: Mon, 30 Apr 2018 11:18:26 +0100
From: Lee Jones <lee.jones@linaro.org>
To: matthias.bgg@kernel.org
Cc: ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
	robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
	sboyd@codeaurora.org, davem@davemloft.net,
	gregkh@linuxfoundation.org, mchehab@kernel.org,
	rdunlap@infradead.org, sean.wang@mediatek.com,
	linux-clk@vger.kernel.org, linux@armlinux.org.uk,
	matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: Re: [v3 03/10] mfd: mtk-mmsys: Add mmsys driver
Message-ID: <20180430101826.GC5147@dell>
References: <cover.1524820923.git.mbrugger@suse.com>
 <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890783825363754?=
X-GMAIL-MSGID: =?utf-8?q?1599165966723225058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018, matthias.bgg@kernel.org wrote:

> From: Matthias Brugger <mbrugger@suse.com>
> 
> The MMSYS subsystem includes clocks and drm components.
> This patch adds a MFD device to probe both drivers from the same
> device tree compatible.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/mfd/Kconfig     |  9 ++++++
>  drivers/mfd/Makefile    |  2 ++
>  drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 drivers/mfd/mtk-mmsys.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5aa194..d23a3b9a2c58 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
>  
> +config MFD_MEDIATEK_MMSYS
> +	tristate "Mediatek MMSYS interface"
> +	select MFD_CORE
> +	select REGMAP_MMIO
> +	help
> +	  Select this if you have a MMSYS subsystem in your SoC. The
> +	  MMSYS subsystem has at least a clock driver part and some
> +	  DRM components.
> +
>  config MFD_MXS_LRADC
>  	tristate "Freescale i.MX23/i.MX28 LRADC"
>  	depends on ARCH_MXS || COMPILE_TEST
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index d9d2cf0d32ef..b96118bd68d9 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -98,6 +98,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
>  
> +obj-$(CONFIG_MFD_MEDIATEK_MMSYS) += mtk-mmsys.o
> +
>  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
>  
>  obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
> diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
> new file mode 100644
> index 000000000000..c802343fb1c6
> --- /dev/null
> +++ b/drivers/mfd/mtk-mmsys.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * mtk-mmsys.c -- Mediatek MMSYS multi-function driver
> + *
> + * Copyright (c) 2018 Matthias Brugger <matthias.bgg@gmail.com>
> + *
> + * Author: Matthias Brugger <matthias.bgg@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/mfd/core.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +enum {
> +	MMSYS_MT2701 = 1,
> +};
> +
> +static const struct mfd_cell mmsys_mt2701_devs[] = {
> +	{ .name = "clk-mt2701-mm", },
> +	{ .name = "drm-mt2701-mm", },
> +};
> +
> +static int mmsys_probe(struct platform_device *pdev)
> +{
> +	const struct mfd_cell *mmsys_cells;
> +	int nr_cells;
> +	long id;
> +	int ret;
> +
> +	id = (long) of_device_get_match_data(&pdev->dev);
> +	if (!id) {
> +		dev_err(&pdev->dev, "of_device_get match_data() failed\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (id) {
> +	case MMSYS_MT2701:
> +		mmsys_cells = mmsys_mt2701_devs;
> +		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_mfd_add_devices(&pdev->dev, 0, mmsys_cells, nr_cells,
> +					NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +};

This driver is pretty pointless.  It doesn't actually do anything.

I think you just want to use "simple-mfd" instead.

> +static const struct of_device_id of_match_mmsys[] = {
> +	{ .compatible = "mediatek,mt2701-mmsys",
> +	  .data = (void *) MMSYS_MT2701,
> +	},
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver mmsys_drv = {
> +	.probe = mmsys_probe,
> +	.driver = {
> +		.name = "mediatek-mmysys",
> +		.of_match_table = of_match_ptr(of_match_mmsys),
> +	},
> +};
> +
> +builtin_platform_driver(mmsys_drv);
> +
> +MODULE_DESCRIPTION("Mediatek MMSYS multi-function driver");
> +MODULE_LICENSE("GPL");

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
