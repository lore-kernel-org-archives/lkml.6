Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49333C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D4520856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P7qWtZNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D4520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbeGXJP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:15:28 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:46873 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388439AbeGXJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:15:28 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180724081011epoutp0430f3cec88373979fe980a61c80c5795d~EP7Ly2fqH3074130741epoutp04p
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:10:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180724081011epoutp0430f3cec88373979fe980a61c80c5795d~EP7Ly2fqH3074130741epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532419811;
        bh=NqZmlbKmO0R5C4Cwu/kWGd3KIqiUm3iOKumJTPyJz3s=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=P7qWtZNuE9JwF7lBCxSVym8J3szQZwiS/1Lj6TuWWgbjPZlRrCx5bf+oyUHU85bky
         AjZ+y3vAY3Arpas2cDBndUCSfok/XNT0rGQ/N8pEmn20EbUMKcV6ybTIWzT70JFm3W
         7cDRsBFdwMU7Kc9o472gLZ1JAV/Vsuov19jJtGZI=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180724081005epcas1p44c2dbd12e7f098da32810a973580355d~EP7GmsBjc0036500365epcas1p4O;
        Tue, 24 Jul 2018 08:10:05 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.89.04176.DDED65B5; Tue, 24 Jul 2018 17:10:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180724081004epcas1p2d5a43c556b831d6fe8cde9a24b284507~EP7F_T9mK0982409824epcas1p2Z;
        Tue, 24 Jul 2018 08:10:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180724081004epsmtrp152f6e4e0679db1b30e7bb219f9835165~EP7F75amB0817908179epsmtrp1C;
        Tue, 24 Jul 2018 08:10:04 +0000 (GMT)
X-AuditID: b6c32a37-6c5ff70000001050-26-5b56dedd701d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.4C.03889.CDED65B5; Tue, 24 Jul 2018 17:10:04 +0900 (KST)
Received: from [10.113.62.206] (unknown [10.113.62.206]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180724081004epsmtip20093d90b94d97530bc2474f1028892ea~EP7FRP85x2994629946epsmtip2x;
        Tue, 24 Jul 2018 08:10:03 +0000 (GMT)
Date:   Tue, 24 Jul 2018 17:10:04 +0900
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
In-Reply-To: <5B56DD97.3030508@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLsWRmVeSWpSXmKPExsWy7bCmge7de2HRBgs/ilvcWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLF/cuslj0P37NbHH+/AZ2i7NNb9gtOicuYbfY9Pgaq8Xl
        XXPYLGac38dkseDlLRaLtUfuslssvX6RyaJ17xF2ixmTX7JZ/Nw1j8VBxGPNvDWMHpf7epk8
        ds66y+4xu2Mmq8emVZ1sHtu/PWD1uN99nMlj85J6j74tqxg9Pm+SC+CKamC0SSxKzsgsS1VI
        zUvOT8nMS7dVCg1x07VQUsjILy6xVYo2NDTSMzQw1zMyMtIztoy1MjJVUshLzE21VarQhepV
        UihKLgCqza0sBhqQk6oHFdcrTs1LccjKLwUFil5xYm5xaV66XnJ+rpJCWWJOKdAIJf2ED4wZ
        /ec6GQuWylbce/OSsYHxo3gXIweHhICJxIvpXF2MXBxCAjsYJe5232CHcD4xSjw6+ZsNwvnG
        KPF1ehtQhhOs43bjeRaIxF5GiSM/70FVvWWUWPf5PFgVi4CqxKMV7cwgNhuQPXHFfTYQW1Qg
        QmLn/G9gNbwCghInZz4BmyQicJFR4ua5dWAOs8BlFolDe7+ygFQJC4RIPNmyEszmFNCWOPn2
        Nlg3s4C8RPPW2cwgDRICt9glVgHjDmJsmcS0RRfZII51kWiesJcJwhaWeHV8C9QTUhIv+9vY
        IZrbGSV+/tnECJHoYZRYvicDwjaWeLawiwkUTswCmhLrd+lDhAUlTl/rZoY4gk/i3dceVkhQ
        8kp0tAlBlChJHLt4A2qihMSFJROhzvGQ2H3iLzS4vjBKPH3ZzTqBUWEWUmjMQvLbLITNCxiZ
        VzGKpRYU56anFhsWGCPH8yZGcE7QMt/BuOGczyFGAQ5GJR7eii+h0UKsiWXFlbmHGCU4mJVE
        eEtnh0UL8aYkVlalFuXHF5XmpBYfYkwGRtZEZinR5HxgvsoriTc0NTI2NrYwMTQzNTREEjYx
        NjAwAiZRc0tzYxzCSuK8Rn7B0UIC6YklqdmpqQWpRTBbmDg4pRoYSxS0zOtjdrZt+7742RyG
        x05JmX3+62N2cNzs3tv7N9q+kVfj+IsDBwVP/m8uuvbUeke9XKS29cZTl56u/M1+/em2oxfy
        pBjSwwtvTDy+eZt9m0nIWadNk7z22HN4TD/WtiCU2fbXHjWjAo1Xf/4oZkrFS6Ulbv2sWa7a
        0vYwzHkXZ9JL8/MaSizFGYmGWsxFxYkAb20iKE0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSvO6de2HRBr83q1vcWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLF/cuslj0P37NbHH+/AZ2i7NNb9gtOicuYbfY9Pgaq8Xl
        XXPYLGac38dkseDlLRaLtUfuslssvX6RyaJ17xF2ixmTX7JZ/Nw1j8VBxGPNvDWMHpf7epk8
        ds66y+4xu2Mmq8emVZ1sHtu/PWD1uN99nMlj85J6j74tqxg9Pm+SC+CK4rJJSc3JLEst0rdL
        4MroP9fJWLBUtuLem5eMDYwfxbsYOTkkBEwkbjeeZwGxhQR2M0rM3BTfxcgBFJeQ2LKVA8IU
        ljh8uLiLkQuo4jWjxImfz9lA4rwCWhIrvyiBdLIIqEo8WtHODGKzAdkTV9xnA7FFBcIkpv1+
        zgpi8woISpyc+YQFZI6IwCVGiQ2X37CCOMwCt1gk/vesA7tBWCBE4smWlSwQ294xSsyY8Qks
        wSmgLXHy7W12EJtZQF3iz7xLzBC2vETz1tnMExgFZyHZMgtJ2SwkZQsYmVcxSqYWFOem5xYb
        FhjlpZbrFSfmFpfmpesl5+duYgTHrZbWDsYTJ+IPMQpwMCrx8F74FhotxJpYVlyZe4hRgoNZ
        SYS3dHZYtBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQZG
        Y6WPJ7qm2qs8YBN9MfH1il/b+BuKfzc8Fop2XOIzQd/T08UjYPqaR2V8y3rCupx8feKORZXq
        TigW3yFxds/ckytltb5dL9i5OODak6P/p0u+CivM8fOQ//nij4p4yWpRdp6lC7sXWhR73lEJ
        mNc6+aDSh4CNC8Nv5uXquEvNq1aR46/6/N1ciaU4I9FQi7moOBEAqj7k3dcCAAA=
Message-Id: <20180724081004epcas1p2d5a43c556b831d6fe8cde9a24b284507~EP7F_T9mK0982409824epcas1p2Z@epcas1p2.samsung.com>
X-CMS-MailID: 20180724081004epcas1p2d5a43c556b831d6fe8cde9a24b284507
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
        <5B56DD97.3030508@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



2018년 07월 24일 17:04에 Inki Dae 이(가) 쓴 글:
> Hi,
> 
> 2018년 06월 19일 17:19에 Maciej Purski 이(가) 쓴 글:
>> The current implementation assumes that the only possible peripheral
>> device for DSIM is a panel. Using an output bridge child device
>> should also be possible.
>>
>> If an output bridge is available, don't create a new connector.
>> Instead, call drm_bridge_attach() and set encoder's bridge to NULL
>> in order to avoid an out bridge from being visible by the framework, as
>> the DSI bus needs control on enabling its child output bridge.
>>
>> Such sequence is required by Toshiba TC358764 bridge, which is a DSI
>> peripheral bridge device.
> 
> Right, we should consider DSI to LVDS bridge.

In addition, could you update below binding document?
Documentation/devicetree/bindings/display/exynos/exynos_dsim.txt

Thanks,
Inki Dae

> 
> Thanks,
> Inki Dae
> 
>>
>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>> ---
>>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 38 ++++++++++++++++++++++-----------
>>  1 file changed, 25 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> index 9599e6b..c0408c0 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>> @@ -255,6 +255,7 @@ struct exynos_dsi {
>>  	struct mipi_dsi_host dsi_host;
>>  	struct drm_connector connector;
>>  	struct drm_panel *panel;
>> +	struct drm_bridge *out_bridge;
>>  	struct device *dev;
>>  
>>  	void __iomem *reg_base;
>> @@ -1499,7 +1500,30 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
>>  				  struct mipi_dsi_device *device)
>>  {
>>  	struct exynos_dsi *dsi = host_to_dsi(host);
>> -	struct drm_device *drm = dsi->connector.dev;
>> +	struct drm_encoder *encoder = &dsi->encoder;
>> +	struct drm_device *drm = encoder->dev;
>> +	struct drm_bridge *out_bridge;
>> +
>> +	out_bridge  = of_drm_find_bridge(device->dev.of_node);
>> +	if (out_bridge) {
>> +		drm_bridge_attach(encoder, out_bridge, NULL);
>> +		dsi->out_bridge = out_bridge;
>> +		encoder->bridge = NULL;
>> +	} else {
>> +		int ret = exynos_dsi_create_connector(encoder);
>> +
>> +		if (ret) {
>> +			DRM_ERROR("failed to create connector ret = %d\n", ret);
>> +			drm_encoder_cleanup(encoder);
>> +			return ret;
>> +		}
>> +
>> +		dsi->panel = of_drm_find_panel(device->dev.of_node);
>> +		if (dsi->panel) {
>> +			drm_panel_attach(dsi->panel, &dsi->connector);
>> +			dsi->connector.status = connector_status_connected;
>> +		}
>> +	}
>>  
>>  	/*
>>  	 * This is a temporary solution and should be made by more generic way.
>> @@ -1518,11 +1542,6 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
>>  	dsi->lanes = device->lanes;
>>  	dsi->format = device->format;
>>  	dsi->mode_flags = device->mode_flags;
>> -	dsi->panel = of_drm_find_panel(device->dev.of_node);
>> -	if (dsi->panel) {
>> -		drm_panel_attach(dsi->panel, &dsi->connector);
>> -		dsi->connector.status = connector_status_connected;
>> -	}
>>  	exynos_drm_crtc_get_by_type(drm, EXYNOS_DISPLAY_TYPE_LCD)->i80_mode =
>>  			!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
>>  
>> @@ -1654,13 +1673,6 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	ret = exynos_dsi_create_connector(encoder);
>> -	if (ret) {
>> -		DRM_ERROR("failed to create connector ret = %d\n", ret);
>> -		drm_encoder_cleanup(encoder);
>> -		return ret;
>> -	}
>> -
>>  	if (dsi->mic_bridge_node) {
>>  		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
>>  		if (mic_bridge)
>>
