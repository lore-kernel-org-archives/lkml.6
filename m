Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFB2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68D820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XkKBP1R7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68D820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbeGXJJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:09:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:10982 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388390AbeGXJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:09:58 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180724080442epoutp028eacf1382572c6d69629b4360752ca15~EP2Z9GHw20915009150epoutp02p
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:04:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180724080442epoutp028eacf1382572c6d69629b4360752ca15~EP2Z9GHw20915009150epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532419482;
        bh=gS407P3bxPX5uUYVatzpqc6aIq+Hw3Ojs3ALfWzBniM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=XkKBP1R7oUanDvyT9F9KbDu27hgjQ9xeXnp5khn/QZqyZs7e7DAR5mmLvJWIprsz0
         eHMRhMlBAxQMxsWDuNJ1/TMAmsLquzMZNlb6BblC70k9ardIvL0WlxmSkDbcrMER7X
         ow1ujZSHbYxSPqifGXhnxXzKPIkqUF7l8qvJvmRw=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724080439epcas1p28541866ecf89d0f5af7c2be46918772e~EP2Xcudc70399603996epcas1p28;
        Tue, 24 Jul 2018 08:04:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.97.04176.79DD65B5; Tue, 24 Jul 2018 17:04:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20180724080439epcas1p3a19bce196acc4611327aa2a78a8e5060~EP2W7G7Vi0942109421epcas1p36;
        Tue, 24 Jul 2018 08:04:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180724080439epsmtrp23fdcc04ddeb929291de8f42bddfaac17~EP2W4qUD53260632606epsmtrp2o;
        Tue, 24 Jul 2018 08:04:39 +0000 (GMT)
X-AuditID: b6c32a37-6ddff70000001050-55-5b56dd971698
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.2C.03889.79DD65B5; Tue, 24 Jul 2018 17:04:39 +0900 (KST)
Received: from [10.113.62.206] (unknown [10.113.62.206]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180724080438epsmtip15306c16d0ec6fc34f38074310cea0491~EP2WibLI_2619726197epsmtip1n;
        Tue, 24 Jul 2018 08:04:38 +0000 (GMT)
Date:   Tue, 24 Jul 2018 17:04:39 +0900
From:   Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
MIME-Version: 1.0
To:     Maciej Purski <m.purski@samsung.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 2/9] drm/exynos: move connector creation to attach
 callback
In-Reply-To: <1529396370-18761-3-git-send-email-m.purski@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA3VTbWxTVRjOuZ/dYs2l2/CkS1i9ioElK/3Y2Jk6JAHNTSRKIiNKFbjpbtZp
        P25612abGJYSpewDaYSwD7ONZIaxTAZlYCnUxLHAxmZHM0Sd1JHAphNXkNLp4ky87R1xf/z3
        nOc8z/O+5z3nqHBNiNaqqp01gtvJ21kqm7hwZb2h6Hh8p8Xw3V8GNHU6SqKW6CiGfP55Ep1t
        HSBR17DM3Uw9oNCvP8cI9Ond+ziamDhDo299v9PoUKCHRsG7t0g0Gf6cQq0TX2Ooe26KQF8O
        x2n0xfcxDH0cGaZR62dzFFoMdxKbc7n+zn7ATR5uwbiL7XGa6/C3kVyw7xDFfbVwh+Smm65h
        3Lme/dzhwT7AJYNrtmfvagAv826rrdor6ASn1VVZ7awqZyt2vFaEWJ3NJdWUsxaj0aQ3Gkr1
        JpNJby5770VTCatz8g6hnK0tWvayOrdVlLWOOkkOsAv6ZV4vCc7Kze+7POmh6CXeIXmcVXqr
        y8HqvLzdI0ewG/Y+BLbofC8mprS1/geLRAOYyWsEWSrIFMOxkSRoBNkqDRMCcOn637SyeATg
        zYAPS6s0zAKAM9d3PXF0zx6kFD4CYN/DfMUwD+DZb+JkeoNg1sIDjxMZESXjQO90Bucxb8OL
        XQt0GquZVXC07R6RNucyMQB/jJ7OLHBmkoBDkRSRVuUwO+C9wVMZnMW8Cjt9iUwFnCmAB853
        4GkDZKZo6D/XIpdQybFemBrVKq1uhSdHZ3AF58Dfrg3SCtbCZCJCKd6DAC4uBYGy0Qzgycs2
        BZvh7IlGLJ2JM+vhQHiDQq+CY7eacKWHp2Ei1UymJZBRQ/8nGkXCwquxH5YTIbzRE6AUzMFL
        I/9QyrQm5YleCBFHgK59xTDaVxyt/b/K3QDvA6sFUXJUCZJRNK+85SDI/IPC0hA4E902BBgV
        YJ9S1z6usGhI3ivVOYYAVOFsrtrTsdOiUVfydfWC27XH7bEL0hCwyncVwLV5Vpf8q5w1e4wl
        JrPZjIqNG0uMxhV0sdlgMMkPtLSs1Pw/NPuM2vTGWxYNU8XXCB8Igii4n1TBVFnaBmCuXTyx
        ban3p/wgG/nozv3dzz9qPeY5r096tV2izTc7Jx77ZaRtbf0fdKJ539F3iaaXsDWFV+cK7PvK
        HH+SBdy6jv5QfH/+kn1Lffj4C+Ob3nw9Z1z8UIz1bL09PjOGR5OGoksivVcLb1gHtnNhYcvI
        s8/5bzcdeUca3zj9yqajFSwh2XhjIe6W+H8BFDHU4UsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSnO70u2HRBvtn8lncWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLF/cuslj0P37NbHH+/AZ2i7NNb9gtOicuYbfY9Pgaq8Xl
        XXPYLGac38dkseDlLRaLtUfuslssvX6RyaJ17xF2ixmTX7JZ/Nw1j8VBxGPNvDWMHpf7epk8
        ds66y+4xu2Mmq8emVZ1sHtu/PWD1uN99nMlj85J6j74tqxg9Pm+SC+CK4rJJSc3JLEst0rdL
        4Mo493YFU8FXqYqO9z9ZGhifinYxcnJICJhILHjWztbFyMUhJLCbUWLtnDPMXYwcQAkJiS1b
        OSBMYYnDh4tByoUEXjNKXJ6hD2LzCmhJrPq0gRnEZhFQlWj+8o4NxGYDsieuuA9miwqESUz7
        /ZwVol5Q4uTMJywgq0QELjFKbLj8hhXEYRa4xSLxv2cdC0iVsECIxJMtK1kgtp1nlJjVHA1i
        cwq4Ssxregc2iVlAXeLPvEvMELa8RPPW2cwTGAVnIVkyC0nZLCRlCxiZVzFKphYU56bnFhsW
        GOWllusVJ+YWl+al6yXn525iBMetltYOxhMn4g8xCnAwKvHwXvgWGi3EmlhWXJl7iFGCg1lJ
        hLd0dli0EG9KYmVValF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBkam
        ZTuqZWfW229pF+vpvLhaWGtJ8IYnvtyFj09uDDsl6dO5UVKSa1/1VUWm4HBN3ou+fcs/LNrV
        3JYROOWf2rLexxkX9q6UfOP7Xfs5x52wK04M/SfFLc+muO81WzUl2dDpl/mrqQlvOh9Lbnu9
        Xpw/wyj1bYCJS1ablK6sYPTO3rSPB0X+uSqxFGckGmoxFxUnAgAjgqW61wIAAA==
Message-Id: <20180724080439epcas1p3a19bce196acc4611327aa2a78a8e5060~EP2W7G7Vi0942109421epcas1p36@epcas1p3.samsung.com>
X-CMS-MailID: 20180724080439epcas1p3a19bce196acc4611327aa2a78a8e5060
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180619081958eucas1p16911ee9962441735d929dc588e70ce70
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619081958eucas1p16911ee9962441735d929dc588e70ce70@eucas1p1.samsung.com>
        <1529396370-18761-3-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2018년 06월 19일 17:19에 Maciej Purski 이(가) 쓴 글:
> The current implementation assumes that the only possible peripheral
> device for DSIM is a panel. Using an output bridge child device
> should also be possible.
> 
> If an output bridge is available, don't create a new connector.
> Instead, call drm_bridge_attach() and set encoder's bridge to NULL
> in order to avoid an out bridge from being visible by the framework, as
> the DSI bus needs control on enabling its child output bridge.
> 
> Such sequence is required by Toshiba TC358764 bridge, which is a DSI
> peripheral bridge device.

Right, we should consider DSI to LVDS bridge.

Thanks,
Inki Dae

> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 38 ++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 9599e6b..c0408c0 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -255,6 +255,7 @@ struct exynos_dsi {
>  	struct mipi_dsi_host dsi_host;
>  	struct drm_connector connector;
>  	struct drm_panel *panel;
> +	struct drm_bridge *out_bridge;
>  	struct device *dev;
>  
>  	void __iomem *reg_base;
> @@ -1499,7 +1500,30 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
>  				  struct mipi_dsi_device *device)
>  {
>  	struct exynos_dsi *dsi = host_to_dsi(host);
> -	struct drm_device *drm = dsi->connector.dev;
> +	struct drm_encoder *encoder = &dsi->encoder;
> +	struct drm_device *drm = encoder->dev;
> +	struct drm_bridge *out_bridge;
> +
> +	out_bridge  = of_drm_find_bridge(device->dev.of_node);
> +	if (out_bridge) {
> +		drm_bridge_attach(encoder, out_bridge, NULL);
> +		dsi->out_bridge = out_bridge;
> +		encoder->bridge = NULL;
> +	} else {
> +		int ret = exynos_dsi_create_connector(encoder);
> +
> +		if (ret) {
> +			DRM_ERROR("failed to create connector ret = %d\n", ret);
> +			drm_encoder_cleanup(encoder);
> +			return ret;
> +		}
> +
> +		dsi->panel = of_drm_find_panel(device->dev.of_node);
> +		if (dsi->panel) {
> +			drm_panel_attach(dsi->panel, &dsi->connector);
> +			dsi->connector.status = connector_status_connected;
> +		}
> +	}
>  
>  	/*
>  	 * This is a temporary solution and should be made by more generic way.
> @@ -1518,11 +1542,6 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
>  	dsi->lanes = device->lanes;
>  	dsi->format = device->format;
>  	dsi->mode_flags = device->mode_flags;
> -	dsi->panel = of_drm_find_panel(device->dev.of_node);
> -	if (dsi->panel) {
> -		drm_panel_attach(dsi->panel, &dsi->connector);
> -		dsi->connector.status = connector_status_connected;
> -	}
>  	exynos_drm_crtc_get_by_type(drm, EXYNOS_DISPLAY_TYPE_LCD)->i80_mode =
>  			!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
>  
> @@ -1654,13 +1673,6 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = exynos_dsi_create_connector(encoder);
> -	if (ret) {
> -		DRM_ERROR("failed to create connector ret = %d\n", ret);
> -		drm_encoder_cleanup(encoder);
> -		return ret;
> -	}
> -
>  	if (dsi->mic_bridge_node) {
>  		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
>  		if (mic_bridge)
> 
