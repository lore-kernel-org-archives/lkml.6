Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD842245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MM6Z2C5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD842245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbeKMScK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:32:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50994 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbeKMScJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:32:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id 124-v6so11036252wmw.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9/mv9m00FRVRwLhbfDsr8tIKnH2PvEBmJ5S5xo4mrYI=;
        b=MM6Z2C5L706429h+9nAUp4v9h0bkD38uJqAkUVTDqljpEn3NKjL2MRsRr/2lj2xeMi
         h2o/q7PSolpqGGxUz8xG7IGt3mZbRy0p/mTAtmdHLp12m5OMDiDCr3+4DPKzyQMMdFiv
         GEdAsf4xq5Ky2Joe/YmE33r+NKJ8gunFVEmXqiM+ix4cl3nupviXgbDsSb4stnXqoxKj
         SPj92OR1wiwLZ76fDCS0U8YDEnoagSfLCylAg4ngDLNqdVx4CtLqRdYvkoZmJwyl9Ui6
         tymq9mbxYJ6y1OhsDv99G2Sb7KqU1vgyoMW4Ouei0VVXxBLCuSjkLbFZL5XvuLRpnujB
         ESiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9/mv9m00FRVRwLhbfDsr8tIKnH2PvEBmJ5S5xo4mrYI=;
        b=Dre0n0ldc3as4EHQYDekF2jyBQUc7s1QkLck6GVBGR34WuL60F6mf9ZAU1Li+2FL0+
         fPaFKQxLVscCZCE7LVC/RcJ/iUz0amdF2ZpED7+Q6U3YuqCz2lfO+Z90YjmIKgDS3HUR
         roOgrKR1uIc0wI5Dd8GWo1iMKdNtFAmvb2vi1KBlGlS06Vs0X0lsmDuYM95qZJH0ruNr
         Dz4hTXne/k78pDEaFeAlM4Ese7gbxD3Atufn0Ra7JFSJx6+Kgo/gewPa4Df77Sqt7HfD
         BFQ3vyzATM5IZxuSue8xKC3L/5obcP1ddu7oisquJ+CyBxtvPyDZktyk5A8LE4Pv1Fum
         DamA==
X-Gm-Message-State: AGRZ1gJpQCcuxwnZTwIAy3GOrWcRWCkYdTWGW1CD2inOIYx4+KBfnSn2
        wTKUIMpeYjlsBHQTOh1sqNrMY69uzFA=
X-Google-Smtp-Source: AJdET5d62ZhQYRPqK1teCVlr6OZlreSn5bkugmKggtfi+RFVDiI/j1tAgRxpUByGPmjNpfIb/6KeDQ==
X-Received: by 2002:a7b:c052:: with SMTP id u18-v6mr2352293wmc.29.1542098105537;
        Tue, 13 Nov 2018 00:35:05 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d18-v6sm4180248wre.25.2018.11.13.00.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 00:35:05 -0800 (PST)
Subject: Re: [PATCH] drm/meson: venc: dmt mode must use encp
To:     Jorge Ramirez-Ortiz <jramirez@baylibre.com>, airlied@linux.ie,
        carlo@caione.org, khilman@baylibre.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1542048069-22603-1-git-send-email-jramirez@baylibre.com>
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
Message-ID: <9f20e9d1-2e15-c087-db52-674300d7581d@baylibre.com>
Date:   Tue, 13 Nov 2018 09:35:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542048069-22603-1-git-send-email-jramirez@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 19:41, Jorge Ramirez-Ortiz wrote:
> From: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> 
> The video mode for DMT is only populated to support encp.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> ---
>  drivers/gpu/drm/meson/meson_venc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 514245e..acbbad3 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -854,6 +854,13 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
>  	unsigned int sof_lines;
>  	unsigned int vsync_lines;
>  
> +	/* Use VENCI for 480i and 576i and double HDMI pixels */
> +	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
> +		hdmi_repeat = true;
> +		use_enci = true;
> +		venc_hdmi_latency = 1;
> +	}
> +
>  	if (meson_venc_hdmi_supported_vic(vic)) {
>  		vmode = meson_venc_hdmi_get_vic_vmode(vic);
>  		if (!vmode) {
> @@ -865,13 +872,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
>  	} else {
>  		meson_venc_hdmi_get_dmt_vmode(mode, &vmode_dmt);
>  		vmode = &vmode_dmt;
> -	}
> -
> -	/* Use VENCI for 480i and 576i and double HDMI pixels */
> -	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
> -		hdmi_repeat = true;
> -		use_enci = true;
> -		venc_hdmi_latency = 1;
> +		use_enci = false;
>  	}
>  
>  	/* Repeat VENC pixels for 480/576i/p, 720p50/60 and 1080p50/60 */
> 

Thanks !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I'll apply to drm-misc-fixes !

Neil
