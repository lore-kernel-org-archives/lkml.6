Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeEHGgZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:36:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33436 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbeEHGgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:36:21 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180508063618euoutp016229b69e85e2ea0ce6f863ebc1ea62cd~sl_PlK_P03044130441euoutp01Y
X-AuditID: cbfec7f4-6f9ff700000043e4-7c-5af14561779f
Subject: Re: [PATCH v2 26/26] drm/bridge: establish a link between the
 bridge supplier and consumer
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
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
        Jyri Sarha <jsarha@ti.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <c0835e31-cdfe-e398-5991-f25a556e6e09@samsung.com>
Date: Tue, 8 May 2018 08:36:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507135341.GI12521@phenom.ffwll.local>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH97z3VkpeCkvP2BZct0S3ZTjExSfOsX1g+n4wRhOTkZq4VXmD
        ZBRIa0FcnNgZVwSn1LBhQfHSTYbbYEVu3RhaE7uOS224KG4UBiXlsuIK1mm8sL57NePb75z/
        Oef5/5OHI9VBJpnLzd8jGvP1eVpGSbVeu9/3hv79iO5Ny3QcPtrnJbDFGqaxxf0bgw/+1Mri
        gehtBteGehHuGHOxeHF8lsanbPuxbfQ4hcvLrDSeCvgpfGxilsQ+XxOLey1/sbis0sFi58QQ
        jSu7elnc76plcP9nfoRbpucIPD+2SOJq3y8EPhtpofB31+Jx9zeNJLYcSscjgV8p3OmuQ3gm
        GKVx6Ow9Eo80xZ6vPjHN4J7By9R7WuHLyzWsUFPqp4T+L44SwqPQDUpoH3EgoXzBTQod9pGY
        aj1JC86GMkb4Y+hnRmi7O0YLp71bhdFyDyE0Ow4Ih7xdlNBh6yS2aHTK9dliXm6RaFyV8ZFy
        t2MgwhQ6V+71XA+Qpahn+RGk4IBfA5PlEXQEKTk1X4+g3nmVlIs7CKK+C5RcLCCwfl9DP11p
        mPcQsnABQYfrCisXYQRNUzOxYxyXyItQP5gm9ZP4K0oYP2clpW2GfxUeNQ8zEqv4DLjxj7Ss
        4Cj+FXgwWElI/CyfBZbQfVaeSQDvySAlsYLH0Og9iCQm+RRoC9eSMmvgVrDuP0fANypgwv8t
        JVvNhGOTvxMyJ8KM5xIr8wvQfaLiycwnMDxloeRlK4LRB58zsvA2XPX4aSkNGXPd6FolIfDv
        QFVDsozxcDOcIFuIB1vrV6TcVoH1sFq+8RKM9raQMmvg6+vRJ7cFmL5byR5HWvuSkPYlwexL
        gtn/t3AGUQ1II5pNhhzRtDpfLE416Q0mc35O6q4CgxPF/n73Y8+dduR6uNONeA5p41T3Cv/W
        qWl9kanE4EbAkdok1csvRnRqVba+ZJ9oLPjQaM4TTW70PEdpNaodKz/Vqfkc/R7xY1EsFI1P
        VYJTJJei6odFbWtv7xpf6KrIzlpH1HqTSlybDqR/kLpx7eJwYKe5YFNu2Ubz64GErNCKTG1w
        6HGicvXmuOeC56s6Dc8EVELFXN9YRvuPKemnbtoKtxnq5i6xg38u2zG5gUiZ9/XsJzfM/vBW
        S4FzuDlzKl0VfbeqGIrTzmwfiNya3OcIX1y+QkuZduvTXiONJv2/j7FHuvcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjH855rIas5FpR3xGs1irfK4SIPRsm+bDkmZs4sMVi3QKNHSqQt
        62mNNVEB/UBBHZdlasUiEZk2GLAqtHhvIl1V1iEWNyOVDTZUrAqoaESxpZrw7Zf8/788z5M8
        MlIRohNl+XqTaNRrCpRMLHXrgze4LPfrIXXyXydi4MAfPgJKSkM0lHhuMlB8sYWFu6+eM1Az
        0IHA3dvGwvi/gzQcq9oFVQ8rKCi3ltLwKNhJwc99gyT4/c0sdJQ8ZcFaWc+Cs6+bhsqrHSx0
        tdUw0LW3E8GFx88IGO4dJ+Gw/woBdUMXKGhsnwK3GppIKNmXCj3B3ym47KlF8KT/FQ0DdW9I
        6GkOjz9c/ZiB24Fr1FdK4ddrR1nhaFEnJXQdPEAI7wfuUYKrpx4J5SMeUnDbesJp6RFacDqs
        jPCg+xIjtL7upQW7b73wsNxLCOfq9wj7fFcpwV11mfguQa1aZTSYTeIcrUEyrVZu4iFFxWeC
        KiUtU8WnZvy4MiVduTxr1RaxIH+7aFyelavS1t8dYgqdSTu8fwbJInR7ThmKkWEuDTuGvUQZ
        ipUpuJMI///ETkWDBHyxNkRGOQ6PdZcx0dIgwjdOn5wI4jgRt4+cRZEgnvPG4t9eBtlo6xCB
        7dV3mEiL4Rbh9+f+nmA5l4XvjV5nI0xx8/G7QCUR4WlcNg76hz91pmLfkf6JNWI4wE2+YhRh
        kluIx+x3yCjPxq2hmk+cgO/31xIVaKptkm6bpNgmKbZJynFEOVC8aJZ0eTopRSVpdJJZn6fa
        bNA5UfjVWtrfnnehsmffexAnQ8ov5G8KX6gVtGa7ZNF5EJaRynj5vJlDaoV8i8ayUzQacozm
        AlHyoPTwcZVk4rTNhvDj6k05fDqfAZl8RmpG6gpQJsj9yRa1gsvTmMRtolgoGj97hCwmsQhl
        jqlzXc0+u2W1fsA2Up39g2vpiWT3toXdSb/MG6QUbbkL5t7c7UhqsTQ++Mc+Y2sc/1+rfB0/
        vStw3BrYeH9NvmlZb866hqw057EbP800H+zbudFUW9GRbRd3F5+i1365f1Z6tXb/htHp1uHX
        o4FvYl9iR5NLW/Dt+JI6d0hzZrZeSUlaDb+YNEqaj7fCrEOAAwAA
X-CMS-MailID: 20180508063616eucas1p1bfc54e19e3f387028d4d9f6888bc4180
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180508063616eucas1p1bfc54e19e3f387028d4d9f6888bc4180
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1
X-RootMTR: 20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1
References: <20180504135212.26977-1-peda@axentia.se>
        <CGME20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1@epcas3p2.samsung.com>
        <20180504135212.26977-27-peda@axentia.se>
        <4cdcd215-8caf-e045-a478-f438f128c9f2@samsung.com>
        <20180507135341.GI12521@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.05.2018 15:53, Daniel Vetter wrote:
> On Mon, May 07, 2018 at 02:59:45PM +0200, Andrzej Hajda wrote:
>> On 04.05.2018 15:52, Peter Rosin wrote:
>>> If the bridge supplier is unbound, this will bring the bridge consumer
>>> down along with the bridge. Thus, there will no longer linger any
>>> dangling pointers from the bridge consumer (the drm_device) to some
>>> non-existent bridge supplier.
>> I understand rationales behind this patch, but it is another step into
>> making drm_dev one big driver with subcomponents, where drm will work
>> only if every subcomponent is working/loaded. Do we need to go this way?
>> In case of many platforms such approach results in display turned on
>> very late on boot for example due to late initialization of some
>> regulator exposed by some i2c device, which is used by hdmi bridge. And
>> this hdmi bridge is just to provide alternative(rarely used) display
>> path, the main display path would work anyway.
>>
>> So the main question to drm maintainers is about evolution of bridges,
>> if drm_bridges should become mandatory components of drm device or they
>> could be added/removed dynamically?
> This is already the case. You currently cannot hotplug a drm_bridge,
> everything must be present.

Are you sure? DRM core is changing quite fast, so maybe I have missed
something, but AFAIK core calls bridge code only if full display
pipeline is created and connector is in connected state.
So adding and removing bridges from inactive pipelines should work if
coded properly.

>  I don't think it makes sense to change that
> until we have physically hotpluggable drm_bridges in real hardware.

But kernel core already assumes that device drivers are hot-pluggable
:), even this patch is created to solve issues regarding driver hot
unplugging.

>  I
> definitely don't want to refcount stuff to work around driver load
> bonghits on DT platforms, because refcounting is way too hard to get right
> :-)

I am not sure about bridges, but I have successfully (IMO) experimented
with hot (un)plugging panel driver, see panel-samsung-s6e8aa0.c driver
and exynos_drm_dsi.c, panel driver can be safely
plugged/unplugged/replugged without any refcounting (but with help of
mipi_dsi attach/detach callbacks, which are not available for
non-mipi-dsi drivers).

Regards
Andrzej

>
> Afaik there's out-of-tree patches to solve 99% of the driver load fun on
> DT platforms, but because it's not a 100% solution it's blocked since
> forever.
> -Daniel
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
