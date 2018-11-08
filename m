Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DFFECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7218D20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JDjSIy6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7218D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeKHXCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:02:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56112 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeKHXCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:02:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10-v6so1256543wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=U7old8aK++kAGhulGpjkuVOMdIcvE/PUtm614UA0/Es=;
        b=JDjSIy6JO4q57RFlJ5L5BYm62NLJwwhuZAsSAuGuSjN1hDkgeQXsAiALcmhjoElvxp
         soOGUbDQKVfo4/xuuuzZ29z+JHfyO9nNuh34OtJM4DAuxptx9ZcGVZcvU/PfdNYpA2aH
         dNNMq2VWLg4hn3X5RldFyR/mM3pErnc07VxAfGJkTUp94a6h7CKX0ezsyPZjyvPIRL+R
         63zhdJnN/ngIkrLh7IbmK9gB2yDAYs2CboeKhwdVO5wNY4wkuiRyoPAKkthWMPiK+Bzl
         OsQYn1aKv20cARJMoUfGW2fsA/3emKOWBpSdHSyPXoYNWpEqmob9+WcV5gtw4WDkmSEU
         P/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=U7old8aK++kAGhulGpjkuVOMdIcvE/PUtm614UA0/Es=;
        b=pxm+3PCgjil25EcxF/icGTiZ29y9NZHHFYRfJNlvMDorVoxEP0K1SelKh/GvlXNYZo
         QLV/jGXanV8Vyqp3CbuQMetpjmRuuynBWbbbzsc0TEHihZrFq/zEOsr7jIdYFHlr54Xh
         N/oh52N4vkLakEko9XgkygFUMPjnQjhbXPnIwh2nSGFaGopwHG9TXsWkaoZLx0zT3TyH
         /ScrLxvV68v6ErhWAud3teiyMN4km4saG0iaoqAONFBRihjhWSrSjcnBqXOxh4JO4iVr
         fdLgrbKqIAFZIJeAhfc3iR1ETzrGFIhesohanJ4y4cii3oev5HMxSZVOw6IEdimmP1UZ
         KpKA==
X-Gm-Message-State: AGRZ1gIeyCAQWoJvzWhnlBLMl2C1xHoDoSvhq9Em8VVkjeLo3rgWocCW
        EHYzqiaSJ7Uh0iQJXZJp4/mdnugmm3A=
X-Google-Smtp-Source: AJdET5crXW5dWNl9vZtRwmF/lmlQZ91muYIxRkcxAY4S5vyauXXavIbPvS4dM+wCN5YzEkbJHT/PJQ==
X-Received: by 2002:a1c:2b03:: with SMTP id r3-v6mr1256051wmr.131.1541683621263;
        Thu, 08 Nov 2018 05:27:01 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l5-v6sm4780111wrv.84.2018.11.08.05.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 05:27:00 -0800 (PST)
Subject: Re: [PATCH] clk: meson: axg: mark fdiv2 and fdiv3 as critical
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181108093123.21498-1-jbrunet@baylibre.com>
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
Message-ID: <59cda050-988f-20b9-b211-e6a426139665@baylibre.com>
Date:   Thu, 8 Nov 2018 14:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108093123.21498-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 10:31, Jerome Brunet wrote:
> Similar to gxbb and gxl platforms, axg SCPI Cortex-M co-processor
> uses the fdiv2 and fdiv3 to, among other things, provide the cpu
> clock.
> 
> Until clock hand-off mechanism makes its way to CCF and the generic
> SCPI claims platform specific clocks, these clocks must be marked as
> critical to make sure they are never disabled when needed by the
> co-processor.
> 
> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> 
> Hi Stephen,
> 
> If you can put this one in clk-fixes as well, it would be awesome.
> It is basically the same thing as the change you took this Tuesday.
> 
> Since then, we had reports the same problem with SCPI was happening
> on the axg, calling for the same fixup.
> 
> Cheers
> Jerome
> 
>  drivers/clk/meson/axg.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index c981159b02c0..792735d7e46e 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -325,6 +325,7 @@ static struct clk_regmap axg_fclk_div2 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_names = (const char *[]){ "fclk_div2_div" },
>  		.num_parents = 1,
> +		.flags = CLK_IS_CRITICAL,
>  	},
>  };
>  
> @@ -349,6 +350,18 @@ static struct clk_regmap axg_fclk_div3 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_names = (const char *[]){ "fclk_div3_div" },
>  		.num_parents = 1,
> +		/*
> +		 * FIXME:
> +		 * This clock, as fdiv2, is used by the SCPI FW and is required
> +		 * by the platform to operate correctly.
> +		 * Until the following condition are met, we need this clock to
> +		 * be marked as critical:
> +		 * a) The SCPI generic driver claims and enable all the clocks
> +		 *    it needs
> +		 * b) CCF has a clock hand-off mechanism to make the sure the
> +		 *    clock stays on until the proper driver comes along
> +		 */
> +		.flags = CLK_IS_CRITICAL,
>  	},
>  };
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
