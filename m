Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754466AbeDPJG7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:06:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33471 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754116AbeDPJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:06:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180416090653euoutp0150a2e4c7bda971a330d993be44dffa64~l31cC2x4k0138701387euoutp01v
X-AuditID: cbfec7f4-b4fc79c0000043e4-58-5ad467ac3df3
Subject: Re: [PATCH v6 26/30] drm/rockchip: psr: Avoid redundant calls to
 .set() callback
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
        hshi@chromium.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <c6a89199-a5e0-abad-3e53-3ef12da076b9@samsung.com>
Date: Mon, 16 Apr 2018 11:06:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405095000.9756-27-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxbZRjde7/brPOlTHnCjGadJGIUEGbyGnFRN7Mbf+2Pipi4XceVLUKH
        vWOKC7OpAh0wYGzqKBPJxiojmJUW+WgisOJWcZaOdE7QVCYj4xvNCow6AWkvi/w7z3nOyXNO
        8gi0/g4XLxw0HpZNRinHwGmZtqth/zPN2TcyU4JdT5AT/X0UsVhnWOKzX+bIjfm/ONL8uweR
        lZEplnxVXUgWHT/RpKR1hCLVw1UMuTfo40jjXA1Pxv8YYIirv5wllbenaOL3O3hyvfsaRXyW
        aZ4cP9nAE+ftmywZurvAkoD7LEfu3lqhyRl/F0W+/SHIk47TPRTpcvUy5MeFLygSdPgQOXNq
        giOhomWOhN11DCn51E6R4l8fIf3mU/xL28TmumYkhpomWbHWPMCIgYoTlNgRbEBipy3Ii7XW
        GlZ0Nh3nxPaFW6w4XOalRFfDJ+KSrZsRK1qbkNh+s44WQ87H9jyUqU3PknMOHpFNyTv2aQ+U
        BxLzrMkf3WuxM2ZUmVCKNALg7dA2V8aVIq2gx40IxjzVrDrMIag799naEEKwZL3PPbAsTttp
        dfENgp7pruhCj2cQDLbyERyL34Y7V2b5iGgznkDguDJFRQYan2dh5JcKNqLicCIsuYaibh3e
        AUWNnVE3gxPgsqWPieCHcQZYxsK8qomBvprRKK/Br4C71xzlafw4tM+cpVUcB7+Nfh09Brhb
        A+cmy2k19y6wlDoZFcfCpFeNCvhRWOmMGCL4KAyNWxjVbEUwfL9krfQL0OsdWE0trF5IhEvu
        ZJV+EWov/cxFaMCbYHAmRs2wCarbvqRVWgfWYr2q3grDvu/W0sTBhevzXBXaZlvXzLaujW1d
        G9v/d+sR04Ti5HwlN1tWUo3yh0mKlKvkG7OT9h/KdaLV77+27J3rQO5/3/UgLCDDRl2HL5Cp
        Z6UjSkGuB4FAGzbr7NIqpcuSCj6WTYf2mvJzZMWDtgiMIU73zpPHMvU4Wzosvy/LebLpwZYS
        NPFmZNvzz1vHiir+nK/cQm8d3zCfN42zdo89V7UrDT1vNHa+9kY3/eYIfrVsY+EGsfj12Q96
        CnHL0bT6nDRNeuvk6Xq/8vdO7fdJqedjyOLUxGx4e0HGe+GarAv6FK/2ZcnzdMru0EX/5/HF
        gYvKyf3a2NHU0M50V3A5oX1vrPdqRotjn4FRDkjPPkWbFOk/IbZgX/kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxzG955rMas7FpA3JDpXQpQlFspl/HGKiybLScaHbfpBIeqqHouR
        UuxpEYxuTb1wv+m2SGVgBKtBjFBQKhpQvKIrHaI4QKgB4w0KgQKC4SIFTfj2e5/n+X14k7+E
        lE3Q/pK9iXpBl6hKkDOLqEfT97tXX1Q/iQ05awuCnOYmAkzpLhrsllsMPBkdZKCisxHBTE8f
        Df+cOAzjlQ9JSKvpIeCEM5+C9//bGbgwUsjCm+4WCqqbs2nI6+0jweGoZOG/hkcE2E39LGQU
        lLFg7W2joX14jIbWuiIGhl/MkHDKUU/ApTtdLNj+vElAffVtCh6M/U1AV6UdwamTbxlwH5tm
        YKKumIK0IxYCjj9bCs3Gk+wPAXxFcQXi3eXvaP60sYXiW3NzCN7WVYb4a+Yulj+dXkjz1vIM
        hq8de0Hzzqz7BF9d9gc/ZW6g+NyacsTXthWTvNu6/OevYhVrdVqDXlgRrxX16+RxSghVKKNA
        ERoepVCGRW5bExohD45eu1tI2Jss6IKjf1PEZ7cGJaUHp7yvslBGlBeYibwkmAvH4/0WMhMt
        ksi4cwjfGLAS84Ufvl7iIufZG0+2ZTLzoz6ErVmTyFN4c3H41d0B1lP4cG8Rbsp5N/cguVIa
        d3T+xXhWMu5fhEt7fT3McEF4qrp9Lpdy0fjYhWushykuEN8yNVEe9uW24G7H8KfNEtxU+HIu
        9+I24Lrbxrk9ya3Ek8WPyXn+Gte6ij6xH+54WULkI5l5gW5eoJgXKOYFyhlElSMfwSBq1Box
        VCGqNKIhUa3YpdVY0ezZXb03UWNDmQObGhEnQfIvpTZ7a6yMViWLqZpGhCWk3EdqUc1G0t2q
        1IOCTrtDZ0gQxEYUMfu5AtLfd5d29ogT9TuUEcpIiFJGhkWGfQdyP6kjJDVWxqlVemGfICQJ
        us8eIfHyNyLvbSU7H2b8vnXom4LXpTGbDWXOJTE3qjoHHdsH21YFfTE+MzPxPG7ggNrvvDt/
        VcvU+rwr4WfiqtQhW2MCbFqu39lR5Xh9Ntm5uOKiy70/ZfzpocBfj34fPGnKOn95SLNnrPKZ
        +cd254grYTjZm0j7JZ9NGf2px5nVP7pso5ZOmjZ9kFNivEr5LakTVR8BvBx4HIwDAAA=
X-CMS-MailID: 20180416090652eucas1p1de9f6fa001d37a109e5587395653ae11
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416090652eucas1p1de9f6fa001d37a109e5587395653ae11
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180405095305epcas1p11a5082d2f0df9d35b953a4932827be0e
X-RootMTR: 20180405095305epcas1p11a5082d2f0df9d35b953a4932827be0e
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
        <CGME20180405095305epcas1p11a5082d2f0df9d35b953a4932827be0e@epcas1p1.samsung.com>
        <20180405095000.9756-27-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> The first time after we call rockchip_drm_do_flush() after
> rockchip_drm_psr_register(), we go from PSR_DISABLE to PSR_FLUSH. The
> difference between PSR_DISABLE and PSR_FLUSH is whether or not we have a
> delayed work pending - PSR is off in either state.  However
> psr_set_state() only catches the transition from PSR_FLUSH to
> PSR_DISABLE (which never happens), while going from PSR_DISABLE to
> PSR_FLUSH triggers a call to psr->set() to disable PSR while it's
> already disabled. This triggers the eDP PHY power-on sequence without
> being shut down first and this seems to occasionally leave the encoder
> unable to later enable PSR. Let's just simplify the state machine and
> simply consider PSR_DISABLE and PSR_FLUSH the same state. This lets us
> represent the hardware state by a simple boolean called "enabled" and,
> while at it, rename the misleading "active" boolean to "inhibit", which
> represents the purpose much better.

This phrase has no corresponding part in the patch.

>
> Also, userspace can (and does) trigger the rockchip_drm_do_flush() path
> from drmModeDirtyFB() at any time, whether or the encoder is active. If
> no mode is set, we call into analogix_dp_psr_set() which returns -EINVAL
> because encoder->crtc is NULL. Avoid this by starting out with
> psr->allowed set to false.

ditto

>
> Signed-off-by: Kristian H. Kristensen <hoegsberg@chromium.org>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Original author should be first, 1st line of the patch "From:...."
suggests it should be Tomasz.

Regards
Andrzej

> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 79 +++++++++--------------------
>  1 file changed, 23 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> index c8655e625ba2..448c5fde241c 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> @@ -22,19 +22,13 @@
>  
>  #define PSR_FLUSH_TIMEOUT_MS	100
>  
> -enum psr_state {
> -	PSR_FLUSH,
> -	PSR_ENABLE,
> -	PSR_DISABLE,
> -};
> -
>  struct psr_drv {
>  	struct list_head	list;
>  	struct drm_encoder	*encoder;
>  
>  	struct mutex		lock;
>  	bool			active;
> -	enum psr_state		state;
> +	bool			enabled;
>  
>  	struct delayed_work	flush_work;
>  	struct work_struct	disable_work;
> @@ -78,52 +72,22 @@ static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
>  	return psr;
>  }
>  
> -static void psr_set_state_locked(struct psr_drv *psr, enum psr_state state)
> +static int psr_set_state_locked(struct psr_drv *psr, bool enable)
>  {
> -	/*
> -	 * Allowed finite state machine:
> -	 *
> -	 *   PSR_ENABLE  < = = = = = >  PSR_FLUSH
> -	 *       | ^                        |
> -	 *       | |                        |
> -	 *       v |                        |
> -	 *   PSR_DISABLE < - - - - - - - - -
> -	 */
> -	if (state == psr->state || !psr->active)
> -		return;
> -
> -	/* Already disabled in flush, change the state, but not the hardware */
> -	if (state == PSR_DISABLE && psr->state == PSR_FLUSH) {
> -		psr->state = state;
> -		return;
> -	}
> +	int ret;
>  
> -	/* Actually commit the state change to hardware */
> -	switch (state) {
> -	case PSR_ENABLE:
> -		if (psr->set(psr->encoder, true))
> -			return;
> -		break;
> -
> -	case PSR_DISABLE:
> -	case PSR_FLUSH:
> -		if (psr->set(psr->encoder, false))
> -			return;
> -		break;
> -
> -	default:
> -		pr_err("%s: Unknown state %d\n", __func__, state);
> -		return;
> -	}
> +	if (!psr->active)
> +		return -EINVAL;
>  
> -	psr->state = state;
> -}
> +	if (enable == psr->enabled)
> +		return 0;
>  
> -static void psr_set_state(struct psr_drv *psr, enum psr_state state)
> -{
> -	mutex_lock(&psr->lock);
> -	psr_set_state_locked(psr, state);
> -	mutex_unlock(&psr->lock);
> +	ret = psr->set(psr->encoder, enable);
> +	if (ret)
> +		return ret;
> +
> +	psr->enabled = enable;
> +	return 0;
>  }
>  
>  static void psr_flush_handler(struct work_struct *work)
> @@ -131,10 +95,8 @@ static void psr_flush_handler(struct work_struct *work)
>  	struct psr_drv *psr = container_of(to_delayed_work(work),
>  					   struct psr_drv, flush_work);
>  
> -	/* If the state has changed since we initiated the flush, do nothing */
>  	mutex_lock(&psr->lock);
> -	if (psr->state == PSR_FLUSH)
> -		psr_set_state_locked(psr, PSR_ENABLE);
> +	psr_set_state_locked(psr, true);
>  	mutex_unlock(&psr->lock);
>  }
>  
> @@ -176,6 +138,7 @@ int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
>  
>  	mutex_lock(&psr->lock);
>  	psr->active = false;
> +	psr->enabled = false;
>  	mutex_unlock(&psr->lock);
>  	cancel_delayed_work_sync(&psr->flush_work);
>  	cancel_work_sync(&psr->disable_work);
> @@ -187,8 +150,12 @@ EXPORT_SYMBOL(rockchip_drm_psr_deactivate);
>  static void rockchip_drm_do_flush(struct psr_drv *psr)
>  {
>  	cancel_delayed_work_sync(&psr->flush_work);
> -	psr_set_state(psr, PSR_FLUSH);
> -	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
> +
> +	mutex_lock(&psr->lock);
> +	if (!psr_set_state_locked(psr, false))
> +		mod_delayed_work(system_wq, &psr->flush_work,
> +				 PSR_FLUSH_TIMEOUT_MS);
> +	mutex_unlock(&psr->lock);
>  }
>  
>  /**
> @@ -355,8 +322,8 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
>  	INIT_WORK(&psr->disable_work, psr_disable_handler);
>  	mutex_init(&psr->lock);
>  
> -	psr->active = true;
> -	psr->state = PSR_DISABLE;
> +	psr->active = false;
> +	psr->enabled = false;
>  	psr->encoder = encoder;
>  	psr->set = psr_set;
>  
