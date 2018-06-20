Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDF7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B55D208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QEPvkir0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B55D208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932570AbeFTIcF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:32:05 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37131 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbeFTIb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:31:59 -0400
Received: by mail-wr0-f196.google.com with SMTP id d8-v6so2332822wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3tOw0HCbLQYIFS3MeYe5E3IRiDVmH53ikPCudzzg7pk=;
        b=QEPvkir0H0YQynyOkEiFWwTppHiaHy8Q3wlrwbHwj21mFJpx+vOOnWd4VS8UVMwBFr
         P2BdrJbz2E3+Zqv1kVwiNZw0J6+jSGfvhK+/iyQ2ogYZJ1ZxjtSf42p1MGIhE89RbBuv
         xFVca597wO45xC2kay4b9CC1E45E89tVq3VvvD+DCvV1Dc5kyuBuDK1CP0htD6fCOZkx
         bTgCA3NjDnIW/vpr549fykH6brb0xeriahD1gg347kGcpzBbuceddLdwjFB5GIu0ry4+
         CrGygh+TjLQPM/65s8tCK77h7oKdeP0w+qIsl9u9GHmnRuoaYLDgxNgy9jixpObfW2gm
         ABSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3tOw0HCbLQYIFS3MeYe5E3IRiDVmH53ikPCudzzg7pk=;
        b=Y0m1KyHXQF0cMnCHLBhstUxgCX5QSnAmZGnHj7+xCEUEqrYLzNO/5chJEcyltAdLWQ
         6ZytrCtf4boY42+Zb2blbL/zK965O2s97B9Xi4zwtpaZGciNEJYfwizY3kbyg272IOTT
         oVpvoel6YtIfb8HNlfgs7M6xIRca/8nqyjLNw1NFD6C/guNdsAW/iCv7821jgQ7ClgEH
         iOTswbPAsEkRg2uzV8brjdmfMGVk7iNmrQPjLMsOoPzdXyzy+xqm1e2eqorCGxORpyD3
         3tcp3xezmd/8YCQyKbTppdc9P6f/Xm2Ubsf3uU0xdOccsk38Xj73g9PVpA50AOTiGkB8
         wa8A==
X-Gm-Message-State: APt69E1ggkZlhHcz6YJPfug2Z2/QRAIZV8hqp3cZov4ZLswdRSyCWuQu
        V6oRLTa5m7DFUzsMFY6z6k2fSdoVM+s=
X-Google-Smtp-Source: ADUXVKLyDO3ZUPNszm7kCJyzhD10Erqy6XmuY7EmEJAdmXHJJslYNGiTufL/JoLzSDwIJUoJhQEdsw==
X-Received: by 2002:adf:ae09:: with SMTP id x9-v6mr16844367wrc.19.1529483518192;
        Wed, 20 Jun 2018 01:31:58 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:7411:64db:cd3a:8490? ([2a01:cb1d:4ce:ea00:7411:64db:cd3a:8490])
        by smtp.gmail.com with ESMTPSA id q17-v6sm1953580wrs.5.2018.06.20.01.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:31:57 -0700 (PDT)
Subject: Re: [PATCH] clk: meson: remove obsolete register access
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180619160050.26958-1-jbrunet@baylibre.com>
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
Message-ID: <0e57617b-0ece-3c6d-f124-6197ef82b1c7@baylibre.com>
Date:   Wed, 20 Jun 2018 10:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619160050.26958-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2018 18:00, Jerome Brunet wrote:
> The legacy method to access the hhi register space is not longer used.
> We can safely drop it now.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg.c  | 37 ++-----------------------------------
>  drivers/clk/meson/gxbb.c | 36 ++----------------------------------
>  2 files changed, 4 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index bd4dbc696b88..3fb884db1b10 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -12,7 +12,6 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/init.h>
> -#include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
> @@ -995,49 +994,17 @@ static const struct of_device_id clkc_match_table[] = {
>  	{}
>  };
>  
> -static const struct regmap_config clkc_regmap_config = {
> -	.reg_bits       = 32,
> -	.val_bits       = 32,
> -	.reg_stride     = 4,
> -};
> -
>  static int axg_clkc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct resource *res;
> -	void __iomem *clk_base = NULL;
>  	struct regmap *map;
>  	int ret, i;
>  
>  	/* Get the hhi system controller node if available */
>  	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
>  	if (IS_ERR(map)) {
> -		dev_err(dev,
> -			"failed to get HHI regmap - Trying obsolete regs\n");
> -
> -		/*
> -		 * FIXME: HHI registers should be accessed through
> -		 * the appropriate system controller. This is required because
> -		 * there is more than just clocks in this register space
> -		 *
> -		 * This fallback method is only provided temporarily until
> -		 * all the platform DTs are properly using the syscon node
> -		 */
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (!res)
> -			return -EINVAL;
> -
> -
> -		clk_base = devm_ioremap(dev, res->start, resource_size(res));
> -		if (!clk_base) {
> -			dev_err(dev, "Unable to map clk base\n");
> -			return -ENXIO;
> -		}
> -
> -		map = devm_regmap_init_mmio(dev, clk_base,
> -					    &clkc_regmap_config);
> -		if (IS_ERR(map))
> -			return PTR_ERR(map);
> +		dev_err(dev, "failed to get HHI regmap\n");
> +		return PTR_ERR(map);
>  	}
>  
>  	/* Populate regmap for the regmap backed clocks */
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 177fffb9ebef..297ebc391475 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -7,7 +7,6 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/init.h>
> -#include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
> @@ -2228,17 +2227,9 @@ static const struct of_device_id clkc_match_table[] = {
>  	{},
>  };
>  
> -static const struct regmap_config clkc_regmap_config = {
> -	.reg_bits       = 32,
> -	.val_bits       = 32,
> -	.reg_stride     = 4,
> -};
> -
>  static int gxbb_clkc_probe(struct platform_device *pdev)
>  {
>  	const struct clkc_data *clkc_data;
> -	struct resource *res;
> -	void __iomem *clk_base;
>  	struct regmap *map;
>  	int ret, i;
>  	struct device *dev = &pdev->dev;
> @@ -2250,31 +2241,8 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
>  	/* Get the hhi system controller node if available */
>  	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
>  	if (IS_ERR(map)) {
> -		dev_err(dev,
> -			"failed to get HHI regmap - Trying obsolete regs\n");
> -
> -		/*
> -		 * FIXME: HHI registers should be accessed through
> -		 * the appropriate system controller. This is required because
> -		 * there is more than just clocks in this register space
> -		 *
> -		 * This fallback method is only provided temporarily until
> -		 * all the platform DTs are properly using the syscon node
> -		 */
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (!res)
> -			return -EINVAL;
> -
> -		clk_base = devm_ioremap(dev, res->start, resource_size(res));
> -		if (!clk_base) {
> -			dev_err(dev, "Unable to map clk base\n");
> -			return -ENXIO;
> -		}
> -
> -		map = devm_regmap_init_mmio(dev, clk_base,
> -					    &clkc_regmap_config);
> -		if (IS_ERR(map))
> -			return PTR_ERR(map);
> +		dev_err(dev, "failed to get HHI regmap\n");
> +		return PTR_ERR(map);
>  	}
>  
>  	/* Populate regmap for the common regmap backed clocks */
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
