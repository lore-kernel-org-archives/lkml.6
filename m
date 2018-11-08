Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B861ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20932081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MU90ALHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20932081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKHXBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:01:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37178 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeKHXBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:01:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so1193431wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KezX1PXaieHOZcVFn+1NcfNi1YwhyP1SN67jpP5MQmo=;
        b=MU90ALHJUaKYApkhWfxENJpXVhIO07cnn05ZDID7GGAlUURs8R3qYLmNJysx9A+nn5
         NH1JzB5IpmfSUf6fbuLOY7Fb0daGPOTWNp7wzF9TVmZ9PaaHIDlWAC7dXyhkACypWEVe
         mAlp4UxsmbsCoHrLz3nXkSeAGoDwwIgY4lWw+LgwpkMymEaf95s+xMxSbWmrUGmc8h/K
         YLDGlMWwnOiNsNeBlRtUOxMEheXQH7nb9AktK6Gil5wQxLFugzE/BbK0gsS04cgEZ1SR
         IVrT3QWh7PIpW1EEPufqtzdj6YsUWoDylPr4gS2mU2xKC1kd3apP/gJJiWPsiMfj55Ws
         UzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KezX1PXaieHOZcVFn+1NcfNi1YwhyP1SN67jpP5MQmo=;
        b=aRfVYZf7ujpsdVzRDHFzrzltBLUQJR8IBAu6/ENPKih8JzOruaqlLgxT3az3X7Qh5C
         7D1y2qFiwf31nrjQxdqH9LRH7viHWWk8F/hMPOApe/dKdd2pK/44PCUt698nNkmEyXrJ
         8hf7EIFztsP3Q7ec6t9cbCm/LtAcu/Qxwp31qORAykqC4cUVmgSCSjqXHKnKdxb23yNi
         TXZES2IDNjxysCUASg8cv0ClhyKs7FlQW2nJhZCV7MzCHWTFzzUSVYbOst1N/Dv1egAs
         zHeIrqkpjDipfE4DAT7y8WOzDgheRJRr+wJI4W7lo1DI8InTqEznVbVkEdbHxiWEUq7R
         neTg==
X-Gm-Message-State: AGRZ1gIKX5/HDwRsIGR+RJQQoqdQ6eHFgy0BHQ6bHtC43uyGmZ7xZQuA
        4NRLaoHvbLSOxFkqi9eg1GCRdQWvSCM=
X-Google-Smtp-Source: AJdET5cKxGPidDZ0CvLI8cHwD2/u1cfhlTIZjY6OJeRJC5w4iGLEcplYPiDJ7QHA0RVTowkT1YSIqQ==
X-Received: by 2002:a1c:f008:: with SMTP id a8-v6mr1169160wmb.5.1541683579742;
        Thu, 08 Nov 2018 05:26:19 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x65-v6sm4274769wmg.9.2018.11.08.05.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 05:26:19 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson-axg: s400: add cts-rts to the bluetooth
 uart
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181108095640.27876-1-jbrunet@baylibre.com>
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
Message-ID: <79dd5a96-b7e1-31ed-745f-5ba05ba30173@baylibre.com>
Date:   Thu, 8 Nov 2018 14:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108095640.27876-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 10:56, Jerome Brunet wrote:
> The uart used with bluetooth chipset on the s400 has flow control
> available. Let's enable it.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index ba44b0419404..29ccb8ad0de6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -543,8 +543,9 @@
>  
>  &uart_A {
>  	status = "okay";
> -	pinctrl-0 = <&uart_a_pins>;
> +	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
>  	pinctrl-names = "default";
> +	uart-has-rtscts;
>  };
>  
>  &uart_AO {
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
