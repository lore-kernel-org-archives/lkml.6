Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E314BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16652087A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TZjP8Lbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16652087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbeKNXUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:20:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44199 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbeKNXUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:20:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id j17-v6so17223456wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 05:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kW2sHIb2r1v13irH8L2s5x7FhoT+lK+NAEpqovLcQe8=;
        b=TZjP8LbvIH7vitf/qPiMU8ggQoiTeUqC+Jire4izXUyhsfQHq3r7GR/BhQ+GJP3gsU
         DeOTgHJugDxCfYPuoTffiYPDEuFQc1qOGbetdSw6tzR2ZU0MWY2C80Bn4OdHEmHCfgrj
         LJtfDKNu+ofkj027jHdeNXefrIG/nTqgY5mBbG75Lr7nrvG4dOSggk/9dFe8VyuUYe1t
         Mf3XlcvU7tR+/56YSqSUiXJo9eykgq5z807BY6Yv4Ce72M0wPDKCS7X/wacjny5Zzq2m
         QeuTdqZvrB8u+PLM78HsXEzyfdtbdw3McLGWCCf/dyrAXCuWQwHTJ277kxLiv0qV90YC
         raxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kW2sHIb2r1v13irH8L2s5x7FhoT+lK+NAEpqovLcQe8=;
        b=TnmNnEbx8fLbGgbgnCxz3eYp5pbTDWZr/JCxCfM92yj7IZDjAVI1tNSLivfcH0B9K2
         UfkdQvqqfsT47VvcAI5mHhzobSBHg5UPpr3ADVWad1eVqTuS5oInWlrqmN0v0RJggChg
         V6zNfDRwTEhkgpzfAykZIfxHE0ZsaYJC2b3UhhxetuPJTLLs0637ttTwsk70Q0GUkKag
         ud0ECfzSbFA9/MmaSEGzcW250UL6hbO3Au+RwnqskPlEciW7a3CPvq23BdX1CCxVkp1o
         0vAPHT3FakZtJnmglKNwh3HTJlZyCSx48kZkc2PnNO9YZOGd3AWGxny7ZRH7NwnPA1cr
         wFnQ==
X-Gm-Message-State: AGRZ1gJNFe1Dq0tmh+Yi9QU9Ghi3+T/bEvNSd9Rx8k/KeS7DoDV/D0HI
        VXJsxtsqn8KXMGb9qRBTOruEHodiq7U=
X-Google-Smtp-Source: AJdET5es3HyIzcslQgNPDh1B/73Ht0EBeojU+cxOftQ6yl/PydT0sqF6Hp02JvUpVHmemYbqIed47w==
X-Received: by 2002:a5d:4a11:: with SMTP id m17-v6mr1778869wrq.259.1542201435303;
        Wed, 14 Nov 2018 05:17:15 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k15sm8727994wru.8.2018.11.14.05.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 05:17:14 -0800 (PST)
Subject: Re: [PATCH v2 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181114131627.17766-1-narmstrong@baylibre.com>
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
Message-ID: <75ca31ca-82f4-c9e9-0d73-29fde405c47c@baylibre.com>
Date:   Wed, 14 Nov 2018 14:17:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114131627.17766-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2018 14:16, Neil Armstrong wrote:
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clocks frequencyies.
> The precision is determined by stepping into the divider until the counter
> overflows.
> The debugfs slows a pretty summary and each clock can be measured
> individually aswell.
> 
> Thsi patchset includes the dt-bindings, driver and the DT node added to the
> meson-gx dtsi.
> 
> Changes since v1 at [1]:
> - fixed clock names
> - added summary in debugfs and moved indivudual clocks into a subdirectory
> - added the GX table to the match data
> 
> Neil Armstrong (3):
>   dt-bindings: amlogic: Add Internal Clock Measurer bindings
>   soc: amlogic: Add Meson GX Clock Measure driver
>   ARM64: dts: meson-gx: Add Internal Clock Measurer node
> 
>  .../bindings/soc/amlogic/clk-measure.txt      |  15 +
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   5 +
>  drivers/soc/amlogic/Kconfig                   |   8 +
>  drivers/soc/amlogic/Makefile                  |   1 +
>  drivers/soc/amlogic/meson-gx-clk-measure.c    | 293 ++++++++++++++++++
>  5 files changed, 322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
> 

For example, the debugfs summary looks like :

# cat /sys/kernel/debug/meson-clk-msr/measure_summary
  clock                     rate    precision
---------------------------------------------
 ring_osc_out_ee_0             0    +/-3125Hz
 ring_osc_out_ee_1             0    +/-3125Hz
 ring_osc_out_ee_2             0    +/-3125Hz
 a53_ring_osc                  0    +/-3125Hz
 gp0_pll                       0    +/-3125Hz
 enci                   26998438    +/-3125Hz
 clk81                 166661458    +/-5208Hz
 encp                          0    +/-3125Hz
 encl                          0    +/-3125Hz
 vdac                   26998438    +/-3125Hz
 rgmii_tx                      0    +/-3125Hz
 pdm                           0    +/-3125Hz
 amclk                         0    +/-3125Hz
 fec_0                         0    +/-3125Hz
 fec_1                         0    +/-3125Hz
 fec_2                         0    +/-3125Hz
 sys_pll_div16                 0    +/-3125Hz
 sys_cpu_div16                 0    +/-3125Hz
 hdmitx_sys             24000000    +/-3125Hz
 rtc_osc_out               32813    +/-3125Hz
 i2s_in_src0                   0    +/-3125Hz
 eth_phy_ref                   0    +/-3125Hz
 hdmi_todig                    0    +/-3125Hz
 sc_int                        0    +/-3125Hz
 sar_adc                 1195313    +/-3125Hz
 mpll_test_out                 0    +/-3125Hz
 vdec                          0    +/-3125Hz
 mali                          0    +/-3125Hz
 hdmi_tx_pixel                 0    +/-3125Hz
 i958                          0    +/-3125Hz
 vdin_meas            1484656250    +/-62500Hz
 pcm_sclk                      0    +/-3125Hz
 pcm_mclk                      0    +/-3125Hz
 eth_rx_or_rmii         50000000    +/-3125Hz
 mp0_out                       0    +/-3125Hz
 fclk_div5                     0    +/-3125Hz
 pwm_b                  24000000    +/-3125Hz
 pwm_a                         0    +/-3125Hz
 vpu                   666625000    +/-20833Hz
 ddr_dpll_pt                   0    +/-3125Hz
 mp1_out                       0    +/-3125Hz
 mp2_out                       0    +/-3125Hz
 mp3_out                       0    +/-3125Hz
 nand_core              24000000    +/-3125Hz
 sd_emmc_b                     0    +/-3125Hz
 sd_emmc_a                     0    +/-3125Hz
 vid_pll_div_out      1484843750    +/-62500Hz
 cci                           0    +/-3125Hz
 wave420l_c                    0    +/-3125Hz
 wave420l_b                    0    +/-3125Hz
 hcodec                        0    +/-3125Hz
 alt_32k                       0    +/-3125Hz
 gpio_msr                      0    +/-3125Hz
 hevc                          0    +/-3125Hz
 vid_lock                      0    +/-3125Hz
 pwm_f                         0    +/-3125Hz
 pwm_e                         0    +/-3125Hz
 pwm_d                  23984375    +/-3125Hz
 pwm_c                         0    +/-3125Hz
 aoclkx2_int                   0    +/-3125Hz
 aoclk_int                     0    +/-3125Hz
 rng_ring_osc_0         66746875    +/-3125Hz
 rng_ring_osc_1         58442188    +/-3125Hz
 rng_ring_osc_2         52098438    +/-3125Hz
 rng_ring_osc_3         46662500    +/-3125Hz
 vapb                  249996094    +/-7812Hz
 ge2d                  249992188    +/-7812Hz

On the AML-S905X-CC board.

Neil
