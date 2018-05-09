Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964791AbeEIPIh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:08:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49824 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935065AbeEIPId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:08:33 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180509150829euoutp012da2a522032bf083e2c82d28b9549561~tAmuGJHX_0834308343euoutp01Y
X-AuditID: cbfec7f4-713ff700000043e4-0f-5af30eec285b
Subject: Re: [PATCH v2 01/26] drm/bridge: allow optionally specifying an
 owner .odev device
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <4e92fdea-0609-0fff-0e3f-d9f78f596eb7@samsung.com>
Date: Wed, 9 May 2018 17:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504135212.26977-2-peda@axentia.se>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTVxjHc/qe90Kl9bSy9ATJLmVL5hIvm86cTXH7sCwn2T5sMUbXxUkn
        bxClaPqClxkVOjdKGY7L3KDcJOJYjBGHo1w2gdQNRKyVwKoOawl0KahVJrQBFFjb12V8+5/n
        +f3zPP8nR2C0AS5RyMjKFs1Zxkw9p4SO7hn3ygfqScOa70aTSNH1XgWxWIMssTivciTvVwdP
        FhwlDBkMPeJIVcAFSNtwe6Q2cp8l1aVHSKmvGJLCAitLxu72Q/Lt6H2GuN0XeOKyPOBJQUk9
        T5pGPSwp6XTxZKC9iiMDX/YD0jz+UEEeDy8wpNzdoSB1/zRDcq5bTfp+bGSI5fha4r17BZJL
        zlpA7vlDLAnUTTPEeyEyvrxsnCPX/uyC7ybT77sqeVqZ2w/pwIkiBZ0L3IS01VsP6KXwKUgL
        J50MbbN7I4i1gqVNZws4esfzG0dbwsMsren9mPoKexT0Yv0xery3E36EDcqNaWJmxn7RvHpT
        qnJX2FXN7ivXHRxq2Z0LBrU2ECdgtA7PlZ3kbEApaNFPAA89ygfyYwrga623ePkxCXDh9YYI
        JsQsxYN7om4tagA4OLZdZoIAz9eOxJhlaDvOde+IMgnoHXzSM66IMgw6rcTd+X4+2uDQCjx3
        8TYX1Sq0CbdNV8KohuhlHO6rizHPoW3YEpjhZUaDeyv8MSYOvYlnp/0xL4NewC3BKkbWOvyX
        vzY2DKPOOGyz1LByzvfw05kTjKyX4Xs9v/CyTsJ9Zd9AWR/Gt8csUDZbAfY9yefkxgZ8uaef
        jSZjIls3tq+Wyyk4NP47lI+ixreCGnkHNS51/MDIZRW2fv3s0i9hn6v52QY6fOZGiCsGyfZF
        yeyL0tgXpbH/P/cUgGeBTsyRTOmi9EaWeGCVZDRJOVnpq3buNTWByPfvm++ZagXtTz93AiQA
        fbxqIn7SoGWN+6VDJifAAqNPUC0MPzZoVWnGQ1+I5r07zDmZouQEywWo16k+e/WoQYvSjdni
        HlHcJ5r/6yqEuMRckPBzdmJFwqz3lZabwdq1YeHTic1dd67+8Tw9TV+0dsbrJ84ley5/MHJg
        pZTy90ZW4zlqW9+6dKnh7Qm0ZOvQzuTZMzXut75yofAnqW1FjTTQsWVqRePyjBRd3sP5J9ty
        zis1GkWquqG6I9T0oS8vL8kEOYdNcKw/fOPI+1fOp2Wu00Npl/H11xizZPwXbUNrcPoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH8+t9tJBVr1e0P2sWXTUuM6FyqR2HRZl/zfsHW3zFmA6jFa/A
        pNT1tkw0ZNixhEdQwLiUlkcx+IIlAzooyBymfyCV1cpjGOeKDbJg14ERIkED1hZcwn+fnPP9
        nJOTHBnBvqGUspw8s2DK0+eq6Hhy4O29QGJ41awuyf4PhooHXglYS6YosHru03Chp1MKkc4q
        AkZevaChdtKHoDt4O1obD1NQV10I1U8rSSgvLaHg+dggCZeehQnw+1ul4LP+J4XSqiYptD8b
        paCq1yeF4du1NAz/MIigIzQtgZlghACb/3cJNL7sIOHnvlUwcP0XAqzFGgiM9ZNwx9OA4N+J
        VxRMNs4TEGiNrrddDtHwx593yT1b+J/uOqS8o2iQ5IcvVkj4xclHJN8VaEL8nTknyZfPegi+
        2x6IRkpqKL69uZTm/x79jebdc0GKr/fu55+W35Pwrqbv+WJvL7kP69S7TEaLWdicbRTNu1Vf
        c5Cs5lJBnbwzVc1pUo5+lqxV7UjbdVLIzckXTDvSjquz53x11Bmb4uwT9zdFaIQtQzIZZnbi
        ypHTZShexjLXEI7YelEZiovWFbinYYpY5rV4YbSMXg6FEe65Pk7HGmuZo9h9q5mMcQLzOb4y
        GpLEmGBa4vGvzw0xZhkXwsU3DsWYZj7Bi67HS66cScPd844ll2S24rmBRmmM1zFH8Jh/5n1m
        DfbWTCxl4hgtfjM/QS/P/xgv1A8Ry7wJu6dq37MC/zXRIKlErH2Fbl+h2Fco9hWKE5HNKEGw
        iIYsg8ipRb1BtORlqTONhnYU/bvOvteuLjTUdtCDGBlSfSC3xc/qWEqfLxYYPAjLCFWCPBKc
        0bHyk/qCc4LJeMxkyRVED9JGj6silOsyjdEvzjMf47RcCqRyKZoUzaegUsj9SQU6lsnSm4XT
        gnBGMP3vSWRxyiLkeBgcQOF+azr3+qv6PevrHJYvp/G37kFrU2FGKLXau2l1TX3E/+HlA/Yr
        HQrN45nv0qWn2MIKMWnvR4cXtP35iV9k5lxNnNzets/36Mj4g4z8H590BURnyD+0oZVX9q2e
        XlR6XWvIHjI90ljTMmvZdsGncqpPbDx/swRGbmY4VaSYree2EyZR/w4algzCjQMAAA==
X-CMS-MailID: 20180509150827eucas1p2ef5b11e51f53aebc4ce9a7ffc4349213
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180509150827eucas1p2ef5b11e51f53aebc4ce9a7ffc4349213
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180504135245epcas4p1d0463b6b3c73d1dd2550c6ed5a4e3986
X-RootMTR: 20180504135245epcas4p1d0463b6b3c73d1dd2550c6ed5a4e3986
References: <20180504135212.26977-1-peda@axentia.se>
        <CGME20180504135245epcas4p1d0463b6b3c73d1dd2550c6ed5a4e3986@epcas4p1.samsung.com>
        <20180504135212.26977-2-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2018 15:51, Peter Rosin wrote:
> Bridge drivers can now (temporarily, in a transition phase) select if
> they want to provide a full owner device or keep just providing an
> of_node.
>
> By providing a full owner device, the bridge drivers no longer need
> to provide an of_node since that node is available via the owner
> device.
>
> When all bridge drivers provide an owner device, that will become
> mandatory and the .of_node member will be removed.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/drm_bridge.c             | 3 ++-
>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 4 +++-

What is the reason to put rockchip here? Shouldn't be in separate patch?

>  include/drm/drm_bridge.h                 | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 1638bfe9627c..3872f5379998 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -365,7 +365,8 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  	mutex_lock(&bridge_lock);
>  
>  	list_for_each_entry(bridge, &bridge_list, list) {
> -		if (bridge->of_node == np) {
> +		if ((bridge->odev && bridge->odev->of_node == np) ||
> +		    bridge->of_node == np) {
>  			mutex_unlock(&bridge_lock);
>  			return bridge;
>  		}
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 4bd94b167d2c..557e0079c98d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -377,8 +377,10 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	}
>  	if (lvds->panel)
>  		remote = lvds->panel->dev->of_node;
> -	else
> +	else if (lvds->bridge->of_node)
>  		remote = lvds->bridge->of_node;
> +	else
> +		remote = lvds->bridge->odev->of_node;

I guess odev should be NULL here, or have I missed something.

Regards
Andrzej

>  	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
>  		/* default set it as output rgb */
>  		lvds->output = DISPLAY_OUTPUT_RGB;
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 3270fec46979..7c17977c3537 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -254,6 +254,7 @@ struct drm_bridge_timings {
>  
>  /**
>   * struct drm_bridge - central DRM bridge control structure
> + * @odev: device that owns the bridge
>   * @dev: DRM device this bridge belongs to
>   * @encoder: encoder to which this bridge is connected
>   * @next: the next bridge in the encoder chain
> @@ -265,6 +266,7 @@ struct drm_bridge_timings {
>   * @driver_private: pointer to the bridge driver's internal context
>   */
>  struct drm_bridge {
> +	struct device *odev;
>  	struct drm_device *dev;
>  	struct drm_encoder *encoder;
>  	struct drm_bridge *next;
