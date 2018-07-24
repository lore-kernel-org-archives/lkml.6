Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C609ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06E820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t1+HQ5vD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06E820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbeGXJIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:08:10 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:42138 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388523AbeGXJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:08:10 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180724080255epoutp04c77c4b3a9c8271553db241c18a6977dd~EP01uz6Ez2502725027epoutp04D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:02:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180724080255epoutp04c77c4b3a9c8271553db241c18a6977dd~EP01uz6Ez2502725027epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532419375;
        bh=SRn3mz7CUoQ11Jw3fFFy3CZtwm/Z+Yp7B9BfYT5aJXw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=t1+HQ5vDcAhKevVx2M4lQ2pQjWe5wKUlMW4i7VDGzO8AOZttAVU6FyjfIIs54OeVL
         jY7X4whTDMPCKHShE9AZAgmuiuPJFCxO8q1GWK8EQsZN+V3EBUEA29b474vdX93egF
         7AFSMjHJPU9PB/EozpQOub2BFhapIXbS8L7AyU1c=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180724080251epcas1p4e0b8943dd54c6c0a3a0ca2be71c559be~EP0yR4bu92051720517epcas1p4a;
        Tue, 24 Jul 2018 08:02:51 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.65.04213.B2DD65B5; Tue, 24 Jul 2018 17:02:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20180724080250epcas1p399b546f087dc1acd81dd5824f4498433~EP0x1jr7b1293312933epcas1p3z;
        Tue, 24 Jul 2018 08:02:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180724080250epsmtrp1bbb8388385608baf4cf54768c94d99f2~EP0xzQlzW0515905159epsmtrp1j;
        Tue, 24 Jul 2018 08:02:50 +0000 (GMT)
X-AuditID: b6c32a35-8d7ff70000001075-0c-5b56dd2b5633
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.3C.03759.A2DD65B5; Tue, 24 Jul 2018 17:02:50 +0900 (KST)
Received: from [10.113.62.206] (unknown [10.113.62.206]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180724080250epsmtip1bd7cd8d7daf03bb40f14081a8a8dee33~EP0xWrSxi2253622536epsmtip1Z;
        Tue, 24 Jul 2018 08:02:50 +0000 (GMT)
Date:   Tue, 24 Jul 2018 17:02:50 +0900
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
Subject: Re: [PATCH v3 3/9] drm/exynos: enable out_bridge in
 exynos_dsi_enable()
In-Reply-To: <1529396370-18761-4-git-send-email-m.purski@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLsWRmVeSWpSXmKPExsWy7bCmrq723bBog71XuS1urTvHatF77iST
        RVPHW1aLjTPWs1rMPwIUu/L1PZvFi3sXWSz6H79mtjh/fgO7xdmmN+wWnROXsFtsenyN1eLy
        rjlsFjPO72OyWPDyFovF2iN32S2WXr/IZNG69wi7xYzJL9ksfu6ax+Ig4rFm3hpGj8t9vUwe
        O2fdZfeY3TGT1WPTqk42j+3fHrB63O8+zuSxeUm9R9+WVYwenzfJBXBFNTDaJBYlZ2SWpSqk
        5iXnp2TmpdsqhYa46VooKWTkF5fYKkUbGhrpGRqY6xkZGekZW8ZaGZkqKeQl5qbaKlXoQvUq
        KRQlFwDV5lYWAw3ISdWDiusVp+alOGTll4ICRa84Mbe4NC9dLzk/V0mhLDGnFGiEkn7CB8aM
        SRNnshf0CFfM2PmLvYHxAH8XIyeHhICJxLymj0xdjFwcQgI7GCX+Pv7ADuF8YpRomnqDBcL5
        xijRffkdWxcjB1hL+8FckG4hgb2MEhe/uEPUvAXq3vSSHSTBIqAq8WvfDTCbDcieuOI+G4gt
        KhAhsXP+N7A4r4CgxMmZT8AWiAhcZJS4eW4dmMMscJlF4tDerywgVcICQRITfqwFszkFXCWO
        zDrGDGIzC8hLNG+dzQzSICFwiV1i8a+lUGPLJG7eAWkGOdVFYtqlfIhHhSVeHd/CDmFLSbzs
        b2OH6G1nlPj5ZxMjRKKHUWL5ngwI21ji2cIuJpA5zAKaEut36UOEBSVOX+uGuoFP4t3XHlaI
        VbwSHW1CECVKEscu3oCaKCFxYclENgjbQ6LhZA8jJLQuM0qcuraEaQKjwiykwJiF5LVZCJsX
        MDKvYhRLLSjOTU8tNiwwRI7lTYzgfKBluoNxyjmfQ4wCHIxKPLwVX0KjhVgTy4orcw8xSnAw
        K4nwls4OixbiTUmsrEotyo8vKs1JLT7EmAyMq4nMUqLJ+cBclVcSb2hqZGxsbGFiaGZqaIgk
        bGJsYGAETKDmlubGOISVxHmN/IKjhQTSE0tSs1NTC1KLYLYwcXBKNTBqReyyynu1/kX67Oyr
        XvEZ4axX85TW7ai8qW0ldV7vx4Eyvzrbe/vt9hzbJntGpWFL8MPTzG2hwaJsbVfNt/6bsbxh
        i1DlCbe50VdebfvHbNC6O3Oejfac8vp5l/NPzbmRUpg1O36++cUtby+mPks8+v82Q2ymcF/I
        iY7rW64r2bTOMXvGOSdEiaU4I9FQi7moOBEAYPLS7ksEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSnK7W3bBog2nTtCxurTvHatF77iST
        RVPHW1aLjTPWs1rMPwIUu/L1PZvFi3sXWSz6H79mtjh/fgO7xdmmN+wWnROXsFtsenyN1eLy
        rjlsFjPO72OyWPDyFovF2iN32S2WXr/IZNG69wi7xYzJL9ksfu6ax+Ig4rFm3hpGj8t9vUwe
        O2fdZfeY3TGT1WPTqk42j+3fHrB63O8+zuSxeUm9R9+WVYwenzfJBXBFcdmkpOZklqUW6dsl
        cGVMmjiTvaBHuGLGzl/sDYwH+LsYOTgkBEwk2g/mdjFycQgJ7GaUmLRhOgtEXEJiy1YOCFNY
        4vDhYoiS14wSS7f9Yuxi5OTgFdCSWH94BpjNIqAq8WvfDXYQmw3InrjiPhuILSoQJjHt93NW
        iHpBiZMzn7CADBIRuMQoseHyG1YQh1ngFovE/551YIuFBQIkjkz2g9h2nlFi7fbpTCDdnAKu
        EkdmHWMGsZkF1CX+zLsEZctLNG+dzTyBUXAWkiWzkJTNQlK2gJF5FaNkakFxbnpusWGBYV5q
        uV5xYm5xaV66XnJ+7iZGcNxqae5gvLwk/hCjAAejEg9vxZfQaCHWxLLiytxDjBIczEoivKWz
        w6KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYFRJ9t3A
        kRgreZC/1l773Fdrx9mJ+fc+c5T5ul+RzglgEhN8t+rKZLbEPIu0Fz56q2sT3bZETwjjX2/R
        s+rjhU/SRauqlvE1li64aqXVFFiyomunlfealVc4p9tpST0vT7r35fXX6WW2ewTWCS1OZe44
        r//pg4Lt3vCYu2bRJwRP5e+c9NN+qhJLcUaioRZzUXEiAN5hZp7XAgAA
Message-Id: <20180724080250epcas1p399b546f087dc1acd81dd5824f4498433~EP0x1jr7b1293312933epcas1p3z@epcas1p3.samsung.com>
X-CMS-MailID: 20180724080250epcas1p399b546f087dc1acd81dd5824f4498433
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180619081959eucas1p14aee2dfc0231d2f645e3c9071b92341e
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619081959eucas1p14aee2dfc0231d2f645e3c9071b92341e@eucas1p1.samsung.com>
        <1529396370-18761-4-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2018년 06월 19일 17:19에 Maciej Purski 이(가) 쓴 글:
> As the out bridge will not be enabled directly by the framework,
> it should be enabled by DSI. Exynos_dsi_enable() should handle a case,
> when there is an out_bridge connected as a DSI peripheral.
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 34 +++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index c0408c0..8aa7ace 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1386,25 +1386,33 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
>  
>  	dsi->state |= DSIM_STATE_ENABLED;
>  
> -	ret = drm_panel_prepare(dsi->panel);
> -	if (ret < 0) {
> -		dsi->state &= ~DSIM_STATE_ENABLED;
> -		pm_runtime_put_sync(dsi->dev);
> -		return;
> +	if (dsi->panel) {
> +		ret = drm_panel_prepare(dsi->panel);
> +		if (ret < 0) {
> +			dsi->state &= ~DSIM_STATE_ENABLED;

Why did you remove pm_runtime_put_sync call?

> +			return;
> +		}
>  	}
>  
> +	if (dsi->out_bridge)
> +		drm_bridge_pre_enable(dsi->out_bridge);
> +
>  	exynos_dsi_set_display_mode(dsi);
>  	exynos_dsi_set_display_enable(dsi, true);
>  
> -	ret = drm_panel_enable(dsi->panel);
> -	if (ret < 0) {
> -		dsi->state &= ~DSIM_STATE_ENABLED;
> -		exynos_dsi_set_display_enable(dsi, false);
> -		drm_panel_unprepare(dsi->panel);
> -		pm_runtime_put_sync(dsi->dev);
> -		return;
> +	if (dsi->panel) {
> +		ret = drm_panel_enable(dsi->panel);
> +		if (ret < 0) {
> +			dsi->state &= ~DSIM_STATE_ENABLED;
> +			exynos_dsi_set_display_enable(dsi, false);
> +			drm_panel_unprepare(dsi->panel);

Ditto.

Thanks,
Inki Dae

> +			return;
> +		}
>  	}
>  
> +	if (dsi->out_bridge)
> +		drm_bridge_enable(dsi->out_bridge);
> +
>  	dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
>  }
>  
> @@ -1418,8 +1426,10 @@ static void exynos_dsi_disable(struct drm_encoder *encoder)
>  	dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
>  
>  	drm_panel_disable(dsi->panel);
> +	drm_bridge_disable(dsi->out_bridge);
>  	exynos_dsi_set_display_enable(dsi, false);
>  	drm_panel_unprepare(dsi->panel);
> +	drm_bridge_post_disable(dsi->out_bridge);
>  
>  	dsi->state &= ~DSIM_STATE_ENABLED;
>  
> 
