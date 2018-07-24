Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33978C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB9C20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VatT3Pws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB9C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbeGXIyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:54:33 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55848 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388400AbeGXIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:54:32 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180724074920epoutp02c5c6f1f3530c1ab1aca3be152d3bda32~EPo_9KsQz2816528165epoutp02k
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 07:49:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180724074920epoutp02c5c6f1f3530c1ab1aca3be152d3bda32~EPo_9KsQz2816528165epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532418560;
        bh=jtmAcPy3lm/DspYlhrUJ0/iJDT/1UGETvkGfWLBebiQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=VatT3PwsAW6JDv2QzxLn9rczJbgsMw6hiLyr13fypg2nwI9zY3X/rix/Fqo0EUYPG
         fu6mkyq3w8ZDL2zdtx3dyPpGKWzG4LJcu/+oHfVBjPZ6kkiCoCpEw9TYlfzw0vz5oK
         trFVaRjOp7UnerxPMez/ex/1tk6gV5gIX2i2gyOI=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724074912epcas1p121ce43608d383ee320fd6a3ad773a777~EPo4EOSmF2162721627epcas1p1V;
        Tue, 24 Jul 2018 07:49:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.10.04213.8F9D65B5; Tue, 24 Jul 2018 16:49:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180724074912epcas1p2e47dba6793b91a90b183e6cd809200bb~EPo3hWbma0369303693epcas1p2F;
        Tue, 24 Jul 2018 07:49:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180724074912epsmtrp1203ed38f8fa7e70e673bbb6c2a91f46c~EPo3cPrV80145601456epsmtrp1U;
        Tue, 24 Jul 2018 07:49:12 +0000 (GMT)
X-AuditID: b6c32a35-8d7ff70000001075-89-5b56d9f811a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.BB.03759.8F9D65B5; Tue, 24 Jul 2018 16:49:12 +0900 (KST)
Received: from [10.113.62.206] (unknown [10.113.62.206]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180724074911epsmtip24113f91e136663b732c1a0a20c7632e5~EPo2YpPBx2283222832epsmtip24;
        Tue, 24 Jul 2018 07:49:11 +0000 (GMT)
Date:   Tue, 24 Jul 2018 16:49:11 +0900
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
Subject: Re: [PATCH v3 1/9] drm/exynos: rename "bridge_node" to
 "mic_bridge_node"
In-Reply-To: <1529396370-18761-2-git-send-email-m.purski@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLsWRmVeSWpSXmKPExsWy7bCmge6Pm2HRBof2GlvcWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLF/cuslj0P37NbHH+/AZ2i7NNb9gtOicuYbfY9Pgaq8Xl
        XXPYLGac38dkseDlLRaLtUfuslssvX6RyaJ17xF2ixmTX7JZ/Nw1j8VBxGPNvDWMHpf7epk8
        ds66y+4xu2Mmq8emVZ1sHtu/PWD1uN99nMlj85J6j74tqxg9Pm+SC+CKamC0SSxKzsgsS1VI
        zUvOT8nMS7dVCg1x07VQUsjILy6xVYo2NDTSMzQw1zMyMtIztoy1MjJVUshLzE21VarQhepV
        UihKLgCqza0sBhqQk6oHFdcrTs1LccjKLwUFil5xYm5xaV66XnJ+rpJCWWJOKdAIJf2ED4wZ
        Jw48ZSpYLlrx71QnUwPjfsEuRg4OCQETiVUXgEwuDiGBHYwSG+b/YYJwPjFKNK78wgjhfGOU
        +LZgJ3MXIydYx6SDG9khEnsZJWZt/cUM4bxllLh8YAYjSBWLgKrErG2X2EBsNiB74or7YLao
        QITEzvnf2EFsXgFBiZMzn7CANIsIXGSUuHluHZjDLHCZReLQ3q8sIFXCAsESk3vXgE3lFHCV
        +Na9C2wSs4C8RPPW2WCrJQSusUtc/9sCNbZMYu6xdjaIY10kVh24zg5hC0u8Or4FypaSeNnf
        xg7R3M4o8fPPJkaIRA+jxPI9GRC2scSzhV1MoHBiFtCUWL9LHyIsKHH6WjczxBF8Eu++9rBC
        gpJXoqNNCKJESeLYxRtQEyUkLiyZCHWOh8TfX3NYIMF1mVHi9fUtjBMYFWYhhcYsJL/NQti8
        gJF5FaNYakFxbnpqsWGBIXI8b2IE5wQt0x2MU875HGIU4GBU4uGt+BIaLcSaWFZcmXuIUYKD
        WUmEt3R2WLQQb0piZVVqUX58UWlOavEhxmRgZE1klhJNzgfmq7ySeENTI2NjYwsTQzNTQ0Mk
        YRNjAwMjYBI1tzQ3xiGsJM5r5BccLSSQnliSmp2aWpBaBLOFiYNTqoExRJ+9tUdGTXPmnmVe
        YofWyzmFdK+M4Oqr9miOvsj22nt/0nuVwKWTPh31jmVi4bsiqX5V1V5G7a2ZITOnpLOd7etV
        9owZux9abwz7c2OufJ6sXN3Hm9vcy58fdTt9a868Tzfsm3ddy33nHWNkdF7puPDM4mIL9fnx
        XivLqllK183jvnbeb6USS3FGoqEWc1FxIgAD/gpGTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCSvO6Pm2HRBqcvc1jcWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLF/cuslj0P37NbHH+/AZ2i7NNb9gtOicuYbfY9Pgaq8Xl
        XXPYLGac38dkseDlLRaLtUfuslssvX6RyaJ17xF2ixmTX7JZ/Nw1j8VBxGPNvDWMHpf7epk8
        ds66y+4xu2Mmq8emVZ1sHtu/PWD1uN99nMlj85J6j74tqxg9Pm+SC+CK4rJJSc3JLEst0rdL
        4Mo4ceApU8Fy0Yp/pzqZGhj3C3YxcnJICJhITDq4kb2LkYtDSGA3o8TRh++Yuxg5gBISElu2
        ckCYwhKHDxdDlLxmlHh6ch8LSC+vgJbEye9bmUFsFgFViVnbLrGB2GxA9sQV98FsUYEwiWm/
        n7NC1AtKnJz5hAVkkIjAJUaJDZffsII4zAK3WCT+96xjAdkmLBAocX03K8S284wS517NApvE
        KeAq8a17F5jNLKAu8WfeJWYIW16ieets5gmMgrOQLJmFpGwWkrIFjMyrGCVTC4pz03OLDQsM
        81LL9YoTc4tL89L1kvNzNzGCI1dLcwfj5SXxhxgFOBiVeHgrvoRGC7EmlhVX5h5ilOBgVhLh
        LZ0dFi3Em5JYWZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QD46yq
        7/Pa+6N81ZR48h2ypeZ+O9wZv9BkomT2Z/P71yL743yeuc46v8vRqk9HcM4u1+2xwbN2M74s
        mmrdWV33dZWW7WuhVewpkrPOXu2+fvJ4XMaEWuXp4RVW7hG1ITF3qyQ7LHodjKaetDRevGjF
        5LoJx9j2vWK6NOvYPZ22lTeyOzty1h5TUWIpzkg01GIuKk4EABiaesbYAgAA
Message-Id: <20180724074912epcas1p2e47dba6793b91a90b183e6cd809200bb~EPo3hWbma0369303693epcas1p2F@epcas1p2.samsung.com>
X-CMS-MailID: 20180724074912epcas1p2e47dba6793b91a90b183e6cd809200bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180619081957eucas1p2d2b9075a9b7a90837b40e4529ab31888
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619081957eucas1p2d2b9075a9b7a90837b40e4529ab31888@eucas1p2.samsung.com>
        <1529396370-18761-2-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2018년 06월 19일 17:19에 Maciej Purski 이(가) 쓴 글:
> When adding support for peripheral out bridges, the "bridge" name
> becomes imprecise as it refers to a different device than the
> "out_bridge".

Could you give me more details? I'm afriad that I don't understand what you say.

And in case of Exynos5433 SoC, SMIES(Samsung Mobile Image Enhancement System) can be located between DECON and MIPI-DSI devices also.
Therefore, having specific name isn't reasonable.

Thanks,
Inki Dae

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
