Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6420DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8C7208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yRSFw7TZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8C7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389066AbeKPTFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:05:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53415 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeKPTFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:05:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id f10-v6so21202379wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 00:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7hzHKK2Bq/brkNiGyAudqFya43IkCaPZVoqXPJeNx2U=;
        b=yRSFw7TZvQ2ztj3vFoBNR+Kcf5VRG+90Bi6qvAmGbWdn2NrvrHzQZKZyBNVyMfiBmp
         V0eqNnyyPinYHe9i1rpI5v8wYhpAg52dXCj3BMIiyoOy/QlL/enAnrk4Vjf6BHe0X51Z
         EeD+nSkT0wywDQq6bWPzFqw3u3hR0VrKpO9pdwiqflaetQYnTjhVscajg72ZavmqwTf1
         cLT82ek5MNk3lQpiUkQ2ca1m45yvkJ5wCtsgq/kyZzZz2dmHuWpretSQPaz8hBpx8GuS
         Zx8jEOzfPyFveC6/4k+BwD4hbuc5bW40EH4oNksg08lyqhIwrmnRKYLdz4yNxajG52rw
         1rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7hzHKK2Bq/brkNiGyAudqFya43IkCaPZVoqXPJeNx2U=;
        b=WxYIg5Oimr1YrTQ6ELEqsj5YxbknwBArI8rlvKNzozFhamYtju5XKwuTwxVszPoXVl
         kuBpCTVhqsgxfi7ZKAazYY8WD/wFOyy3cj0ETwmJ+KEM49vTiX24OZYziDrz/epTwsd8
         kBZGTc6oqspb3LknDY3lWrNtM0eb285WFF8UPFblMdbqjqdz+fojgCnRke9OuRH+YZ6J
         BZ1/3TvrO5A3BBeGg44Jy0ZrPdEOLVDMRneQzmTsIrl0HY+x+SElREmCXSWw/sRZKfJZ
         xfxB2xMzaEovKNrnf74pZx6WULJVYR33pXdwRnu71kgsfMByNj8wXN+xzxmam2n4lSRr
         Q/NA==
X-Gm-Message-State: AGRZ1gJ9kmISkl4oVlWCYcaUgjN1GHkkJmQ5E8Wi+AvRIogSaqEXSaxU
        90xydInR0MkJEwylzO3TH+fbVg==
X-Google-Smtp-Source: AJdET5crr2Ms1ETZd00gjb5pzao7HOOtHFNtKG6batz0aJK7/mW3i4ueVFIZCMB0BYGOAJhxZfpAEg==
X-Received: by 2002:a1c:9f0b:: with SMTP id i11-v6mr1679177wme.59.1542358423757;
        Fri, 16 Nov 2018 00:53:43 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l5-v6sm29094523wrv.84.2018.11.16.00.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:53:43 -0800 (PST)
Subject: Re: [PATCH v5 1/3] arm64: dts: meson-gxl: add support for phicomm n1
To:     He Yangxuan <yangxuan8282@gmail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, carlo@caione.org, khilman@baylibre.com
References: <20181110033904.4207-1-yangxuan8282@gmail.com>
 <20181110033904.4207-2-yangxuan8282@gmail.com>
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
Message-ID: <5974964f-e81a-8edd-23d1-f6a80185f9cc@baylibre.com>
Date:   Fri, 16 Nov 2018 09:53:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181110033904.4207-2-yangxuan8282@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 04:39, He Yangxuan wrote:
> This patch adds support for the Phicomm N1. This device based on P230 reference design.
> And this box doesn't have cvbs, so disable related section in device tree.
> 
> Signed-off-by: He Yangxuan <yangxuan8282@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile                |  1 +
>  .../boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index c31f29d66..49f3ac5d8 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
> new file mode 100644
> index 000000000..9a8a8a7e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 He Yangxuan
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-gxl-s905d-p230.dts"
> +
> +/ {
> +	compatible = "phicomm,n1", "amlogic,s905d", "amlogic,meson-gxl";
> +	model = "Phicomm N1";
> +
> +	cvbs-connector {
> +		status = "disabled";
> +	};
> +};
> +
> +&cvbs_vdac_port {
> +	status = "disabled";
> +};
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
