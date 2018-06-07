Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2nrHFNb8GFvoFAAAmS7hNA
	; Thu, 07 Jun 2018 09:37:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D103A606DD; Thu,  7 Jun 2018 09:37:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DrEj/pSl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0E4AE602FC;
	Thu,  7 Jun 2018 09:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E4AE602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeFGJhZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:37:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43611 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeFGJhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:37:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180607093720euoutp01d6ab7ad0340e5c62a7a29c447917f575~11y3epRnD0501805018euoutp01M
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 09:37:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180607093720euoutp01d6ab7ad0340e5c62a7a29c447917f575~11y3epRnD0501805018euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528364240;
        bh=ssLWmLYkLpd9VSPV8WjfwUcPxOf2Ef2+o7M961TC5nE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DrEj/pSlVdYPceHbfxwso3sOdaSEzEz39qU+YotxXK0RiBqZSxlyZ0QYja9E3fpVa
         OtGp2ZHN2y/Qs/VjutnIm3CPd7t1jqQ2Wv6uqT4HNo+2icPVgiIy58c5bIcLxiw4Oy
         Ii5apcnvRGES5RzJnj7buwPxAM9frDcvou+XeaLs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180607093719eucas1p1ffffd535761947085716fbf0b5ddf620~11y2uFXOG3079730797eucas1p1Z;
        Thu,  7 Jun 2018 09:37:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F7.1C.05700.FCCF81B5; Thu,  7
        Jun 2018 10:37:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180607093718eucas1p2b4661411d63639afab493e6098dc8f26~11y1kzGTK3005330053eucas1p2O;
        Thu,  7 Jun 2018 09:37:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180607093718eusmtrp2c8a83facafa9afb478c965c58f7744cb~11y1WFFlJ2113621136eusmtrp2M;
        Thu,  7 Jun 2018 09:37:18 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-ca-5b18fccfbb90
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.1F.04183.ECCF81B5; Thu,  7
        Jun 2018 10:37:18 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180607093718eusmtip2bf75e811fd3534b5c998ce18eb6dc41d~11y1Gi2lR0052700527eusmtip2v;
        Thu,  7 Jun 2018 09:37:17 +0000 (GMT)
Subject: Re: [PATCH 2/3] drm/bridge: Allow DSI encoders to decide when to
 call bridge funcs.
To: Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Thu, 7 Jun 2018 11:37:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606190431.1833-2-eric@anholt.net>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7rn/0hEGxxYK2fR1PGW1eLK1/ds
        FgcaLzNadE5cwm5xedccNgdWj6b3x9g8Lvf1MnnM7pjJ6nG/+ziTx+dNcgGsUVw2Kak5mWWp
        Rfp2CVwZk6cvZyuYaFHxsGESYwPjIt0uRk4OCQETiV1z5rN1MXJxCAmsYJSYu/IVE4TzhVHi
        3/a/zBDOZ0aJbX8XMcO0HOueB5VYzihxanEbVMtbRolP1x6ygFQJC8RJXJrXCVYlIrCEUeJS
        w0tWkASzgILEr3ubwGw2AU2Jv5tvsoHYLAIqEl86jzOC2KICERIbJ3wCW8crIChxcuYTsKGc
        QKuf3b8JNUdeYvvbOcwQtrjErSfzwa6QEFjELjHn3DOo5jKJqZ87WCHudpG4cvgPG4QtLPHq
        +BZ2CFtG4v9OkGYQu16iaeYVZohBHYwSJxYvh2qwljh8/CLQIA6gbZoS63fpQ4QdJdrWr2cG
        CUsI8EnceCsIcQ+fxKRt06HCvBIdbUIQ1YoS989uhYaiuMTSC1/ZJjAqzULy5Swkn81C8tks
        hL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBKac0/+Of9rB+PVS0iFGAQ5GJR7e
        Gw/Fo4VYE8uKK3MPMUpwMCuJ8CZeEosW4k1JrKxKLcqPLyrNSS0+xCjNwaIkzhunURclJJCe
        WJKanZpakFoEk2Xi4JRqYOS5ua2Z96K+z+3Dv0MFf0Sb/V3x46uucqPB9sw/iSV1X8znxhn5
        WAmVHktfFLq3n6cr6ttNPflF5U53Nta+368u5P/Yb0n1nX2l3TGPPZxuLfjwbapP2i6OPRGL
        e25bPv+bnREj9nZPiARPp3bxwp7QLSo9y95yrtCbYB3eUpu3K/Lhb3ebJUosxRmJhlrMRcWJ
        AFQbG6g1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7rn/khEG0xaKGDR1PGW1eLK1/ds
        FgcaLzNadE5cwm5xedccNgdWj6b3x9g8Lvf1MnnM7pjJ6nG/+ziTx+dNcgGsUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZk6cvZyuYaFHxsGES
        YwPjIt0uRk4OCQETiWPd85i7GLk4hASWMkosvtnIBJEQl9g9/y0zhC0s8edaFxtE0WtGib5V
        Z1hBEsICcRK7ru0ES4gILGGUWNHcAdbNLKAg8eveJlaIjo2MElNuP2cBSbAJaEr83XyTDcTm
        FbCT+P/wCFgDi4CKxJfO44wgtqhAhETTvDXsEDWCEidnPgHr5QS69dn9m6wQC9Ql/sy7xAxh
        y0tsfzsHyhaXuPVkPtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS
        83M3MQKjbNuxn1t2MHa9Cz7EKMDBqMTDe+OheLQQa2JZcWXuIUYJDmYlEd7ES2LRQrwpiZVV
        qUX58UWlOanFhxhNgZ6byCwlmpwPTAB5JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNT
        UwtSi2D6mDg4pRoYLZdElH6euV3+Ml+E2ITGnPePnxpb14ft8QsQjRFSPOScVbCx2KX5orRj
        66V/luKR/grv39mlhG+RKMk1DNt688JZ7rOH7sa9jV15rPzg7hJW1mM/fKbyxekXZTvVTEub
        XblD/iy/j0LGynPWTAp/Q+63fjSbI3NwwtPGfaohLu3mFz+emiKrxFKckWioxVxUnAgAfkzo
        M8gCAAA=
Message-Id: <20180607093718eucas1p2b4661411d63639afab493e6098dc8f26~11y1kzGTK3005330053eucas1p2O@eucas1p2.samsung.com>
X-CMS-MailID: 20180607093718eucas1p2b4661411d63639afab493e6098dc8f26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180606190437epcas1p3c33d51471a16b8a047c175a0cd3f8869
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180606190437epcas1p3c33d51471a16b8a047c175a0cd3f8869
References: <20180606190431.1833-1-eric@anholt.net>
        <CGME20180606190437epcas1p3c33d51471a16b8a047c175a0cd3f8869@epcas1p3.samsung.com>
        <20180606190431.1833-2-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.2018 21:04, Eric Anholt wrote:
> For DSI, we want to pre_enable once the DSI link is up but before
> video packets are being sent, and similarly we want to be able to
> post_disable while the link is still up but after video has stopped.
>
> Given that with drm_panels we've had issues with drivers missing calls
> to one of the hooks, include some checks in the atomic helpers that
> the driver got it right.

There is no explicit description of disable_midlayer_calls.

Anyway I have few general comments I put them here to simplify discussion:
1. disable_midlayer_calls is used only by drm core on only 1st bridge in
the chain, in such case the flag should be placed rather in drm_encoder.
On the other hand to support this case it would be enough to use private
drm_bridge pointer instead of drm_encoder->bridge. I guess it should be
enough to solve your case.
2. Similar issue can appear not only between encoder->bridge pair, but
also in bridge->bridge pair (for longer display chains), it would be
good to cover such case, so maybe instead of disable_midlayer_calls
there should be flag disable_recursive_calls/disable_chain_calls in
drm_bridge, but again it can be solved also by not using
drm_bridge->next member.
3. There are 4 bools to control state machine of the bridge (it makes 16
possibilities, most of them is invalid), but it has only 3 states: off,
prepared, enabled. I think it would be clearer if we define
enum with these three states and use it.
4. WARN in atomics checks only 1st bridge in the chain, in most cases it
is enough but in case of longer chains it will not check next
bridges/panels - this is definitely only partial solution, maybe
skipping it wouldn't be bad idea, but it is just my suggestion.

Regards
Andrzej

>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 32 +++++++++++++++++++++++++----
>  drivers/gpu/drm/drm_bridge.c        | 12 +++++++++++
>  include/drm/drm_bridge.h            | 21 +++++++++++++++++++
>  3 files changed, 61 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 130da5195f3b..2950ddcc9013 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -950,7 +950,13 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  		 * Each encoder has at most one connector (since we always steal
>  		 * it away), so we won't call disable hooks twice.
>  		 */
> -		drm_bridge_disable(encoder->bridge);
> +		if (encoder->bridge) {
> +			encoder->bridge->post_disable_called = false;
> +			encoder->bridge->disable_called = false;
> +
> +			if (!encoder->bridge->disable_midlayer_calls)
> +				drm_bridge_disable(encoder->bridge);
> +		}
>  
>  		/* Right function depends upon target state. */
>  		if (funcs) {
> @@ -962,7 +968,13 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  				funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
>  		}
>  
> -		drm_bridge_post_disable(encoder->bridge);
> +		if (encoder->bridge) {
> +			if (!encoder->bridge->disable_midlayer_calls)
> +				drm_bridge_post_disable(encoder->bridge);
> +
> +			WARN_ON(!encoder->bridge->post_disable_called);
> +			WARN_ON(!encoder->bridge->disable_called);
> +		}
>  	}
>  
>  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> @@ -1240,7 +1252,13 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  		 * Each encoder has at most one connector (since we always steal
>  		 * it away), so we won't call enable hooks twice.
>  		 */
> -		drm_bridge_pre_enable(encoder->bridge);
> +		if (encoder->bridge) {
> +			encoder->bridge->pre_enable_called = false;
> +			encoder->bridge->enable_called = false;
> +
> +			if (!encoder->bridge->disable_midlayer_calls)
> +				drm_bridge_pre_enable(encoder->bridge);
> +		}
>  
>  		if (funcs) {
>  			if (funcs->enable)
> @@ -1249,7 +1267,13 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  				funcs->commit(encoder);
>  		}
>  
> -		drm_bridge_enable(encoder->bridge);
> +		if (encoder->bridge) {
> +			if (!encoder->bridge->disable_midlayer_calls)
> +				drm_bridge_enable(encoder->bridge);
> +
> +			WARN_ON(!encoder->bridge->pre_enable_called);
> +			WARN_ON(!encoder->bridge->enable_called);
> +		}
>  	}
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 1638bfe9627c..847c4209da60 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -153,6 +153,8 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>  	if (bridge->funcs->detach)
>  		bridge->funcs->detach(bridge);
>  
> +	bridge->disable_midlayer_calls = false;
> +
>  	bridge->dev = NULL;
>  }
>  
> @@ -248,6 +250,8 @@ void drm_bridge_disable(struct drm_bridge *bridge)
>  	if (!bridge)
>  		return;
>  
> +	bridge->disable_called = true;
> +
>  	drm_bridge_disable(bridge->next);
>  
>  	if (bridge->funcs->disable)
> @@ -270,6 +274,9 @@ void drm_bridge_post_disable(struct drm_bridge *bridge)
>  	if (!bridge)
>  		return;
>  
> +	WARN_ON(!bridge->disable_called);
> +	bridge->post_disable_called = true;
> +
>  	if (bridge->funcs->post_disable)
>  		bridge->funcs->post_disable(bridge);
>  
> @@ -319,6 +326,8 @@ void drm_bridge_pre_enable(struct drm_bridge *bridge)
>  	if (!bridge)
>  		return;
>  
> +	bridge->pre_enable_called = true;
> +
>  	drm_bridge_pre_enable(bridge->next);
>  
>  	if (bridge->funcs->pre_enable)
> @@ -341,6 +350,9 @@ void drm_bridge_enable(struct drm_bridge *bridge)
>  	if (!bridge)
>  		return;
>  
> +	WARN_ON(!bridge->pre_enable_called);
> +	bridge->enable_called = true;
> +
>  	if (bridge->funcs->enable)
>  		bridge->funcs->enable(bridge);
>  
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index bd850747ce54..ba0a227c96b7 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -294,6 +294,27 @@ struct drm_bridge {
>  	const struct drm_bridge_funcs *funcs;
>  	/** @driver_private: pointer to the bridge driver's internal context */
>  	void *driver_private;
> +
> +	/**
> +	 * @disable_midlayer_calls:
> +	 *
> +	 * disables the calls from the DRM atomic helpers into the
> +	 * bridge, leaving them to be performed by the driver.  This
> +	 * may be useful for encoders such as DSI, where the
> +	 * pre_enable/post_disable hooks want to be called while the
> +	 * bus is still enabled but before/after video packets are
> +	 * being sent.
> +	 */
> +	bool disable_midlayer_calls : 1;
> +
> +	/* private: flags for atomic helpers to check that the driver
> +	 * called the bridge functions properly if
> +	 * @disable_midlayer_calls was set.
> +	 */
> +	bool pre_enable_called : 1;
> +	bool enable_called : 1;
> +	bool disable_called : 1;
> +	bool post_disable_called : 1;
>  };
>  
>  void drm_bridge_add(struct drm_bridge *bridge);
