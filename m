Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D0FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DDA25B18
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wAy5Br7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DDA25B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964959AbeGBIn3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:43:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51596 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbeGBInX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:43:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id u22-v6so782961wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Toe+Yo6pJAZsar+0iZyxvDQ9LGId8bw9kcgKIR3edxo=;
        b=wAy5Br7rJ50vPfoaKNfsicYEBOn/76xUKE+AUiFmrSgDmD5TBO/uwwDDR0Y0eyP74X
         rFg/3Ahdj7rdPeCiE0Bup5uU73c35ufNojrjgIw4CCyoZQoPKc3gY/DLf9C+nUkWy9la
         5RSpsnkCrGIK9l2a8ScmckJFdfomAgPzirgpNJlMUa/15BjN4NEwuBjcmX/AMO5Cg4p2
         e/J4G955viXEpeINuU5vnS84FWjqdKKQFyUZ4KVtEbR7XiBqIfVRgSYy7ci43ZNWHhSt
         vNBXv1BHBNz/04jgPf6vxnayJpez6yOEGs/nHkiU5NPqkNY1zOPBR761VfVCaWvAsOpz
         TcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Toe+Yo6pJAZsar+0iZyxvDQ9LGId8bw9kcgKIR3edxo=;
        b=fHHj95Bwd+3rA9Is/tMPHk43PtszrGJQCvGmfFt7rXZQ2JvnE0YOt3ZO8b8CXB4zkj
         utUl8AdtKDE2PAPy2xEZyoCrHbnLCBcbGZ6hLbVOKYmPdKPMw/dHy+dxBwOl0nAZZo63
         5hWLr8phPgyGxQbfkRoPZ5xG3fxpoab/T4RedMldTT6BYTJMEYgDY1oeL6CQ89D2SdpE
         7tZ1qhdWpofD5WvaYAkl0tqcJBIwCNTmXWEhchxIrpM5bLNFmyotHDQoXIGvDwqXUdOj
         21vcMModdH1iUgU2+9biWPz8ybiIqt/k/8aalioArmnH8Ys+LIMSvAIQCq2SPP8fcAPH
         NzeA==
X-Gm-Message-State: APt69E3623BzgyJVbJzFeYJf3GhhkqPQlUQD8bUlS+1Xkg9163N5CkVT
        9qrbpOBYlhqgPr+8JgvJgPQiUyXW/XQ=
X-Google-Smtp-Source: AAOMgpc28vnkpGhRH7VnBFcKUn7qBlqfEvj1lSJOw7rkCPAIxESNd8Bb9yu8G3rFk3zIcG3L4tfY8w==
X-Received: by 2002:a1c:4143:: with SMTP id o64-v6mr6977907wma.123.1530521001804;
        Mon, 02 Jul 2018 01:43:21 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 75-v6sm2213159wmn.22.2018.07.02.01.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:43:20 -0700 (PDT)
Subject: Re: [PATCH] ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0
To:     stable@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
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
Message-ID: <817c589d-25e4-e2d0-cd46-99a2ae59b014@baylibre.com>
Date:   Mon, 2 Jul 2018 10:43:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stable Maintainers,

On 05/06/2018 10:52, Neil Armstrong wrote:
> Like LibreTech-CC, the USB0 needs the 5V regulator to be enabled to power the
> devices on the P212 Reference Design based boards.
> 
> Fixes: b9f07cb4f41f ("ARM64: dts: meson-gxl-s905x-p212: enable the USB controller")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

This commit hit Linus master with commit sha d511b3e4087eedbe11c7496c396432b8b7c2d7d9
Can this fix be applied to 4.17 stable kernel ?

Thanks,
Neil

>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> index 0cfd701..a1b3101 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -189,3 +189,10 @@
>  &usb0 {
>  	status = "okay";
>  };
> +
> +&usb2_phy0 {
> +	/*
> +	 * HDMI_5V is also used as supply for the USB VBUS.
> +	 */
> +	phy-supply = <&hdmi_5v>;
> +};
> 

