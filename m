Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeDLJyL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:54:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44031 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeDLJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:54:08 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180412095405euoutp019a6f8ffb98dc24bafa0dd3cb3aede870~kp5gTLEe40980009800euoutp01F
X-AuditID: cbfec7f4-6f9ff700000043e4-15-5acf2cbbaaed
Subject: Re: [PATCH v6 23/30] drm/rockchip: analogix_dp: Do not call
 Analogix code before bind
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
Message-ID: <2fde5d53-0e8d-6a15-7962-0e76532d0926@samsung.com>
Date: Thu, 12 Apr 2018 11:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405095000.9756-24-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjde78hK7tUXJ85s42aRSAON1nmuwzd5kZ2F/3hD020PzYq3hQj
        FNMrOvdJIAN0gI5uU8oGJlDFrkTkQ7EQFdAVJW1tmHxIahGZA7oGQwElo3S0FzL+nfM858k5
        J3k4UjnGrOEO6A+LBr02S81EU5f/mHO+0bbBpXkzUPcOLnXeJnB+sZ/GjnMdDP5zZpLB1qFO
        hEMjPhr/Vv4NftZwh8RFzSMELveeovDTAQeD66YrWDz2wE3hJmcJjU8+8pHY5Wpg8d3rPQR2
        5P/D4uM/1rK48VEfjQenZmnca/uVwVPDIRKfcV0jcP1ND4tbf7pB4GtNXRTunv2FwJ4GB8Jn
        jOMMDny/wOA5WxWFiwrOEbiw/0XszDOyH6wTrFVWJAQsE7RQmeemhN6yUkJo9dQi4arJwwqV
        xRW00Gg5zghXZodpwfuDnRCaar8TgqbrlFDWbEHClb4qUgg0vrLzBU106n4x68AR0bBxa3p0
        5mPrPHPofuwXpZa/6DxkjzmBojjg34b22RHqBIrmlHwdgpvOSUYm0wjcjzuWSABByPiEWD75
        2bS8OI/A9rR/ifgRBHvbqbBqFZ8OV29diCzi+HEEDbd8RJiQfA0NI/fK6LCK4RMh2DTIhLGC
        3wou62QEU/zrEHxijmhW83sg/+85VtbEwu2K0YhDFL8N3A8LURiT/KtQ0FJJylgF90erI2bA
        t0XB0D0fIwf/GGqelSyVWAUT9mZWxmuhx1hCyfgrGBzLp+TjYgTef4uWjt+DLrt7MRG36JAI
        F20b5fEWqK++ExkDHwMD/lg5QwyUXz5NymMFFBcqZXU8eB0tpIxVYL47w5xC60wrmplWtDGt
        aGP63/csoixIJeZK2TpR2qQXjyZL2mwpV69LzsjJbkSL/9+zYJ9uRbb5fZ2I55D6ecWeFKdG
        SWuPSMeyOxFwpDpOoVrv0igV+7XHvhQNOZ8bcrNEqRO9zFFqleKzhG81Sl6nPSweFMVDomF5
        S3BRa/LQvqn3u2oqUo76fp8JpazN3KygLN05Sc/5Y3a9Nl9CbjfWxX4qFO5IG58wfz2aWlu9
        gW07aW4/u/NGxpb+xOTUbbvPX5yRlBlDMHhpIWlyem9aeQIkYG9WSK9L9w+8dHr75u6gJz6n
        jzbEt3R99MBc8KFWZ6rfm/au0TncofokjlBTUqb2rSTSIGn/AyOTVej7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjHfc+1GOsOFe0rH4bWGCKBYsvtQREvifHsw9ToPphuCzZ4Amwt
        JT2FDBOVSBRlogjeaLdCVkDTlIQUNjpIcDBih1rOGJNNWKFex0XUgIJugFLAhG+/J///L0+e
        5JGRiv/pcFlWtkUwZ+sNKmY5dWfW649pjpZ0m722eCjp6iTg5JkxGny1bQz8+foFA67+dgTv
        Ho7S8H3ZMXhTf5uEosaHBJQNllIw9bePgRuvKlgYGuimoKHrHA0XHo2SIEn1LPx+8w4BvpPP
        WDh7sZoF96NeGu6PT9LQ0/wdA+OBdyRck1oJqOvws+C59AsBrQ2/UvDb5BUC/PU+BNfKhxmY
        ODXLwNtmOwVFhbUEnP5rDXQVlLM7NvAuuwvxE84RmrcVdFN8z/kSgvf4qxH/s9XP8rYzFTTv
        dp5l+KbJAM0Pfusl+IbqE/yM9SbFn290Ir6p107yE+6P93+kU6eYTbkWYV2mSbRsU32uAa1a
        kwxqbXyyWhOX9OUWbYIqNjXliGDIyhPMsamH1ZlPXdNMTl/oNyXOJ3QB8q4sRiEyzMXjy9Y2
        phgtlym4GoR7AsPsQqDELZVj5AKvwtO9xYulUYT9/g4UDFZxh/E9h50NBmHcMMKdJSPzA8k5
        aNzXf3lRuYtw261LdFBhuE14puE+E2Q5l4ol14t5priNeOZlzXxnNXcID0jji51Q3FnxmApy
        CLcLdz84Pb+a5CLxtP0PcoEjcOGPtkVW4r7HlUQpUliX6NYlinWJYl2iVCHKicKEXNGYYRS1
        alFvFHOzM9TpJqMbzT3eT7feNnpQ8fOD7YiTIdUK+aG4Lp2C1ueJ+cZ2hGWkKkyujJR0CvkR
        ff5RwWxKM+caBLEdJcwdd5EMX51umnvjbEuaJkGTBMmapLikuERQKeXS5nydgsvQW4SvBSFH
        MH/wCFlIeAHylOUNRlsTNrmnat07t/5XWSFC/miE94ByS+IX/VFZuxVE8t5Pto+Vb9j3T1ZT
        xlShPfPqE8MPManHY9Zr963tVHZUcssMHf2e3ffqQv/1ValR7LOZNYbGscCFvT1HlyksrXWO
        gaHEU19V5UhRn8a8dDjCIaL03Ge2oj3r01uuRwdUlJip10SRZlH/Hldln7aOAwAA
X-CMS-MailID: 20180412095403eucas1p13590fbd8850951e84f44908785cb7284
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180412095403eucas1p13590fbd8850951e84f44908785cb7284
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180405095337epcas3p1a8750649c8032d844991db91595da8e5
X-RootMTR: 20180405095337epcas3p1a8750649c8032d844991db91595da8e5
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
        <CGME20180405095337epcas3p1a8750649c8032d844991db91595da8e5@epcas3p1.samsung.com>
        <20180405095000.9756-24-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> Driver callbacks, such as system suspend or resume can be called any
> time, specifically they can be called before the component bind
> callback. Let's use dp->adp pointer as a safeguard and skip calling
> Analogix entry points if it is an ERR_PTR().

>From purity PoV I would store either 0 either valid pointer in dp->adp,
but functionally it should be the same.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 23317a2269e1..6d45d62466b3 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -368,6 +368,8 @@ static void rockchip_dp_unbind(struct device *dev, struct device *master,
>  	analogix_dp_unbind(dp->adp);
>  	rockchip_drm_psr_unregister(&dp->encoder);
>  	dp->encoder.funcs->destroy(&dp->encoder);
> +
> +	dp->adp = ERR_PTR(-ENODEV);
>  }
>  
>  static const struct component_ops rockchip_dp_component_ops = {
> @@ -391,6 +393,7 @@ static int rockchip_dp_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	dp->dev = dev;
> +	dp->adp = ERR_PTR(-ENODEV);
>  	dp->plat_data.panel = panel;
>  
>  	ret = rockchip_dp_of_probe(dp);
> @@ -414,6 +417,9 @@ static int rockchip_dp_suspend(struct device *dev)
>  {
>  	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
>  
> +	if (IS_ERR(dp->adp))
> +		return 0;
> +
>  	return analogix_dp_suspend(dp->adp);
>  }
>  
> @@ -421,6 +427,9 @@ static int rockchip_dp_resume(struct device *dev)
>  {
>  	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
>  
> +	if (IS_ERR(dp->adp))
> +		return 0;
> +
>  	return analogix_dp_resume(dp->adp);
>  }
>  #endif
