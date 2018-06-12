Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 25DF9C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D782086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Nxhq+AhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D782086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934072AbeFLOez (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:34:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36031 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932803AbeFLOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:34:53 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so24360852wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mLg8cSAUilMKu5cSEgArmgEkOfyvHuiKwOSvJ+vRgho=;
        b=Nxhq+AhHrS49WMoaMt17YCn1uBGVWwxXYUWgpcBH7XoQ3BdnX2RTL0Jncsg549FD2A
         2qxcQKy6FnoyOnglR0Zhbxw87r9zXjH3TeLUwfYzMN5L1SqC6BsO/MZFujgAEc+F0ve2
         eibCyXfRfuDh0h1v84GaMQ9iGY5shzMxdAcp54xdDRVhyMvKpmXSoS55VZgPMEpwfLnQ
         G06nz4Nb9z4CP6xz2P8Py0oiQh9PNhbbKm0lDgb3R9zl0KusoSLd0Ql5clXKaaEAV83O
         POGcpbFwXDrVEEVRvDn3xjpn/7hqzjCQI/LsQwlUxkvVuOAun9UsIMlXLLCm1IbY/Uzm
         uBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mLg8cSAUilMKu5cSEgArmgEkOfyvHuiKwOSvJ+vRgho=;
        b=ln4w467PT+bDU2qjpbv2/a9AQfrTLMiVLV2y2cj20qFVFDd/OcVpq6xqTabfYedNdf
         KTCkexg8qfEyRQdSmU+89wNsgrjlrqZ5xWAJ1TEp379rJgB5nCdFC+EkMflCScLEiIMD
         LBEKkrAofg03RYY75EqMLjN+mHu0LlVjqzk6adzwQ1utqcsysBkglvlVtZjDwGqpoUAC
         O3Lmg/JkytiZBzUqOT9a0/1eTIygdTMr8FbDYNue4/CobrR9lrih9ag3Qc0GiJpbd7kd
         jBZZHIYiko1GrXcUqti6wOvc21FFjevALLvRsUzDy8H1v624WBYAFLs2sNJXEPClTFfd
         ITYw==
X-Gm-Message-State: APt69E02FE58kXnuCkI19IyN1M/XuGUcpRSaglgX7TCBSvawzmwAF3qo
        +ex+TMrYxQuL6buKpDlcru5yyw==
X-Google-Smtp-Source: ADUXVKKHF8YFjcnsTJeWzcxhfTeTUUjak88EwttHOQ6ouyP0fNe/tdcGpIxC+0cs4xWfycz5F3HOvg==
X-Received: by 2002:adf:82d1:: with SMTP id 75-v6mr502727wrc.77.1528814091489;
        Tue, 12 Jun 2018 07:34:51 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o9-v6sm303767wrn.73.2018.06.12.07.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 07:34:50 -0700 (PDT)
Subject: Re: [PATCH] drm/meson: Fix an un-handled error path in
 'meson_drv_bind_master()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        weiyongjun1@huawei.com, airlied@linux.ie, carlo@caione.org,
        khilman@baylibre.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180611165335.24542-1-christophe.jaillet@wanadoo.fr>
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
Message-ID: <b25b05d0-b192-1cf8-0c25-38b8bdb53b92@baylibre.com>
Date:   Tue, 12 Jun 2018 16:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611165335.24542-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 18:53, Christophe JAILLET wrote:
> If 'platform_get_resource_byname()' fails, we should release some resources
> before leaving, as already done in the other error handling path of the
> function.
> 
> Fixes: acaa3f13b8dd ("drm/meson: Fix potential NULL dereference in meson_drv_bind_master()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 32b1a6cdecfc..d3443125e661 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -197,8 +197,10 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	priv->io_base = regs;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
> -	if (!res)
> -		return -EINVAL;
> +	if (!res) {
> +		ret = -EINVAL;
> +		goto free_drm;
> +	}
>  	/* Simply ioremap since it may be a shared register zone */
>  	regs = devm_ioremap(dev, res->start, resource_size(res));
>  	if (!regs) {
> @@ -215,8 +217,10 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
> -	if (!res)
> -		return -EINVAL;
> +	if (!res) {
> +		ret = -EINVAL;
> +		goto free_drm;
> +	}
>  	/* Simply ioremap since it may be a shared register zone */
>  	regs = devm_ioremap(dev, res->start, resource_size(res));
>  	if (!regs) {
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I'll push it when rc1 is tagged.

Neil
