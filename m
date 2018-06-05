Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbeFEIZk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:25:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49554 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeFEIZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:25:38 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180605082534euoutp022be2d798a8f287164e0349970f011b38~1Nho6v13n2334923349euoutp02S
X-AuditID: cbfec7f2-1dbff70000011644-f8-5b1648fdbca0
Subject: Re: [PATCH] drm/vc4: Enable the DSI module and link before other
 enables.
To: Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc: Kevin Quigley <kevin@kquigley.co.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org,
        James Hughes <james.hughes@raspberrypi.org>,
        Archit Taneja <architt@codeaurora.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Tue, 5 Jun 2018 10:25:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604194437.13790-1-eric@anholt.net>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87p/PcSiDeY9VbBo6njLarHvVD+L
        xZWv79ksDjReZrTY/P0Bq8XNd0/YLC7vmsPmwO7R9P4Ym8e8NdUel/t6mTzW9K5j87jffZzJ
        4+DJbkaPz5vkAtijuGxSUnMyy1KL9O0SuDK6m4oLXmpUbHsQ28D4RrGLkZNDQsBE4s6tBexd
        jFwcQgIrGCVu3PnHBuF8YZS4cGoyK4TzmVHi+/FHrDAtxxbNZIFILGeUmDX3KFTLW6CWVQfY
        QaqEBUIkptzexQJiiwg4SXzcsI8JpIhZ4ByjRNOC72wgCTYBTYm/m2+C2SwCKhKr1y9lBLFF
        BSIkNk74xAxi8woISpyc+QRsEKeAqcS7x1PB6pkF5CW2v53DDGGLS9x6Mh9sgYTAPnaJXz2P
        2CCayySuzpsPdbeLxO4fIEUgtrDEq+Nb2CFsGYnTk3tYIOxiiU9TG6AGNTBKzF5+EiphLXH4
        +EWgQRxA2zQl1u/Shwg7Shy70s8OEpYQ4JO48VYQ4h4+iUnbpjNDhHklOtqEIKoVJe6f3coM
        YYtLLL3wlW0Co9IsJF/OQvLZLCSfzULYu4CRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7u
        JkZgUjr97/inHYxfLyUdYhTgYFTi4dWwEo0WYk0sK67MPcQowcGsJMLL4y4WLcSbklhZlVqU
        H19UmpNafIhRmoNFSZw3TqMuSkggPbEkNTs1tSC1CCbLxMEp1cAoPlNqEZdrRc+PzU2KM4Me
        PzlQHHHgV5nycaM1DCuebjLznbStMGXe7Rs83hs2185++nV5alv9n8Br/mLOjxe/37ivdep7
        EfFtp831Pr54bXX4q88npdYVj/it1h9zC0q5aXLqwCOp85keGxyiYqwq3XTrnlmFrb3YcbT3
        muzeGD632v7dRxoFlViKMxINtZiLihMBHpZxHEYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7p/PMSiDVZd0LBo6njLarHvVD+L
        xZWv79ksDjReZrTY/P0Bq8XNd0/YLC7vmsPmwO7R9P4Ym8e8NdUel/t6mTzW9K5j87jffZzJ
        4+DJbkaPz5vkAtij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMy
        y1KL9O0S9DK6m4oLXmpUbHsQ28D4RrGLkZNDQsBE4tiimSxdjFwcQgJLGSW+7PrABpEQl9g9
        /y0zhC0s8edaFxtE0WtGiUWHN4EVCQuESEy5vYsFxBYRcJL4uGEfE0gRs8AFRoneLSsYITo6
        GCUOnHjBClLFJqAp8XfzTbBuXgE7ibc9K9hBbBYBFYnV65cygtiiAhESTfPWsEPUCEqcnPkE
        bAOngKnEu8dTwXqZBdQl/sy7xAxhy0tsfzsHyhaXuPVkPtMERqFZSNpnIWmZhaRlFpKWBYws
        qxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjcNuxn5t3MF7aGHyIUYCDUYmHV8NKNFqINbGs
        uDL3EKMEB7OSCC+Pu1i0EG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDU0ReSbyhqaG5haWh
        ubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQZGuRkdPXnZU1Zf/5t6Ru7Q04QqrYr+
        CaKMS1Rjoi5f/1PJWRthtC3r34dNM2wb48J+Jlk5nep/rzXnz4qV1i61Z3I+TShecI61uj/X
        Vf+G0LJfbg8ESh6xTuyWUJ0uecrUemul/151tnYRsdPLw1/wWd4xZtS9dqvdS+JjYeWmD0eK
        t18UaGpQYinOSDTUYi4qTgQAspSBk9kCAAA=
Message-Id: <20180605082532eucas1p21328ec5bea7d588c81480829f862bdfd~1NhnMydDJ0562405624eucas1p2l@eucas1p2.samsung.com>
X-CMS-MailID: 20180605082532eucas1p21328ec5bea7d588c81480829f862bdfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180604194448epcas1p29627759e2d8c0b1388c6700a7da77a45
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604194448epcas1p29627759e2d8c0b1388c6700a7da77a45
References: <CGME20180604194448epcas1p29627759e2d8c0b1388c6700a7da77a45@epcas1p2.samsung.com>
        <20180604194437.13790-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.2018 21:44, Eric Anholt wrote:
> We want the DSI PHY to be enabled and the DSI module clocked before a
> panel or bridge's prepare() function, since most DSI panel drivers
> with a prepare() hook are doing DCS transactions inside of them.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: Kevin Quigley <kevin@kquigley.co.uk>
> Cc: James Hughes <james.hughes@raspberrypi.org>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>
> I'm not sure it makes sense to enable CRTCs before encoders on vc4 at
> all.  Why start scanning pixels before the encoder is ready to hear
> about VSTART?  However, this patch will hopefully unblock people
> trying to attach other panels to rpi

But this patch is about enabling encoder before panel/bridge prepare. Or
am I missing something.
Anyway I would be more precise here, MIPI-DSI bus is used for two things:
- control bus - accessing DSI device (configuration/detection,...),
- video data bus - sending video stream.

I suspect in prepare/pre_enable phase of DSI panel/bridge only control
bus should be functional, video stream transfer does not make sense.
So the best solution (I guess) would be to split DSI-encoder enable
sequence into control bus enable and video transfer enable parts and
call the former before 1st transfer request from device and the latter
in encoder enable callback. Of course there will be a problem then with
disabling sequence, ie stopping video stream should be performed in
encoder's disable, but when we should disable control bus? If we do it
in encoder's disable callback we could not perform transfers in
post_disable cb of the bridge - in most cases (maybe all currently
present in kernel) it will work, but it does not look ideal.
All this recalls me discussion that hardwiring bridge callbacks into drm
core is problematic and maybe it would be better to call downstream
callbacks explicitly from upstream element - the callback order should
depend on the local bus protocol, and should not be fixed in drm core.

Regards
Andrzej

>
>  drivers/gpu/drm/vc4/vc4_drv.h |  1 +
>  drivers/gpu/drm/vc4/vc4_dsi.c |  3 +--
>  drivers/gpu/drm/vc4/vc4_kms.c | 25 +++++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 554a4e810d5b..e7d7bfc75acd 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -711,6 +711,7 @@ int vc4_dpi_debugfs_regs(struct seq_file *m, void *unused);
>  /* vc4_dsi.c */
>  extern struct platform_driver vc4_dsi_driver;
>  int vc4_dsi_debugfs_regs(struct seq_file *m, void *unused);
> +void vc4_dsi_prepare(struct drm_encoder *encoder);
>  
>  /* vc4_fence.c */
>  extern const struct dma_fence_ops vc4_fence_ops;
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 8aa897835118..88471731e066 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -875,7 +875,7 @@ static bool vc4_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
>  	return true;
>  }
>  
> -static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
> +void vc4_dsi_prepare(struct drm_encoder *encoder)
>  {
>  	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
>  	struct vc4_dsi_encoder *vc4_encoder = to_vc4_dsi_encoder(encoder);
> @@ -1345,7 +1345,6 @@ static const struct mipi_dsi_host_ops vc4_dsi_host_ops = {
>  
>  static const struct drm_encoder_helper_funcs vc4_dsi_encoder_helper_funcs = {
>  	.disable = vc4_dsi_encoder_disable,
> -	.enable = vc4_dsi_encoder_enable,
>  	.mode_fixup = vc4_dsi_encoder_mode_fixup,
>  };
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index 8a411e5f8776..7e9b52ba3448 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -140,6 +140,9 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
>  {
>  	struct drm_device *dev = state->dev;
>  	struct vc4_dev *vc4 = to_vc4_dev(dev);
> +	struct drm_connector *connector;
> +	struct drm_connector_state *new_conn_state;
> +	int i;
>  
>  	drm_atomic_helper_wait_for_fences(dev, state, false);
>  
> @@ -151,6 +154,28 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
>  
>  	drm_atomic_helper_commit_planes(dev, state, 0);
>  
> +	/* Enable DSI link. */
> +	for_each_new_connector_in_state(state, connector, new_conn_state, i) {
> +		struct drm_encoder *encoder;
> +		struct vc4_encoder *vc4_encoder;
> +
> +		if (!new_conn_state->best_encoder)
> +			continue;
> +
> +		if (!new_conn_state->crtc->state->active ||
> +		    !drm_atomic_crtc_needs_modeset(new_conn_state->crtc->state))
> +			continue;
> +
> +		(void)connector;
> +		encoder = new_conn_state->best_encoder;
> +		vc4_encoder = to_vc4_encoder(encoder);
> +
> +		if (vc4_encoder->type == VC4_ENCODER_TYPE_DSI0 ||
> +		    vc4_encoder->type == VC4_ENCODER_TYPE_DSI1) {
> +			vc4_dsi_prepare(encoder);
> +		}
> +	}
> +
>  	drm_atomic_helper_commit_modeset_enables(dev, state);
>  
>  	/* Make sure that drm_atomic_helper_wait_for_vblanks()
