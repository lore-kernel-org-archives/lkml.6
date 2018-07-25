Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CD0C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A262088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NsSZbKub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A262088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeGYJWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:22:08 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48274 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbeGYJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:22:08 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180725081134euoutp014a601fda63ce059d96a970865eccde38~EjlrXlhEJ0621906219euoutp01D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 08:11:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180725081134euoutp014a601fda63ce059d96a970865eccde38~EjlrXlhEJ0621906219euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532506294;
        bh=l0T5VQSeeESGavb2W/rDaFNZ+7YhAf0EuML92OOTQ6Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NsSZbKubpylNlucbYvkN8K7jC52wYBTtQjo4CCmquH/k3/8TZdzGI56SfGofbWBKS
         AkeQrQXEww0R9BExRkfnk4xlrJx+lTWzwXwKH6FUxRlnPLhbfUvJQpv3l+rIvsUBdf
         hUDnVZaNpNaQdft7vR3ikgm2AIX4OBi0iOaeFskU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180725081132eucas1p16cca51ab5b8f0e5cd87c225f65925d8c~EjlqU_LfZ1466214662eucas1p1e;
        Wed, 25 Jul 2018 08:11:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B4.31.05751.4B0385B5; Wed, 25
        Jul 2018 09:11:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180725081131eucas1p1a5a7f7e19d8ef3254dfe89049ea6d7c7~EjlpXj7zz1467114671eucas1p1f;
        Wed, 25 Jul 2018 08:11:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180725081131eusmtrp2928ead5894147bbf9e346f05e95f67e5~EjlpHaCaR1944619446eusmtrp2G;
        Wed, 25 Jul 2018 08:11:31 +0000 (GMT)
X-AuditID: cbfec7f4-c2dff70000001677-4d-5b5830b4f4d7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.E5.04183.3B0385B5; Wed, 25
        Jul 2018 09:11:31 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180725081130eusmtip1801aa224d712e83bdf9b91c83bdf869b~EjloGLRVs0221802218eusmtip1I;
        Wed, 25 Jul 2018 08:11:30 +0000 (GMT)
Subject: Re: [PATCH v3 1/9] drm/exynos: rename "bridge_node" to
 "mic_bridge_node"
To:     Inki Dae <inki.dae@samsung.com>,
        Maciej Purski <m.purski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Wed, 25 Jul 2018 10:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724074912epcas1p2e47dba6793b91a90b183e6cd809200bb~EPo3hWbma0369303693epcas1p2F@epcas1p2.samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfe/52XE8Tq3P0jKXNmzIr/U1lkzjYf1hw7SaH4dn+dGl3VNX
        2FQnnFo/6A910Q9KSYqT5MyP1XGadWlHl0ZHYRyNlqIpubuH6b/X5/P+vD/fz/vZwxLKTDqA
        3Z+QJGgT1PEqWk42Ph5pX9AQGh0bWp0ejHNsrTKsN/RT+EZhPYVLLTYKPx/6SuOzznwSf+zp
        IHFe32cCt7dfZ3Cb/guDT5+pYLCpr5PCdvN5Ghe235fhsk/dJL5mec3gSkeHDJ+4Z2FwYcEn
        Go+YS8gIX762pBbx9twcGX/H+Jrhiw1FFG+qOU3zt4ffULwz2yrjb1ak8bkNNYgfNAVtksfI
        V+0V4vfrBO2i8F3yfbbhrYnHA1K/GWwoHdX5ZSEfFrhlcDXXKstCclbJVSPQfzDSUvEdQcbl
        B4xUDCLoeZZB/LPcddmRJFQhGNc7CKnoR/DK+ZH2TM3gNkNBTq13ytdjr/hZ511McFdIGMto
        9E7R3DwYu/nSyyQXAuUX9MjDflw0WN6Ue1nBTYfWonekh324FHD0PKI8THCz4PitYkJif+h+
        V+qNAVwTCxUvutwC6zbr4P3gLunuSMjXn6AkngEuawMjcSCM3/F4PZwG+qLnhLTHgODJpSpa
        ElZCi7WD8uwk3EfXmxdJ7TXQcXnc2wZuKnT1T5fOmQpnG88RUlsBhpNKaXo2ONtu/f2K/lD5
        bIjORyrjhJDGCcGME4IZ/79bhsga5C8ki5o4QVySIKQsFNUaMTkhbuGeQxoTcv+bT39bvzch
        8+juZsSxSDVFMRC+LVZJqXXiYU0zApZQ+SoiW9wtxV714SOC9tBObXK8IDajmSyp8lfsmHss
        RsnFqZOEg4KQKGj/qTLWJyAd+a3wi89/v+HiQ8uspYqmbC6rM2Jj1Ojbtfddk1XTtu+JE2ue
        Bi83M/aW+oCo3pChLQ06/HV96MjRnPBJea6mHxF8oOZFwZy+3Y2pIafCdGcU5XVjpsr0ykvB
        M2OSen/hxc7hoAHO3maobnU8dNjyDp470LtudVjs9tuphSvnPqIzVaS4T714PqEV1X8AnulB
        y5cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsVy+t/xu7qbDSKiDS4sFrDoPXeSyaKp4y2r
        xcYZ61kt5h85x2px5et7NotJ9yewWLy4d5HFov/xa2aL8+c3sFucbXrDbtE5cQm7xabH11gt
        Lu+aw2Yx4/w+JosFL2+xWKw9cpfdYun1i0wWrXuPsFvMmPySzeLnrnksDiIea+atYfS43NfL
        5LFz1l12j9kdM1k9Nq3qZPPY/u0Bq8f97uNMHpuX1Hv0bVnF6PF5k1wAV5SeTVF+aUmqQkZ+
        cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrlvoQXNUhUfOs4xNjCu
        E+1i5OSQEDCR2P3qMmMXIxeHkMBSRommrXcYIRLiErvnv2WGsIUl/lzrYgOxhQReM0rMa5AF
        sYUFgiUm964BaxYR+MwoMe3BOjYQh1lgLYvE2rc/mCDGHmCSuD+plx2khU1AU+Lv5ptgo3gF
        7CTunXkHFmcRUJVYOLcJbLWoQITE6uUvWCFqBCVOznzCAmJzCpRLXL93FCzOLKAu8WfeJWYI
        W16ieetsKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dL
        zs/dxAhMFNuO/dyyg7HrXfAhRgEORiUeXg/H8Ggh1sSy4srcQ4wSHMxKIrwuh4FCvCmJlVWp
        RfnxRaU5qcWHGE2BnpvILCWanA9MYnkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NT
        C1KLYPqYODilGhgnFuz708x78791iOh9fp5VKlkuSj/bPzi5qvp+2XJN/bfFBO179TlOETMK
        F7Jd/DWfQ8TwGPe2DW7TjtcxPvhfK9DR63bu/7m5i6Sa2II/8DIJ3OXv/y/4tD058cLxtL+/
        dgTe8t/x/y97s4rvsTPyK1Oqf/i8nvcxMSXW+ETHH9/rrbnGZTxKLMUZiYZazEXFiQC3tliY
        KgMAAA==
Message-Id: <20180725081131eucas1p1a5a7f7e19d8ef3254dfe89049ea6d7c7~EjlpXj7zz1467114671eucas1p1f@eucas1p1.samsung.com>
X-CMS-MailID: 20180725081131eucas1p1a5a7f7e19d8ef3254dfe89049ea6d7c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180619081957eucas1p2d2b9075a9b7a90837b40e4529ab31888
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619081957eucas1p2d2b9075a9b7a90837b40e4529ab31888
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619081957eucas1p2d2b9075a9b7a90837b40e4529ab31888@eucas1p2.samsung.com>
        <1529396370-18761-2-git-send-email-m.purski@samsung.com>
        <20180724074912epcas1p2e47dba6793b91a90b183e6cd809200bb~EPo3hWbma0369303693epcas1p2F@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.2018 09:49, Inki Dae wrote:
> Hi,
>
> 2018년 06월 19일 17:19에 Maciej Purski 이(가) 쓴 글:
>> When adding support for peripheral out bridges, the "bridge" name
>> becomes imprecise as it refers to a different device than the
>> "out_bridge".
> Could you give me more details? I'm afriad that I don't understand what you say.

The problem is that MIC is an input bridge and now we will have also
output bridge (Toshiba DSI/LVDS converter).
So we will have to distinguish them.

>
> And in case of Exynos5433 SoC, SMIES(Samsung Mobile Image Enhancement System) can be located between DECON and MIPI-DSI devices also.
> Therefore, having specific name isn't reasonable.

So probably in_bridge would be a better name. I will rephrase message
and bridge name.

Regars
Andrzej


>
> Thanks,
> Inki Dae
>
>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>> ---
>>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> index eae44fd..9599e6b 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> @@ -279,7 +279,7 @@ struct exynos_dsi {
>>  	struct list_head transfer_list;
>>  
>>  	const struct exynos_dsi_driver_data *driver_data;
>> -	struct device_node *bridge_node;
>> +	struct device_node *mic_bridge_node;
>>  };
>>  
>>  #define host_to_dsi(host) container_of(host, struct exynos_dsi, dsi_host)
>> @@ -1631,7 +1631,7 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
>> +	dsi->mic_bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
>>  
>>  	return 0;
>>  }
>> @@ -1642,7 +1642,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>>  	struct drm_encoder *encoder = dev_get_drvdata(dev);
>>  	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
>>  	struct drm_device *drm_dev = data;
>> -	struct drm_bridge *bridge;
>> +	struct drm_bridge *mic_bridge;
>>  	int ret;
>>  
>>  	drm_encoder_init(drm_dev, encoder, &exynos_dsi_encoder_funcs,
>> @@ -1661,10 +1661,10 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>>  		return ret;
>>  	}
>>  
>> -	if (dsi->bridge_node) {
>> -		bridge = of_drm_find_bridge(dsi->bridge_node);
>> -		if (bridge)
>> -			drm_bridge_attach(encoder, bridge, NULL);
>> +	if (dsi->mic_bridge_node) {
>> +		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
>> +		if (mic_bridge)
>> +			drm_bridge_attach(encoder, mic_bridge, NULL);
>>  	}
>>  
>>  	return mipi_dsi_host_register(&dsi->dsi_host);
>> @@ -1783,7 +1783,7 @@ static int exynos_dsi_remove(struct platform_device *pdev)
>>  {
>>  	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
>>  
>> -	of_node_put(dsi->bridge_node);
>> +	of_node_put(dsi->mic_bridge_node);
>>  
>>  	pm_runtime_disable(&pdev->dev);
>>  
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

