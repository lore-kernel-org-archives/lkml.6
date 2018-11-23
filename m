Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F649C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C282B20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KQDheVde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C282B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436888AbeKXBZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:25:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35031 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391353AbeKXBZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:25:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so12596950wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jWnIdsDrWcxWTq1j213GdVFWnMbnWtL0+OC4UsptE/A=;
        b=KQDheVdeC2XZ2Jy/v9GFGKxtJk2ry38wY9pJa/HEqfoGTPMepVPoHRhY8AKpY36Tag
         4uUzKRsjmhtS/OReIS/+S5DNOKIXB4gvPHBDNZFTHAfaOoPLA7Nk9AhKHKDV3FrtuN3K
         TlktYdIyK0ZP2TbYhTwGSUl5+F+91feuXK5e2OJSVxrToIPGzZks2+n66R0PY6s6mjyD
         7tecJs1UA4o+Q8JZYDC3j1LgiMjn3OFD+2FnSuHqs9rC8XQmZRkxnGbZmYrelS7o03hp
         ctdmwcmILHMVDE8LdmKo7a5lYGqlTmLRBYK4LOwQFZtTSpDDgod7LNYTbLo5AnRAhXxF
         xfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jWnIdsDrWcxWTq1j213GdVFWnMbnWtL0+OC4UsptE/A=;
        b=IZ9siLocq+RtkVFm+qaqKh4P28qK7ESzLvnDX6ZCKDLQMD6XMtnPuG0GRSJ9Nzq6DD
         YCty8rBAcf8a1kxcGxfbHO2BIlRZDfnvHXU7gKKTVQoX+Fn6aU8sW6fnKIzIYgbKizeF
         Rq60nipBHCa3QWBVrUf+i38UDH7BkRGVv6V7r8c0/xlaWKhmzAt5O+2IGobmRVBGyDkd
         IleQcqaXetgPwhzfIue1tN20YYRifbPRBK6krjU+adMNNZep+1Msy9RdtQB+qu4uddOC
         58IbgOA4P1/H4lKASm2Hkn3fmhIHUmuzuTfvGp3Cfn2idwVGUXMD9TNRfuk/vpWhMcM5
         AdmA==
X-Gm-Message-State: AA+aEWYnNt5jCzdPydeaLrmbUp8w7YSCR5FTG4nBEhnDw2JcwqPpk6Ov
        EpN6VxHPsv1EDPpfqVZ9wtXck7Ys6zzFxA==
X-Google-Smtp-Source: AFSGD/VSK01VEwGhFg+aAgTrkBkpPB8x/CYYkzpm9VUmFrL3oRQuWHcr55eSxKfu7dTfZZHXrI9CFg==
X-Received: by 2002:adf:8464:: with SMTP id 91mr14926193wrf.251.1542984056412;
        Fri, 23 Nov 2018 06:40:56 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t131sm6055850wmt.1.2018.11.23.06.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 06:40:55 -0800 (PST)
Subject: Re: [PATCH v2 0/4] Meson8b: add the CPU clock post-dividers
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
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
Message-ID: <4859b354-ade4-8172-eeb5-7a4a42045589@baylibre.com>
Date:   Fri, 23 Nov 2018 15:40:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 22:40, Martin Blumenstingl wrote:
> This is the successor to my previous series "meson8b: add the CPU_DIV16
> clock for the ARM TWD" from [0]. I decided to not send this as v2 of
> the original series because the PERIPH clock is not the CPU_DIV16 clock.
> It's not clear whether a CPU_DIV16 clock exists.
> 
> With this series we get all the CPU_CLK post-dividers as listed in the
> public S805 datasheet [1] on pages 31 and 32:
> - ABP
> - PERIPH (used as input for the ARM global timer and ARM TWD timer)
> - AXI
> - L2 DRAM
> 
> Each of these clocks has a register called "..._CLK_DIS" which is
> documented as a "just in case" bit:
> "Set to 1 to manually disable the [...] clock when changing the mux
> selection. Typically this bit is set to 0 since the clock muxes can
> switch without glitches."
> Since we're not supposed to touch that register we're using the new
> read-only gate clk_ops to ensure that nothing accidentally modifies
> these bits.
> 
> The result of this is that we can use the PERIPH clock which clocks
> the ARM TWD timer. I will send a separate series to add the TWD timer.
> 
> 
> changes since v1 at [2]:
> - added new patch 2 "clk: meson: clk-regmap: add read-only gate ops"
> - switched from CLK_IS_CRITICAL to the new clk_regmap_gate_ro_ops
>   so we're consistent with all other read-only clocks
> - collected Jerome's Acked-by tags (thanks!)
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html
> [1] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
> [2] https://patchwork.kernel.org/cover/10687023/
> 
> 
> Martin Blumenstingl (4):
>   dt-bindings: clock: meson8b: export the CPU post dividers
>   clk: meson: clk-regmap: add read-only gate ops
>   clk: meson: meson8b: rename cpu_div2/cpu_div3 to
>     cpu_in_div2/cpu_in_div3
>   clk: meson: meson8b: add the CPU clock post divider clocks
> 
>  drivers/clk/meson/clk-regmap.c           |   5 +
>  drivers/clk/meson/clk-regmap.h           |   1 +
>  drivers/clk/meson/meson8b.c              | 264 ++++++++++++++++++++++-
>  drivers/clk/meson/meson8b.h              |  17 +-
>  include/dt-bindings/clock/meson8b-clkc.h |   4 +
>  5 files changed, 278 insertions(+), 13 deletions(-)


Applied, with the bindings on next/headers

Neil
