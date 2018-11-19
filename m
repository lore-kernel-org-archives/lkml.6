Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1C3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193FA20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jVUOodgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193FA20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeKSTWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:22:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34880 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeKSTWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:22:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so14192231wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 00:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wR6JyfdzIywpHxZOsSr/27mOXAcYWeE8wyd6CS3sorU=;
        b=jVUOodgoxSKFPEvKZVWdLALynximcgU0uD6gGZ5Mqe3AbmyzHDjW+nT3HYmJ7YpKHT
         5EZ/hHLsOUMAgU5hNQ251rVuQrpOnhvq9nQkWJbKnsdwFgWOFESwrP9ZA8PFgf0eAxp0
         ufIoeXfk7KVSDFcHfTUybuq40hyXhACEpPlKvzw/CNaMKBOP1iE1zkEvif/t4u/dpo7U
         9wSSzRC1E9Ut0dqNbaqeIqVnkAB28em/ru/iMj03MTlkEQN9SYGJJI48ZWXZP0RrmuxQ
         ELeg2jJ/G86+gXs9iYKimS7VykU3KhrkmThMTdv5rtgec7UDTdgq3FD5Wy27HU+yMW9g
         Qq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wR6JyfdzIywpHxZOsSr/27mOXAcYWeE8wyd6CS3sorU=;
        b=jJjWlfGRdzP2mo7p0N2NamwqA7/1D1Lr0BqEGxmGABgI/lCeZcljdBZcnkLH9B2hM2
         0/C6Rr65QOxtTOXQnM1su4IbxC+jU3BcAS8DNFrxEgvb3YkX8skVaat93/M0dvvjkWDD
         Gf2a+P7lvG0KmvBAYmCneFzIcNG6UQlPNouC0pIukd/xSi+ZILTZJuAZ1Fg/TmtxsYlS
         IqZDjLOg0Zt/GRyGo54z+ouqB4Aw/ZQiYGU8oyw6iIVEYepKrE/QYjUC7zAt3H45BJfQ
         WPW00ZT/pjvNCq/W+FcGUuGVd/6/KUrawViVupqEHpdBlPu4W919avNvJ5w4dg2DlWN3
         3uDQ==
X-Gm-Message-State: AA+aEWYaxctLU1Ks22qW704GzJRgNX6guqMQokwiGJHC9uqUv0oX/x6r
        am6ZyelKxp+LWIOojklE+FMETg==
X-Google-Smtp-Source: AFSGD/VqaJIW9SJNHCftaC9hc/CMOCHKCW3JULU+1dL6ljdbIg3BzYAgEorsoDXFetNr+pxMVa2bAg==
X-Received: by 2002:adf:8544:: with SMTP id 62mr7213060wrh.1.1542617951713;
        Mon, 19 Nov 2018 00:59:11 -0800 (PST)
Received: from ?IPv6:2a01:e34:eeb6:4690:e5a0:b59f:f315:89e8? ([2a01:e34:eeb6:4690:e5a0:b59f:f315:89e8])
        by smtp.gmail.com with ESMTPSA id k124sm9360559wmd.33.2018.11.19.00.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 00:59:11 -0800 (PST)
Subject: Re: [PATCH] ARM64: dts: meson-gxbb-wetek: fix hwmon temperature
 sensor output
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1542601348-3469-1-git-send-email-christianshewitt@gmail.com>
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
Message-ID: <d4baee43-d666-0268-30e9-694a8355d5b9@baylibre.com>
Date:   Mon, 19 Nov 2018 09:59:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542601348-3469-1-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 19/11/2018 05:22, Christian Hewitt wrote:
> Add &saradc and supporting vddio_ao18 nodes to fix hwmon temperature
> readings on the WeTek Hub and Play2 devices. Without these nodes the
> temp is reported as 4294967295 degrees C.
> 
> Thanks to Martin Blumenstingl for assisting debug and the winning
> guess at what was missing.

It's a good workaround, but the real solution is that we should instead
add the CLKID_SAR_ADC* clock in the scpi_sensors node and update
the driver to keep these clocks enabled.

We hit the same issue as the clk_div2/3 which should be kept enabled
by the SCPI scpi_dvfs driver.

Neil

> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> index 70325b2..dd12e02 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> @@ -59,6 +59,13 @@
>  		regulator-max-microvolt = <3300000>;
>  	};
>  
> +	vddio_ao18: regulator-vddio_ao18 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
>  	vcc_3v3: regulator-vcc_3v3 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VCC_3V3";
> @@ -173,6 +180,11 @@
>  	clock-names = "clkin0";
>  };
>  
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddio_ao18>;
> +};
> +
>  /* Wireless SDIO Module */
>  &sd_emmc_a {
>  	status = "okay";
> 

