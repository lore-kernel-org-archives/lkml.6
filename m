Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18954C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDC221479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0F84n8hO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDC221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeKUUVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:21:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52107 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:21:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so4808681wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gC6wILJYVXi+yqNV6Kwifg17K+ifVT3NHnkfndY9evI=;
        b=0F84n8hO5oAu2mkfkquqFChhi0xvguOwsfHm+imoSwZs58eFOSIFFMmOe8dzljA4sP
         ysvKnPhzgvozyyLXm1IfSxp3Ahzuao2hDSXpk6y0cL/SK6IRPTJ2PKTIItbm5gSJP33m
         iwhyi8sETN29L6FD7njzMdVCTv5rmOU8n34hJN3JoBOI7yzRRrEfFxKaaclP+3b9Qn9h
         FU+Dix5eVk8vc9BodX9NpcGnZ+WSbbrYedozb0u6NU+icv0EnWaYnQAmi5wi91X0vip5
         xw9eEngLGhdeowwrEYF2dwaNOwVnextyPhBoG1HTkM++uuF4cr2zw0eXLMbP8+3MNipp
         PiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gC6wILJYVXi+yqNV6Kwifg17K+ifVT3NHnkfndY9evI=;
        b=Bx0JK/wFQmFrGx4buVV7Z4aAdhDuuY0VPPcQf3bcAdlwsyTF++fEeZ8H03EGLl2u+x
         2m9JWszRgIuT77KLIk1isTUtMUcAcZLlajzjWUqoUJ6MYT0YN2eHLc+D344Y1FvvzOf3
         MYBPuDWelMrAzw0FfMeGrdYyFiTSnaweXsjKKB/Id1rhmoK+boeg/JloaBk3M7qcGLgD
         vwslz7oJ4eqIiI0XVWIjBBROqOm3fejoBMldUFXAT/GGzST8jnPUMNjufoD6kFwmQ+cj
         VC9PH1bQossu5wtIAFZ1SmlZYSiAWJlp66irch/HSv5LXF/xdJag3FuN5Gd+zJyMcuCn
         kAqg==
X-Gm-Message-State: AA+aEWbOgl03hbcKNUJU2YjcWxFOaw6215ZtaFLtiLnr8AtIPT694/Yr
        /F19PQGfCqrnv7pP/RK1DCwAsCSIUMH+hw==
X-Google-Smtp-Source: AFSGD/XeA0PhMGQ/N7lONFFop9BMGd6iQo6o7frsmPksbihgAdUAb6RptiOUqdj4Yr0qov+OgCIvng==
X-Received: by 2002:a1c:8b42:: with SMTP id n63mr4645961wmd.38.1542793632354;
        Wed, 21 Nov 2018 01:47:12 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 3-v6sm27309951wrs.44.2018.11.21.01.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:47:11 -0800 (PST)
Subject: Re: [PATCH] drm/meson: add support for 1080p25 mode
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1542793169-13008-1-git-send-email-christianshewitt@gmail.com>
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
Message-ID: <2a9d9fa9-c9ba-c624-28da-dd3804faf438@baylibre.com>
Date:   Wed, 21 Nov 2018 10:47:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542793169-13008-1-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 10:39, Christian Hewitt wrote:
> This essential mode for PAL users is missing, so add it.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  drivers/gpu/drm/meson/meson_venc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index acbbad3..ab16046 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -714,6 +714,7 @@ struct meson_hdmi_venc_vic_mode {
>  	{ 5, &meson_hdmi_encp_mode_1080i60 },
>  	{ 20, &meson_hdmi_encp_mode_1080i50 },
>  	{ 32, &meson_hdmi_encp_mode_1080p24 },
> +	{ 33, &meson_hdmi_encp_mode_1080p50 },
>  	{ 34, &meson_hdmi_encp_mode_1080p30 },
>  	{ 31, &meson_hdmi_encp_mode_1080p50 },
>  	{ 16, &meson_hdmi_encp_mode_1080p60 },
> 

Exact, I forgot this mode...

Thanks for the change !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I'll add :
Fixes: 335e3713afb87 ("drm/meson: Add support for HDMI venc modes and settings")
when applying to drm-misc-fixes.

Neil
