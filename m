Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3C0C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30D820866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sfUVZuFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30D820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394055AbeKVUyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:54:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42166 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390613AbeKVUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:54:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so8640680wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 02:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pSwTBihn04Dewman2rEm9moNWy0qXtRfIk4dG0T6jpo=;
        b=sfUVZuFeICGS/4m3FNzeUkm85cfXlg+VzcwlCzInhkb8tjoRY2QQsGoi+lkl2h4SVl
         F7f5KvsasOGN3zay1twYFd0vpbupnBgmD8o4RghXYx7v9QH1Y9qw+cRub+oVgMsxKg9B
         M8cmDDG51HKcVxjl5wrotX/QfbTckbbsozsFCeHpDt9QjNex18HAQNRINwbItgaFeb/+
         YyJMUAtX0RocriHWoSOCXM/YRW+j0lq/PFVwy+Kxj5nQ8t+kx1qBLYl9cM3EbuRVzehr
         b8GsW8tz8RRV/Njzx/yYHNWVBO2OzHGFwdF6TagBRdVP0h6vow4vk9ddvq6oM3m+OrdS
         68dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pSwTBihn04Dewman2rEm9moNWy0qXtRfIk4dG0T6jpo=;
        b=EPgEPB9RjKDXExEscOdL6xNX5qBWoKBHxHpKP/sEShxGvFeNcm0QTPc/1s49Z/SqRG
         zVVIg1VtUKakiGu6wuHyha9V01942Syq9bTrnSEUyG9B79e1GzYfPd3b8oSY+XuXAobd
         nKaPjKuVKmkYj8RtzmAKK50BIs70OQ4IvBerbtbXlSxUhjLLMy6xAxy6aJ0/UNjsPqYN
         38Jl0PfgO2DrxK/HoxLukMCOJ71qhZvgCF5ca2VWhpy4MImxPkPjfiw40ytAQClQT/O2
         2Cpvd3XrZC2Wgbwb5X4v5eea0vl+j9JG4IhZTWPjWI0OtQgla1Xsy0LGparPTxkMdfJr
         4ZDw==
X-Gm-Message-State: AA+aEWbbc+7pdHMkg+qnT8dNRTZlzxn133p6fvKwckR/K89Jcyd4115W
        aH9hRDlUG4Te4NbBZi6LNAND9n9B+mMHEQ==
X-Google-Smtp-Source: AFSGD/W+6ThNCftTV0cVayDrUvWEAPOpLyKNdWbFAYV9WHs3LJi6fRbBAsY/fYpJ87eIJcoS6K1xng==
X-Received: by 2002:adf:bc91:: with SMTP id g17-v6mr1347035wrh.250.1542881723294;
        Thu, 22 Nov 2018 02:15:23 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f192sm3382329wmd.12.2018.11.22.02.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 02:15:22 -0800 (PST)
Subject: Re: [PATCH] drm/meson: Fixes for drm_crtc_vblank_on/off support
To:     daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181121171525.6593-1-narmstrong@baylibre.com>
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
Message-ID: <f8cd32d4-6475-ae07-edf8-9f458279d0e0@baylibre.com>
Date:   Thu, 22 Nov 2018 11:15:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121171525.6593-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 18:15, Neil Armstrong wrote:
> Since Linux 4.17, calls to drm_crtc_vblank_on/off are mandatory, and we get
> a warning when ctrc is disabled :
> " driver forgot to call drm_crtc_vblank_off()"
> 
> But, the vsync IRQ was not totally disabled due the transient hardware
> state and specific interrupt line thus adding proper IRQ masking from
> the HHI system control registers.
> 
> Finally, due to changed in the atomic_disable code path with the updated
> fbdev emulation, checking the crct state with an atomic_disable call
> leads to warning in further atomic_begin() with a leftover event not cleared.
> 
> To Summarize :
> - Make sure that the CRTC code will call the enable/disable_vblank hooks.
> - *Really* mask the Vsync IRQ
> - Allways consume the state event in atomic_disable()
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c | 6 +++++-
>  drivers/gpu/drm/meson/meson_venc.c | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

[...]

Well it doesn't totally solve the issue....

Will resend a fixed version..

Neil
