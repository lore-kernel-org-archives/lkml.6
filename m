Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CE1C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD39A248C8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t77c7k/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD39A248C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbeFYCiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 22:38:06 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21023 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbeFYCiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 22:38:04 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180625023801epoutp040fa20ca65d59c47b80facc941bc05d98~7Rr5f8qIP0084000840epoutp04E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:38:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180625023801epoutp040fa20ca65d59c47b80facc941bc05d98~7Rr5f8qIP0084000840epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529894281;
        bh=BIAGg9oHKEWpb1ZFXQ1wR0rqWLgYS/dsHm03q7mW2Gc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=t77c7k/Bl2ljcx9tM62LWUcbBY186uIYZxBcin1opbBn/5BNWD2SnWTsA0LwdATxw
         HX4wwsvXMARxCpjwWLsF8y4Ta47XenEgZuZDrRg94NFSwCjGZrzsysj6x38zEUObXa
         9zqNke5JWhL6Q2sM4J7bmUeqAWuZ+wB+4VyAc4fw=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180625023758epcas1p4b6bb3e6d9c8b71bf3a865be245b95b9d~7Rr2Km4xt2221122211epcas1p4I;
        Mon, 25 Jun 2018 02:37:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.1F.04068.685503B5; Mon, 25 Jun 2018 11:37:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180625023757epcas1p215ceb8660829c6ce1bd60c572a4e61c0~7Rr1bz4G52864028640epcas1p24;
        Mon, 25 Jun 2018 02:37:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180625023757epsmtrp227a7b56d451e03ac6db6414bd1c14721~7Rr1ZEh_A1610616106epsmtrp2m;
        Mon, 25 Jun 2018 02:37:57 +0000 (GMT)
X-AuditID: b6c32a36-be9ff70000000fe4-d3-5b305586fe1d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.A0.03632.585503B5; Mon, 25 Jun 2018 11:37:57 +0900 (KST)
Received: from [10.113.62.206] (unknown [10.113.62.206]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180625023757epsmtip29e5a3039b7c2c7cbbb96e7bb39f52edb~7Rr095YLU1516415164epsmtip2r;
        Mon, 25 Jun 2018 02:37:57 +0000 (GMT)
Date:   Mon, 25 Jun 2018 11:37:56 +0900
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
Subject: Re: [PATCH v2 01/10] drm/exynos: rename "bridge_node" to
 "mic_bridge_node"
In-Reply-To: <1527682561-1386-2-git-send-email-m.purski@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA3VTa0wcVRjN3ZmdWZC10+1WbrbRbiY2aUlYZh+U26akxLRkkvrDH6WhbCxO
        lnEX3Zc7uwTsD5EK5VUeqSawmLJFGtotQlmoAhFjkPQRZSnhIRCRJq3FtoLGumhTKM7srJE/
        /jvn3O+ce++5uSpMM0jqVMVuP+9zc06aSMa/+HZfRnpVHmNl2pfVaKEnqkTnorcVqKJ6RYn6
        WnqVqH1M1KZjvxHol58mcdR47zGGJiaukWi84lcS1TR3kihyb1aJpoY/JVDLxNcKFHq4gKPP
        xxZJdOmHSQWqHBkjUcv5hwR6OnwBz9Gy3Re6ATvVcE7BDgUXSbatulXJRsI1BPvl2l0lu1R3
        U8H2d37ANgyEAfsk8sobyQXl4BDnszmKS3g977Z5iord9mw673huOqL1Do/gz6atJsZsMGVa
        DCZLluEA8+ZBUyatd3MuPpsuTU94ab3P5hVnXWWCGODkDQndIPDuopx3PAGpFIPAuYSA226w
        eVy0voRzBsQIOuOt34FjIviA8LZrS9tadpeDKFULVCpIWeCPlQdrQbJKQw0C2DC9QsrkDwDH
        P64TSZJI1gAcmPNLWDLE1lsV8tCI6OjeBDJZATC4PAOkKZzaAx+vbsTdhIibLy8REt5J5cOh
        9rW4rqa2w9ut93HJrKUmAZyP9sQJRk3hcHQkhktTO6g8uNrbF09Noo7AjsaFuI5Ru+GZ622Y
        ZIDULAljY0NAji2BNTPPcfmwR2BoKETKeAd8dHMggXXwyeoIIZvPAvh0PQLkhXoAu75yyNgM
        H1ysVUg1YdQ+2DucIcvb4XezdZh8iBfhaqxeKTephtVVGnmEhjcm5xKJEN7pbCZkzMJnG3cS
        BYs3Dl8/TzYBfXBLG8Etdwv+t3MIYGHwEu8VXHZeMHpNW185AuL/IG3/IOiIvj4KKBWgU9Rz
        yxlWjZIrEcpcowCqMFqrDrCMVaMu4sre532eQl/AyQujwCY+VjOm22nziL/K7S80ZprMZjOy
        GPdnGo1bZIuZYUxGJivrQJb5f2Q6VV06T1k1lJ3z8+/yvJf3/buLQpWkKwe7wkcX60+m9ZdW
        ZB/7u2Bm2n/jz74TNHMseW8hdqvpVn+TY13z6uyV08Ohy98Iuvtz4Y8epZ3AKzF7kFna5FLz
        U7Rn8I3cU/Nth1MDr739XHf0Z9d7tSm5XIVW8/InH3aN92wryI8E7p7+vmqlqPGv5SsvdNkG
        T9pzaMJZdnXzrO8zGhccnDEN8wncP2NhE5pLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCSvG5rqEG0wdwdYha31p1jteg9d5LJ
        oqnjLavFxhnrWS3mHwGKXfn6ns3ixb2LLBb9j18zW5w/v4Hd4mzTG3aLzolL2C02Pb7GanF5
        1xw2ixnn9zFZLHh5i8Vi7ZG77BZLr19ksmjde4TdYsbkl2wWP3fNY3EQ8Vgzbw2jx+W+XiaP
        nbPusnvM7pjJ6rFpVSebx/ZvD1g97ncfZ/LYvKTeo2/LKkaPz5vkAriiuGxSUnMyy1KL9O0S
        uDLOz3rGVjBfpGL2DPkGxnMCXYycHBICJhJf/8xk6mLk4hAS2M0o8eVrB5DDAZSQkNiylQPC
        FJY4fLgYouQ1o0T75n4WkF5eAS2Jpyt3sYHYLAKqEq/f/WUHsdmA7Ikr7oPFRQXCJKb9fs4K
        US8ocXLmExaQQSIClxglNlx+wwriMAvcYpH437MObKqwQLDEjg1bmSHWnWWUeHf5LBNIglPA
        RWJR/y2wImYBdYk/8y4xQ9jyEs1bZzNPYBSchWTLLCRls5CULWBkXsUomVpQnJueW2xYYJiX
        Wq5XnJhbXJqXrpecn7uJERy5Wpo7GC8viT/EKMDBqMTDe+O5frQQa2JZcWXuIUYJDmYlEd5S
        D4NoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhiLH//+
        0Jkh7X+jR4vruI+E0UvpcKtcixRvEeNbP5LOX9R5mDcpvmzm3TsRR+wvxxU5NN1vSPFQtJ1t
        ueWK3yGrc3cbmESsRdnmbEh5ef+JmY68NnPGJY+GZ8srRFekBqe3mNrdPNQ+ear0O/eVOSY5
        O3/lTMtPE5nZ8uSJU8WOgEsB756K6SqxFGckGmoxFxUnAgDJESQS2AIAAA==
Message-Id: <20180625023757epcas1p215ceb8660829c6ce1bd60c572a4e61c0~7Rr1bz4G52864028640epcas1p24@epcas1p2.samsung.com>
X-CMS-MailID: 20180625023757epcas1p215ceb8660829c6ce1bd60c572a4e61c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180530121623eucas1p27e08223bc5b04dbb0b0253c18a9f83d5
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121623eucas1p27e08223bc5b04dbb0b0253c18a9f83d5@eucas1p2.samsung.com>
        <1527682561-1386-2-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I will start to review patch sets for -fixes first so I queued your four patches and you can check exynos-drm-next-todo branch for it.

Thanks,
Inki Dae

2018년 05월 30일 21:15에 Maciej Purski 이(가) 쓴 글:
> When adding support for peripheral out bridges, the "bridge" name
> becomes imprecise as it refers to a different device than the
> "out_bridge".
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index eae44fd..9599e6b 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -279,7 +279,7 @@ struct exynos_dsi {
>  	struct list_head transfer_list;
>  
>  	const struct exynos_dsi_driver_data *driver_data;
> -	struct device_node *bridge_node;
> +	struct device_node *mic_bridge_node;
>  };
>  
>  #define host_to_dsi(host) container_of(host, struct exynos_dsi, dsi_host)
> @@ -1631,7 +1631,7 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
>  	if (ret < 0)
>  		return ret;
>  
> -	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
> +	dsi->mic_bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
>  
>  	return 0;
>  }
> @@ -1642,7 +1642,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>  	struct drm_encoder *encoder = dev_get_drvdata(dev);
>  	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
>  	struct drm_device *drm_dev = data;
> -	struct drm_bridge *bridge;
> +	struct drm_bridge *mic_bridge;
>  	int ret;
>  
>  	drm_encoder_init(drm_dev, encoder, &exynos_dsi_encoder_funcs,
> @@ -1661,10 +1661,10 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>  		return ret;
>  	}
>  
> -	if (dsi->bridge_node) {
> -		bridge = of_drm_find_bridge(dsi->bridge_node);
> -		if (bridge)
> -			drm_bridge_attach(encoder, bridge, NULL);
> +	if (dsi->mic_bridge_node) {
> +		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
> +		if (mic_bridge)
> +			drm_bridge_attach(encoder, mic_bridge, NULL);
>  	}
>  
>  	return mipi_dsi_host_register(&dsi->dsi_host);
> @@ -1783,7 +1783,7 @@ static int exynos_dsi_remove(struct platform_device *pdev)
>  {
>  	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
>  
> -	of_node_put(dsi->bridge_node);
> +	of_node_put(dsi->mic_bridge_node);
>  
>  	pm_runtime_disable(&pdev->dev);
>  
> 
