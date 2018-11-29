Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F6CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FAA20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nqPnO4xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FAA20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeK2Wbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:31:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38817 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeK2Wbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:31:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so1514484wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 03:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P1M6pMruorGrh/6hd7Kh77sByxeMonsKeMZXMHpoQ6s=;
        b=nqPnO4xyD5Pvolc80LLGrweQjfgTSCS8W/HjbF4TVirBvnzVYXo7db/jQRx7L2XI58
         OrTLNQz/aZpgSyZgQEy21i8+Fi+4vswI35DJrNQvlsn0n+ZNvSVS8WAHyGp8tmfQPpgW
         8QNLPD3dA91mqFwFmokfR1IKnh8truA5fgDF2PqBJykvUHJO97mveXYBYB+QpSKISipX
         TxQY8YMAbfMbZy7T8GYlGyQmfOg78knIfBzZ8vxaKQv3HDT0uA777mTjkfX8/ve4mh38
         pxi1MxmOtcFAP8iOKUBGl2qr6uWGbjhdC9OxF760sQ9/lRfHAHDEk8JVA4MwGpxJofe+
         MwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P1M6pMruorGrh/6hd7Kh77sByxeMonsKeMZXMHpoQ6s=;
        b=re/ICRIUHiRq005f/NDGqeaBuIleNNJpvm9vTuCvQ1CzHaQnB74CDdakVH9IaefKWv
         eIBjHUzE61wpZ45DVdGj7QS4YCnbepBtaliRySQtLFiLeQ1Z4I+gboigf+h5OHxH3U2h
         SnNmOjpa/08WyoNj/waZolvyUlf+x4qIdJJPlH3/vBOUJPRvuxxiRLRVvIDHP28naSiV
         6jkuxXqTWKYdhsuytVrL9dW4O9LCf11J/dFIuZqF02iQqz+B05cmWXBsYzEhjhzC9z34
         jnMkITk5Ws6zVd0GVxdjzCLDzjwuDILpWKeFjboUJmAhAg/XxxCPgiiA47FqHJaLjcIx
         mXuA==
X-Gm-Message-State: AA+aEWbN2m/5YNK3ccFMnzglp8JvEbovssan37sd8CYSLZd/o88i3avV
        XpJZHuThftyXmm1seHEoe6boug==
X-Google-Smtp-Source: AFSGD/W6ikS6JOIV7F6zZLhlhtUq9SgrNRg4e0I2Q4o2I9htbEacJ1F0R1fhyA9u4I6V7yoJ1HbVxw==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr1070074wru.222.1543490807273;
        Thu, 29 Nov 2018 03:26:47 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:819f:4d34:9af9:e67? ([2a01:cb1d:4ce:ea00:819f:4d34:9af9:e67])
        by smtp.gmail.com with ESMTPSA id v133sm2295529wmd.4.2018.11.29.03.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 03:26:46 -0800 (PST)
Subject: Re: [PATCH 2/2] i2c: meson: add support for Meson G12A SoC I2C
 controller
To:     Jian Hu <jian.hu@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
 <1543489197-183181-3-git-send-email-jian.hu@amlogic.com>
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
Message-ID: <865b607c-8419-9c9e-0a00-018e87adf8de@baylibre.com>
Date:   Thu, 29 Nov 2018 12:26:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543489197-183181-3-git-send-email-jian.hu@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 11:59, Jian Hu wrote:
> Add compatible and data for G12A I2C controller.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  drivers/i2c/busses/i2c-meson.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
> index 90f5d04..b86eed7 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -462,10 +462,15 @@ static int meson_i2c_remove(struct platform_device *pdev)
>  	.div_factor = 3,
>  };
>  
> +static const struct meson_i2c_data i2c_g12a_data = {
> +	.div_factor = 3,

Especially if the div_factor is the same as AXG.

If you have some other fixes for G12a in the pipe, you will add the new compatible and meson_i2c_data later,
for the div_factor, simply use the axg struct and compatible.

Neil

> +};
> +
>  static const struct of_device_id meson_i2c_match[] = {
>  	{ .compatible = "amlogic,meson6-i2c", .data = &i2c_meson6_data },
>  	{ .compatible = "amlogic,meson-gxbb-i2c", .data = &i2c_gxbb_data },
>  	{ .compatible = "amlogic,meson-axg-i2c", .data = &i2c_axg_data },
> +	{ .compatible = "amlogic,meson-g12a-i2c", .data = &i2c_g12a_data },
>  	{},
>  };
>  
> 

