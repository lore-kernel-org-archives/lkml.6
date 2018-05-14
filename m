Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeENQ2i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:28:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38915 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753477AbeENQ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:28:33 -0400
X-Google-Smtp-Source: AB8JxZp8ihqXDBOfaj/qcnFkNLWpwLzwIGfaq1yww97ILFHYQ0LHkuxB+8fUkEOqK4N+99nLEJEg8w==
Date: Mon, 14 May 2018 18:28:28 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Peter Rosin <peda@axentia.se>
Cc: Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
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
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 26/26] drm/bridge: establish a link between the bridge
 supplier and consumer
Message-ID: <20180514162828.GE28661@phenom.ffwll.local>
Mail-Followup-To: Peter Rosin <peda@axentia.se>,
        Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
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
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Jyri Sarha <jsarha@ti.com>
References: <20180504135212.26977-1-peda@axentia.se>
 <CGME20180504135432epcas3p368bb7541ca52bc8bc301dec794851214@epcas3p3.samsung.com>
 <20180504135212.26977-27-peda@axentia.se>
 <a723ad4a-8caa-4ff5-d39d-52db98a56d7b@samsung.com>
 <c25f81e0-5b7b-c605-5b58-0ecc88830124@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c25f81e0-5b7b-c605-5b58-0ecc88830124@axentia.se>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 09:37:47AM +0200, Peter Rosin wrote:
> On 2018-05-10 10:10, Andrzej Hajda wrote:
> > On 04.05.2018 15:52, Peter Rosin wrote:
> >> If the bridge supplier is unbound, this will bring the bridge consumer
> >> down along with the bridge. Thus, there will no longer linger any
> >> dangling pointers from the bridge consumer (the drm_device) to some
> >> non-existent bridge supplier.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
> >>  include/drm/drm_bridge.h     |  2 ++
> >>  2 files changed, 20 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> >> index 78d186b6831b..0259f0a3ff27 100644
> >> --- a/drivers/gpu/drm/drm_bridge.c
> >> +++ b/drivers/gpu/drm/drm_bridge.c
> >> @@ -26,6 +26,7 @@
> >>  #include <linux/mutex.h>
> >>  
> >>  #include <drm/drm_bridge.h>
> >> +#include <drm/drm_device.h>
> >>  #include <drm/drm_encoder.h>
> >>  
> >>  #include "drm_crtc_internal.h"
> >> @@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> >>  	if (bridge->dev)
> >>  		return -EBUSY;
> >>  
> >> +	if (encoder->dev->dev != bridge->odev) {
> > 
> > I wonder why device_link_add does not handle this case (self dependency)
> > silently as noop, as it seems to be a correct behavior.
> 
> It's kind-of a silly corner-case though, so perfectly understandable
> that it isn't handled.
> 
> >> +		bridge->link = device_link_add(encoder->dev->dev,
> >> +					       bridge->odev, 0);
> >> +		if (!bridge->link) {
> >> +			dev_err(bridge->odev, "failed to link bridge to %s\n",
> >> +				dev_name(encoder->dev->dev));
> >> +			return -EINVAL;
> >> +		}
> >> +	}
> >> +
> >>  	bridge->dev = encoder->dev;
> >>  	bridge->encoder = encoder;
> >>  
> >>  	if (bridge->funcs->attach) {
> >>  		ret = bridge->funcs->attach(bridge);
> >>  		if (ret < 0) {
> >> +			if (bridge->link)
> >> +				device_link_del(bridge->link);
> >> +			bridge->link = NULL;
> >>  			bridge->dev = NULL;
> >>  			bridge->encoder = NULL;
> >>  			return ret;
> >> @@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
> >>  	if (bridge->funcs->detach)
> >>  		bridge->funcs->detach(bridge);
> >>  
> >> +	if (bridge->link)
> >> +		device_link_del(bridge->link);
> >> +	bridge->link = NULL;
> >> +
> >>  	bridge->dev = NULL;
> >>  }
> >>  
> >> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> >> index b656e505d11e..804189c63a4c 100644
> >> --- a/include/drm/drm_bridge.h
> >> +++ b/include/drm/drm_bridge.h
> >> @@ -261,6 +261,7 @@ struct drm_bridge_timings {
> >>   * @list: to keep track of all added bridges
> >>   * @timings: the timing specification for the bridge, if any (may
> >>   * be NULL)
> >> + * @link: drm consumer <-> bridge supplier
> > 
> > Nitpick: "<->" suggests symmetry, maybe "device link from drm consumer
> > to the bridge" would be better.
> 
> I meant "<->" to indicate that the link is bidirectional, not that the
> relationship is in any way symmetric. I wasn't aware of any implication
> of a symmetric relationship when using "<->", do you have a reference?
> But I guess the different arrow notations in math are somewhat overloaded
> and that someone at some point must have used "<->" to indicate a
> symmetric relationship...

Yeah I agree with Andrzej here, for me <-> implies a symmetric
relationship. Spelling it out like Andrzej suggested sounds like the
better idea.
-Daniel

> 
> > Anyway:
> > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 
> Thanks!
> 
> Cheers,
> Peter
> 
> >  --
> > Regards
> > Andrzej
> > 
> >>   * @funcs: control functions
> >>   * @driver_private: pointer to the bridge driver's internal context
> >>   */
> >> @@ -271,6 +272,7 @@ struct drm_bridge {
> >>  	struct drm_bridge *next;
> >>  	struct list_head list;
> >>  	const struct drm_bridge_timings *timings;
> >> +	struct device_link *link;
> >>  
> >>  	const struct drm_bridge_funcs *funcs;
> >>  	void *driver_private;
> > 
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
