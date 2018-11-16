Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D18C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E93E208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tGw/rRPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E93E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389379AbeKPTAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:00:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41284 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeKPTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:00:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id v18-v6so23980517wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 00:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QdrWVf6FcxdcftgCc422+j0b5Of9lkH7Efo3onWpM8A=;
        b=tGw/rRPG9BTngGd2DZE3aU6o9MjREJhqc6CPC5+4eJ6Nqb+InyBmx+zQZbvDgLDNvJ
         VdMUP0OIpU/dttpXd3EsxGFlV3gf3Oma/+i4OPGIGwNY5l+fSC1sQcylxvqAYbvW3v4x
         AVQ0woU2lQWsRGSx5Wi8aL+NL4blBpbUzJOn+jvBftKWFWQZZRNBJcyKdQdV2zHIUiU9
         +17BIEDHLwSIz2YnUgrxK5xFT/8LoMxxsCVd8rRSZHKPU1dKthvcNPox/WDyhBemIuz6
         cZqW/KjvgVRIaiKaz8cMMWJZUoJLvocqnG2uBpaAT/YHSpq0AsYdVTMQpt2+Dgv7D8Iy
         m7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QdrWVf6FcxdcftgCc422+j0b5Of9lkH7Efo3onWpM8A=;
        b=luQKw658Xf21JymUzodQxqWL4gar/hTZXYq2FcHQDsSuEI8xdWhcOf9vgVOBcIUHo9
         JGCUqkpKJ2nZyUyVe3fSV6XchhoVfCo+M2uORIpKedk4/ZySPb5DY82R9+jKMx/og6zu
         PiqNzBtq/4uSKke/RUQYdysGwkbU6bIcsfxoVOEwHdM1HQfmMu3kNiRzszg5VTxpEnGe
         SN2nvab4pr0zl+yKF46HtzC7i6HNWylOj2cMf+hsKr1nCKzSCOcA7H4xx9HIYfc3yX1A
         JUH38voC8+62P5FLn2XRMDn6+wIQWE9tTAFQ6OHV+mXMiIIjmJdVNdzqQheKYuOO1s+O
         f6bw==
X-Gm-Message-State: AGRZ1gIKWTC4uKiIFGJH2k2RhxhCMbbVdOmGPoj2lvXbHWvQPQcMcw0m
        2Xd8A49Lu8pZSH2O9cmoxceWFQ==
X-Google-Smtp-Source: AJdET5e6ruidOm9tbmGltFQGJmF4YmbITV8R2KevNlRphZkIVCN8EwvuNsKEv214ETsyQgJoslARsQ==
X-Received: by 2002:a5d:6050:: with SMTP id j16-v6mr8624370wrt.301.1542358159331;
        Fri, 16 Nov 2018 00:49:19 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j199sm2239524wmf.13.2018.11.16.00.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:49:18 -0800 (PST)
Subject: Re: [PATCH v2 0/6] Meson8b: make the CPU clock mutable
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
References: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
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
Message-ID: <a942be34-9a17-13b1-5ceb-19777bebe335@baylibre.com>
Date:   Fri, 16 Nov 2018 09:49:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2018 23:40, Martin Blumenstingl wrote:
> This allows changing the CPU clock on the 32-bit Amlogic Meson SoCs
> (Meson8, Meson8b and Meson8m2).
> CPU frequency scaling will be enabled with a separate series by adding
> the CPU clock and the OPP tables to meson8.dtsi and meson8b.dtsi.
> 
> While changing the CPU frequency (sys_pll or any of it's post-dividers)
> we need to run the CPU clock off the XTAL clock. Otherwise the system
> will lock up because we need to disable the sys_pll to change it's
> rate.
> 
> This also makes the clk-pll's .enable hook a no-op if the clock is
> already enabled. Otherwise we're getting lockups when calling the
> first clk_{prepare_}enable on the sys_pll or any of it's children (as
> the CCF propagates the enable event up to the sys_pll). This is because
> the .enable hook unconditionally disables and enables the clock.
> However, we can't disable that clock (not even temporarily) if the CPU
> is running off sys_pll.
> 
> Additionally this adds support for more M/N combinations in sys_pll to
> achieve all of the OPPs on Meson8b and all OPPs <= 1608 MHz on Meson8
> and Meson8m2.
> 
> Compared to Amlogic's 3.10 kernel there's one notable difference: we
> are actually allowing changes to the sys_pll. Amlogic's kernel sets
> sys_pll to a fixed rate during boot and then uses a timer generate a
> "virtual clock rate" by toggling between various dividers (for example:
> sys_pll is set to 1536MHz. to achieve 1008MHz they are toggling every
> 2500us between 1536MHZ and 768MHz so the average over <period, for
> example one second> is 1008MHz).
> I could reproduce any situation where changing sys_pll failed (for
> example due to high temperature). To prove that I ran "stress --cpu 4"
> for multiple hours and then cycled through all available CPU
> frequencies (while keeping "stress" running in the background). This
> worked fine on my Meson8b Odroid-C1 and EC-100 boards as well as my
> Meson8m2 board.
> 
> 
> Dependencies:
> This series is built on top of the latest clk-meson.git tree and the
> patches from my other series [1] "Meson8b: fixes for the cpu_scale_div
> clock".
> 
> 
> Changes since v1 at [0]:
> - re-ordered patches as suggested by Jerome: keep all fixes first, then
>   the new "features"
> - squashed patches "clk-pll: check if the clock is already enabled" and
>   "clk-pll: add the is_enabled function in the clk_ops". This also
>   allows calling clk_hw_is_enabled() from meson_clk_pll_enable()
>   instead of calling meson_clk_pll_is_enabled() directly (this matches
>   the implementation of sclk-div.c)
> - documented the dependencies of this series in the cover-letter
> - dropped "RFC" prefix
> - collected Jerome's Acked-/Reviewed-by's (thanks for the quick
>   response!)
> 
> 
> [0] https://patchwork.kernel.org/cover/10683317/
> [1] https://patchwork.kernel.org/cover/10617617/
> 
> 
> Martin Blumenstingl (6):
>   clk: meson: clk-pll: check if the clock is already enabled
>   clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel
>   clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
>   clk: meson: meson8b: add support for more M/N values in sys_pll
>   clk: meson: meson8b: run from the XTAL when changing the CPU frequency
>   clk: meson: meson8b: allow changing the CPU clock tree
> 
>  drivers/clk/meson/clk-pll.c | 19 ++++++++
>  drivers/clk/meson/meson8b.c | 94 +++++++++++++++++++++++++++++++++----
>  2 files changed, 104 insertions(+), 9 deletions(-)
> 

Applied to next/drivers !

Thanks for your work on meson8* SoCs !

Neil
