Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754385AbeDPIzn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:55:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42585 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754354AbeDPIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:55:40 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180416085537euoutp023efdb53125a12cd1db879e3e582aa62b~l3rmo0aeQ1931519315euoutp02b
X-AuditID: cbfec7f5-b45ff700000028a9-14-5ad465080316
Subject: Re: [PATCH v6 25/30] drm/rockchip: Cancel PSR enable work before
 changing the state
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
Message-ID: <39f15f1d-c984-d328-4d1f-dc115f71b98f@samsung.com>
Date: Mon, 16 Apr 2018 10:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405095000.9756-26-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG995vmMVLUXkn29iqy9wXYmayk8zpIsu8/2wx22IIibi7eYNO
        Wk0LDt3YujqlBUVXjZZWYYsMDcHYFITaJSC4iUBuoWlhMFZwgA6LFWMpjE1klMsy/nvO7zwn
        5zxvXo5U32FWcrt1eZJeJ+ZqmHiq/sa09zVOCmSld9vS4Zi3jQCTOUyDXNXMQCA6zkBNfwuC
        2aExGs5ZC+EvZzsJRXVDBFgHT1Aw1SszcHGijIXRAR8Ftd6jNBwfHiOhs9PJQldTBwGy6R4L
        lu8qWXAN99DQ93CSBr/nLAMPb82SYOtsJODSz0EW3KeuEdBYe52Cm5OnCQg6ZQS2k3cZiBx+
        zMC0p5yCokNVBBz5dQV4jSfZt1cJNeU1SIhUh2jBYfRRgr/0GCG4g5VIuGoPsoLDXEYLrmoL
        IzRM3qKFwZJWQqit/FqYsTdRQmldNRIaespJIeJ6duvSrPgNO6Xc3fsl/dqNH8fvqn9kY/ed
        W15g6XYyRtSbWIziOMyvx4e/NVPFKJ5T8xcRvlc5xSrFBML9Ry+QShFBeKZpiilG3PxIf8Nz
        Cr8wNxEuXjCFEQ43u1DMlMRn4/GINsaX8XcRdv4yRsQKkj9P46HuUjq2nOFfwjO1fUxMq/iN
        +Iegh4hpin8Bl/im5vlyPhOb/pxmFU8ibisboWI6jt+Mo0X35znJp+JDVxykopPxbyMV88sw
        3xSHR7qGCSXpO7gtECQVnYRDrXWsop/Gs1crFjxf4L5RE6UMmxEe/KeIURpv4uutPjoWjZy7
        +rJnrYLfws3WAVJ5lgTcG05UbkjA1vozC1iFzUfUivt5PChfWbggGf/YFWVOoFX2Rcnsi9LY
        F6Wx/7/3e0RVo2Qp36DNkQyv66TP0wyi1pCvy0n7dK/WheZ+f8fj1qgbNT76pAXxHNIsUbll
        f5aaFvcbDmhbEOZIzTJVlTiHVDvFAwcl/d4d+vxcydCCUjhKk6zKXvNVlprPEfOkPZK0T9L/
        1yW4uJVG9O4DX12JnLokc2LLDVN76P2P8kYLPrwdkH+yBMPypk1bC+9bM3Sd16SDv2/2ZKa8
        0W5/kPBZSPWk7Zk9A6+GHDfvRP/wr3+lIbCtY8tT57WFKTXfpKee3tGxYUXFmu0v3s7oSvE+
        kVFgs3xwxvZej3Gp2XE5zb36ePaX/nHHWTFJXBf8W0MZdonrXib1BvFfDTq5LfkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yTZxSH837XYmz8rCDv2OKlxrgtWaFFxsEgM/yhrzEaNo1uLM41+o2i
        tDX9ChETtwbjkCoKXqFV1HBNhwuhyKVEEXZBwFIRRBSLiCQqqGx0Iiwgawcm/PecX37PSU5y
        ZLRigg2TJRvMosmgTVFy85i2d819n/FiV2JEd2Y4ZLe3UJBx9BUL7pJGDrrejHBQ3tuEYHpg
        mIWLpw7BeEUrDZlVAxScepzDwNseNwdl/+Tz8LyvgwFn+3EWTj4dpsHjqeDhTkMbBe6Mlzxk
        5RbxUPm0m4UHo2MsdLoucDDaP01DnucGBVd/9/JQe+YmBTecvzFwa+wcBd4KN4K80y848B15
        x8GEq4CBzMMlFPx8fzG0W07z61aQ8oJyRHyOIZbYLR0M6TyRTZFabxEidTYvT+xH81lS6cji
        SM1YP0seH2umiLPoJzJla2DIiSoHIjXdBTTxVS5JWJCoijUZU83iMp1RMq9VfqsGjUodAyrN
        6hiVOjJ65xpNlDI8LnaPmJKcJprC475X6aon8/j9F0MOZN2r4CyoZ6EVyWRYWI17a5ZZ0TyZ
        QihG2Fmcg6woyJ+H4vpLr+gZXoQnu63cTGkY4caeIyggLxK+wyM+fSAPFl4g3JI9xAcGWihk
        8cPes7PGbYRd/ZfZwCpO+ARPOR9wAZYLcfiK10UFmBFW4mMdb//PQ4SvcZ9ndLazELfkDzIB
        DhLi8ZvM13yAaWEVniy4S8/wUnz4mn2WQ/HDwUtUDlLY5ui2OYptjmKbo1xGjAMFi6mSPkkv
        aVSSVi+lGpJUu436SuR/u+o/J6pqkfX11iYkyJByvrzW3ZmoYLVpUrq+CWEZrQyWl2j9kXyP
        Nv2gaDLuMqWmiFITivIfl0uHhew2+p/YYN6ljlJHQ4w6OjI68nNQhso9EemJCiFJaxb3ieJ+
        0fTeo2RBYRbknLSkbVtbnNzC87GD43cbjONXf9mw+KupH+p1txqv7/hAHPhjcEthR2mp94wu
        fvuP8Rl1GREjCZtJ17O/6p9QNz86mbvEV6daYChztJ3/5g6xM1+uQY+2XmtN+FCz8e/05471
        pY7rv+5M2Xxu494p17/OMffyj6c36YaqvzgU1OqxN1uUjKTTqj+lTZL2P+sSesyMAwAA
X-CMS-MailID: 20180416085536eucas1p1782ef8a3efb1e4579f76d45d3ac7fad3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416085536eucas1p1782ef8a3efb1e4579f76d45d3ac7fad3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180405095309epcas2p429f551f81c6fee6e6c7ed674318f4bf2
X-RootMTR: 20180405095309epcas2p429f551f81c6fee6e6c7ed674318f4bf2
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
        <CGME20180405095309epcas2p429f551f81c6fee6e6c7ed674318f4bf2@epcas2p4.samsung.com>
        <20180405095000.9756-26-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> If we change the state first and reschedule later, we might have the
> work executed according to previous scheduled time and end up with PSR
> re-enabled instantly. Let's cancel the work before changing the state.
>
> While at it, consolidate psr_disable_handler() to just call
> rockchip_drm_do_flush(), as they are both supposed to do the same.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> index a107845ba97c..c8655e625ba2 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> @@ -138,18 +138,6 @@ static void psr_flush_handler(struct work_struct *work)
>  	mutex_unlock(&psr->lock);
>  }
>  
> -static void psr_disable_handler(struct work_struct *work)
> -{
> -	struct psr_drv *psr = container_of(work, struct psr_drv, disable_work);
> -
> -	/* If the state has changed since we initiated the flush, do nothing */
> -	mutex_lock(&psr->lock);
> -	if (psr->state == PSR_ENABLE)
> -		psr_set_state_locked(psr, PSR_FLUSH);
> -	mutex_unlock(&psr->lock);
> -	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
> -}
> -
>  /**
>   * rockchip_drm_psr_activate - activate PSR on the given pipe
>   * @encoder: encoder to obtain the PSR encoder
> @@ -198,6 +186,7 @@ EXPORT_SYMBOL(rockchip_drm_psr_deactivate);
>  
>  static void rockchip_drm_do_flush(struct psr_drv *psr)
>  {
> +	cancel_delayed_work_sync(&psr->flush_work);
>  	psr_set_state(psr, PSR_FLUSH);
>  	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);

I guess you can change it to schedule_delayed_work then.

Anyway:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


>  }
> @@ -244,6 +233,13 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev)
>  }
>  EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
>  
> +static void psr_disable_handler(struct work_struct *work)
> +{
> +	struct psr_drv *psr = container_of(work, struct psr_drv, disable_work);
> +
> +	rockchip_drm_do_flush(psr);
> +}
> +
>  static void psr_input_event(struct input_handle *handle,
>  			    unsigned int type, unsigned int code,
>  			    int value)
