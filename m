Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeDPJvM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:51:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32979 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeDPJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:51:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180416095106euoutp02f884b1070da7873bd262fb4a77488612~l4cC7G5Fq1471114711euoutp02k
X-AuditID: cbfec7f5-b5fff700000028a9-e8-5ad47209bcc5
Subject: Re: [PATCH v6 29/30] drm/rockchip: Disallow PSR for the whole
 atomic commit
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        ykk@rock-chips.com, kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com,
        jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org, "Kristian H . Kristensen" <hoegsberg@chromium.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <ccd0d30a-e01e-fc56-5983-54ca7c1dbe24@samsung.com>
Date: Mon, 16 Apr 2018 11:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405095000.9756-30-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta2yTZRTH87z3LhZeCronhQytMwEMw0WSHUQJGkneD5oYPxhSE6W6lw1Z
        x2zZZDqhdu6KmziIrt0FYraONDM03QZd1ZW1QAe1LU1xbJCuA5bsRhXYjTq3ufaFuG+/c/7/
        k+d/TvJwpGKcUXIH8g+LunxNnopJoc5fiQe2ynQ31K+cmtkANYGrBBgrYzT4Lb0M3Jj5m4H2
        224ES3cnaWiq+xoe266RMDxqYaGi8y4BddETFMwN+Bk4O21iYWwoREFH4Dsavr83SUIwaGPh
        ustHgN94n4WqH1pYsN/rp2Hw0SwNYWcjA4+Gl0ioD/YQ8MulCAuOUxcJ6OnwUNA3+yMBEZsf
        Qf3JcQamyhYZiDubKagotRBQfvM5CBhOsrvThfbmdiRMWSdoocEQooRwbQ0hOCItSOg2R1ih
        odJEC3ZrFSNcmB2mhehxLyF0tBwTFswuSqjttCLhQn8zKUzZ095brU55PVvMO1Ak6rbt2peS
        aygrKuhKP+IMe1kDmk6rRhyH+e24rDOrGqVwCv4swqOeCJKKaYRLe1sZqZhCuNd0hahGsuTE
        xQezSVbwbQh/G39HMsUQLg+20glhLf8B/rXvGzohrOPHEbZdniQSBckP0njo97HkOMNvxgsd
        g0yC5fwuPB6wJacp/iUcNPqS/Cy/FxtH46zkWYOvmkaoBMv4t3B3W22yT/IbcWlXAylxKr41
        cvpJVI8MT7Tvkfht3PeHj5R4LZ7wdrISb8BL3U/9X+HBMSOVCIr5SoSj8xWMJOzEHm+ITlyM
        XA59zrlNar+B/dEKQjrkKjwQWyNFWIXrzv9ESm05rixXSO4XcNTf9SRBKm69PsOcQC+aVyxm
        XrGMecUy5v/fPYMoK0oVC/XaHFH/ar74RYZeo9UX5udkfHpIa0fLH8C36J1xoJ5/P3EjnkOq
        Z+QOf1itoDVF+mKtG2GOVK2TWzTLLXm2pvhLUXfoY11hnqh3o/UcpUqVf7TpqFrB52gOiwdF
        sUDUPVUJTqY0oJv1Je9qL98JV40OTC7c7jeVtJ3OS3++vnhjKGO3pXEp1Ni0+ejxDPWicu7P
        W8eUrPX9lzPb+rJcn+3v8sjuP8ZpWwt+m3+N46/ZC8/842JyspQ7dn6+/eHD6aZL+2Il8T3r
        FfNitvvBnHPoTsPeD1e/GcvdcSTTGPONlB50/OWq+blJRelzNZlbSJ1e8x9iKvjP/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxSH897P4tZ4LSjvcPGjdtGZrFoQOagjRhNzE/3DxDmV6fQGboBI
        qbu3EFlmbDCKVkERg21RnJFVVzF2LQ4oCWJnRIZt7WBoJUWiRlfxYwFEjHyMAkv47znnd56T
        902OglSN0QmKnDyjKOUJuWpmBtU22hL+SiF1pC8/P/AZlPhbCSg6+poGn/0WAx3v3jJQ0+VF
        MPakl4bzpw/AkPNPEnpe2Fkorn1CwOnHpyh4/9DHwJUBKwv/dAcpcPtP0HDyaS8JgYCThfs3
        2wjwFb1i4VhZNQuup500hPoGaWj3nGOgr2eMBEugiYBrt8Ms1J9pJqDJ/QcFdwcrCAg7fQgs
        5REG+g+PMvDBU0VB8SE7AUcezAG/qZxdq+FrqmoQ3+94SfOVpiDFt5eWEHx9uBrxDbYwy1ce
        tdK8y3GM4esGe2j+8fEWgndXH+RHbDcpvrTWgfi6ziqS73fN2zwzXbtGMuQbxQXZBtn4tfo7
        HSRqdamgTVyRqtUlpexalZisXpa2JlPMzSkQpWVpe7TZpsMF+25o9nvaW1gTGphnRjEKzK3A
        zf8OEmY0Q6HifkHYeifITgbxuPHCa3KSY/Fwp5mZHOpF+G3wEhENYrlvceWb4xNBHBdBuLXk
        JRstSC5E4y6Hc2rvPYQ7Ht6mowrDfYlH3CEmykouDUf8zok+xX2BA0VtEzyb2467A31TM7Nw
        q/UZFeUYbh1uuFw68T6SW4yHq/4iJ3k+PnSjcorj8aNnF4hTSGWbptumKbZpim2a8jOiHChO
        zJf1WXo5USsLejk/L0ubYdC70Pjx/X7nQ209Mr/Z4kWcAqk/Vdb72tNVtFAgF+q9CCtIdZzS
        Loy3lJlC4Y+iZNgt5eeKshclj3+ujEyYnWEYP+U8425dsi4FUnUpSSlJK0EdrwwsL0xXcVmC
        UdwrivtE6X+PUMQkmND6uthbmx5kLLHe1dTxV39ofCRtHnFtu/j50JCQE2kK/WSZ6wlUXOyz
        X47dYPWsjny82uAWKrrgTNkey/rmwPagrtiPrd8X2JceHN26kf17vyb1k7M73ucI15Fl5zfv
        nsOv8RH7nF0dvy3IfDW8clWtt7PcvKhR46/oXnhgr3+LNaSm5GxBt5SUZOE/Pewz+5IDAAA=
X-CMS-MailID: 20180416095104eucas1p1a4a4f1cbd39804702412b0dceff083a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416095104eucas1p1a4a4f1cbd39804702412b0dceff083a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180405095119epcas5p1964fcfc777686af4216a7ff6acd964ce
X-RootMTR: 20180405095119epcas5p1964fcfc777686af4216a7ff6acd964ce
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
        <CGME20180405095119epcas5p1964fcfc777686af4216a7ff6acd964ce@epcas5p1.samsung.com>
        <20180405095000.9756-30-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> Currently PSR flush is triggered from CRTC's .atomic_begin() callback,
> which is executed after modeset disables and enables and before plane
> updates are committed. Since PSR flush and re-enable can be triggered
> asynchronously by external sources (input event, delayed work), it can
> race with hardware programming done in the aforementioned stages.
>
> This patch blocks the PSR completely before hardware programming part
> begins and unblock after it ends. This relies on reference counted PSR
> disable introduced with previous patch.
>
> Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 61 ++++++++++++++++++++++++++++-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  7 ----
>  2 files changed, 60 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index e266539e04e5..d4f4118b482d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -167,8 +167,67 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
>  	return ERR_PTR(ret);
>  }
>  
> +static void
> +rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
> +{
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_encoder *encoder;
> +	u32 encoder_mask = 0;
> +	int i;
> +
> +	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> +		encoder_mask |= crtc_state->encoder_mask;
> +		encoder_mask |= crtc->state->encoder_mask;

Looks clever and cryptic. More readable would be with
for_each_oldnew_crtc_in_state.
Anyway:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

> +	}
> +
> +	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
> +		rockchip_drm_psr_inhibit_get(encoder);
> +}
> +
> +static void
> +rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
> +{
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_encoder *encoder;
> +	u32 encoder_mask = 0;
> +	int i;
> +
> +	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> +		encoder_mask |= crtc_state->encoder_mask;
> +		encoder_mask |= crtc->state->encoder_mask;
> +	}
> +
> +	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
> +		rockchip_drm_psr_inhibit_put(encoder);
> +}
> +
> +static void
> +rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
> +{
> +	struct drm_device *dev = old_state->dev;
> +
> +	rockchip_drm_psr_inhibit_get_state(old_state);
> +
> +	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> +
> +	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> +
> +	drm_atomic_helper_commit_planes(dev, old_state,
> +					DRM_PLANE_COMMIT_ACTIVE_ONLY);
> +
> +	rockchip_drm_psr_inhibit_put_state(old_state);
> +
> +	drm_atomic_helper_commit_hw_done(old_state);
> +
> +	drm_atomic_helper_wait_for_vblanks(dev, old_state);
> +
> +	drm_atomic_helper_cleanup_planes(dev, old_state);
> +}
> +
>  static const struct drm_mode_config_helper_funcs rockchip_mode_config_helpers = {
> -	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> +	.atomic_commit_tail = rockchip_atomic_helper_commit_tail_rpm,
>  };
>  
>  static const struct drm_mode_config_funcs rockchip_drm_mode_config_funcs = {
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 00f7f3441cf6..f14a10ca4792 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1029,16 +1029,9 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
>  	}
>  }
>  
> -static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
> -				  struct drm_crtc_state *old_crtc_state)
> -{
> -	rockchip_drm_psr_flush(crtc);
> -}
> -
>  static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
>  	.mode_fixup = vop_crtc_mode_fixup,
>  	.atomic_flush = vop_crtc_atomic_flush,
> -	.atomic_begin = vop_crtc_atomic_begin,
>  	.atomic_enable = vop_crtc_atomic_enable,
>  	.atomic_disable = vop_crtc_atomic_disable,
>  };
