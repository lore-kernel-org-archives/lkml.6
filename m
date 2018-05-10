Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934217AbeEJHNa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 03:13:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45130 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756582AbeEJHN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 03:13:27 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180510071323euoutp0124106052dd7595f5155f64fac8911fef~tNxMVRlDz1596515965euoutp01S
X-AuditID: cbfec7f5-f95739c0000028a9-97-5af3f1112b00
Subject: Re: [PATCH v2 25/26] drm/bridge: require the owner .odev to be
 filled in on drm_bridge_add/attach
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
Message-ID: <6278e7a4-c67a-6198-364e-526042acc393@samsung.com>
Date: Thu, 10 May 2018 09:13:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504135212.26977-26-peda@axentia.se>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxTOe+97by+NZZfq0jNd9lHiJiQqRmNes+nMvnK3xGxuWbKxbO5u
        3FAioLYgE53D4qSIOGATochAxtxGSFS6Il8C6zIqaEsR+RrUktEAhSFxXQ3ggLVczPj3nOc8
        533Oc5KXo9UT7FouITlF0ieLiVpWiWvbZp0bI+77Y2Nclm0k19lOEaNpiiFGWwdLTjTWKshi
        bT5N7gSmWXJhzIFI/XBDkPtzkiGlBV+QAk8eJjnZJoaM3+3C5OuRSZp0dl5REIfxLwXJzq9U
        kJqRXobktzgUpLvhAku6M7sQsfruUeTv4UWaFHU2U+TifSsm1W3h5OalyzQxntxK3HdvYHLd
        VobIhDfAkLGLMzRxXwnaF33jY8mtnla8O1IobC1RCCUZXVjoPptLCfNjfVioc1ci4fqDcizk
        +G20UG92ByWmYkaoqcpmhaHeJla49mCYEb5r3yt4cuyUYKn8UjjZ3oLfhljli3FSYsJhSb95
        1ydKneXeewf7uM9brANUBjqtOI3COOC3QUenM4iVnJr/CcH5Uh8rF/8gGBh2LRd+BJf6p5hH
        I54RDyM3fkRwrXAUy8UUgqGruSikWs0nQnFhAIfwGv4lONfro0Iimv9eCW1Z3iV3lo+CecsA
        G8Iqfhdk9WVSIYz59VDVU0qH8OP8+2Acm1XImghoL/YuPRrGbwe3zbg0S/NPQ6a1hJaxBv7w
        li2ZAd8YBnMPZ2h571fhzGgjJePVMGH/ZfkET8JifdkyfxQGxo1YHjYh8DzMYuXGC/CbvSsY
        mgs6RMHlhs0yvRO++vUcFaKBD4f+qQh5h3AoqD1Py7QKTKfUsvpZ8Disy9to4AdXgM1DkeYV
        ycwr0phXpDH/71uOcBXSSKmGpHjJsDVZSttkEJMMqcnxmz47kFSDgj/g5oI9UIea//3UhngO
        aVepipT+WDUjHjYcSbIh4GjtGtWMM0ip4sQj6ZL+wD59aqJksKF1HNZqVB9vOB6r5uPFFGm/
        JB2U9I+6FBe2NgPFpNc9X+Ha27LfUZHnPWsX90yLTZk7Zid1Ue7Kwag35m4TV9w7L1fvZhc+
        fCYmLa/0aI5u6Nj66I4d1YNlPU8dGn13nxjZ+tq3Hxi5nXNpH0WfeYt65XdnR1P5xicSxvdc
        3TJY2Pymjvf4U2DDqvmK53wNET+/Pt1/vLsmfeExywn9KY0WG3TilmhabxD/A/8IeVf9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUxTaRSG892thVi9XjF84Y9aRwku1VKQgzpoTIzXzEwyxo3UtZEbQFtq
        egsRdTJYiEJRxzqL2qJYg4LgFqDsimlURMQG0RKMBSJENkGEwCgq2gIm/Htyzvuck5McKcl9
        poOk8QlGwZCg0coZf6purMazdMaHIfXyvk+r4NSzWgJM6X00mJxPGDhWWSKBbyUWEl4Mv2cg
        q7MeQXlbhbf2ppeGi2f/gLOtZyjIzEinoaulgYK/2ntJcLnuSKDe9E4CGZYcCRS2u2mwVNdL
        oLEii4HG1AYEju5+AgbbvpFw3nWPAPsHBwU3Hk2Humu3STClqcDT8piCu85sBD0dwzR02j+S
        4LnjXX/+724Gnr68T62dz/933ybhbSkNFN94+hTBf+1sovgyTw7i745cpvjMISfJl1s93kj6
        BZovzM9g+NfuKoYvHWmj+Uu1m/jWzBqCL8r5k0+rraZ+x2rFaoM+0SjMjdOLxp/lO5QQqlBG
        giI0LFKhVEXsWhkaLl8WtTpG0MYnCYZlUXsVcUX9Ww82SQ9VO5qJFGSWmJGfFLNhuLW9lTYj
        fynHXkX4XF0pOdEIxJXZfZM8C39xm5mJUC/CZXkFjK8xi9XiE8ctlI8D2DX4X3c34WOSLfDH
        xV06H3NsMcLHC7Q+ZtgQ/LWoedyVsVH4RFPqeJ5iF+D8lxfHl81mo3GLa3AyMxPXXugYn+/H
        rsAep4mZmB+Mv1x6Tk7wHJzqsE1yIH7VkU2cQZx1im6dolinKNYpymVE5aMAIVHUxerEUIWo
        0YmJCbGKfXpdIfI+XsmjT8VlyNy/2YlYKZJPkw1MG1JztCZJTNY5EZaS8gDZx2fekixGk3xY
        MOj3GBK1guhE4d7jLGTQ7H167xsnGPcow5UREKmMUEWoVoA8UOZanqzm2FiNUTggCAcFww+P
        kPoFpaBtpbd+5XLn5C7i92+ot4UNBP/yT9eBNPvWB1EhCzPVfVse6nvcucPDm9/ujJ67ZuH/
        9pw3VUe53dsdG+Opw6Moft0Sd/7IFZO+MlY32L2tynb0XPmR/mZtnrFtyy5VzM3RPPuMeT+N
        GrmMdSfH9t8Orpn/W4W6cn2ydqyn5voxtFiXJKfEOI1yEWkQNd8Bw80mSo4DAAA=
X-CMS-MailID: 20180510071320eucas1p193edf1a017d637da364d034611006d87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180510071320eucas1p193edf1a017d637da364d034611006d87
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180504135352epcas5p48cd98762cd4476621f98b0356b891f7e
X-RootMTR: 20180504135352epcas5p48cd98762cd4476621f98b0356b891f7e
References: <20180504135212.26977-1-peda@axentia.se>
        <CGME20180504135352epcas5p48cd98762cd4476621f98b0356b891f7e@epcas5p4.samsung.com>
        <20180504135212.26977-26-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2018 15:52, Peter Rosin wrote:
> The .odev owner device will be handy to have around.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> ---
>  drivers/gpu/drm/drm_bridge.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index df084db33494..78d186b6831b 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -70,6 +70,9 @@ static LIST_HEAD(bridge_list);
>   */
>  void drm_bridge_add(struct drm_bridge *bridge)
>  {
> +	if (WARN_ON(!bridge->odev))
> +		return;
> +
>  	mutex_lock(&bridge_lock);
>  	list_add_tail(&bridge->list, &bridge_list);
>  	mutex_unlock(&bridge_lock);
> @@ -115,6 +118,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	if (!encoder || !bridge)
>  		return -EINVAL;
>  
> +	if (WARN_ON(!bridge->odev))
> +		return -EINVAL;
> +
>  	if (previous && (!previous->dev || previous->encoder != encoder))
>  		return -EINVAL;
>  
