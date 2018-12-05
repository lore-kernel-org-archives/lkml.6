Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72072C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC82214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sqdDIVdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC82214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeLEKD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:03:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeLEKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:03:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id u3so18973603wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 02:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:cc:references:to:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C5ATdGg9OACTKCk7R+0jVc4o/GFvoaV6MIXbML/nfCY=;
        b=sqdDIVdUCXzS/ku9ZHE+FzeDEjKSxBrlQKgox/0Hm6+RzjLD/MTscsmM91ygoSDlNb
         EJXYI6SGC3qfNZHnhm063nBMb32r2kKECppdleHi56tpg29tu3R0DWL7CfS3vkgGrxiI
         EtQJJf0V2wSBSzemj5dtiFi36LAdYgKeuQPT/TDheJD/rs6+Dt0vUAWK11j5Fk9jqACX
         AZ03R2UJ+qilhhKinb6Rn8qa0tApMTmQIyAkLN4nfX2c2PjSVNPBOZ+IUfak6l+qynwv
         mG8h64VwhaFIMKjIE7LCUVoj7tjtCafe1n8xsVLGTCVTwMO/TPsMgcQTUjgIR4xxDg4L
         rhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:to:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C5ATdGg9OACTKCk7R+0jVc4o/GFvoaV6MIXbML/nfCY=;
        b=UY5sgtaM6khcUWJhmRLlofSDtIed7rkJijL84AAD2mpATlWoNe47sH7BDZSs2r3y0z
         wfEhkWoDP0PGxG9UCK1WS8mwc7rX7jspI1hF0Usxl0vPiF1DX+nKtyJJs0VWespXn/W0
         brHpmUshPiSneoc++jDemdhbq7akGadlQkxsxpBTMT2Kkrw41ronjRdkGsDbFAVekw3L
         PjHXhgSPm3CMNlVm9DYth9eJ9iEqSCwU53TkIFAPaxnT+dlzPHwu8gK/VrWIUC6Kym0g
         tmHZUh4HLF3a34RkDU7kW4ltQFnvNvVTLB9pcIbweZWc/bS6+GIfq7FSRuH1DizoaNdJ
         sN6A==
X-Gm-Message-State: AA+aEWbjNGF+frDegJO9OMzPsyiy/sbCjuX+DjYGDTrq492qPRJqT4/C
        Ig+XbuqMY1MogaaOlJUirc0+BwoVmLCNaQ==
X-Google-Smtp-Source: AFSGD/XMVB8pnR479Pe1xR9zpEokLs2N9onHFLT5+JW6pSsVj/hK/hSNqWNzXebMl0hblCqSEMd8eg==
X-Received: by 2002:adf:81b6:: with SMTP id 51mr22789809wra.240.1544004232187;
        Wed, 05 Dec 2018 02:03:52 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:819f:4d34:9af9:e67? ([2a01:cb1d:4ce:ea00:819f:4d34:9af9:e67])
        by smtp.gmail.com with ESMTPSA id x14sm14761986wrm.65.2018.12.05.02.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 02:03:51 -0800 (PST)
Subject: Re: [PATCH v2] drm/meson: Fixes for drm_crtc_vblank_on/off support
Cc:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181122160103.10993-1-narmstrong@baylibre.com>
To:     stable@vger.kernel.org
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
Message-ID: <7f83b5e5-d300-a5e4-a63a-49170ccd4d80@baylibre.com>
Date:   Wed, 5 Dec 2018 11:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122160103.10993-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stable team,

On 22/11/2018 17:01, Neil Armstrong wrote:
> Since Linux 4.17, calls to drm_crtc_vblank_on/off are mandatory, and we get
> a warning when ctrc is disabled :
> " driver forgot to call drm_crtc_vblank_off()"
> 
> But, the vsync IRQ was not totally disabled due the transient hardware
> state and specific interrupt line, thus adding proper IRQ masking from
> the HHI system control registers.
> 
> The last change fixes a race condition introduced by calling the added
> drm_crtc_vblank_on/off when an HPD event occurs from the HDMI connector,
> triggering a WARN_ON() in the _atomic_begin() callback when the CRTC
> is disabled, thus also triggering a WARN_ON() in drm_vblank_put() :
> 
> WARNING: CPU: 0 PID: 1185 at drivers/gpu/drm/meson/meson_crtc.c:157 meson_crtc_atomic_begin+0x78/0x80
> [...]
> Call trace:
>   meson_crtc_atomic_begin+0x78/0x80
>   drm_atomic_helper_commit_planes+0x140/0x218
>   drm_atomic_helper_commit_tail+0x38/0x80
>   commit_tail+0x7c/0x80
>   drm_atomic_helper_commit+0xdc/0x150
>   drm_atomic_commit+0x54/0x60
>   restore_fbdev_mode_atomic+0x198/0x238
>   restore_fbdev_mode+0x6c/0x1c0
>   drm_fb_helper_restore_fbdev_mode_unlocked+0x7c/0xf0
>   drm_fb_helper_set_par+0x34/0x60
>   drm_fb_helper_hotplug_event.part.28+0xb8/0xc8
>   drm_fbdev_client_hotplug+0xa4/0xe0
>   drm_client_dev_hotplug+0x90/0xe0
>   drm_kms_helper_hotplug_event+0x3c/0x48
>   drm_helper_hpd_irq_event+0x134/0x168
>   dw_hdmi_top_thread_irq+0x3c/0x50
> [...]
> WARNING: CPU: 0 PID: 1185 at drivers/gpu/drm/drm_vblank.c:1026 drm_vblank_put+0xb4/0xc8
> [...]
>  Call trace:
>   drm_vblank_put+0xb4/0xc8
>   drm_crtc_vblank_put+0x24/0x30
>   drm_atomic_helper_wait_for_vblanks.part.9+0x130/0x2b8
>   drm_atomic_helper_commit_tail+0x68/0x80
> [...]
> 
> The issue is that vblank need to be enabled in any occurence of :
> - atomic_enable()
> - atomic_begin() and state->enable == true, which was not the case
> 
> Moving the CRTC enable code to a common function and calling in one
> of these occurence solves this race condition and makes sure vblank
> is enabled in each call to _atomic_begin() from the HPD event leading
> to drm_atomic_helper_commit_planes().
> 
> To Summarize :
> - Make sure that the CRTC code will call the drm_crtc_vblank_on()/off()
> - *Really* mask the Vsync IRQ
> - Initialize and enable vblank at the first _atomic_begin()/_atomic_enable()

This fix hit linux master as commit id 2bcd3ecab773f73211c45bb1430bb52ac641f271
Coult it be applied on the Linux 4.19 stable tree ?

Thanks,
Neil

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c | 27 +++++++++++++++++++++++++--
>  drivers/gpu/drm/meson/meson_venc.c |  3 +++
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
> index d78168f979db..75d97f1b2e8f 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -46,6 +46,7 @@ struct meson_crtc {
>  	struct drm_crtc base;
>  	struct drm_pending_vblank_event *event;
>  	struct meson_drm *priv;
> +	bool enabled;
>  };
>  #define to_meson_crtc(x) container_of(x, struct meson_crtc, base)
>  
> @@ -81,8 +82,7 @@ static const struct drm_crtc_funcs meson_crtc_funcs = {
>  
>  };
>  
> -static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
> -				     struct drm_crtc_state *old_state)
> +static void meson_crtc_enable(struct drm_crtc *crtc)
>  {
>  	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>  	struct drm_crtc_state *crtc_state = crtc->state;
> @@ -106,6 +106,22 @@ static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
>  	writel_bits_relaxed(VPP_POSTBLEND_ENABLE, VPP_POSTBLEND_ENABLE,
>  			    priv->io_base + _REG(VPP_MISC));
>  
> +	drm_crtc_vblank_on(crtc);
> +
> +	meson_crtc->enabled = true;
> +}
> +
> +static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *old_state)
> +{
> +	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
> +	struct meson_drm *priv = meson_crtc->priv;
> +
> +	DRM_DEBUG_DRIVER("\n");
> +
> +	if (!meson_crtc->enabled)
> +		meson_crtc_enable(crtc);
> +
>  	priv->viu.osd1_enabled = true;
>  }
>  
> @@ -117,6 +133,8 @@ static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
>  
>  	DRM_DEBUG_DRIVER("\n");
>  
> +	drm_crtc_vblank_off(crtc);
> +
>  	priv->viu.osd1_enabled = false;
>  	priv->viu.osd1_commit = false;
>  
> @@ -135,6 +153,8 @@ static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
>  
>  		crtc->state->event = NULL;
>  	}
> +
> +	meson_crtc->enabled = false;
>  }
>  
>  static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
> @@ -143,6 +163,9 @@ static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
>  	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>  	unsigned long flags;
>  
> +	if (crtc->state->enable && !meson_crtc->enabled)
> +		meson_crtc_enable(crtc);
> +
>  	if (crtc->state->event) {
>  		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
>  
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 9be0376e0329..ab72ddda242d 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -71,6 +71,7 @@
>   */
>  
>  /* HHI Registers */
> +#define HHI_GCLK_MPEG2		0x148 /* 0x52 offset in data sheet */
>  #define HHI_VDAC_CNTL0		0x2F4 /* 0xbd offset in data sheet */
>  #define HHI_VDAC_CNTL1		0x2F8 /* 0xbe offset in data sheet */
>  #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 offset in data sheet */
> @@ -1663,10 +1664,12 @@ unsigned int meson_venci_get_field(struct meson_drm *priv)
>  void meson_venc_enable_vsync(struct meson_drm *priv)
>  {
>  	writel_relaxed(2, priv->io_base + _REG(VENC_INTCTRL));
> +	regmap_update_bits(priv->hhi, HHI_GCLK_MPEG2, BIT(25), BIT(25));
>  }
>  
>  void meson_venc_disable_vsync(struct meson_drm *priv)
>  {
> +	regmap_update_bits(priv->hhi, HHI_GCLK_MPEG2, BIT(25), 0);
>  	writel_relaxed(0, priv->io_base + _REG(VENC_INTCTRL));
>  }
>  
> 

