Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756904AbeEJIKm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 04:10:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34738 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756671AbeEJIKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 04:10:34 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180510081032euoutp010f223cf76be87c090b8b114e64234bcd~tOjFbA6o21361113611euoutp01L
X-AuditID: cbfec7f4-6f9ff700000043e4-29-5af3fe76269d
Subject: Re: [PATCH v2 26/26] drm/bridge: establish a link between the
 bridge supplier and consumer
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
Message-ID: <a723ad4a-8caa-4ff5-d39d-52db98a56d7b@samsung.com>
Date: Thu, 10 May 2018 10:10:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504135212.26977-27-peda@axentia.se>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGd+53O9pdqrPvdMu2IpuaiXOfJ2xDYxZz/9G5zCwLS5yd3hQn
        oOkVnCybrJBZKCgfjkHB+TEmpnGBoBQpA1nNWlssXcdAcSsQ6QKVMZkVAxnCWm7N+O93nud9
        z/O+J4cjNWPMcm5P9gHRmK3P1DFKyu6a6VmbOxdJf7F0MhWX9ngIbDJP0Njk9DL4y3Y7i+ft
        5ST+beoOg+tGfQi3DTui2q1xGp+o+BxXDJVR2FJkpvHYYIDCx0bGSez3N7HYZ/qLxUXl9Sxu
        HumncfllH4t7HXUM7i0IINwS/pvAd4fnSVzt7yTw6X9aKHzepcbdZxtJbCp8GQcHr1K4w3kS
        4duhKRqPnp4mcbApGl9dGWbwtb4uamOSUNVVywq1+QFK6D1aSggPRq9TwqVgPRI67p+iBEvE
        SQpt1mC0xFxDC822Ikb4o/9HRmi9P0wL33reFYYsbkK4UH9YKPRcprZBuvLN3WLmnlzRuC5t
        pzKj8HqA3n9H++l8d3I+mtYUIwUH/Ctw90Y1W4yUnIY/h+BMwQ+EfLiH4OhPnXEngmDyZxv5
        sOX4RBspGw0Ixi198aoJBKb8i6gYcdwSXoRzfetjDUv5DfB1f3jhWpL/TgmuIyE2ZjD8anhw
        YYCJsYpPg1Zn80ICxSeDrTO0oD/OfwCm0RlWrkkET02IirGCfw1KXGEUY5J/GgpaakmZtXAz
        dHIhDPhWBczafaw89tsw2d5IyLwEbrsvxvUnobuyhJL5MxgYM1FysxnB0L9HGNl4A664A3Rs
        MzI6daNjXQyBfwsayz+RUQ03JhLlEdRQYf+GlGUVmL+KP/WzMORrib+hFr7/ZYopQ0nWRYtZ
        Fy1jXbSM9f/YU4iyIa2YI2UZROmlbPFgiqTPknKyDSm79mU1o+j/755z37uEHLMfOxHPIV2C
        ajIhkq6h9bnSoSwnAo7ULVVN90Ql1W79oTzRuO8jY06mKDnRCo7SaVU7Vn2RruEN+gPiXlHc
        LxofugSnWJ6Pnhj0jlQZepd5nl9VdyUxwWtcuWmn4VVH9eHf01J93oMZT7mPbc7r/HDNloyS
        FcvsCqIpL/lXa42ro3ImuHmvRs16r26YrUla/cjWgrxxv+Ud9Rb/nymRru03Bx+7dv59267w
        e1Zp/pbwjLRxLhWXNVQ9+kJO0lnzjk3Ptb2+tqG9smNAR0kZ+vVrSKOk/w/671ft+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjH855bW0LNsaC8QRNNjTEusdIi9KlRxCWa88EPEj+4oJs2eAI4
        eklPS4ThBGRbC4KAumlxVhM0BrfAyh0VmzrBithUFIKxQIAMK+MieEGDsNK6hG+//J//733y
        Jo+YlM3TseJMvZk36bVZciaC6lro9G+xLMymxk2+VUPpEw8BhdYJGgrdjxgouN0kgsWmChKe
        vZti4PJYN4LWobZgNjxOw++VJ6FysJyCEpuVhlcDPgrOjoyT4PXWiaC78F8R2CqqReAc6aWh
        4l63CHraLjPQc9qHoDEwScDM0CIJF73tBFx700jBHx0roOtGLQmFRfHgH3hIwV23A8Hr0Xc0
        jF2bI8FfF1x/8VyAgcfPXVTyBu5XV5WIq8r3UVxPWSnBfR7ro7gWfzXi7r6/SnEls26Sa7X7
        gxXrJZpz1tgY7mXvHYZrfj9Ec1c8KdxgSSfB1Vef4oo896j9OFWxw2SwmPn1GQbBvFN+SAkq
        hVIDCtU2jUIZr/52uypBvjVpxzE+KzObN21NOqrIKOrz0capmBOLXRvz0ZysGEnEmN2Gz0+0
        ksUoQixjryPs/ORA4UEMvu2YIMMched7i5lwaRxhR8GL0CCK5XHH7F8hIZrdhS/0BoglJtlb
        EbjhlS4sNCDc56pllgYMuxl/ru8PsZRNws1uZ+ghit2Ia9pHQ/kq9hs84J350lmJPZdGqSWW
        sIn4TEcAhRdswvNXnpJhXodPN1Z94Rj8YtRBlCOZfZluX6bYlyn2ZcpVRNWgaN4i6NJ1gkoh
        aHWCRZ+uSDPonCh4eU0dHxtaUPHkATdixUgeKZ2OnE2V0dpsIUfnRlhMyqOlc0+CkfSYNieX
        NxmOmCxZvOBGCcHPVZCxq9IMwTvWm48oE5Rq0CjV8er4RJDHSL1xOakyNl1r5r/neSNv+t8j
        xJLYfLTlt9enppo+qpk02Z6WO8Y1T639H4x7iaM/N45Ye/LeZK/dl+GZcQx6r2+WHH8wfPgX
        qr8+97Hm5k9k59fwp2/KNVxWdvAfyWqbd3fpIWMOm5ebtV7zd+IFW7lGdT7ZNfyDvu1TVHpd
        863WwZRpcZxIUVK7q/J+QPdj4ndzKEW/do+cEjK0yq9Ik6D9D4pCfg6PAwAA
X-CMS-MailID: 20180510081030eucas1p1e34df6d19674dded20ff11d48ff19368
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180510081030eucas1p1e34df6d19674dded20ff11d48ff19368
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180504135432epcas3p368bb7541ca52bc8bc301dec794851214
X-RootMTR: 20180504135432epcas3p368bb7541ca52bc8bc301dec794851214
References: <20180504135212.26977-1-peda@axentia.se>
        <CGME20180504135432epcas3p368bb7541ca52bc8bc301dec794851214@epcas3p3.samsung.com>
        <20180504135212.26977-27-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2018 15:52, Peter Rosin wrote:
> If the bridge supplier is unbound, this will bring the bridge consumer
> down along with the bridge. Thus, there will no longer linger any
> dangling pointers from the bridge consumer (the drm_device) to some
> non-existent bridge supplier.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
>  include/drm/drm_bridge.h     |  2 ++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 78d186b6831b..0259f0a3ff27 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_device.h>
>  #include <drm/drm_encoder.h>
>  
>  #include "drm_crtc_internal.h"
> @@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	if (bridge->dev)
>  		return -EBUSY;
>  
> +	if (encoder->dev->dev != bridge->odev) {

I wonder why device_link_add does not handle this case (self dependency)
silently as noop, as it seems to be a correct behavior.

> +		bridge->link = device_link_add(encoder->dev->dev,
> +					       bridge->odev, 0);
> +		if (!bridge->link) {
> +			dev_err(bridge->odev, "failed to link bridge to %s\n",
> +				dev_name(encoder->dev->dev));
> +			return -EINVAL;
> +		}
> +	}
> +
>  	bridge->dev = encoder->dev;
>  	bridge->encoder = encoder;
>  
>  	if (bridge->funcs->attach) {
>  		ret = bridge->funcs->attach(bridge);
>  		if (ret < 0) {
> +			if (bridge->link)
> +				device_link_del(bridge->link);
> +			bridge->link = NULL;
>  			bridge->dev = NULL;
>  			bridge->encoder = NULL;
>  			return ret;
> @@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>  	if (bridge->funcs->detach)
>  		bridge->funcs->detach(bridge);
>  
> +	if (bridge->link)
> +		device_link_del(bridge->link);
> +	bridge->link = NULL;
> +
>  	bridge->dev = NULL;
>  }
>  
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index b656e505d11e..804189c63a4c 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -261,6 +261,7 @@ struct drm_bridge_timings {
>   * @list: to keep track of all added bridges
>   * @timings: the timing specification for the bridge, if any (may
>   * be NULL)
> + * @link: drm consumer <-> bridge supplier

Nitpick: "<->" suggests symmetry, maybe "device link from drm consumer
to the bridge" would be better.

Anyway:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

>   * @funcs: control functions
>   * @driver_private: pointer to the bridge driver's internal context
>   */
> @@ -271,6 +272,7 @@ struct drm_bridge {
>  	struct drm_bridge *next;
>  	struct list_head list;
>  	const struct drm_bridge_timings *timings;
> +	struct device_link *link;
>  
>  	const struct drm_bridge_funcs *funcs;
>  	void *driver_private;
