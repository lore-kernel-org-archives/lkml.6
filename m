Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754786AbeEHJDa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:03:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42416 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754232AbeEHJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:03:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180508090320euoutp0259cc0bcbbe4bfc1c040c965abc8e926e~sn_nfo2SO0136601366euoutp02a
X-AuditID: cbfec7f5-f95739c0000028a9-fc-5af167d7bf94
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
Message-ID: <4284b38f-2c1e-1abd-8a0f-b3b6c90ceeed@samsung.com>
Date: Tue, 8 May 2018 11:03:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9751c1c5-f2fa-f24e-64f3-71019f253332@axentia.se>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjOuefcD6oll+sHJ042Lc7gEmWoS07iVH7sx/2xz2w/tEvQKjdV
        x1d6Bcc2J+uctDCdIJu0FGsjonNLIHQg1EFNTcoKMtYhKDigG2QUtSqTOpAx1svVjH/P+7zP
        c57nTQ4HhTCzgtufc1Ay5RiydIwGNfmnu9ffNE7oXx5wJ5HjPwcoYrZEaGL2dTDksytNLJlr
        KoPkRvQBQxxjXYC0hDwx7o+7NKkuP0zKh08iUmq10CQ8FETkq5G7kHR317Oky3yPJdayGpY0
        jPTRpMzbxZIej4MhPZ8HAWkcv0+Rv0JzkFR2t1HENdGIyPf+eNJZWweJ+egmMjj0EyKtPicg
        d0ajNBlzTUEyWB+Lrzw1zpDrvVdRerL4zdUqVqwqCiKx58RxSpwdu4nE5sEaILY+PovE0kc+
        KLbYB2MSi40WGy5ZGfG3vh8Z8fLjEC2eCbwjDpe2U6K75oh4NOBFb2O95tVMKWt/gWRK3bZb
        s++LiWo6z77uQ9+TOqoI9K8qAXEc5jdjx5k/QQnQcAJ/EeCAuZVSh0mAb7S4aUUl8I8Ado2/
        8czReWIGqaILAJ+vcLPqEAG4uT4Ss3PcEl7CF3vTFMNSfjv+um98/lXIn9Ngf/EoqywYfh2e
        dfczCtby27AzcgoqXsSvwR7/mwq9jN+BzWPTrCpJwAHbKFJwXEzueXJsvhzkX8CXIw6o4kQ8
        MOqcz8K8Nw6XWesYtfVruPPh35SKl+A77T+wKl6J51qcT/mPcX/YjFSzBeDhmeKn5i34WnuQ
        VsrBWOk6T6pKb8U1bS6g0JiPx7ciCWqHeFzedBqqtBZbjgmqejUe7mqEKk7E53+JMidBsn3B
        ZfYF19gXXGP/P/csQJdAopQvZxsleVOOdGiDbMiW83OMG/bmZjeA2P/v/Lc92gza/tnjAzwH
        dIu1U3kP9QJtKJALs30Ac1C3VJucNKEXtJmGwo8kU+4uU36WJPvAcxzSJWozUj7VC7zRcFD6
        QJLyJNOzLcXFrSgCi2jr1hdHbIcmt/96wPigo9q7p+q0N32oduY91uEs35W7SmbDsCKlwDcy
        kNnTcLu6yh+u/K43LX1qjaUiGCp0J3SsvCXMLp8u+PLw7i1vuZo/qbcWl6QOlZwLGTI27rSt
        /Tbl9WvP2y78vpaJJk2uP6BZzbz/7iv3lqdmZQhFtQNzi3VI3mdIewmaZMN/52BLzPsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxiHc+5Xb5k114rpCcmmqSZMjZWCwIth1WTJcpYZP7Il22oWrXBT
        3GhL7i1GnFMsbKFFUSQYKR/VhWnicDoQlCJCalJkDBtkdkEtECFBBqjVCAo4LVQT/nvyO7/n
        fXOSl6fVs2wcv9dqFyWrKVvLxTBd/3eE1gXNYWNC6NxyOHa7kwJH0QQLDt9fHBxpaVLAm6ZS
        Gv558YSDqpFuBM2D3kj2cIyF6pM/wcmBEwwUO4tYeNTfw8DxoTEaAoHLCuh2jCvAWVqrgPqh
        IAulbd0K6PVWcdBb0IOgcfQxBc8G39BwOnCDgrPhRgbq/Iuh69wlGhyFSRDqv8VAq8+D4L/h
        FyyMnH1JQ+hyZP3pslEO/r7bzmxeSU61VypIZX4PQ3pLjlHk9ci/DLkWqkWkdfIMQ4qf+2jS
        7A5FKkUVLKm/4OTIg+B1jlydHGRJTecOMlDcQZGG2sOksLON2Y6NunTJlmsXV2TZZPsn2p16
        SNTp00CXuCFNp09K/W5jYrJ2vSE9U8zeu0+U1ht267J+DlezOe7V+33Tl6h81LfChZQ8Fjbg
        rpIZxoVieLXwG8Ke8QIm+qDBLZ4JOspL8WzQxUVLYwg31dTNl5YKIvY//xPNcaywCZcHR6k5
        poXfY/CVR5aoUE3hof7C+UmcsBq/bujj5lglGLBnoiyS8zwjrMJe/9a5eJnwDe4PPHtXWYI7
        K4bndykjde/0L2x0fjyerblDR3k5vjpR9Y41+N6whzqB1O4FunuB4l6guBcoZxBzAcWKubLF
        bJETdbLJIudazboMm6UeRS6vyf/qyjXkevylDwk80i5Svcx5alSzpn1ynsWHME9rY1UrPwwb
        1apMU94BUbLtknKzRdmHkiN/K6XjlmXYIndste/SJ+tTIU2fmpSalAJajSqQkGdUC2aTXfxB
        FHNE6b1H8cq4fOTd/umvX1AftI5npq8jW1+Vf69v/DFnz8zBjz0PPzpcrqlYvMVQFi75TGnN
        3qh1TV2vM0ufrz2q6VuyZjDDbpDK2IsJf/jvMsr95J6NchnGbh2oyi/6etHooYGvjE+mpuPK
        nSm1sc6nTsf9hovfBg7FO6G5sf2I76CBO99yfltKzU0tI2eZ9GtoSTa9BcnTQ9CPAwAA
X-CMS-MailID: 20180508090318eucas1p143626115dee65f196a598affd6c312ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180508090318eucas1p143626115dee65f196a598affd6c312ca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1
X-RootMTR: 20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1
References: <20180504135212.26977-1-peda@axentia.se>
        <CGME20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1@epcas3p2.samsung.com>
        <20180504135212.26977-27-peda@axentia.se>
        <4cdcd215-8caf-e045-a478-f438f128c9f2@samsung.com>
        <9751c1c5-f2fa-f24e-64f3-71019f253332@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.05.2018 15:43, Peter Rosin wrote:
> On 2018-05-07 14:59, Andrzej Hajda wrote:
>> On 04.05.2018 15:52, Peter Rosin wrote:
>>> If the bridge supplier is unbound, this will bring the bridge consumer
>>> down along with the bridge. Thus, there will no longer linger any
>>> dangling pointers from the bridge consumer (the drm_device) to some
>>> non-existent bridge supplier.
>> I understand rationales behind this patch, but it is another step into
>> making drm_dev one big driver with subcomponents, where drm will work
>> only if every subcomponent is working/loaded.
> The step is very small IMHO. Just a device-link, which is very easy to
> remove once whatever other solution is ready.
>
>>                                               Do we need to go this way?
> If the drivers expect the parts to be there, and there is no other safety
> net in place if they are not, what is the (short-term) alternative?
>
>> In case of many platforms such approach results in display turned on
>> very late on boot for example due to late initialization of some
>> regulator exposed by some i2c device, which is used by hdmi bridge. And
>> this hdmi bridge is just to provide alternative(rarely used) display
>> path, the main display path would work anyway.
> This patch does not contribute to any late init and any such delay is not
> affected by this. At all.
>
>> So the main question to drm maintainers is about evolution of bridges,
>> if drm_bridges should become mandatory components of drm device or they
>> could be added/removed dynamically?
> That is a much bigger question than this patch/series. Conflating the
> two is not fair IMHO. You could run this very same argument for every
> driver that gets added, since any additional driver will just make it
> harder to make everything dynamic. Should we stop development right
> away?
>
> Besides, as long as the drm devices are in fact acting as big static
> drivers (built from smaller parts), 

not true

> this should be considered a bug-fix
> that will prevent dereference of stale pointers.
>
> Or will some other solution appear and magically make all bridges and
> drm drivers capable of dynamic reconfiguration in the next few weeks?
> Yeah, right...

You are not changing single driver, you are changing framework and it
affects all the drivers using it, being more cautious about such patches
seems quite natural.

Anyway, I have realized that since drm_bridge_detach will remove the
link, so with properly written dynamic bridge removal, your patch should
not be a blocker.

Regards
Andrzej

>
> Cheers,
> Peter
>
>> Regards
>> Andrzej
>>
>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> ---
>>>  drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
>>>  include/drm/drm_bridge.h     |  2 ++
>>>  2 files changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>>> index 78d186b6831b..0259f0a3ff27 100644
>>> --- a/drivers/gpu/drm/drm_bridge.c
>>> +++ b/drivers/gpu/drm/drm_bridge.c
>>> @@ -26,6 +26,7 @@
>>>  #include <linux/mutex.h>
>>>  
>>>  #include <drm/drm_bridge.h>
>>> +#include <drm/drm_device.h>
>>>  #include <drm/drm_encoder.h>
>>>  
>>>  #include "drm_crtc_internal.h"
>>> @@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>>>  	if (bridge->dev)
>>>  		return -EBUSY;
>>>  
>>> +	if (encoder->dev->dev != bridge->odev) {
>>> +		bridge->link = device_link_add(encoder->dev->dev,
>>> +					       bridge->odev, 0);
>>> +		if (!bridge->link) {
>>> +			dev_err(bridge->odev, "failed to link bridge to %s\n",
>>> +				dev_name(encoder->dev->dev));
>>> +			return -EINVAL;
>>> +		}
>>> +	}
>>> +
>>>  	bridge->dev = encoder->dev;
>>>  	bridge->encoder = encoder;
>>>  
>>>  	if (bridge->funcs->attach) {
>>>  		ret = bridge->funcs->attach(bridge);
>>>  		if (ret < 0) {
>>> +			if (bridge->link)
>>> +				device_link_del(bridge->link);
>>> +			bridge->link = NULL;
>>>  			bridge->dev = NULL;
>>>  			bridge->encoder = NULL;
>>>  			return ret;
>>> @@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>>>  	if (bridge->funcs->detach)
>>>  		bridge->funcs->detach(bridge);
>>>  
>>> +	if (bridge->link)
>>> +		device_link_del(bridge->link);
>>> +	bridge->link = NULL;
>>> +
>>>  	bridge->dev = NULL;
>>>  }
>>>  
>>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>>> index b656e505d11e..804189c63a4c 100644
>>> --- a/include/drm/drm_bridge.h
>>> +++ b/include/drm/drm_bridge.h
>>> @@ -261,6 +261,7 @@ struct drm_bridge_timings {
>>>   * @list: to keep track of all added bridges
>>>   * @timings: the timing specification for the bridge, if any (may
>>>   * be NULL)
>>> + * @link: drm consumer <-> bridge supplier
>>>   * @funcs: control functions
>>>   * @driver_private: pointer to the bridge driver's internal context
>>>   */
>>> @@ -271,6 +272,7 @@ struct drm_bridge {
>>>  	struct drm_bridge *next;
>>>  	struct list_head list;
>>>  	const struct drm_bridge_timings *timings;
>>> +	struct device_link *link;
>>>  
>>>  	const struct drm_bridge_funcs *funcs;
>>>  	void *driver_private;
>>
>
>
>
