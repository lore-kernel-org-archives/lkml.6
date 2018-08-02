Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E6EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03CD21473
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v1wVnic2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03CD21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeHBK2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:28:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46523 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHBK2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:28:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id h14-v6so1206241wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=f0kQJTQLbrSSI5vBPdBeOnMvnHwTfz3ASPRoOQzTUSQ=;
        b=v1wVnic2ala2riGqbGAKlsM+0vvoQ/2CbETQhc8H4WfOIOoQncKyRCPxlyG1xn+6Hw
         xAzcQR/UEkoQ58s16rCrM9Q8o8rZgMobVUCzjmJdok/cTuUhOFOIY1/eQeGqeh2ZJbmq
         G7Q95Rumslad/ENubS4b8uyhTE5t7kr3IhiDKtqTytzuJDjjo8WZCL8C7U7AdLZHZsj9
         JHZl1QYm75cPW+DhTNpN9m6ypDcGEgUUPpCnbcdzbUDDmbBT9xKkqSqCs0hcfv5fcqcw
         vjjV3GxZ81cv8i8G0mM29cn9W/2gz78BmgegUSKoYlb+CgtgOLT5vBvE0dpKYcFLvNoI
         9+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=f0kQJTQLbrSSI5vBPdBeOnMvnHwTfz3ASPRoOQzTUSQ=;
        b=fcD9n2O57TDhUwQjIiT3bBD7W8HLaa/hM+gWoUSKaRteWDNmURTbnEqaI3CPcF567Q
         NvV3zQAfPkg4DDF50dxRaO5CAAa455DIy0T5lTO/hG8UPt7ZQZ2481/1aDlfpOAwQkTA
         l33ldIf/6QWmYq5q5vCmHFty9YNom4jRV5JpLoO0gg2xhTba/VM+e663IJqNQw2si1l6
         hxMJl0vLBVg7ReaByW9Qd62wwBpxgxCB7QYsfHaWxu6spslKya1EEdquIwimt8I0EJet
         CdhdvrBAfh1LwgIvCKSvxGxQGWjrl+2xI37G8akVxN79HWnotd+YjWTAOwgtUaCniNir
         lc/A==
X-Gm-Message-State: AOUpUlEWWkpCVamGvNKvEs6KMjs52tJEY/BvqfVvDtnwPmT+WRy5dyV/
        tCgBpvN2LOC89ldF//8pktWml+xiiko=
X-Google-Smtp-Source: AAOMgpc6ihFTVb9gBtRCAW9rQm6roXsFEzeie1/UBLIrd4ux50U0Uow/LakPcZ8DRJIrdjUk0e1JXQ==
X-Received: by 2002:adf:dbc3:: with SMTP id e3-v6mr1196909wrj.217.1533199115272;
        Thu, 02 Aug 2018 01:38:35 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n14-v6sm987715wmc.14.2018.08.02.01.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:38:34 -0700 (PDT)
Subject: Re: [PATCH 1/4] soc: amlogic: add meson-canvas driver
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-2-maxi.jourdan@wanadoo.fr>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <e647ae84-35d9-caba-1dc2-302138e41505@baylibre.com>
Date:   Thu, 2 Aug 2018 10:38:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801185128.23440-2-maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 01/08/2018 20:51, Maxime Jourdan wrote:
> Amlogic SoCs have a repository of 256 canvas which they use to
> describe pixel buffers.
> 
> They contain metadata like width, height, block mode, endianness [..]
> 
> Many IPs within those SoCs like vdec/vpu rely on those canvas to read/write
> pixels.
> 
> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> ---
>  drivers/soc/amlogic/Kconfig              |   7 +
>  drivers/soc/amlogic/Makefile             |   1 +
>  drivers/soc/amlogic/meson-canvas.c       | 182 +++++++++++++++++++++++
>  include/linux/soc/amlogic/meson-canvas.h |  37 +++++
>  4 files changed, 227 insertions(+)
>  create mode 100644 drivers/soc/amlogic/meson-canvas.c
>  create mode 100644 include/linux/soc/amlogic/meson-canvas.h
> 
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index b04f6e4aedbc..5bd049899d88 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -1,5 +1,12 @@
>  menu "Amlogic SoC drivers"
>  
> +config MESON_CANVAS
> +	bool "Amlogic Meson Canvas driver"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	default ARCH_MESON
> +	help
> +	  Say yes to support the canvas IP within Amlogic Meson Soc family.
> +
>  config MESON_GX_SOCINFO
>  	bool "Amlogic Meson GX SoC Information driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> index 8fa321893928..0ab16d35ac36 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
> new file mode 100644
> index 000000000000..671eb89c8904
> --- /dev/null
> +++ b/drivers/soc/amlogic/meson-canvas.c
> @@ -0,0 +1,182 @@
> +/*
> + * Copyright (C) 2018 Maxime Jourdan
> + * Copyright (C) 2016 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
> + * Copyright (C) 2014 Endless Mobile
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

Please switch to the spdx header format here and in the .h.

> +
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/soc/amlogic/meson-canvas.h>
> +#include <asm/io.h>
> +
> +#define NUM_CANVAS 256
> +
> +/* DMC Registers */
> +#define DMC_CAV_LUT_DATAL	0x48 /* 0x12 offset in data sheet */
> +	#define CANVAS_WIDTH_LBIT	29
> +	#define CANVAS_WIDTH_LWID       3
> +#define DMC_CAV_LUT_DATAH	0x4c /* 0x13 offset in data sheet */
> +	#define CANVAS_WIDTH_HBIT       0
> +	#define CANVAS_HEIGHT_BIT       9
> +	#define CANVAS_BLKMODE_BIT      24
> +#define DMC_CAV_LUT_ADDR	0x50 /* 0x14 offset in data sheet */
> +	#define CANVAS_LUT_WR_EN        (0x2 << 8)
> +	#define CANVAS_LUT_RD_EN        (0x1 << 8)
> +
> +struct meson_canvas {
> +	struct device *dev;
> +	struct regmap *regmap_dmc;
> +	struct mutex lock;
> +	u8 used[NUM_CANVAS];
> +};
> +
> +static struct meson_canvas canvas = { 0 };
> +
> +static int meson_canvas_setup(uint8_t canvas_index, uint32_t addr,
> +			uint32_t stride, uint32_t height,
> +			unsigned int wrap,
> +			unsigned int blkmode,
> +			unsigned int endian)
> +{
> +	struct regmap *regmap = canvas.regmap_dmc;
> +	u32 val;
> +
> +	mutex_lock(&canvas.lock);

In the DRM driver these are updated in IRQ context, we should make sure we don't sleep
in interrupt context if IRQ occurs when the VDEC updates it's canvases.

Could you switch to spin_lock_irqsave() instead ?

> +
> +	if (!canvas.used[canvas_index]) {
> +		dev_err(canvas.dev,
> +			"Trying to setup non allocated canvas %u\n",
> +			canvas_index);
> +		mutex_unlock(&canvas.lock);
> +		return -EINVAL;
> +	}
> +
> +	regmap_write(regmap, DMC_CAV_LUT_DATAL,
> +		((addr + 7) >> 3) |
> +		(((stride + 7) >> 3) << CANVAS_WIDTH_LBIT));
> +
> +	regmap_write(regmap, DMC_CAV_LUT_DATAH,
> +		((((stride + 7) >> 3) >> CANVAS_WIDTH_LWID) <<
> +						CANVAS_WIDTH_HBIT) |
> +		(height << CANVAS_HEIGHT_BIT) |
> +		(wrap << 22) |
> +		(blkmode << CANVAS_BLKMODE_BIT) |
> +		(endian << 26));
> +
> +	regmap_write(regmap, DMC_CAV_LUT_ADDR,
> +		CANVAS_LUT_WR_EN | canvas_index);
> +
> +	/* Force a read-back to make sure everything is flushed. */
> +	regmap_read(regmap, DMC_CAV_LUT_DATAH, &val);
> +	mutex_unlock(&canvas.lock);
> +
> +	return 0;
> +}
> +
> +static int meson_canvas_alloc(uint8_t *canvas_index)
> +{
> +	int i;
> +
> +	mutex_lock(&canvas.lock);
> +	for (i = 0; i < NUM_CANVAS; ++i) {
> +		if (!canvas.used[i]) {
> +			canvas.used[i] = 1;
> +			mutex_unlock(&canvas.lock);
> +			*canvas_index = i;
> +			return 0;
> +		}
> +	}
> +	mutex_unlock(&canvas.lock);
> +	dev_err(canvas.dev, "No more canvas available\n");
> +
> +	return -ENODEV;
> +}
> +
> +static int meson_canvas_free(uint8_t canvas_index)
> +{
> +	mutex_lock(&canvas.lock);
> +	if (!canvas.used[canvas_index]) {
> +		dev_err(canvas.dev,
> +			"Trying to free unused canvas %u\n", canvas_index);
> +		mutex_unlock(&canvas.lock);
> +		return -EINVAL;
> +	}
> +	canvas.used[canvas_index] = 0;
> +	mutex_unlock(&canvas.lock);
> +
> +	return 0;
> +}
> +
> +static struct meson_canvas_platform_data canvas_platform_data = {
> +	.alloc = meson_canvas_alloc,
> +	.free = meson_canvas_free,
> +	.setup = meson_canvas_setup,
> +};
> +
> +static int meson_canvas_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap_dmc;
> +	struct device *dev;
> +
> +	dev = &pdev->dev;
> +
> +	regmap_dmc = syscon_node_to_regmap(of_get_parent(dev->of_node));
> +	if (IS_ERR(regmap_dmc)) {
> +		dev_err(&pdev->dev, "failed to get DMC regmap\n");
> +		return PTR_ERR(regmap_dmc);
> +	}
> +
> +	canvas.dev = dev;
> +	canvas.regmap_dmc = regmap_dmc;
> +	mutex_init(&canvas.lock);
> +
> +	dev->platform_data = &canvas_platform_data;
> +
> +	return 0;
> +}
> +
> +static int meson_canvas_remove(struct platform_device *pdev)
> +{
> +	mutex_destroy(&canvas.lock);
> +	return 0;
> +}
> +
> +static const struct of_device_id canvas_dt_match[] = {
> +	{ .compatible = "amlogic,meson-canvas" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, canvas_dt_match);
> +
> +static struct platform_driver meson_canvas_driver = {
> +	.probe = meson_canvas_probe,
> +	.remove = meson_canvas_remove,
> +	.driver = {
> +		.name = "meson-canvas",
> +		.of_match_table = canvas_dt_match,
> +	},
> +};
> +module_platform_driver(meson_canvas_driver);
> +
> +MODULE_ALIAS("platform:meson-canvas");
> +MODULE_DESCRIPTION("AMLogic Meson Canvas driver");
> +MODULE_AUTHOR("Maxime Jourdan <maxi.jourdan@wanadoo.fr>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/soc/amlogic/meson-canvas.h b/include/linux/soc/amlogic/meson-canvas.h
> new file mode 100644
> index 000000000000..af9e2415056a
> --- /dev/null
> +++ b/include/linux/soc/amlogic/meson-canvas.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (c) 2018 Maxime Jourdan
> + * Author: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#ifndef MESON_CANVAS_H
> +#define MESON_CANVAS_H
> +
> +#include <linux/kernel.h>
> +
> +#define MESON_CANVAS_WRAP_NONE	0x00
> +#define MESON_CANVAS_WRAP_X	0x01
> +#define MESON_CANVAS_WRAP_Y	0x02
> +
> +#define MESON_CANVAS_BLKMODE_LINEAR	0x00
> +#define MESON_CANVAS_BLKMODE_32x32	0x01
> +#define MESON_CANVAS_BLKMODE_64x64	0x02


Can you add the endian defines ?

#define MESON_CANVAS_ENDIAN_SWAP16	0x1
#define MESON_CANVAS_ENDIAN_SWAP32	0x3
#define MESON_CANVAS_ENDIAN_SWAP64	0x7
#define MESON_CANVAS_ENDIAN_SWAP128	0xf

the SWAP64 is the one used in the VDEC and DRM Overlays.

> +
> +struct meson_canvas_platform_data {
> +	int (*alloc)(uint8_t *canvas_index);
> +	int (*free) (uint8_t canvas_index);
> +	int (*setup)(uint8_t canvas_index, uint32_t addr,
> +			uint32_t stride, uint32_t height,
> +			unsigned int wrap,
> +			unsigned int blkmode,
> +			unsigned int endian);
> +};
> +
> +#endif
> 

Thanks,
Neil
