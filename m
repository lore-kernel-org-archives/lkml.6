Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3957C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86E22081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zH+GHK+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86E22081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeLKPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:06:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42471 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeLKPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:06:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so14427170wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2FfjbBVh3NMYlxvx0kpMUTiT+VcuQMpKGe66zpo84ys=;
        b=zH+GHK+cyzfnCsldWjfKATBR3d3zBPOndVU4g9rNwEQC6jiVhxRdZzd2dFz/I04q/g
         Fsn74ZyOmQhGA7bcWGOSFl8uXOGTPxJkJwT/goglZx+gk1QwjtkFTqpb7SgeXQeEBzTK
         QS5BUsAUBWkrP/V1DySROryNmcs7zQzCRe3GQfVz6JtLdAjp0joayTBPp/oXCLe5v24C
         EobMGcVZ5l9CCv0s/CEtTOtw5k/IlfSD3P9LCB01EpGFOt92/oQ3dbcCELt/yxQYtgtr
         XLfi7LmTJL8mDGfb4AmOTwu1Yu20uQ4x17zuCU6Yux1vtWZ18Pgh8EoDFsf3nfyCkk0H
         L51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2FfjbBVh3NMYlxvx0kpMUTiT+VcuQMpKGe66zpo84ys=;
        b=KezKJW/v0DTvlyRtMuqt8Mw82ARrrCB8pzOwCkHD5U4spgqbzwg/5Ua7QZJHDlAFpA
         yWQb1R8D6mi3/ULZvy37zDeVuoKo1SkriETgOyG4prPS7zHAfmPXLHY1TkoHTQMqvVKX
         p+L7JUfYXcGLvSZcXVUbUhdL2mtaVP6UpxSir+4MzR/wZXL2j4439I6quK18d08R2Nxb
         YNO/n/lE9qohpD5YDNH8Xx2A4mvZ3mS0yJjDLqcWkxiNd4/Rejief7ILoqs8d9+X8eMa
         nX5gtXjB8hZDots/1HKFDv88rlmHwAGQEBoVjgwggyb5Ap37ZiL9k9Gx5M4Ot/GuWD7J
         IRYQ==
X-Gm-Message-State: AA+aEWad/mZpsd8w7jWoKG2ZBOxhRQhlYkbyreQjguMGlHemkNwbnB5B
        KEYWN7ae0awQdtDGX8tR8zm/Rg==
X-Google-Smtp-Source: AFSGD/USfNrs8j5sX9n01FLHEqMyaJqW7AVnl0eC6XATlyN2gyLsZXGliTIXrUHgJDdMsjC8WOz+uw==
X-Received: by 2002:adf:91c3:: with SMTP id 61mr13184213wri.324.1544540761464;
        Tue, 11 Dec 2018 07:06:01 -0800 (PST)
Received: from [192.168.1.16] (lfbn-nic-1-206-198.w2-15.abo.wanadoo.fr. [2.15.53.198])
        by smtp.gmail.com with ESMTPSA id n9sm14709940wrx.80.2018.12.11.07.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 07:06:00 -0800 (PST)
Subject: Re: [PATCH] clk: meson: axg-audio: fix input clock name
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20181211124751.30108-1-jbrunet@baylibre.com>
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
Message-ID: <79f49d43-7eb0-d056-158c-c6c78db9cdef@baylibre.com>
Date:   Tue, 11 Dec 2018 16:06:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211124751.30108-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 13:47, Jerome Brunet wrote:
> The name of input clock is not aligned with the rest of the tree
> Because of this, the audio peripheral clocks are orphaned.
> 
> Fixes: 1222ab89328f ("clk: meson: axg-audio: use the clk input helper function")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Neil,
> 
>  Feel free to squash this with commit 1222ab89328f if you prefer

Well, I'm lazy so I squashed it :-)

> 
>  Cheers
>  Jerome
> 
>  drivers/clk/meson/axg-audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 72b717e61a68..8ac3a2295473 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -752,7 +752,7 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Register the peripheral input clock */
> -	hw = meson_clk_hw_register_input(dev, "pclk", "audio_pclk", 0);
> +	hw = meson_clk_hw_register_input(dev, "pclk", "axg_audio_pclk", 0);
>  	if (IS_ERR(hw))
>  		return PTR_ERR(hw);
>  
> 

