Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E323C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC826223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LyhRkvl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC826223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbeKMXcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:32:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46130 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbeKMXcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:32:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so460289wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9JicXeBdIvUoqP/23RFMgtzQQIM+pgEWyc6SJoQgYXo=;
        b=LyhRkvl+IDl3edEOk+ZgdJNKQB4jKjSQE+xPOCxSqkkkSN85zdfr+AlPgne+YBg1CX
         9Vfwxl3tatXBdn8VAVPbcK1lC70XyKJB6LEuQRuhkX/YYaz8bnJQm9tGcHYaargCVTh+
         EJ0avTBDTAkggbrEo190DL3QqYD1wuuvtuNcJPGemkKYe73Tp3N7xy/k/CwwGDwB5zTI
         KxXRo/r0CICAQnhWppU+NLCKFaG9xXEUqaJc6LAop/gwypRp7fzZgoSFvC+NN4M5CZ/g
         zVJcmrhT+/g+o+GDEHDem2+uuvpKv9X2gqRMg56pARNfO4fRakxEchCYX2ICwQTeANd8
         9qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9JicXeBdIvUoqP/23RFMgtzQQIM+pgEWyc6SJoQgYXo=;
        b=OuYaIQAvaP8/9z3AkQRbpivMTdZyWloqKaJ5bJc1hteqg6Vbfb75eJ+92miwVdfxro
         CkEdiiac6OS3mAA0YhgNAaCOw3TSmOUJ4eQ48YHYL4YkeZhuuue6Ia0Vhfaz+SKdFZKQ
         ulsbTiuSB5x8N/TOa/iLP46hhzggDy4EoF/HeBxkdOkKfMJaQXs9dpkSAX4hn1E9xBhU
         vqg2UkbBSBCN6S/u4ctsWwWDCtaWppJf3T5/9RDT39sXrqiprLSFNVy8gr3G9DvS+JFB
         3sKHfQlLlo3EqGsGSMVmb6nQ0D0s02ZnZyRFzzs1ma8ThFqpa1ks+aZHkNgyFrNboIp3
         aqVQ==
X-Gm-Message-State: AGRZ1gKS0Qk/YxRS2NDT8OW7+/460r58T+bpNh8NhWl+ZO5CXy1xIgMy
        A8GMwpa/3+fkL/VXwC/DJ7S+ej9ugBU=
X-Google-Smtp-Source: AJdET5eNCbkMcBYgJPkWez3VAa1TGh+HSWLVl+ebnVnQsjlDDWwHZDy7mxgi3osCYjm0WEnsuDT/6A==
X-Received: by 2002:a5d:564f:: with SMTP id j15-v6mr4901606wrw.228.1542116049655;
        Tue, 13 Nov 2018 05:34:09 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s81sm13789wmf.14.2018.11.13.05.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 05:34:09 -0800 (PST)
Subject: Re: [PATCH] pinctrl: meson: fix pull enable register calculation
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181113105536.6459-1-jbrunet@baylibre.com>
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
Message-ID: <cee83bac-a55a-0c60-e410-9c1ce4c6b60d@baylibre.com>
Date:   Tue, 13 Nov 2018 14:34:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113105536.6459-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2018 11:55, Jerome Brunet wrote:
> We just changed the code so we apply bias disable on the correct
> register but forgot to align the register calculation. The result
> is that we apply the change on the correct register, but possibly
> at the incorrect offset/bit
> 
> This went undetected because offsets tends to be the same between
> REG_PULL and REG_PULLEN for a given pin the EE controller. This
> is not true for the AO controller.
> 
> Fixes: e39f9dd8206a ("pinctrl: meson: fix pinconf bias disable")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index 53d449076dee..ea87d739f534 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -191,7 +191,8 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
>  		case PIN_CONFIG_BIAS_DISABLE:
>  			dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
>  
> -			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
> +			meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg,
> +					       &bit);
>  			ret = regmap_update_bits(pc->reg_pullen, reg,
>  						 BIT(bit), 0);
>  			if (ret)
> 

I saw it aswell,

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
