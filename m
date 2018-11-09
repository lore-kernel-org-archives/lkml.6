Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A38C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DC720827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yKxP3opj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DC720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeKITVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:21:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55966 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeKITVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:21:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10-v6so1358699wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aBeoUMMBTTikkOyz8hn3EIR4la7TasmQRpsYnog57a4=;
        b=yKxP3opjngIt0vWq8LrrJseNSZyxfdeEIpM8iV8wXOHK0tDkjhGcAtzFU18E/zLNRQ
         lAPcumHbwUo4GHWL4wYOoR7bjmpq7SBRGXKx5w9keiU2BlPFnlTK5pW9bmoJ84UJGrlA
         rNa7bjtJ+CRYja6A7U0UOMRm/dTKGv2KBrFcpClw2f6SgMBR6k8w28yRNr9tRJQizdMo
         3CHeAZd7e6woyg+j0a6SpzZK9yXxNqLjevzytJWsL0/BXr0qGgB+8Vr9kY/7WAU6uWZW
         s4EPo0KKPc1anC6PWHJxuO4GS5u7RchR40uA2EfsYW1rSxr3X//qZ2RIjqnzYQpt+JxF
         NC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aBeoUMMBTTikkOyz8hn3EIR4la7TasmQRpsYnog57a4=;
        b=fsuWUftcOf2vQ+EX51WhLOSkwlY2AZWYC9mF4b0C3+lPhvQMhRhUxcM+8YHi+qEtjj
         gtqgPzQtSQ2B12DcFqAR0gaiPZJY4C+T2TX+xq5HFB9aR/EQPK/SbLBmWV9GD8uVwUUL
         Us9o6GbHJfnRu0Ny/Urp/wtyKrVcKTYwITN8i0HdbgWBFX9K8hT+U0kbTgOiH4WCE6ig
         BUTKdYvOLA3WtNSPeRiOJ93LH7A9Xkvy6/lLSgWt6/Yz6mDH5KqlLNsfltkx/Was1ww7
         vxTNX8zTg3s49Pbn4DWpVe9vuyRdl+2caa+rg2Yo5v+yhC+axEFSVRPgzaWLmVYBTFZA
         DkwA==
X-Gm-Message-State: AGRZ1gLZDF8sTXuMkESMoj7mofDTve4tFcxx2EZFf+0HjNqBzLY36q4Z
        tkrXhTGKmZLDe+v1coXQX56FSw==
X-Google-Smtp-Source: AJdET5e5DFG8Xo4d0FatJND+e76B3k0KLr48q00aqG05mDs5oc9AIPrGvQwY8JPqqKGmeJfEA1e5/A==
X-Received: by 2002:a1c:1f4c:: with SMTP id f73-v6mr4409558wmf.56.1541756492240;
        Fri, 09 Nov 2018 01:41:32 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x194-v6sm3469873wmd.41.2018.11.09.01.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 01:41:31 -0800 (PST)
Subject: Re: [PATCH v3 3/3] ARM64: dts: meson-gxl: Add support for the
 Smartlabs SML-5442TW
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-4-git-send-email-christianshewitt@gmail.com>
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
Message-ID: <5118ab67-3856-90c2-300d-ab6ff73e7f71@baylibre.com>
Date:   Fri, 9 Nov 2018 10:41:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541706240-30036-4-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 08/11/2018 20:43, Christian Hewitt wrote:
> The Smartlabs SML-5442TW is broadly similar to the P231 reference design
> but with the following differences:
> 
> - Yellow and Blue front-panel LEDs are available but disabled
> - Red/Green LED is used to signal off/on status
> - GPIOX_17 is set high to enable the QCA9377 wireless module
> - uart_AO can be accessed after opening the case; soldered pins exist
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>  .../boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 292 +++++++++++++++++++++
>  2 files changed, 293 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index c31f29d6..37d7dbd 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-sml5442tw.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
> new file mode 100644
> index 0000000..44d02c2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2016 Endless Computers, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
> + * Copyright (c) 2018 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +/dts-v1/;
> +

[...]

> +
> +&usb0 {
> +	status = "okay";
> +};
> 

It's ok for me !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
