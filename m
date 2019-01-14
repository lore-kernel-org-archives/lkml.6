Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46793C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E702087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Hw28TAYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfANPyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:54:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52814 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfANPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:54:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so53179wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QKurbT1gY75I88YXQ2C719LrnWNnmRiSPGsbTxUqSNg=;
        b=Hw28TAYSVEEiaevE2TR54u+0XPzpd9+GlExkRtfXYSwdWskfd3wIE3QX1a7gAzWN1H
         zKrPLuLziWqRqqTWM5H6kRofHs9DN00NTIhwaxL9+tjJgkSc5Qmr2vGHTa5FYMeQGNTY
         0an4BtFAFCx2komKt0FdGenZanLetFTQUAYemM37KPdt29biHB3p/SPnWiVArsIW1Eew
         47CTh/JjYrGgktcJ7iAmDd5T0Z7VY8sszm5V9tDYShOrVrI2bwuGMlPmFphZBHmmmG6O
         hjIJfCK5Ybd9lWnbvOT2CeYpsDUVBqQLXYZRMMY1mPziBH9VV8JOEhKC2XFhogcL8oMN
         CXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QKurbT1gY75I88YXQ2C719LrnWNnmRiSPGsbTxUqSNg=;
        b=cEPybfPkJ6tzF0g7Jgus0iBdk2FMtPMA3SDvdFuYS0rUqj2T0B2DIfuAqjbj3Nghz9
         ZD4u+Rv3Xrb8Ri+MM/zqnuV5S/Lx7LKVA+WTEDI1CFiq8HjYfk1kbrQzK5FzQj97xGRX
         9ns+vGw8SBftcgV0PZaB5WvGRSNKpOnXbYIx2cc2rJKz1LQom+VIqn0+eJ2IhMN/Ib8+
         CpAoyfoy56f+y2Hi8x67fnrW8YsXJEBSJ46YqrYdwBNRwWAmxxRn1M4FeUH/bF4jmhoj
         Spq5gXeod/Jzd6wdV32QwF1HQBpO8C0e1OINy7HEcUj/WCFdxMD4cyP/7BYvyt4Q9l1T
         42qQ==
X-Gm-Message-State: AJcUukd/irmXfoiALMhA4qRe/IWL80tzjnW2TYWo0Lq1pJVyN26iGLeD
        CDCwrtxgejgT+aNlj1xaGwDoKCe8NiKGsQ==
X-Google-Smtp-Source: ALg8bN71McuF98POGZqCWfJrwX40hCzrPzM0spPUuAG9HK1CBLtYsmXnTqr3l1LjoljtxotLvybGVA==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr12997436wmb.145.1547481274406;
        Mon, 14 Jan 2019 07:54:34 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c15sm23705492wml.27.2019.01.14.07.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 07:54:33 -0800 (PST)
Subject: Re: [PATCH v3 3/7] drm: meson: Cleanup on drm_display_mode print str
To:     Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1547137815.git.shayenneluzmoura@gmail.com>
 <70da9f0c1a6dfa2bd2eb4e12fd3a6f53df05855b.1547137815.git.shayenneluzmoura@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <8946b525-8430-3b16-46f4-18eb74573c49@baylibre.com>
Date:   Mon, 14 Jan 2019 16:54:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <70da9f0c1a6dfa2bd2eb4e12fd3a6f53df05855b.1547137815.git.shayenneluzmoura@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shayenne,

On 10/01/2019 18:16, Shayenne Moura wrote:
> This patch adjust the print string of drm_display_mode object
> to remove drm_mode_object dependency in meson files.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Totally missed this one... please respect MAINTAINERS and CC the linux-amlogic ML otherwise I'll miss it again.

> ---
> Changes in v2:
>   - Use DRM_MODE_FMT/ARG macros (Daniel)
>   - Make the commit message more clear
> 
> Changes in v3:
>   - No changes
> 
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index d8c5cc34e22e..0b6c29cdd934 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -365,7 +365,7 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>  	unsigned int wr_clk =
>  		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
>  
> -	DRM_DEBUG_DRIVER("%d:\"%s\"\n", mode->base.id, mode->name);
> +	DRM_DEBUG_DRIVER("\"%s\"\n", mode->name);
>  
>  	/* Enable clocks */
>  	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
> @@ -555,12 +555,7 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>  	int vic = drm_match_cea_mode(mode);
>  	enum drm_mode_status status;
>  
> -	DRM_DEBUG_DRIVER("Modeline %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
> -		mode->base.id, mode->name, mode->vrefresh, mode->clock,
> -		mode->hdisplay, mode->hsync_start,
> -		mode->hsync_end, mode->htotal,
> -		mode->vdisplay, mode->vsync_start,
> -		mode->vsync_end, mode->vtotal, mode->type, mode->flags);
> +	DRM_DEBUG_DRIVER("Modeline " DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
>  
>  	/* Check against non-VIC supported modes */
>  	if (!vic) {
> @@ -650,8 +645,7 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
>  	struct meson_drm *priv = dw_hdmi->priv;
>  	int vic = drm_match_cea_mode(mode);
>  
> -	DRM_DEBUG_DRIVER("%d:\"%s\" vic %d\n",
> -			 mode->base.id, mode->name, vic);
> +	DRM_DEBUG_DRIVER("\"%s\" vic %d\n", mode->name, vic);
>  
>  	/* VENC + VENC-DVI Mode setup */
>  	meson_venc_hdmi_mode_set(priv, vic, mode);
> 

Anyway it's ok for me.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
