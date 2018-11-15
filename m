Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B159C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2163C21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v8LsOP9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2163C21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbeKOTUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:20:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34178 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeKOTUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:20:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id f1-v6so15322896wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LY6YswFN4Td7+LGniScF1DGT8tdD8RUvWn2jNuzhhrI=;
        b=v8LsOP9icqXeFx9QG2P4zBzvsoVvA3H07Ur55G3cFKEp4KKG3bPp53UOG9i4NwBlQB
         ncsRQ4eL1gEndqkX8CVN7Tu+t9/7/xderkxoNT7q3tEZaVSDiPhQEfXQRSLpoEUzmLGd
         TVSroIfqvL3u8QF3jaiNaVAcmhKiZeOU3Icb+OSQ2S+O/xB6speS9EdS5my5bm6IkDgb
         9nrzHGPfaPNYadi4o5JZmxL2e3GG8OKOUBMT00ufYvs+TQsYQwHvBViJ64oyZmo1dIif
         Sm23oV6dK9SUpopFMTcPf9ZSSzcS5GjcFGfYtGS9UNdy7QHKnsBd81QCuFXdK9MvZxGf
         nQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LY6YswFN4Td7+LGniScF1DGT8tdD8RUvWn2jNuzhhrI=;
        b=N0jWID2raEtvmbyASwfqhRqQsXLGvs4sVryq7cAd2pelkTEhaz0HENV7x5y7bu1fho
         aVvZ8JtKzOSE7tZkmuI89eL0ogRhGyVTHIMs8AUfgVLEnSFUB73yFkYxOsqAhaX4hh67
         iQ1jkW+FkDKD4w9hVJw/T4O7AXMPCpXa33/oj5dKXd3X8R4g+GAi3yoYsjJMSsc5qqNv
         NZOYQeQCLRZTkZu0KJED1v8n4E5c9gC8OEObT+zTreVfvnr/2vx9JPR8XS3mUuXeXpUg
         NzEs1J0UxcBC6fElK562re/R7TixSngDaMXYv51yNAC1m/uStPqAEk0gxCIrvK0rAuHg
         k63Q==
X-Gm-Message-State: AGRZ1gLyGHSFtXhxLXmpJXZ3EVCdh51aWFmIEERtsKtSfQBhU3I4QKFa
        1fezm8y8xc6ukxr81RmUOFzxEw==
X-Google-Smtp-Source: AJdET5eZTt9zWhj697ayxm2+vPJkVPMQ4WxPUYJdY7KU0ugjqAYNgsGZXLLz9QZmtSuodjiPdLEd6Q==
X-Received: by 2002:a1c:5706:: with SMTP id l6-v6mr4796452wmb.51.1542273210637;
        Thu, 15 Nov 2018 01:13:30 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l5-v6sm25507841wrv.84.2018.11.15.01.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 01:13:29 -0800 (PST)
Subject: Re: [PATCH RESEND 2/2] arm64: dts: meson: add libretech aml-s805x-ac
 board
To:     Peter Korsgaard <peter@korsgaard.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20181114101925.10526-3-jbrunet@baylibre.com>
 <20181114103855.14571-1-jbrunet@baylibre.com>
 <87a7mbvi6y.fsf@dell.be.48ers.dk>
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
Message-ID: <4c2aae46-e34e-aeb4-339d-00a4f4cbf3e7@baylibre.com>
Date:   Thu, 15 Nov 2018 10:13:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87a7mbvi6y.fsf@dell.be.48ers.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2018 15:37, Peter Korsgaard wrote:
>>>>>> "Jerome" == Jerome Brunet <jbrunet@baylibre.com> writes:
> 
>  > From: Neil Armstrong <narmstrong@baylibre.com>
>  > Add Libretech aml-s805x-ac board (aka 'La Frite') support
> 
>  > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>  > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>  > ---
> 
> ..
> 
>  > +#include "meson-gxl-s905x.dtsi"
>  > +
>  > +/ {
>  > +	compatible = "libretech,aml-s805x-ac", "amlogic,s805x",
>  > +		     "amlogic,meson-gxl";
>  > +	model = "Libre Computer Board AML-S805X-AC";
> 
> No mention of 'La Frite'?

It's a codename, the actual product name is AML-S805X-AC

> 
>  > +	memory@0 {
>  > +		device_type = "memory";
>  > +		reg = <0x0 0x0 0x0 0x20000000>;
>  > +	};
> 
> Maybe add a comment that there's 1GB variants as well?

Like other board, we set the minimal encountered memory size in DT,
the bootloader will update it to the actual memory size.

> 
>> +
>  > +	vcck: regulator-vcck {
>  > +		compatible = "regulator-fixed";
>  > +		regulator-name = "VCCK";
>  > +		regulator-min-microvolt = <3300000>;
>  > +		regulator-max-microvolt = <3300000>;
>  > +		vin-supply = <&dc_5v>;
>  > +
>  > +		/*
>  > +		 * This is controlled by GPIOAO_9 we reserve this but
>  > +		 * claiming it as done bellow reset the board anyway
> 
> s/bellow/below/

Good catch !

> 
>  > +&spifc {
>  > +	status = "okay";
>  > +	pinctrl-0 = <&nor_pins>;
>  > +	pinctrl-names = "default";
>  > +
>  > +	w25q32: spi-flash@0 {
>  > +		#address-cells = <1>;
>  > +		#size-cells = <1>;
>  > +		compatible = "jedec,spi-nor";
>  > +		reg = <0>;
>  > +		spi-max-frequency = <3000000>;
> 
> Is this 3MHz a limitation of the flash, board layout or SPI controller?
> 

It's the stable clock frequency used by amlogic to access to SPI flash,
we prefer using a safe freq, because we don't need fast access here.

Neil
