Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeDPJ52 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:57:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34819 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeDPJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:57:25 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180416095722euoutp022c2ba670925bcef288339c184615a43b~l4hhMvnYr1787917879euoutp021
X-AuditID: cbfec7f2-5ffe19c000011644-bb-5ad47380c964
Subject: Re: [PATCH v6 28/30] drm/rockchip: Disable PSR from reboot notifier
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
Message-ID: <a9e436f8-34ec-123a-9c69-efabb4576bea@samsung.com>
Date: Mon, 16 Apr 2018 11:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405095000.9756-29-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH97zXlqzupQg9umXGGowaL9PM5GRzzF0+vNv8oJ9mmNnsxhsk
        pdW14lDnLN2UgtB1QBwUrSYwVghzFSoFvIDV2aG2gIATWIUgRgU7Fm4bLspo3yzj2++c/7n8
        z5NHQauHucWKDONeyWTUZWq5OKbh2kxojcXcnfrK2aaNWBhqo9Bqi7AYrLrMYffUGIe1/X6C
        s0OjLJ4sOoR/e67TmOsdorBowMHgX3eCHLony3h8eLeTwfpQAYvf3hulsb3dw2NHyw0Kg9bH
        POZ9V8lj3b3bLPaOT7PY1XyCw/HBWRpL2y9R+NPVMI+NJa0UXqq/wuCv08cpDHuCBEuLH3E4
        ceQZhzPNLgZzv66i8OhvSRiyFPObl4m1rloiTtSMsGK5pZMRu+yFlNgYriRikzPMi+W2Mlas
        q8njRN/0ICsOHAtQYn3lYfGps4UR7d4aIvpuu2hxou7lrS+kxm1KkzIz9kmmdSk743Y1OHPo
        PbOLsquvqy2kIDGfKBQgvArhJ5BP4hRqwU3A3RXi5GCSwLnSEUoOJggEWqxsPlHGOko8F4gs
        /Ejg96t2Rg4iBG7erGaiVQnCFnhc2M1HhYXCIwKeX0Zjs2ihgoWhHntsFieshKf1vVyUVUIK
        5F1zkCgzQjK0tY3GahKF7WB9MMPLNfHQVjbMRJ0rhbdhuDgxmqaFJeCLnKBl1kDf8KnYLhB8
        Suh39TCy73fB3XORyJwAIwEvL/NLMNsUbYjyQeh9aGXkZhuBgX9yOVl4Ha4EOtnoYnrO9M/N
        6+TXewP+8KTJuADuROJlCwugqOF7Wk6rwHZULc9YCgPBc7TMGvihY4pzkGXOeXc55x3jnHeM
        8/+1pwlTQzRSltmQLpnXG6Uv1pp1BnOWMX3tZ7sNdWTu7994FhhvJFO3PvUTQUG0z6sag12p
        ala3z7zf4CegoLULVVW6uZQqTbf/gGTa/YkpK1My+8mLCkarUX284qtUtZCu2yvpJWmPZPpP
        pRTKxRayMf7wA0f/9hEvHOP45dkFB1frV6UvekfZ96U144OLxyPJryV9Pp08FvlmcEc2jC3Z
        sME7Ga76U21PMq54srRz09bnDlVUv99x/n7i6S2r30w5kvOR9u6ZNSXlB/yOPr0qUnphZzjH
        l1txZhuKyR/apPda9S7DSc0t/VsJ21qt7s2G+1rGvEu3fhVtMuv+BVZGKuj3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0iTeRjA+b6/Dce9Lc1vFldN5Mi61fyRj1ESckcvlFAdHGGEveSbjnPO
        9s7UIFxGmdY8TQudnQWnconB2sLNrtOyo1o111J2Zad26h+pWaGlSU3btAP/+zw/Pg/PAw9H
        Kj/SkZw2xygZcsRsFbOEejR7v//7IrknbZP1PwrMXS4Cis+M0+BuusNAz4e3DLS86EQwNzhG
        w2/nj8NH60MSSm4MEnB+oIKC6WduBv54X8vCq34vBfauczT8OjRGgsdjZeFJxyMC3MWvWSit
        bGDBNuSj4fnEFA3dNy8xMPFyjoQaTzsB1/7uY8FZfZuAdvtdCh5MXSSgz+pGUFM1wsDkqVkG
        Zm7WU1BysomA0/8shy5TFbs9Smipb0HCZPMoLdSZvJTQXW4mBGdfAxLaLH2sUHemlhZszaWM
        4Jh6SQsDZ+8Tgr2hSPBbOiih/EYzEhy+elKYtH27+5s09VaDPs8orcnSy8Ztqv0aiFVrkkAd
        G5+k1sQlHtgSm6DamLw1Q8rWHpUMG5MPqrNaLSfI3LkVBVcfKk3oXHgZCuEwH4+rrbdQGVrC
        KflGhNu814iFQgT+8/I4ucDL8GdfGRNkJT+G8NQTNsjL+F34tbmHDcph/AjCLvPofEDyv9O4
        98UFZmHsY4RnR9uooMLw67Df/nx+lIJPxqX3KlCQKT4au1xjdJDD+X243zPxtWcpdtUOB1yO
        C+FT8HDV/Nok/x3+XP+UXODV2DF+6StH4N7hy0QFUloW2ZZFimWRYlmkXEFUMwqT8mRdpk7W
        qGVRJ+flZKoP6XU2FPi61nszdid6ev2nTsRzSBWqcLq705S0eFQu1HUizJGqMEWTGEgpMsTC
        Y5JBn27Iy5bkTpQQuK2SjAw/pA/8cI4xXZOgSYQkTWJcYtxmUEUoPJsK05R8pmiUfpGkXMnw
        v0dwIZEmlHq1PL+wqr/x7hGd6dRum+y1D0VNKn9cf2DEHMqmfGhNz/T7LCkm74pPzp/rfvDP
        2MV32ln+lmND6GliuWPL6phc8MYUdP81/W9Y6d6zt4neEwNRSanTnw7np9ZW+9JXZvvXZnB6
        h3ZVbNHO4gfa3OgatnLPmxJx+5Ujb3Y0POtVUXKWqIkhDbL4BUN7YVKLAwAA
X-CMS-MailID: 20180416095719eucas1p13fc38ada2e3029b899f5740ebbfc7b64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416095719eucas1p13fc38ada2e3029b899f5740ebbfc7b64
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180405095117epcas2p2093448b49aab2abd6684bf689f8888d5
X-RootMTR: 20180405095117epcas2p2093448b49aab2abd6684bf689f8888d5
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
        <CGME20180405095117epcas2p2093448b49aab2abd6684bf689f8888d5@epcas2p2.samsung.com>
        <20180405095000.9756-29-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> It looks like the driver subsystem detaches devices from power domains
> at shutdown without consent of the drivers.

It looks bit strange. Could you elaborate more on it. Could you show the
code performing the detach?


Regards
Andrzej


>  This means that we might have
> our power domain turned off behind our back and the only way to avoid
> problems is to stop doing any hardware programming at some point before
> the power is cut. A reboot notifier, despite being a misnomer and
> handling shutdowns as well, is a good place to do it.
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> index e7e16d92d5a1..1bf5cba9a64d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/input.h>
> +#include <linux/reboot.h>
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -33,6 +34,7 @@ struct psr_drv {
>  	struct delayed_work	flush_work;
>  	struct work_struct	disable_work;
>  
> +	struct notifier_block	reboot_nb;
>  	struct input_handler    input_handler;
>  
>  	int (*set)(struct drm_encoder *encoder, bool enable);
> @@ -309,6 +311,24 @@ static const struct input_device_id psr_ids[] = {
>  	{ },
>  };
>  
> +static int rockchip_drm_psr_reboot_notifier(struct notifier_block *nb,
> +					    unsigned long action, void *data)
> +{
> +	struct psr_drv *psr = container_of(nb, struct psr_drv, reboot_nb);
> +
> +	/*
> +	 * It looks like the driver subsystem detaches devices from power
> +	 * domains at shutdown without consent of the drivers. This means
> +	 * that we might have our power domain turned off behind our back
> +	 * and the only way to avoid problems is to stop doing any hardware
> +	 * programming after this point, which is achieved by the unbalanced
> +	 * call below.
> +	 */
> +	rockchip_drm_psr_inhibit_get(psr->encoder);
> +
> +	return 0;
> +}
> +
>  /**
>   * rockchip_drm_psr_register - register encoder to psr driver
>   * @encoder: encoder that obtain the PSR function
> @@ -361,6 +381,9 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
>  	if (error)
>  		goto err1;
>  
> +	psr->reboot_nb.notifier_call = rockchip_drm_psr_reboot_notifier;
> +	register_reboot_notifier(&psr->reboot_nb);
> +
>  	mutex_lock(&drm_drv->psr_list_lock);
>  	list_add_tail(&psr->list, &drm_drv->psr_list);
>  	mutex_unlock(&drm_drv->psr_list_lock);
> @@ -403,6 +426,7 @@ void rockchip_drm_psr_unregister(struct drm_encoder *encoder)
>  			WARN_ON(psr->inhibit_count != 1);
>  
>  			list_del(&psr->list);
> +			unregister_reboot_notifier(&psr->reboot_nb);
>  			input_unregister_handler(&psr->input_handler);
>  			kfree(psr->input_handler.name);
>  			kfree(psr);
