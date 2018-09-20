Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0DEECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DC820880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ep1EBbQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DC820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbeITNgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:36:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36938 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeITNgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:36:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so8325732wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HS/qUo0KSn4e5rqSvPRq9Uqk0287bshrj/sMI3BlqJc=;
        b=ep1EBbQMRP8v1xkhja+2kbswQJgjSUQaeTcqBr1Em0c6j4MrcJXVpVzgHRxQs1vjyo
         0XPlMEMze9bo4UY93bUiECVSDyaVCUOlhHhTXXJ/1+83eh5Y4zzxvi9B+Ax2fy45cqvl
         B1eAGC3kpQFu0wphk18P/4ut1Jc+vU8wE0sXbhoahSrgZebask3TekuNgN9bIPpHeUjH
         zepODqtGcYCPkFuzsOcuSZ6heWYrseRP7ncQzxVGzh5ukdOgbDmgBt/vpWR7f3/OAITR
         FSWF8E4b98IjmanpYqYjEmQx/9r6bF1z53lnWag5e5ak9oWh325k0nTm4fxFDykuhKN1
         +9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HS/qUo0KSn4e5rqSvPRq9Uqk0287bshrj/sMI3BlqJc=;
        b=l98gCxuP3NdsGW7kYDJFAEWxkrzKdAZ+W9M29z+ziYJoYfF9MFN0/Dh2wk6jf1Rx/h
         0peG1F7NjePokuWrocQ1kMicI8ZMKeuj/hE6sQbkuyWptSp0P2NOpP+XKrUb6gmnm8ye
         nbQqrkyKycR8T1VO70dCwiqWQEwF/xmqNjPcdgsx1nBYLc+04Zpj97/p8nswprLmS/x0
         1A7w9OUpNc4q4ISyJccobRmIcN8mFtZih7bDvyYZ7k578bBDlc5tYfctx9VUC2HG04yY
         xzcdgSRjN29L/ZWC9W9ThCBN1NCwcExu/oI0kTqnSYV665A/h78PW2wxiiUIyapMqfRx
         6YCA==
X-Gm-Message-State: APzg51C43F5gSt9EFMwGmr7ys5upZb2Yqm6UzaUebPZU9iDQZRYIeLD/
        3hSBRwTdLk3V8Ht7xo9ioCuj7WJqGzY=
X-Google-Smtp-Source: ANB0VdYDFhJ2XDx2v70T6+JCahcvc+wpMpSfsz68OGkgA4JnBb0bV74cmpzQcFYOrno4v55ccqGwgg==
X-Received: by 2002:a5d:4089:: with SMTP id o9-v6mr32339310wrp.133.1537430078357;
        Thu, 20 Sep 2018 00:54:38 -0700 (PDT)
Received: from ?IPv6:2a01:e34:eeb6:4690:3dd5:8518:3946:bbed? ([2a01:e34:eeb6:4690:3dd5:8518:3946:bbed])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1113134wmf.28.2018.09.20.00.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 00:54:37 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] arm64: dts: meson-g12a: add initial g12a s905d2
 SoC DT support
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1537427368-11104-1-git-send-email-jianxin.pan@amlogic.com>
 <1537427368-11104-3-git-send-email-jianxin.pan@amlogic.com>
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
Message-ID: <c16ae8cf-5802-778b-1fd8-494dfb2d8d1b@baylibre.com>
Date:   Thu, 20 Sep 2018 09:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537427368-11104-3-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2018 09:09, Jianxin Pan wrote:
> Try to add basic DT support for the Amlogic's Meson-G12A S905D2 SoC,
> which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
> Timer, UART. It's capable of booting up into the serial console.
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile            |   1 +
>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts |  22 +++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi     | 172 ++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index a97c0e2..c31f29d6 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> new file mode 100644
> index 0000000..d267a37
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-g12a.dtsi"
> +
> +/ {
> +	compatible = "amlogic,u200", "amlogic,g12a";
> +	model = "Amlogic Meson G12A U200 Development Board";
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +	};

Hi Jianxin,

Please add the /memory and /chosen nodes.

+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};

Thanks,
Neil


> +};
> +
> +&uart_AO {
> +	status = "okay";
> +};
> +
[...]

