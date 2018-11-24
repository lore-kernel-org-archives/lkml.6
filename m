Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5636CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAB020874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAB020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeKYDzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 22:55:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43539 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeKYDzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 22:55:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id i7so13369437qtj.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 09:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=N3raQaF6xXsQvQ86LfVzkhpyFuWHEewrJKnybrBoaAA=;
        b=RPQiuArR8MApKtVe962UaON5ZeotdKgSqDm06OAUXlrYRQPxNfQ0KQ2h7uBFj7DQCQ
         V6ZFn2MusImXn3o+qGLE2CfaudmxmRGEQNN7DxlL7OJrW8iSViSwHwY/R9oStvsmfvQj
         5t2ZRo6qgrM7j/ZYMHS2PkCYls4cYIsU4z+EQ9/thxVZCCXGZJX7gXbIqQtcYt4JPQGb
         WRRV4NMlX8xDePMap+sYAeAnkPWJpzfBgTrAnG/J9Ud1Jp4R78WAIUiAKOAl3Wy0DWT5
         SJMZcUEmYEubJYE2eTbbR1CEsXUBpFmbFMgBQaPOb4VKLMyGKjyeg4VZkRvNuPRBwzFQ
         oQDQ==
X-Gm-Message-State: AGRZ1gKadISPCS7YgBMmxisT9kIo4Zggo2g1Z3ZRMgi/NcU/yECpAI9D
        42YphfylZDdnE1B+CvQtxKud5A==
X-Google-Smtp-Source: AJdET5cYf7TCH9QWAOAwF0SigRHD8ZzOQRc6xuRTw71wqHJZPqW6n7bGzc1jGA6bcCjZGWCOF40wkQ==
X-Received: by 2002:ac8:2fdc:: with SMTP id m28mr20200477qta.202.1543079188961;
        Sat, 24 Nov 2018 09:06:28 -0800 (PST)
Received: from whitewolf.lyude.net (pool-108-26-148-220.bstnma.fios.verizon.net. [108.26.148.220])
        by smtp.gmail.com with ESMTPSA id d32sm29109097qte.36.2018.11.24.09.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 09:06:28 -0800 (PST)
Message-ID: <75e9fc92d43fc8ddbb787763581d1d7b9b7ed980.camel@redhat.com>
Subject: Re: [PATCH v2] drm/meson: Fixes for drm_crtc_vblank_on/off support
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Neil Armstrong <narmstrong@baylibre.com>, daniel@ffwll.ch
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Sat, 24 Nov 2018 12:06:27 -0500
In-Reply-To: <20181122160103.10993-1-narmstrong@baylibre.com>
References: <20181122160103.10993-1-narmstrong@baylibre.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some typos according to dim checkpatch:

  6421619a1655 (HEAD) drm/meson: Fixes for drm_crtc_vblank_on/off support
  -:48: WARNING:TYPO_SPELLING: 'occurence' may be misspelled - perhaps
  'occurrence'?
  #48:
  The issue is that vblank need to be enabled in any occurence of :

  -:53: WARNING:TYPO_SPELLING: 'occurence' may be misspelled - perhaps
  'occurrence'?
  #53:
  of these occurence solves this race condition and makes sure vblank

  -:60: WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description
  (prefer a maximum 75 chars per line)
  #60:
  - Initialize and enable vblank at the first _atomic_begin()/_atomic_enable()

  total: 0 errors, 3 warnings, 0 checks, 82 lines checked

But I don't mind correcting those myself. Other then that, looks good

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in just a moment with the typo fixes/cc to
stable

On Thu, 2018-11-22 at 17:01 +0100, Neil Armstrong wrote:
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
> WARNING: CPU: 0 PID: 1185 at drivers/gpu/drm/meson/meson_crtc.c:157
> meson_crtc_atomic_begin+0x78/0x80
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
> WARNING: CPU: 0 PID: 1185 at drivers/gpu/drm/drm_vblank.c:1026
> drm_vblank_put+0xb4/0xc8
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
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c | 27 +++++++++++++++++++++++++--
>  drivers/gpu/drm/meson/meson_venc.c |  3 +++
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c
> b/drivers/gpu/drm/meson/meson_crtc.c
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
> @@ -106,6 +106,22 @@ static void meson_crtc_atomic_enable(struct drm_crtc
> *crtc,
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
> @@ -117,6 +133,8 @@ static void meson_crtc_atomic_disable(struct drm_crtc
> *crtc,
>
>  	DRM_DEBUG_DRIVER("\n");
>
> +	drm_crtc_vblank_off(crtc);
> +
>  	priv->viu.osd1_enabled = false;
>  	priv->viu.osd1_commit = false;
>
> @@ -135,6 +153,8 @@ static void meson_crtc_atomic_disable(struct drm_crtc
> *crtc,
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
> diff --git a/drivers/gpu/drm/meson/meson_venc.c
> b/drivers/gpu/drm/meson/meson_venc.c
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
> @@ -1663,10 +1664,12 @@ unsigned int meson_venci_get_field(struct meson_drm
> *priv)
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

