Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B36C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D1020824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d4ULvfjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D1020824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeJXVxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:53:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32975 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeJXVxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:53:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id u1-v6so5611960wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GK2SNLhoUAArbnT5neeOO7CPg4wVkVQuX1Pg/ajWh8k=;
        b=d4ULvfjnV8klCpOg6Y8TULTXvRtvRHRVc+b5nIDBnyxD1TdRB8Z0SboWKWJj+22xQM
         3ig64/KtVBM1dPD+nx2uHFywWgbKyY183eZbKQ3dSz6C+0up2nw+yF00WRRe9hnvPQo1
         i61Qz3cSeC75Opn5RCE2QOmAzRg0F13l7qgtsLNsDwe1xJ+KpuZ6ifq8qzHXr1YjRAgK
         0reMjUgVyji5N9UvjJknOaqEatbpc0f7lkgRC7SAFOLl98a2uxQ79lDCSEcL3y+DeqiD
         z/mGyzxBXM9rja4Lv/9079l+Q65Mv9IleR0MCk+3omjMMtWOGmusn5smJj5S/2llAvcv
         sYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GK2SNLhoUAArbnT5neeOO7CPg4wVkVQuX1Pg/ajWh8k=;
        b=KdWxyqKEdLiL/Dt7xyiqMPDXqsKaeijD1glwC2aoxGgTm2whYnj+JO7BxrKGf9PxVd
         NRYLHqWaMB+54swT6sqwKc535WRtlEQ34xHRWjVmY1LxtMtwx3mCN2K+uHRpeC1I7Onc
         NKahSzdpk/KJ6PK3jQ9stLXjbycjjPWMAmXTsaizqEZiWIHsR6fg/7rX/sixaMoxwcxW
         JM27dGPcCeqRu/lQHmr3PSUeKpA6nva9LWN3EU3foDRNclcVVz1rJ/rKqwxyAiIqyoyM
         y8du7jWdWaiYhySF6tsmFAjxXrHjfsBZJgPx64YB7DcJkHyldqavDpHwZz0VSqUvwALE
         fHjA==
X-Gm-Message-State: AGRZ1gJ4kBkf1oMpsosX56FeHym8v3VSDRUrypZxS2gIxOn0HYVkf76k
        vCzceNd91zd+OxNjVIAt4v4sOp6Qxpf3sg==
X-Google-Smtp-Source: AJdET5fmW7QxqzYzj4zIiKwnHNZVTmMqPPqF72NRJ+VKQWjRvsxTHsZxbCojzPOUsgUtXKXh6XGPKw==
X-Received: by 2002:a5d:6707:: with SMTP id o7-v6mr2986918wru.326.1540387507966;
        Wed, 24 Oct 2018 06:25:07 -0700 (PDT)
Received: from [10.101.219.70] ([185.7.230.216])
        by smtp.gmail.com with ESMTPSA id t194-v6sm6725104wmd.48.2018.10.24.06.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 06:25:07 -0700 (PDT)
Subject: Re: [PATCH] pinctrl: meson: fix pinconf bias disable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181023160319.27003-1-jbrunet@baylibre.com>
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
Message-ID: <e59dce0c-e26c-1918-724c-8508fd841678@baylibre.com>
Date:   Wed, 24 Oct 2018 15:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181023160319.27003-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2018 18:03, Jerome Brunet wrote:
> If a bias is enabled on a pin of an Amlogic SoC, calling .pin_config_set()
> with PIN_CONFIG_BIAS_DISABLE will not disable the bias. Instead it will
> force a pull-down bias on the pin.
> 
> Instead of the pull type register bank, the driver should access the pull
> enable register bank.
> 
> Fixes: 6ac730951104 ("pinctrl: add driver for Amlogic Meson SoCs")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index 29a458da78db..4f3ab18636a3 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -192,7 +192,7 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
>  			dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
>  
>  			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
> -			ret = regmap_update_bits(pc->reg_pull, reg,
> +			ret = regmap_update_bits(pc->reg_pullen, reg,
>  						 BIT(bit), 0);
>  			if (ret)
>  				return ret;
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Nice catch !

Neil
