Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE71EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AAC20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LStFrTqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AAC20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeK0CGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:06:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35027 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0CGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:06:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so19331894wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/lmotuRIFMmx6O3HvSMOtxNghIq8hqR9LwoR2FFPanI=;
        b=LStFrTqGoiRm2pxkJiqKyjRBNEhCmUBiwj4OFlk8IqrhM4LP210d6sLZqmP3wmotht
         uyKmcknXVDiNm6r9iBn7u6sKZjx1kN06aXSFaen5jHb4P6LF86T/1eQ5YJ0PEnS6r30I
         RJvXRkFCcU+WdX8mSWi5k3K0uVG24taN8yMAUvenCxeGV52vb+72XNYlOlGRMGr7QLKb
         BzOgEcQ6yUSw0djj8/pO6aUY/4PFHvVSLTcqIMqDl/Kg3V/fLEDu6L31yU5afaCO31qZ
         SvQzVvYTrIcQ3H93xz9Oo3wW2eLp1sHtRsooTj64JQTACrNaHvccsghQ07rmMr+nTKH2
         87CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/lmotuRIFMmx6O3HvSMOtxNghIq8hqR9LwoR2FFPanI=;
        b=LrN2eXBNrAiJk9HvcWXaEEFXRlGaKgS6QkDyS/qFwHnrwKjkgcyQ7XVVlIB66yPtZ7
         cufXvQioZtHiidc+luqwFyTvOPpVzQ9iwGRQhALdwxpN066naHBd2WccUuWar/opZ2Vf
         HGShuDVq3ZctqFhItVs9VynMKiyg58aqW9dZHtTanSe0M3T+0AHNa7SNsN8j7VSIuYMB
         B0UOydiCBtdZKzjlefYtywtXrzAiLTiJpy7vQbWRRVIGtxX1EySPKsFuPaSV+PM+MVfT
         YabjDZAfehr0ygws1Do/Zdpp+dfelVqXQdrgowhV/9xAydWNYW0C9QXOAxV+FlUguLvq
         B4vQ==
X-Gm-Message-State: AA+aEWZgCg76wsJu+TahLk6iR1SbVaSQvJn28xo5Udv01mAqx583XIzy
        pYraVqbFNADstlT1SR9V9JGLvYsC2yHhyA==
X-Google-Smtp-Source: AFSGD/XE1MR6MlPAFOuNXXKuFy+Wm3unHDzd1YykaVAJ4kplS7Iv+FBao+DfkZ3akPexQ+U0kMkvzQ==
X-Received: by 2002:adf:e608:: with SMTP id p8mr24108991wrm.166.1543245142101;
        Mon, 26 Nov 2018 07:12:22 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l15sm728975wrw.4.2018.11.26.07.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 07:12:21 -0800 (PST)
Subject: Re: [PATCH] drm/meson: Fix an Alpha Primary Plane bug on Meson
 GXL/GXM SoCs
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181123105417.18948-1-narmstrong@baylibre.com>
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
Message-ID: <7ab852a3-91a5-b84c-04b4-d2ea0ef653b8@baylibre.com>
Date:   Mon, 26 Nov 2018 16:12:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123105417.18948-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 23/11/2018 11:54, Neil Armstrong wrote:
> On the Amlogic GXL & GXM SoCs, a bug occurs on the OSD1 primaty plane when
> alpha is used where the alpha is not aligned with the pixel content.
> 
> The woraround Amlogic implemented is to reset the OSD1 plane hardware
> block each time the plane is updated, solving the issue.
> 
> In the reset, we still need to save the content of 2 registers which
> depends on the status of the plane, in addition to reload the scaler
> conversion matrix at the same time.

This patch needs much more work, it creates some screen flickering and shaking
in 4k modes, which is not really good.

Neil

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c |  6 ++++++
>  drivers/gpu/drm/meson/meson_viu.c  | 27 +++++++++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_viu.h  |  1 +
>  3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
> index 75d97f1b2e8f..2f9dfb1d408f 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -200,6 +200,12 @@ void meson_crtc_irq(struct meson_drm *priv)
>  
>  	/* Update the OSD registers */
>  	if (priv->viu.osd1_enabled && priv->viu.osd1_commit) {
> +
> +		/* Reset OSD1 at updates on GXL+ SoCs */
> +		if (meson_vpu_is_compatible(priv, "amlogic,meson-gxm-vpu") ||
> +		    meson_vpu_is_compatible(priv, "amlogic,meson-gxl-vpu"))
> +			meson_viu_reset(priv);
> +
>  		writel_relaxed(priv->viu.osd1_ctrl_stat,
>  				priv->io_base + _REG(VIU_OSD1_CTRL_STAT));
>  		writel_relaxed(priv->viu.osd1_blk0_cfg[0],
> diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
> index 2dffb987ec65..a41dd6cc343e 100644
> --- a/drivers/gpu/drm/meson/meson_viu.c
> +++ b/drivers/gpu/drm/meson/meson_viu.c
> @@ -296,6 +296,33 @@ static void meson_viu_load_matrix(struct meson_drm *priv)
>  				 true);
>  }
>  
> +/* VIU OSD1 Reset as workaround for GXL+ Alpha OSD Bug */
> +void meson_viu_reset(struct meson_drm *priv)
> +{
> +	uint32_t osd1_fifo_ctrl_stat, osd1_ctrl_stat2;
> +
> +	/* Save these 2 registers state */
> +	osd1_fifo_ctrl_stat = readl_relaxed(
> +				priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
> +	osd1_ctrl_stat2 = readl_relaxed(
> +				priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
> +
> +	/* Reset OSD1 */
> +	writel_bits_relaxed(BIT(0), BIT(0),
> +			    priv->io_base + _REG(VIU_SW_RESET));
> +	writel_bits_relaxed(BIT(0), 0,
> +			    priv->io_base + _REG(VIU_SW_RESET));
> +
> +	/* Rewrite these registers state lost in the reset */
> +	writel_relaxed(osd1_fifo_ctrl_stat,
> +		       priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
> +	writel_relaxed(osd1_ctrl_stat2,
> +		       priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
> +
> +	/* Reload the conversion matrix */
> +	meson_viu_load_matrix(priv);
> +}
> +
>  void meson_viu_init(struct meson_drm *priv)
>  {
>  	uint32_t reg;
> diff --git a/drivers/gpu/drm/meson/meson_viu.h b/drivers/gpu/drm/meson/meson_viu.h
> index 073b1910bd1b..e4a6e2fba8fb 100644
> --- a/drivers/gpu/drm/meson/meson_viu.h
> +++ b/drivers/gpu/drm/meson/meson_viu.h
> @@ -59,6 +59,7 @@
>  #define OSD_REPLACE_EN		BIT(14)
>  #define OSD_REPLACE_SHIFT	6
>  
> +void meson_viu_reset(struct meson_drm *priv);
>  void meson_viu_init(struct meson_drm *priv);
>  
>  #endif /* __MESON_VIU_H */
> 

