Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756746AbeEJHAj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 03:00:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57819 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756305AbeEJHAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 03:00:34 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180510070031euoutp02e9179ad91a2f7df124318863e5350744~tNl8nghES0134801348euoutp02z
X-AuditID: cbfec7f4-6f9ff700000043e4-18-5af3ee0e1fae
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
Message-ID: <603ed606-022b-6520-149d-3b333123cfcf@samsung.com>
Date: Thu, 10 May 2018 09:00:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5abcab35-8a78-a02a-9f22-321da55d9858@axentia.se>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxjO13OlseRQMbyyJboaI1syUTDLlyBoMo1HfxiJfwgRXJ0n4IRq
        esTN24atkQJBAbMiLVCMdVPmBkGo0oGQ6uiqQEEGXqFHZSkX8bKK4rxgy8HIv+d93ud9n/f5
        8rGEepiOZnfo9gh6nTZLQytJR/sr75fhjwOpy+73RuKiLo8CG0zjFDa4rtH48J8OBk85Sgj8
        z8QTGlf4OxFukpxB7sEYhStLD+FSXzGJC/NNFB4e7CHx8YdjBPZ66xjcaXjE4PwSO4PrH/ZT
        uKS1k8G9zgoa9xp7EG4ceazA/0lTBD7pvazAp541kvh8ezi+/kstgQ1H4vHA4N8kbnHZEB4d
        mqCw/9QkgQfqgvYnT4zQuKOvjVy9iDe3WRnemttD8r3HihT8W/9Nkr80YEd8y4tqki8MuAi+
        yTIQlJjKKb6+Jp/m7/U30/zFFxLFV3mSeV+hW8FfsP/EH/G0kpsgVblyu5C1Y6+gj036Rpl5
        9488tNu34AePtZrJRd75BSiMBW4FVNT8ThUgJavmziIod3Yp5OI5AulWBS0XAQS+e2biw4jD
        aZpR/YqgvXaUkItxBIY3V8gCxLJzuTTI9W4NDURyq+Dn/pHpAYI7rYT2vCEm1KC5z+Hthdt0
        CKu4JLAbbVQIk9xiqJROT2vmcSlg8L9iZE0EeMqHpveHBfWDJ5JDNMEtAGOjlZBxFNwZsk17
        AdcaBl5bg0K+eg34zEdn8FwYdTcwMv4UpppsM/wBuD1sIOVhUzDy6zxabiTAFXcPFTImgkfX
        OmNDELhEqLqpkmE43BqPkE8Ih1JHGSHTKjAdVcs7PgNfZ+PME0bBme4JuhgtsszKZZkVxjIr
        jOWjbTUia1CUkCNmZwhinE74fqmozRZzdBlLv92VXY+C///6O/fzS8j5ZpsLcSzSzFE9nRNI
        VVPaveK+bBcCltBEqia7gpRqu3bffkG/a6s+J0sQXegTltREqdJjfkxVcxnaPcJOQdgt6D90
        FWxYdC6KuLw8IV1clvydvW7TEmNMsXlhaUfixt+UW64+KtOu7nbmvRw5fi6+7SXz7E5sWlLg
        QVK37qLUHJ1Ct+xsqC38euHmxTHuCf9aKdFati3F33fwatw5Y1pCZXrJk8HRjrH4xKLJFZv/
        eioVnz1vbjbE/Xtj3Zq+zK/+b1HN2yBNjq+vMmpIMVO7/AtCL2rfA/faBcb7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxiH951bD83qjhXCJ0twdll0S6gcLvKyKeqIyUlcCGiWIBtIoydA
        pNT0FASTRQYmFAgqOBYoIpBVExhB5VIFpphqYIVBuUzESy8qCSBDp6TMJag7UJfw3y/v73m+
        N1/ysqR6mQ5hs3JMojFHl61hlNTQ2wF3mOr5Ykq42bceKkYcBBSZF2gosg8y8GOvTQHvbJUk
        /Ol7wcD5mWEE3d4eefZknob6qh+gynOWgvJSMw2z7jEKzjydJ8HpvKKA4aK/FFBaaVVA+9NJ
        Gir7hhUw0XOegYniMQRdc88JeOV9R0KN8yYBTS+7KGjtXwdDly6TUHQqElzu3ym4YW9A8Gza
        R8NM02sSXFfk9TXn5hj44+4tavenws+36hRCXeEYJUycriCENzP3KOG6y4qEG0uNlFC+aCeF
        botLRsy1tNDeUsoIjyZ/Y4RrS15auOBIEjzlA4TQYT0pnHL0UYk4RbvDaMg1iZ9kGiTTTs13
        PERo+VjQRkTFavnImNQvI6I12+J2HBGzs/JE47a4dG3mw7YSdMyzKd9R16goRM6NZSiAxVwU
        tvWYiTKkZNXcRYQd9dWEvwjGvQ0LpD9vwMuTZYwfmke4tfsnZqXYwKXia80t1EoO5Hbh6sm5
        VZnkflXizlm9Xxgl8NBilWKlYLjP8ZuO+6uyiovD1uIGeiVT3Ge43vvLKhPEJWO389V7Zj12
        1E7LC1g2QObd55L872/ByxfGSX/ehIu76t7nYPxguoE4i9SWNbZljWJZo1jWKI2IakGBYq6k
        z9BLvFbS6aXcnAztYYO+HcmXZ+v/t+M6Gr96wI44Fmk+VNUoF1PUtC5PKtDbEWZJTaDq9Yg8
        Uh3RFZwQjYZDxtxsUbKjaPlvlWRI0GGDfMc5pkN8NB8DsXxMZEzkdtAEq5zhBSlqLkNnEo+K
        4jHR+L9HsAEhheijQcKz8I1rdFc/t33vlPlFetgHjP5x6NTtKOXu253MbMHA6b6bzbFJd8oS
        dtpoXzN1p+Ir6/3a+KUEPZXH+L4NDYsv8diyOj1t/3xcUSIkHHiYNq3ac3L/1EvvifT4dYat
        QaFvk7+ubkvjNyv/1o0fj0pM7SPLvz94tDY//9E+9V4NJWXq+C9Io6T7D0yOoj2PAwAA
X-CMS-MailID: 20180510070029eucas1p15acf23b29afdd21901104a85789227d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180510070029eucas1p15acf23b29afdd21901104a85789227d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180504135245epcas4p1d0463b6b3c73d1dd2550c6ed5a4e3986
X-RootMTR: 20180504135245epcas4p1d0463b6b3c73d1dd2550c6ed5a4e3986
References: <20180504135212.26977-1-peda@axentia.se>
        <CGME20180504135245epcas4p1d0463b6b3c73d1dd2550c6ed5a4e3986@epcas4p1.samsung.com>
        <20180504135212.26977-2-peda@axentia.se>
        <4e92fdea-0609-0fff-0e3f-d9f78f596eb7@samsung.com>
        <4be4448e-763c-4832-f194-6b79afe87d08@axentia.se>
        <5abcab35-8a78-a02a-9f22-321da55d9858@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.2018 00:21, Peter Rosin wrote:
> On 2018-05-09 17:53, Peter Rosin wrote:
>> On 2018-05-09 17:08, Andrzej Hajda wrote:
>>> On 04.05.2018 15:51, Peter Rosin wrote:
>>>> Bridge drivers can now (temporarily, in a transition phase) select if
>>>> they want to provide a full owner device or keep just providing an
>>>> of_node.
>>>>
>>>> By providing a full owner device, the bridge drivers no longer need
>>>> to provide an of_node since that node is available via the owner
>>>> device.
>>>>
>>>> When all bridge drivers provide an owner device, that will become
>>>> mandatory and the .of_node member will be removed.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/gpu/drm/drm_bridge.c             | 3 ++-
>>>>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 4 +++-
>>> What is the reason to put rockchip here? Shouldn't be in separate patch?
>> Because the rockchip driver peeks into the bridge struct and all the
>> changes in this patch relate to making the new .odev member optional in
>> the transition phase, when the bridge can have either a new-style odev
>> or an old style of_node.
>>
>> I guess this rockchip change could be patch 2, but it has to come first
>> after this patch and it makes no sense on its own. Hence, one patch.
>>
>> This rockchip_lvds interaction is also present in patch 24/26
>> drm/bridge: remove the .of_node member
>>
>> I can split them if you want, but I personally don't see the point.
> I had a second look, and maybe the series should start with a patch like
> this instead, so that the rockchip_lvds.c hunks can be removed from
> patch 1/26 and 24/26. That would perhaps be slightly cleaner?
>
> On the other hand, it's orthogonal and this series can be left as is
> (with the benefit of me not having to do another iteration and you all
> not having another bunch of messages to sift through). The below
> patch could easily be (adjusted and) applied later instead. Or not,
> since the right fix is to do this with the newfangled static image
> format mechanism from Jacopo Mondi, and it might be easier to just do
> it right.
>
> State your preference.

For me the current version is OK, it maybe lacks explanation why do you
need to touch rockchip, from my PoV it did not seem so obvious.
Somebody should fix rockchip to use Jacopo's approach instead of
violating abstractions, but this is another story.

With or without added missing explanation:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


>
> Cheers,
> Peter
>
> >From dee27b36a36acd271459d1489336b56132097425 Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> Date: Wed, 9 May 2018 23:58:24 +0200
> Subject: [PATCH] drm/rockchip: lvds: do not dig into the DT of remote bridges
>
> The driver is trying to find the needed "data-mapping" for
> interacting with the following bridge in the graphics chain.
> But, doing so is bad since it is done w/o regard of the
> compatible of the remote bridge, so the value of "data-mapping"
> might not mean what this driver assumes. It is also pointless
> since no bridge has any documented "data-mapping" DT property
> and no dts file show any undocumented use.
>
> Just remove the inappropriate code.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 4bd94b167d2c..fa3f4bf9712f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -377,8 +377,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	}
>  	if (lvds->panel)
>  		remote = lvds->panel->dev->of_node;
> -	else
> -		remote = lvds->bridge->of_node;
>  	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
>  		/* default set it as output rgb */
>  		lvds->output = DISPLAY_OUTPUT_RGB;
