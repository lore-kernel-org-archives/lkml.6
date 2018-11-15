Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A472CC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6737322419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hs1v/Ugh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6737322419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbeKOUP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:15:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34249 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbeKOUP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:15:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so20531160wre.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 02:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0vJXw3AR7uSkc4dSVfIaJ52+gBP1m47qSMMVoeMH/Eo=;
        b=hs1v/UghD81Y+0F72bNx27pFMxX8ga3DEMdYHdZmlrDUVPu4Vi+R6++So39y6ulNBw
         hdEVpIHxWBrRL70nxkKBj8XiteZFnCV2vf0u5hVuglqGOW+Ro6uHaWUg8ujF7B8PIxzi
         27l57VPVubIfawGKPWpxBNkm99rVhWL79CRjAKrUsvG6ozVYhbW2SNreIaHWDGrU3nFZ
         vv6zT7fMeiw4IhUpyQNrlq4109WZfzvkZTDt4qlcAKHbO6AL/eXSboC3FIWLTSZ0FUfP
         Mo+zAWktBWWD0JcdUUsekGbmfC3YTnxo8njsfWpY1pKUwVmD4hW7LewWv+CtgtMdTfwr
         3ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0vJXw3AR7uSkc4dSVfIaJ52+gBP1m47qSMMVoeMH/Eo=;
        b=UOne3Af5sXp6kp6Ms39mf5y8AiGixRMtEgyYS/WrygwGbMujH8OUCVnnidPvFygLto
         QnsWJGDY45oJ1jOQnw6pmNcNGVK3Haw1XIqfiMzsJ26CFquTvSuI+ytKA9KhlBHR++PE
         Cl4XcLw3RXG5Z1d52S5AwWonn4QcrA28xf3K/K/tj1BesiH8ulYrpdPPfzmKh9W+TMD5
         1dK1qP4rQbZ/9slLUqern9Sz7fNpYv7nmHLJ2f2vr+vZu3/CTuYYENZnYq8BWkAdBKcD
         RCAUG/qs9+TUxAC3yd8zaho0S5Vrh+OTm2DQ02Q44kkteqOYHCraHXstxppHJDaBfDdH
         zGxA==
X-Gm-Message-State: AGRZ1gKBaPbbaOG697JO60q5h1gHD/XAPKdDqmfCpyEnKTe5kNr2ES0Q
        rz+jj2M9htzPoIFekm/p6QcpXQ==
X-Google-Smtp-Source: AJdET5fTcFMN8QJoPZndDVEzYaD8Y7dWPsFIZSuHgcoDKMfLJB/iYrnWOBvGvYUcIAIBfCTJyEr9SQ==
X-Received: by 2002:adf:c550:: with SMTP id s16-v6mr5221236wrf.264.1542276524710;
        Thu, 15 Nov 2018 02:08:44 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v16-v6sm5682943wrv.90.2018.11.15.02.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 02:08:44 -0800 (PST)
Subject: Re: [RFC v1 0/7] Meson8b: make the CPU clock mutable
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
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
Message-ID: <ae3ede9e-ecc7-ad47-bd2c-9b760480ad85@baylibre.com>
Date:   Thu, 15 Nov 2018 11:08:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 14/11/2018 23:57, Martin Blumenstingl wrote:
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
> Martin Blumenstingl (7):
>   clk: meson: meson8b: run from the XTAL when changing the CPU frequency
>   clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel
>   clk: meson: clk-pll: check if the clock is already enabled
>   clk: meson: clk-pll: add the is_enabled function in the clk_ops
>   clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
>   clk: meson: meson8b: add support for more M/N values in sys_pll
>   clk: meson: meson8b: allow changing the CPU clock tree
> 
>  drivers/clk/meson/clk-pll.c | 23 +++++++++
>  drivers/clk/meson/meson8b.c | 94 +++++++++++++++++++++++++++++++++----
>  2 files changed, 108 insertions(+), 9 deletions(-)
> 

I suppose it depends on the fixes you sent earlier ?

Anyway, resend it without RFC and by squashing patch 4 in 3 and
address the small comment issue and I'll take it for 4.21 !

Thanks,
Neil
