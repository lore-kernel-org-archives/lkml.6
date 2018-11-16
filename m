Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC538C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888102089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f1ptuTnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888102089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbeKPUTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:19:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51359 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeKPUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:19:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so21451220wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ja33JDDokGdW3hOdKYRVP/IerJwF02amkL65l2yxjrc=;
        b=f1ptuTnEV7tgk32tmlgdclKRNT7jL9jMrKSPZ7dXGLhANSfVQffeoWJLQ0N9vKmIeT
         LNvKruh2ywDslygHhqiSpgUInEmwZCljWnlW61HG+HN3hBMcDD70F3G2pjH+Am5Zbndx
         KQFORrmkGavDIYEbdX4OvadG7YM/ucLqqhh9HXMqAcWaWPI6h39+oba3drk9E2/0g4rh
         9XUnq4nql4zyZxNgbopnr/DVJxU3tAyZzKlOwraNjmOBENv7ooqYB64wTGG84MJd+TkU
         h+18NifqFBOwfsn/g0AiUkBxqrzOFvH+X8UijL22cwdTADCLzlCRRoMIkqyOqv13yh94
         IYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ja33JDDokGdW3hOdKYRVP/IerJwF02amkL65l2yxjrc=;
        b=ENPbJbfYR+5YqkYeXWil4AKvho2YaI4PdFcw4VRgZE3k1ueDnwx1muDB7VMTQw0n2O
         30CIV3Tn9Hs40HrjuEGsJYUqLtsDghuWoIeGm+dgowg3nae/WFZOD+gAx77IJux4nUXP
         609yiYawHjX2zqvgGuM6qjbmPLg4NxlztuL4PEYLGJ1q8Q1fH9pwDFX24EEZdDxkmQ/a
         0eHL4IiQAU+UqK1u0cx6uKDxQq+KrJHw7Fp2YQ2x12UbDz4KgO5kxxDNzFc+94PysU9D
         FG/8CoccEFfx3SZdV+0sQctI4kgARgvFQbGkinVGxEbO3krxwUf/crzf+iy8n4KDdTHa
         qk9Q==
X-Gm-Message-State: AGRZ1gKj210udrO/H7aWKo9j8ftL74cP2TtSj6PLXb67JAwgHvIJI6DL
        3ay8pi1mxVLu1PJ77csZrHWuOg==
X-Google-Smtp-Source: AJdET5eyR566X23Jz3MoKW7XpT08g9MvnV1tTLj5wPW7jtjquBQZeKE/uhlCQdsYBoxTVAGm37yDTg==
X-Received: by 2002:a1c:e03:: with SMTP id 3-v6mr2155777wmo.13.1542362842325;
        Fri, 16 Nov 2018 02:07:22 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q9sm4534550wrp.0.2018.11.16.02.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:07:21 -0800 (PST)
Subject: Re: [PATCH 01/10] ARM64: dts: amlogic: Add all CPUs in cooling maps
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <2778d0d4813cc56be851719846afecbab5f2e657.1542362530.git.viresh.kumar@linaro.org>
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
Message-ID: <c63cc837-218a-5b53-d7a9-4610bfbd0796@baylibre.com>
Date:   Fri, 16 Nov 2018 11:07:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2778d0d4813cc56be851719846afecbab5f2e657.1542362530.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2018 11:04, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
> 
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
> 
> Update cooling maps to include all devices affected by individual trip
> points.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 22 ++++++++-----------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 313f88f8759e..cfc92d06a28f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -132,19 +132,15 @@
>  
>  				map1 {
>  					trip = <&cpu_alert1>;
> -					cooling-device = <&gpio_fan 2 THERMAL_NO_LIMIT>;
> -				};
> -
> -				map2 {
> -					trip = <&cpu_alert1>;
> -					cooling-device =
> -						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -
> -				map3 {
> -					trip = <&cpu_alert1>;
> -					cooling-device =
> -						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					cooling-device = <&gpio_fan 2 THERMAL_NO_LIMIT>,
> +							 <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  				};
>  			};
>  		};
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
