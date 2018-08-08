Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49882C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FC921A14
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SHl7LQ/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FC921A14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeHHRbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:31:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43226 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeHHRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:31:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so2322481wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iFEYr7cxr5wnHazYAHlJSN1roEmzQojyVo5snz306Mw=;
        b=SHl7LQ/qym7Hho6haH46JYYMYrNRvT9iccDj3joF57u3nPBbMwRCOpVLyl5NlwPcjl
         qAvHvYtKFlEwA8hD4EKItIZOkaSen595PNwXzqACDfK2rbZY26LM261Dhy8uyvXHAO9W
         S6Sc7MCycf3t1BCpKZ7ZxqmSljUg0+59xae35GvAtWXkruK+wtYlOiAP7ZZzfQY4FKh8
         hfXJrsNcuZwYKkfz281oiVpNMYSJLz9zwRz1omm5YFKka2EEWFd1EiWeovbL6walR6nl
         VtrtgK0UiPZsy1PB/iHC3JqXqWLXnBo5TD7sA2Hs74ojqkdv0BXMsozRvYPb3RKKHago
         eRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iFEYr7cxr5wnHazYAHlJSN1roEmzQojyVo5snz306Mw=;
        b=pGjzjCtVhhp3xGR7uyFBpaqCrMEsjT/WTklXlKG9G9QdBNLU4Sp5Nhcy5ojJi8auX5
         zhrkQeZuEXgLHBMYfw1ffc8SkTffabqYvZlAnc0NYbWQnH9jnFQuTWC5iMhoSwqyLTHA
         U9Q37IBSVM4WHLJncRmLTHu7C4WsNhh7ZDiHGrJKejKhTdGH3Zm1HNem4udffk0XWkrS
         HLLWGR3UOKcOc4VEsLuFAU0RuKesQFgIwv+9IihleMxSf9gkvb8Y5OZW2aKt+yS7ETFQ
         RywVb5Ik2xtIX3M/9xmkwdMYlaUZlXjEpsVQ5KRRUC72YLzk9K9hhuNGxNzJW+bE/CDq
         twQg==
X-Gm-Message-State: AOUpUlGZKlI5GmzZ/khXJ4LmKzf97TTED8Hrv8VoBNQBoji//wTfZbRu
        6YLgG4+Rbf4U9zNij+320gpRTM9w094=
X-Google-Smtp-Source: AA+uWPwP0iGAFKzAVOgmG27lDa33V3LesDl79ZQii5WIumNpFj6Gpmh8NhWyG1ApvGYueMLpyczFNw==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr2156667wrd.67.1533741060053;
        Wed, 08 Aug 2018 08:11:00 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f132-v6sm9488080wme.24.2018.08.08.08.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:10:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] soc: amlogic: add meson-canvas driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
 <20180807220011.24436-2-maxi.jourdan@wanadoo.fr>
 <e766247cb536753b5433b65c41bee7d24b7107fb.camel@baylibre.com>
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
Message-ID: <ad71f8b9-dd3f-f33f-b1d9-4e2c2ccd19f6@baylibre.com>
Date:   Wed, 8 Aug 2018 17:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e766247cb536753b5433b65c41bee7d24b7107fb.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 09:45, Jerome Brunet wrote:
> On Wed, 2018-08-08 at 00:00 +0200, Maxime Jourdan wrote:
>> Amlogic SoCs have a repository of 256 canvas which they use to
>> describe pixel buffers.
>>
>> They contain metadata like width, height, block mode, endianness [..]
>>
>> Many IPs within those SoCs like vdec/vpu rely on those canvas to read/write
>> pixels.
>>
>> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Thanks for making the changes Martin, I do prefer this version. You did not have
> to drop the ops, until it is really needed because of some SoC quirks, I guess
> it is simpler this way
> 
> With some answers to the nitpicks below, feel free to add :
> 
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> 
>> ---
>>  drivers/soc/amlogic/Kconfig              |   7 +
>>  drivers/soc/amlogic/Makefile             |   1 +
>>  drivers/soc/amlogic/meson-canvas.c       | 185 +++++++++++++++++++++++
>>  include/linux/soc/amlogic/meson-canvas.h |  65 ++++++++
>>  4 files changed, 258 insertions(+)
>>  create mode 100644 drivers/soc/amlogic/meson-canvas.c
>>  create mode 100644 include/linux/soc/amlogic/meson-canvas.h
>>
>> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
>> index b04f6e4aedbc..2f282b472912 100644
>> --- a/drivers/soc/amlogic/Kconfig
>> +++ b/drivers/soc/amlogic/Kconfig
>> @@ -1,5 +1,12 @@
>>  menu "Amlogic SoC drivers"
>>  
>> +config MESON_CANVAS
>> +	tristate "Amlogic Meson Canvas driver"
>> +	depends on ARCH_MESON || COMPILE_TEST
>> +	default n
>> +	help
>> +	  Say yes to support the canvas IP for Amlogic SoCs.
>> +
>>  config MESON_GX_SOCINFO
>>  	bool "Amlogic Meson GX SoC Information driver"
>>  	depends on ARCH_MESON || COMPILE_TEST
>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
>> index 8fa321893928..0ab16d35ac36 100644
>> --- a/drivers/soc/amlogic/Makefile
>> +++ b/drivers/soc/amlogic/Makefile
>> @@ -1,3 +1,4 @@
>> +obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
>>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>> diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
>> new file mode 100644
>> index 000000000000..c461334b36d4
>> --- /dev/null
>> +++ b/drivers/soc/amlogic/meson-canvas.c
>> @@ -0,0 +1,185 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2018 Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>> + * Copyright (C) 2016 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
>> + * Copyright (C) 2014 Endless Mobile
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/soc/amlogic/meson-canvas.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/io.h>
>> +
>> +#define NUM_CANVAS 256
>> +
>> +/* DMC Registers */
>> +#define DMC_CAV_LUT_DATAL	0x48 /* 0x12 offset in data sheet */
>> +	#define CANVAS_WIDTH_LBIT	29
>> +	#define CANVAS_WIDTH_LWID       3
>> +#define DMC_CAV_LUT_DATAH	0x4c /* 0x13 offset in data sheet */
>> +	#define CANVAS_WIDTH_HBIT       0
>> +	#define CANVAS_HEIGHT_BIT       9
>> +	#define CANVAS_BLKMODE_BIT      24
>> +#define DMC_CAV_LUT_ADDR	0x50 /* 0x14 offset in data sheet */
>> +	#define CANVAS_LUT_WR_EN        (0x2 << 8)
>> +	#define CANVAS_LUT_RD_EN        (0x1 << 8)
>> +
>> +struct meson_canvas {
>> +	struct device *dev;
>> +	struct regmap *regmap_dmc;
>> +	spinlock_t lock; /* canvas device lock */
>> +	u8 used[NUM_CANVAS];
>> +};
>> +
>> +struct meson_canvas *meson_canvas_get(struct device *dev)
>> +{
>> +	struct device_node *canvas_node;
>> +	struct platform_device *canvas_pdev;
>> +	struct meson_canvas *canvas;
>> +
>> +	canvas_node = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
>> +	if (!canvas_node)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	canvas_pdev = of_find_device_by_node(canvas_node);
>> +	if (!canvas_pdev) {
>> +		dev_err(dev, "Unable to find canvas pdev\n");
>> +		return ERR_PTR(-ENODEV);
>> +	}

I should be -EPROBE_DEFER here since the canvas driver maybe hasn't probed yet.

>> +
>> +	canvas = dev_get_drvdata(&canvas_pdev->dev);
>> +	if (!canvas)
>> +		return ERR_PTR(-ENODEV);
> 
> You've got your device at this point, maybe EINVAL instead ?

This shouldn't fail here... I'm not sure what should be the error.

> 
>> +
>> +	return canvas;
>> +}
>> +EXPORT_SYMBOL_GPL(meson_canvas_get);
>> +
>> +int meson_canvas_setup(struct meson_canvas *canvas, u8 canvas_index,
>> +		       u32 addr, u32 stride, u32 height,
>> +		       unsigned int wrap,
>> +		       unsigned int blkmode,
>> +		       unsigned int endian)
>> +{
>> +	struct regmap *regmap = canvas->regmap_dmc;
>> +	unsigned long flags;
>> +	u32 val;
>> +
>> +	spin_lock_irqsave(&canvas->lock, flags);
>> +	if (!canvas->used[canvas_index]) {
>> +		dev_err(canvas->dev,
>> +			"Trying to setup non allocated canvas %u\n",
>> +			canvas_index);
>> +		spin_unlock_irqrestore(&canvas->lock, flags);
>> +		return -EINVAL;
>> +	}
>> +
>> +	regmap_write(regmap, DMC_CAV_LUT_DATAL,
>> +		     ((addr + 7) >> 3) |
>> +		     (((stride + 7) >> 3) << CANVAS_WIDTH_LBIT));
>> +
>> +	regmap_write(regmap, DMC_CAV_LUT_DATAH,
>> +		     ((((stride + 7) >> 3) >> CANVAS_WIDTH_LWID) <<
>> +						CANVAS_WIDTH_HBIT) |
>> +		     (height << CANVAS_HEIGHT_BIT) |
>> +		     (wrap << 22) |
>> +		     (blkmode << CANVAS_BLKMODE_BIT) |
>> +		     (endian << 26));
>> +
>> +	regmap_write(regmap, DMC_CAV_LUT_ADDR,
>> +		     CANVAS_LUT_WR_EN | canvas_index);
>> +
>> +	/* Force a read-back to make sure everything is flushed. */
>> +	regmap_read(regmap, DMC_CAV_LUT_DATAH, &val);
> 
> I suppose this something you got from the vendor kernel ? Out of curiosity, have
> you tried w/o it ? I am wondering if this is really necessary ? 


It's explicit in the Amlogic source, you need a readback to make sure it's taken in account.

> 
> 
>> +	spin_unlock_irqrestore(&canvas->lock, flags);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(meson_canvas_setup);
>> +
>> +int meson_canvas_alloc(struct meson_canvas *canvas, u8 *canvas_index)
>> +{
>> +	int i;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&canvas->lock, flags);
>> +	for (i = 0; i < NUM_CANVAS; ++i) {
>> +		if (!canvas->used[i]) {
>> +			canvas->used[i] = 1;
>> +			spin_unlock_irqrestore(&canvas->lock, flags);
>> +			*canvas_index = i;
>> +			return 0;
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&canvas->lock, flags);
>> +
>> +	dev_err(canvas->dev, "No more canvas available\n");
>> +	return -ENODEV;
>> +}
>> +EXPORT_SYMBOL_GPL(meson_canvas_alloc);
>> +
>> +int meson_canvas_free(struct meson_canvas *canvas, u8 canvas_index)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&canvas->lock, flags);
>> +	if (!canvas->used[canvas_index]) {
>> +		dev_err(canvas->dev,
>> +			"Trying to free unused canvas %u\n", canvas_index);
>> +		spin_unlock_irqrestore(&canvas->lock, flags);
>> +		return -EINVAL;
>> +	}
>> +	canvas->used[canvas_index] = 0;
>> +	spin_unlock_irqrestore(&canvas->lock, flags);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(meson_canvas_free);
>> +
>> +static int meson_canvas_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct meson_canvas *canvas;
>> +
>> +	canvas = devm_kzalloc(dev, sizeof(*canvas), GFP_KERNEL);
>> +	if (!canvas)
>> +		return -ENOMEM;
>> +
>> +	canvas->regmap_dmc =
>> +		syscon_node_to_regmap(of_get_parent(dev->of_node));
>> +	if (IS_ERR(canvas->regmap_dmc)) {
>> +		dev_err(dev, "failed to get DMC regmap\n");
>> +		return PTR_ERR(canvas->regmap_dmc);
>> +	}
>> +
>> +	canvas->dev = dev;
>> +	spin_lock_init(&canvas->lock);
>> +	dev_set_drvdata(dev, canvas);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id canvas_dt_match[] = {
>> +	{ .compatible = "amlogic,canvas" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, canvas_dt_match);
>> +
>> +static struct platform_driver meson_canvas_driver = {
>> +	.probe = meson_canvas_probe,
>> +	.driver = {
>> +		.name = "amlogic-canvas",
>> +		.of_match_table = canvas_dt_match,
>> +	},
>> +};
>> +module_platform_driver(meson_canvas_driver);
>> +
>> +MODULE_DESCRIPTION("Amlogic Canvas driver");
>> +MODULE_AUTHOR("Maxime Jourdan <maxi.jourdan@wanadoo.fr>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/soc/amlogic/meson-canvas.h b/include/linux/soc/amlogic/meson-canvas.h
>> new file mode 100644
>> index 000000000000..c164202d8e39
>> --- /dev/null
>> +++ b/include/linux/soc/amlogic/meson-canvas.h
>> @@ -0,0 +1,65 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2018 Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>> + */
>> +#ifndef MESON_CANVAS_H
>> +#define MESON_CANVAS_H
>> +
>> +#include <linux/kernel.h>
>> +
>> +#define MESON_CANVAS_WRAP_NONE	0x00
>> +#define MESON_CANVAS_WRAP_X	0x01
>> +#define MESON_CANVAS_WRAP_Y	0x02
>> +
>> +#define MESON_CANVAS_BLKMODE_LINEAR	0x00
>> +#define MESON_CANVAS_BLKMODE_32x32	0x01
>> +#define MESON_CANVAS_BLKMODE_64x64	0x02
>> +
>> +#define MESON_CANVAS_ENDIAN_SWAP16	0x1
>> +#define MESON_CANVAS_ENDIAN_SWAP32	0x3
>> +#define MESON_CANVAS_ENDIAN_SWAP64	0x7
>> +#define MESON_CANVAS_ENDIAN_SWAP128	0xf
>> +
>> +struct meson_canvas;
>> +
>> +/**
>> + * meson_canvas_get() - get a canvas provider instance
>> + *
>> + * @dev: your device
> 
> s/your device/consumer device pointer ?
> 
>> + */
>> +struct meson_canvas *meson_canvas_get(struct device *dev);
>> +
>> +/**
>> + * meson_canvas_alloc() - take ownership of a canvas
>> + *
>> + * @canvas: canvas provider instance retrieved from meson_canvas_get()
>> + * @canvas_index: will be filled with the canvas ID
>> + */
>> +int meson_canvas_alloc(struct meson_canvas *canvas, u8 *canvas_index);
>> +
>> +/**
>> + * meson_canvas_free() - remove ownership from a canvas
>> + *
>> + * @canvas: canvas provider instance retrieved from meson_canvas_get()
>> + * @canvas_index: canvas ID that was obtained via meson_canvas_alloc()
>> + */
>> +int meson_canvas_free(struct meson_canvas *canvas, u8 canvas_index);
>> +
>> +/**
>> + * meson_canvas_setup() - configure a canvas
>> + *
>> + * @canvas: canvas provider instance retrieved from meson_canvas_get()
>> + * @canvas_index: canvas ID that was obtained via meson_canvas_alloc()
>> + * @addr: physical address to the pixel buffer
>> + * @stride: width of the buffer
>> + * @height: height of the buffer
>> + * @wrap: undocumented
>> + * @blkmode: block mode (linear, 32x32, 64x64)
>> + * @endian: byte swapping (swap16, swap32, swap64, swap128)
>> + */
>> +int meson_canvas_setup(struct meson_canvas *canvas, u8 canvas_index,
>> +		       u32 addr, u32 stride, u32 height,
>> +		       unsigned int wrap, unsigned int blkmode,
>> +		       unsigned int endian);
>> +
>> +#endif
> 
> 

