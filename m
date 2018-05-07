Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeEGM75 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:59:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33446 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeEGM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:59:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180507125950euoutp01eb3aa06479d189566d5a810f3b06564e~sXj0MAvad0864808648euoutp01b
X-AuditID: cbfec7f4-713ff700000043e4-30-5af04dc4fa83
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
Message-ID: <4cdcd215-8caf-e045-a478-f438f128c9f2@samsung.com>
Date: Mon, 7 May 2018 14:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504135212.26977-27-peda@axentia.se>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTZxTHfXqf+9LGsmvRcCJL1LIPzmUwnHFPoqiJS3aXzOgSlyz94Fbm
        DZpBNS3gHNFhC6NAHS3GFwqbEHFzWgKrQKVOYdW1AiKrTJSFAhtdoLzKmxGZYsvFjG+/8z//
        /3PO+fBwlCrErOYO6tJFvU6bqmYUuN472/727V2PNe/8+zSenLzXLCNG8yhNjJ4Whpy4Xs+S
        +XobRf6cGWdI2UAbIg197rD2zzBNvi8+Rop7rZgU5ptpMtjjx6Sof5gi7e01LGkzjrAk31bJ
        Emd/J01sjW0s6XCXMaTD5EekLjQmI5N98xQ5135TRiom6jBxeKNI64/VFDHmvEsCPXcwueE5
        j8hQcIYmAxVPKRKoCY8/dyrEkLsPmvCOOOFMUykrlGb7sdDx3UmZ8HzgIRauBSqRcONJORYK
        pzyU0GAPhC3mElpwXs5nhO7OXxnB9aSPFn5o/ljoLfTJhKuV3wg5zY14D2gUW/eLqQczRX3C
        ts8VB5z3rdThM7FfFf2WkI06VhUgOQf8JjhddYUuQApOxV9CMGd3MFIxjWDIUS2TiikEdm+T
        7FWkq9SEpMZPCAI11sXIKIKpu/1hF8dF8yJcepAYCazkt8PpztDCSxR/QQHevCAbaTD8m/D8
        ahcTYSW/DexzOSjCmH8DGlqsVIRX8Z+CcWCWlTwroLkkiCMs5zeDxRta8FP8GnCNllESx8Bf
        wfMLw4BvlIP/yk1GWvt9qGpxYYmjYchXy0r8OrSesizqWdA1aMRS2Iygdy5vMbwFbvn8dOQy
        Krx1tTtBkpOg9qINRWTgo+DR6Apphygorj9LSbISzN+qJPc66G2roySOgYt/zDBWFGdfcpl9
        yTX2JdfY/59bjvBlFCNmGNJSRMNGnXgk3qBNM2ToUuK/OJTmROEP0PrCN30Nuf9L9iCeQ+rl
        ymVnxzUqWptpOJrmQcBR6pVKJu6xRqXcrz36tag/9Jk+I1U0eFAsh9Uxyn3rj2tUfIo2XfxS
        FA+L+lddGSdfnY1sEz3uT7Ys/3Dn7R5z9L7kSVO5//4Rk8gVjdRusFzXJVm413LZrGWzCt+8
        a/KjpPeOW7odE4FNyg9SLjwreLh3Pj15/Z3xF3lVu71jb90aWZvZXZFsOlGVnhu78V7J4BpH
        lzp4LORXyMc2e6Zd8bPiL62Jv68d/jl36/bSqEdZzqS/1dhwQJu4gdIbtC8B4XMeXfwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUxTaRSG/XqXFsaaS4XhCyZq6qjBxGKLyGGiqPHPFxONxjHRqoFGbwCl
        rbm3EDExMpUYKMriglCwhYRxEmeCiGzFDauibNOBjmWc2IKKQUSWkUhccGmpJvx7cs55zpuT
        HBml+MhEydIMJl4w6NKVbCjd+fmBd+XdLRPaVb22pXD6r3YJmHNHGTA7O1j49XqjFL40FlPw
        z9txFiqGuhE4Blr8tWcjDFw8cwzO9BfRkJ+Xy8BLXw8Nhc9HKHC5aqXQbX4thbziainUPfcw
        UHy7WwrulgoW3Cd6EDQMj0ngzcAXCkpdtyRQ9X8DDX+2zYPOS1coMOfEgtf3kIabTjuCV4Nv
        GRiqekeBt9YfX3p2mIWuR630hiWkpLVcSsqze2jiLjgtIZ+G+mjS7K1G5OZUJU3yJ50UcVi9
        /pHcMobUXc5jyRPPDZY0TQ0wxNa+nfTnP5CQa9XHSU77bXob1qrWCsYME7841Sia1in3qEGj
        UieASrM6QaWOjd/3syZOGZO49gCfnpbJCzGJyarUut4i6nDJgiOFd2KykTvCgkJkmFuNH5ef
        QBYUKlNwvyF8ttnDBhuR+Lp9lAryfDztsczUFdwIwiMWPsDzOR63TV5FAQ7n1uPznmFJgCnu
        j1Bc/1IfXFqPsPl9szTQYLlo/Ona45lFci4RWz/mzMg09xN2dBTNhEVwu7DP9ebbTBhuLxuk
        AxzCrcGn2oZRMGA5nrb1UkFehJtGK75xJP5v0C4pQgrrLN06S7HOUqyzlEpEX0bhfIaoT9GL
        GpWo04sZhhTVfqO+Dvkfr7HtfX0zsoztcCJOhpRz5XMujGsVjC5TzNI7EZZRynA5u2RCq5Af
        0GUd5QVjkpCRzotOFOc/rpiKithv9L+xwZSkjlPHQ4I6PjY+dg0oI+WuVVlaBZeiM/GHeP4w
        L3z3JLKQqGwk5KS9qhnre/HLMUuZhsyLKdC6ppMrZRdsYb7dZXm3nv5gO7mw4WDrRBJzZ1Hf
        3kz31nOvl/nuHWotvPSkarF940UCfUdsXbt/jDbX7qop+D15yldulwuOjkcPJ/s3jzkir/6d
        bti0b7l604371fz50oJnmSUJ41P/foiOkG/YttOYraTFVJ16BSWIuq9uHDPBjgMAAA==
X-CMS-MailID: 20180507125947eucas1p141a4d83749ae42519f1baabec966b8db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180507125947eucas1p141a4d83749ae42519f1baabec966b8db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1
X-RootMTR: 20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1
References: <20180504135212.26977-1-peda@axentia.se>
        <CGME20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1@epcas3p2.samsung.com>
        <20180504135212.26977-27-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2018 15:52, Peter Rosin wrote:
> If the bridge supplier is unbound, this will bring the bridge consumer
> down along with the bridge. Thus, there will no longer linger any
> dangling pointers from the bridge consumer (the drm_device) to some
> non-existent bridge supplier.

I understand rationales behind this patch, but it is another step into
making drm_dev one big driver with subcomponents, where drm will work
only if every subcomponent is working/loaded. Do we need to go this way?
In case of many platforms such approach results in display turned on
very late on boot for example due to late initialization of some
regulator exposed by some i2c device, which is used by hdmi bridge. And
this hdmi bridge is just to provide alternative(rarely used) display
path, the main display path would work anyway.

So the main question to drm maintainers is about evolution of bridges,
if drm_bridges should become mandatory components of drm device or they
could be added/removed dynamically?

Regards
Andrzej


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
