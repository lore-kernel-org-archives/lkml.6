Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FDCC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C01E2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Mx0joKnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C01E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeLLJzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:55:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34682 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeLLJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:55:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so17027991wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 01:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yz4APOAv/5rPDI+5AhAgwhPWaSULeQZqxdonoNl29f4=;
        b=Mx0joKndQwtDwDEfAuHS2RtHTWDa7j6fKOMAM5OEdHU5ZmqBj21u+3f7yswkeIrjMe
         XvyXDSXNjeT/sqQ5EiOEESHllu9b+E9HZ4PD/AJB7JASnPcosDtgphh0nTdK+pxVyK1k
         HwRsI9RbNJmnSoHzRXduOA6BkQ6yEeh0FApdnHsPkz2Qm2n54L643pjDyOX5h/NHl664
         WptP43ACLPo4BFazlIBJCxDE4SpwQSoHmpf6zFlkL2fIoK+0wwSXbA9PIP4/3yYYv+9J
         XQrEQRvMRne60Cn8w2Gfc21st9ZQ4AOdTi4jLxsyTHaYDiFiis4ICNTjH/92d89S3HYX
         P8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yz4APOAv/5rPDI+5AhAgwhPWaSULeQZqxdonoNl29f4=;
        b=S/jRkEZW3yqDL0vXYuJ3YO286fuQc0f3ap7A6ET7I62PRzCXARisaAtL+9ze9MWuvn
         FfMazP5inf/k06GFNKZKMX+AgyeJZrIULitrjcM91V5lQ5aFBT/u9u175joptpqmcLoL
         m2UesamRwrg6ZE0+Qwm4tyBClK4UM1dWC4XlWsiIQx+TSD61Ay8JQkimEvEREFALeX11
         K96K/zQQN0vw4EkdKwjtrafYn/rccNzQPQKiiwvGhKqUjpJtv1ioRGRbB+Mo6nNqcyk2
         uQy1YwUsP1ZRVEDg17WsfBQrB1yaqmLLQoup8n99gK8jkqPgf/e0LpU3weNWBfXBv5NJ
         EB7w==
X-Gm-Message-State: AA+aEWZNxZox9sHnUR2bOKRa5Dxry1cnSWKZ7W1909HrP0n+ySTGdBBC
        PG9i625kjF+Gucnp5ddL/IhhGV29sGbDrQ==
X-Google-Smtp-Source: AFSGD/XEWHyYKdLFjz+oxQxXo0j3xPeuZ5eN+nnEDGi8J5+uEQU80CYw5w0bhRokd7YMhfM3dAlKDg==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr17191261wrc.168.1544608535035;
        Wed, 12 Dec 2018 01:55:35 -0800 (PST)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d4sm1718525wmb.25.2018.12.12.01.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 01:55:34 -0800 (PST)
Subject: Re: [PATCH RESEND] drm/meson: remove firmware framebuffers
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20181210092853.13050-1-mjourdan@baylibre.com>
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
Message-ID: <c5138091-d801-8b2a-85ab-d815f0508933@baylibre.com>
Date:   Wed, 12 Dec 2018 10:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210092853.13050-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 10/12/2018 10:28, Maxime Jourdan wrote:
> In case we are using simplefb or another conflicting framebuffer, make
> the call to drm_fb_helper_remove_conflicting_framebuffers()
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index d3443125e661..afbb3d707d15 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -159,6 +159,23 @@ static void meson_vpu_init(struct meson_drm *priv)
>  	writel_relaxed(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
>  }
>  
> +static void meson_remove_framebuffers(void)
> +{
> +	struct apertures_struct *ap;
> +
> +	ap = alloc_apertures(1);
> +	if (!ap)
> +		return;
> +
> +	/* The framebuffer can be located anywhere in RAM */
> +	ap->ranges[0].base = 0;
> +	ap->ranges[0].size = ~0;
> +
> +	drm_fb_helper_remove_conflicting_framebuffers(ap, "meson-drm-fb",
> +						      false);

I always wondered, where does the "meson-drm-fb" comes from ???

Neil

> +	kfree(ap);
> +}
> +
>  static int meson_drv_bind_master(struct device *dev, bool has_components)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -242,6 +259,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	if (ret)
>  		goto free_drm;
>  
> +	/* Remove early framebuffers (ie. simplefb) */
> +	meson_remove_framebuffers();
> +
>  	drm_mode_config_init(drm);
>  	drm->mode_config.max_width = 3840;
>  	drm->mode_config.max_height = 2160;
> 

