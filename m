Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04192C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D802085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XKXW+6Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D802085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbeKFCDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:03:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38105 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbeKFCDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:03:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so8747526wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zmI7+dHKaN8BwVGQDQY0tm20/E9lZzIKXpfq/RUB2ac=;
        b=XKXW+6LrYSNpyzSCkm6jpEXF4DUno22+bPgV2L2SBv9lr/QZPLIromqODj/BsadzdV
         wv+9oe6b1RSW1okE/9F2RTh1e66hlh0eI71FrAGhHVyRbP41T+xkTOiPZRWm+CKNr0An
         Vsb8xUJo/SGviAtpYL74HZri6dvGCtBHGlXCf1N/znwWxVfE9+Vexwrw7JM1/lZF3efC
         Tbn/7zZwsa+vn7mHQvuDi/zypIDEQ+MEgcT6MU+wa3mTgx0cFFnCM6Qw5JJJJYlGKQH5
         frUJcwm634VzkQx3sBodMjuCrgkeSpe4BLDrWvdM11o0N5Hj3UvikkXgOY6tGJImUiSK
         FdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zmI7+dHKaN8BwVGQDQY0tm20/E9lZzIKXpfq/RUB2ac=;
        b=kr7cPl8G5tBtxWf+PgGlxkZ7q94gDJi4V3V1V2Q/4wkV0n0ZkBOT/UU6iguBb1rkWa
         m+AsdymawF8zYaSN761dypk2DPVSZaAmwtCNurdz3C8ogyNPAOV5YbTzNsG07irYPOwN
         1vDNkjtTSfcj9V4wQsg8jl6X4iVUX/r9Rf7+5QT/uh365Z2OLJalLG6glYQRb2M5+eg2
         Kxr5Peyhw64stjmvqoxSjP79mBdBlIgJVOTR8lCZbBB07YqzZA9a2NcWUguBKitCZSDt
         n6orIuNZxnK8zbaKtsI8SVYGCuwvz0IbzQxkOsWHDr0oM8+zhgOhFO8W4e/uBdgTXBu3
         47ng==
X-Gm-Message-State: AGRZ1gJI2AGyafpnfDcMMZUrRiEuab+WyLNXpNQXDNZpT+B4rKI18/JH
        1i64to0Tv/w35lAQjTaCJVRw5+hM9V4=
X-Google-Smtp-Source: AJdET5cAiNm5LuNz5PCXgnmFQIPr2/GipQqrrlYGnUmgwdOS759vjnzyO32U4TKtO5L5UpJDXYHOlg==
X-Received: by 2002:a1c:104:: with SMTP id 4-v6mr6605533wmb.69.1541436153431;
        Mon, 05 Nov 2018 08:42:33 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f67-v6sm22132681wme.22.2018.11.05.08.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:42:32 -0800 (PST)
Subject: Re: [PATCH] ARM64: dts: meson-gxl-s905x-khadas-vim enable Bluetooth
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1539432427-11779-1-git-send-email-christianshewitt@gmail.com>
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
Message-ID: <277b9fee-de65-41e6-4243-c13142191b5c@baylibre.com>
Date:   Mon, 5 Nov 2018 17:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539432427-11779-1-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2018 14:07, Christian Hewitt wrote:
> This enables Bluetooth support for the following models:
> 
> - Khadas VIM basic (AP6212) using firmware BCM43438A1.hcd
> - Khadas VIM pro (AP6255) using firmware BCM4345C0.hcd
> 
> The AP6212 module used on the VIM basic has an ID clash with another
> device. To get Bluetooth working you either need to apply a kernel
> patch to drivers/bluetooth/btbcm.c so 0x2209 loads BCM43438A1 or the
> BCM43438A1.hcd firmware must be renamed to BCM43430A1.hcd.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> index d32cf38..7e0717d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> @@ -187,6 +187,13 @@
>  	};
>  };
>  
> +&uart_A {
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
>  /* This is brought out on the Linux_RX (18) and Linux_TX (19) pins: */
>  &uart_AO {
>  	status = "okay";
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
