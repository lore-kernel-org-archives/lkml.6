Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20CDC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E631206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oQcnOo10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E631206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632724AbeKXCE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:04:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39707 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394997AbeKXCE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:04:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so4733838wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 07:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ib6K/S2X2KQ3k0hXvXC3UVSEXSrcd/wHvu6uquJikUw=;
        b=oQcnOo10mQ7DLsRjrm0ZYaWDQYuzqKsmvH59FfuNzVG0P7hd0qs7cnse/Bgcj3l/P1
         vrGigu+1M/fE2jvNJwrLMlSEu6uwJC/jCiUXFvORpD/UQyoGmoBb/FGu8uczqNhW8wGI
         Lqr8qIHPAeB0AMA4t8lWZ994kGfIzFRznmRG/YqZcDuIQIm42P2Oa2TraDbUwgzgIGEs
         EKvhTSAiWeXoSJfohQlWXR8by+LnjqMrkI8U7Q6S/4Zccgbuu+i7hsjtnD80Nuch7M0d
         bT5Zy9qSBFgWt14/I7cy7cNnhRwYYANVq3/R01/wwakKUg4h/GaFhT9r0aelcwBKt2pB
         cALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ib6K/S2X2KQ3k0hXvXC3UVSEXSrcd/wHvu6uquJikUw=;
        b=HBTGSb2ZAbZvy0tItatmbfMgqz+4vgof9exNLHH3t1zXjMs4Z0vcIeHKRjwEYUnmwM
         XUyH+xNqohDV611qCRPzjUXaaDP8GG8uncBQ+QjPih2lt2HTVhQoF/Mdm7z/tj/dH024
         rte9guiq6H6nlmYLiquO8kTWuxwpx84oLvTzIFX4bIrV+YrBkkCIgFp/WKKJnreXqlD8
         nmCX3xWYqPUCe1nqbjGA+Y57TGmYMgWjhMWIYoXO0YK1e4rTuNoWnqML130IVsMQPRcE
         +AjJIj5CCFYiz6FTyDfi43ajpsLv/yzWXY+GKH53HkLVhd2RUJ5LRlYcHO7PAvPOTcJn
         mvag==
X-Gm-Message-State: AA+aEWZEGPSRX41m5a0LTNkEs1m8QCMp6TjLwo5ndH5a4ZpnmEb3q7oD
        r+Shl985Y84JVPo92w1XyTKVAAouYSLfVw==
X-Google-Smtp-Source: AFSGD/VmzGkO9k3AYk2lMhVZ5PeTQ+RsqvBAiAVqEIKscvXuzuhQP00t8/tCFGeO5hHifRwJ8uTX2w==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr13925001wrw.323.1542986418865;
        Fri, 23 Nov 2018 07:20:18 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u10sm9928927wrr.33.2018.11.23.07.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 07:20:17 -0800 (PST)
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: meson8b: export the CPU post
 dividers
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
 <20181122214017.25643-2-martin.blumenstingl@googlemail.com>
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
Message-ID: <4e82df94-dcb0-57ca-c751-074012d054dd@baylibre.com>
Date:   Fri, 23 Nov 2018 16:20:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122214017.25643-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 22:40, Martin Blumenstingl wrote:
> There are four CPU clock post dividers:
> - ABP
> - PERIPH (used as input for the ARM global timer and ARM TWD timer)
> - AXI
> - L2 DRAM
> 
> Export these so we can use them in .dts files.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  include/dt-bindings/clock/meson8b-clkc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
> index a60f47b49231..5fe2923382d0 100644
> --- a/include/dt-bindings/clock/meson8b-clkc.h
> +++ b/include/dt-bindings/clock/meson8b-clkc.h
> @@ -103,5 +103,9 @@
>  #define CLKID_MPLL1		94
>  #define CLKID_MPLL2		95
>  #define CLKID_NAND_CLK		112
> +#define CLKID_ABP		124
> +#define CLKID_PERIPH		126
> +#define CLKID_AXI		128
> +#define CLKID_L2_DRAM		130
>  
>  #endif /* __MESON8B_CLKC_H */
> 

Kevin,

Martin asked my a tag for this patch since he has a dependency on it.

You can find it here :

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://github.com/BayLibre/clk-meson.git tags/meson-clk-headers-4.21-1

for you to fetch changes up to 8e1dd17c8b0e3f8c66ed2a3f88a440d36135e589:

  dt-bindings: clock: meson8b: export the CPU post dividers (2018-11-23 15:11:55 +0100)

----------------------------------------------------------------
Update for meson clocks bindings targeted at v4.21:
- Export Meson8b CPU post dividers

----------------------------------------------------------------
Martin Blumenstingl (1):
      dt-bindings: clock: meson8b: export the CPU post dividers

 include/dt-bindings/clock/meson8b-clkc.h | 4 ++++
 1 file changed, 4 insertions(+)

Neil
