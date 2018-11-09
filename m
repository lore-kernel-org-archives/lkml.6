Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF20C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F00720827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="y33bnjIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F00720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeKITSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:18:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44226 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeKITSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:18:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id j17-v6so1134646wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IxoNC+llQzDj3MfnR6bVy9DSdGxL8htH3BCONzUjlEk=;
        b=y33bnjIErVQi2xvjYxKRz0E0QX5S8QM9l7jYDaEzWbNWjjTAtGA6JYxnXwqwRZ/ZCK
         CD56LtT1oCmLGoqN5DqPuiAo2NCW2w7x5rMFz8vlkPtgNLNA93YG2emL3NcWCO70/ezD
         82ejntONtJI5LQZXm6IvvO6q+QigRHwcpdkO5LTj4owonq/UXeN9y49S5G6ElFR9Gtf4
         sivLk+dLx4DjMQFZtv7eCyEiCO/H+eRCKC2hGOxM/Jg6AAmNEohONz0uLMpEbiW1ar7l
         Q6X/P7k3VNAdZ8Fl/a5Bf7Ii3ArbhrQFUZAPUQn+9aHBD8ek90r9PtzIxPkfLZEbR+Bj
         Z+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IxoNC+llQzDj3MfnR6bVy9DSdGxL8htH3BCONzUjlEk=;
        b=MCb8vcJgXxZOm9ezOFCyNE4VVIV0WH5EdFmUoJS/hLCnQ/YGOsH5CgNekfTU0mSjol
         oMtXr9BO1wPL5vsXnt9Mls32c/t/qnkKwDqymt8ksORPfPVXoGHnWUujmAUKtNRTNI5e
         qegL/TTpRgma4DKC81PCA1ooWRel9ukk73LkKCUR7FVr4SfM+l6tqZO3cpjdTbOoOZZ0
         pyvYzzkRLjjuQwatsjJPlyaObrtfgFw1DySg+nNIGS6Vmom+wjykBu1azLVetFVTXo5d
         baUk8Bs/C/8y6vGCNdzu3a/0+6R5uOSFEg66uXfW8XU3hjX6m6yEQEVVfu/QgwcVn9v6
         nWpA==
X-Gm-Message-State: AGRZ1gJDvusDIkPK3sjGfGejc3bMzd4cF8XKKXMMkqTnt3VFGVlijfcE
        aOgLHC82tGFRt84V2CeGH1rAyQ==
X-Google-Smtp-Source: AJdET5eSYNx3ZpkbuFCeS5eatARspQW7ZL9zQynMm3RIEQfHDOKCwqOlkpZmMOT+QnlYJeUp156GbA==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr7167571wrw.136.1541756329286;
        Fri, 09 Nov 2018 01:38:49 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i7-v6sm5119958wrs.55.2018.11.09.01.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 01:38:48 -0800 (PST)
Subject: Re: [PATCH 2/4] arm64: dts: meson-axg: correct sram shared mem
 unit-address
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181108135352.8459-1-jbrunet@baylibre.com>
 <20181108135352.8459-3-jbrunet@baylibre.com>
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
Message-ID: <b2cdbf04-522a-3170-09e9-6bc105f212cc@baylibre.com>
Date:   Fri, 9 Nov 2018 10:38:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108135352.8459-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 14:53, Jerome Brunet wrote:
> Correct the unit-address in the node name of the SRAM shared memory
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index ff8b3406aff6..b8893675e39c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1659,12 +1659,12 @@
>  			#size-cells = <1>;
>  			ranges = <0 0x0 0xfffc0000 0x20000>;
>  
> -			cpu_scp_lpri: scp-shmem@0 {
> +			cpu_scp_lpri: scp-shmem@13000 {
>  				compatible = "amlogic,meson-axg-scp-shmem";
>  				reg = <0x13000 0x400>;
>  			};
>  
> -			cpu_scp_hpri: scp-shmem@200 {
> +			cpu_scp_hpri: scp-shmem@13400 {
>  				compatible = "amlogic,meson-axg-scp-shmem";
>  				reg = <0x13400 0x400>;
>  			};
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
