Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40BAC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC5C2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NxVPxD0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC5C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeGYJXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:23:52 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:56025 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbeGYJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:23:51 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180725081317epoutp017b39fd873e85fcad5a422607cbb81ee3~EjnLXE2Ut0202402024epoutp01E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 08:13:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180725081317epoutp017b39fd873e85fcad5a422607cbb81ee3~EjnLXE2Ut0202402024epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532506397;
        bh=w2dzBTzZtT6uSx19WsFcfaJS84FgLmzjODDihYid/84=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=NxVPxD0DdFH8MiOT1zwmEXoJoKzDYJdBCEk4C+t3x2zGis38fx7vIruip1SgQN8O5
         tPhSyNsWOmYxSJVdcG5Nol5eH1klu1tE8gCG2yu3L/UAY9aLIn1ilA11sbGdJ28Trt
         zcExdios3T//djQiuxEawGjVXikTz8xxcfgTdwDk=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180725081313epcas1p2e08f7b294be0520129f27af7b60c9cd0~EjnIHCzZh1818118181epcas1p2_;
        Wed, 25 Jul 2018 08:13:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.C6.04292.611385B5; Wed, 25 Jul 2018 17:13:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180725081309epcas1p24823c07f661eacc35e59fdb483a2e2bb~EjnEtSsCZ0913609136epcas1p2M;
        Wed, 25 Jul 2018 08:13:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180725081309epsmtrp1a131f671eb47a6ff4899c19b6342c1df~EjnEq50IE2243022430epsmtrp1W;
        Wed, 25 Jul 2018 08:13:09 +0000 (GMT)
X-AuditID: b6c32a38-d53ff700000010c4-38-5b58311659b6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.DC.03889.511385B5; Wed, 25 Jul 2018 17:13:09 +0900 (KST)
Received: from [10.113.62.206] (unknown [10.113.62.206]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180725081309epsmtip1b8d53831780dadc6174d105e3ce5f757~EjnEN7c9j1029810298epsmtip1e;
        Wed, 25 Jul 2018 08:13:09 +0000 (GMT)
Date:   Wed, 25 Jul 2018 17:13:09 +0900
From:   Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
MIME-Version: 1.0
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Maciej Purski <m.purski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v3 1/9] drm/exynos: rename "bridge_node" to
 "mic_bridge_node"
In-Reply-To: <20180725081131eucas1p1a5a7f7e19d8ef3254dfe89049ea6d7c7~EjlpXj7zz1467114671eucas1p1f@eucas1p1.samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLsWRmVeSWpSXmKPExsWy7bCmga6YYUS0wfw9Yha31p1jteg9d5LJ
        oqnjLavFxhnrWS3mHwGKXfn6ns3ixb2LLBb9j18zW5w/v4Hd4mzTG3aLzolL2C02Pb7GanF5
        1xw2ixnn9zFZLHh5i8Vi7ZG77BZLr19ksmjde4TdYsbkl2wWP3fNY3EQ8Vgzbw2jx+W+XiaP
        nbPusnvM7pjJ6rFpVSebx/ZvD1g97ncfZ/LYvKTeo2/LKkaPz5vkAriiGhhtEouSMzLLUhVS
        85LzUzLz0m2VQkPcdC2UFDLyi0tslaINDY30DA3M9YyMjPSMLWOtjEyVFPISc1NtlSp0oXqV
        FIqSC4BqcyuLgQbkpOpBxfWKU/NSHLLyS0GBolecmFtcmpeul5yfq6RQlphTCjRCST/hA2NG
        X+s89oKtshVHpj5iamCcKNHFyMkhIWAi8enHX9YuRi4OIYEdjBJdT7ewQTifGCUefN3MDOF8
        Y5RYf+kykMMB1vJxZzREfC+jxKsfq6GK3jJKbG2+yAQyl0VAVeL95I3sIDYbkD1xxX02EFtU
        IEJi5/xvYHFeAUGJkzOfsIA0iwj8YpT4sv8O2G5mgXUsEvP6H4JVCQsES0zuXcMIYnMKlEsc
        a/nFDGIzC8hLNG+dDbZaQuAcu8ScPdPYIMaWSUw8N58J4j0XidcnfrBC2MISr45vYYewpSRe
        9rexQzS3M0r8/LOJESLRwyixfE8GhG0s8WxhFxPI08wCmhLrd+lDhAUlTl/rhjqCT+Ld1x5W
        SLjwSnS0CUGUKEkcu3gDaqKExIUlE9kgbA+Jv7/msECCay2zxN++p6wTGBVmIYXGLCS/zULY
        vICReRWjWGpBcW56arFhgQlyPG9iBOcELYsdjHvO+RxiFOBgVOLh/WAXHi3EmlhWXJl7iFGC
        g1lJhNflMFCINyWxsiq1KD++qDQntfgQYzIwsiYyS4km5wPzVV5JvKGpkbGxsYWJoZmpoSGS
        sImxgYERMImaW5ob4xBWEuc18guOFhJITyxJzU5NLUgtgtnCxMEp1cBoHTXJ7+iNnZwHl9Q2
        n1tdkVrsdltU7cTUbo6pb+qqJRb0K0yp+rXF74G91v6jEqlpBvEPOWd+2SOd6n3W+t1aOcFi
        6ZSYVpVPsxaGfOAVPp9oYPU8TmOGqEvV5Ar+0AvLuTQ/ZBmvVpA5+lvP8fzcrulHo/hm8S8U
        c3iptYfR/qE5wyfuacFKLMUZiYZazEXFiQAFCQGXTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCSnK6oYUS0weIbBha31p1jteg9d5LJ
        oqnjLavFxhnrWS3mHwGKXfn6ns3ixb2LLBb9j18zW5w/v4Hd4mzTG3aLzolL2C02Pb7GanF5
        1xw2ixnn9zFZLHh5i8Vi7ZG77BZLr19ksmjde4TdYsbkl2wWP3fNY3EQ8Vgzbw2jx+W+XiaP
        nbPusnvM7pjJ6rFpVSebx/ZvD1g97ncfZ/LYvKTeo2/LKkaPz5vkAriiuGxSUnMyy1KL9O0S
        uDL6WuexF2yVrTgy9RFTA+NEiS5GDg4JAROJjzujuxi5OIQEdjNK3Jx4nREiLiGxZSsHhCks
        cfhwMUTJa0aJbSfXsXQxcnLwCmhJ3HnVAGazCKhKvJ+8kR3EZgOyJ664zwZiiwqESUz7/ZwV
        ol5Q4uTMJywgg0QE/jBKnFt4FKyIWWATi8TXd7Igy4QFAiWu72aFWLaUWeLurF4mkBpOgXKJ
        Yy2/mCHq1SX+zLsEZctLNG+dzTyBUXAWkh2zkJTNQlK2gJF5FaNkakFxbnpusWGBUV5quV5x
        Ym5xaV66XnJ+7iZGcNRqae1gPHEi/hCjAAejEg+vh2N4tBBrYllxZe4hRgkOZiURXpfDQCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2MZat5BDJ0jrrG
        z9dZ8lziU8bGnSWv50z9IeB+aGPFHB19M8M9YRbXK//u2NHhtnVi4iXlXTeetj30PjS1u9BW
        xa24RsXlZVHDlJr4k6XfrZY+FV/+9+idpIC9G7TfO10xVzGeprVWec796W8ZSr59FZ9r38Fw
        WCOoqvTXD6bT6asPL7Bx0p3op8RSnJFoqMVcVJwIAMlLyC3WAgAA
Message-Id: <20180725081309epcas1p24823c07f661eacc35e59fdb483a2e2bb~EjnEtSsCZ0913609136epcas1p2M@epcas1p2.samsung.com>
X-CMS-MailID: 20180725081309epcas1p24823c07f661eacc35e59fdb483a2e2bb
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
        <20180724074912epcas1p2e47dba6793b91a90b183e6cd809200bb~EPo3hWbma0369303693epcas1p2F@epcas1p2.samsung.com>
        <20180725081131eucas1p1a5a7f7e19d8ef3254dfe89049ea6d7c7~EjlpXj7zz1467114671eucas1p1f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



2018년 07월 25일 17:11에 Andrzej Hajda 이(가) 쓴 글:
> On 24.07.2018 09:49, Inki Dae wrote:
>> Hi,
>>
>> 2018년 06월 19일 17:19에 Maciej Purski 이(가) 쓴 글:
>>> When adding support for peripheral out bridges, the "bridge" name
>>> becomes imprecise as it refers to a different device than the
>>> "out_bridge".
>> Could you give me more details? I'm afriad that I don't understand what you say.
> 
> The problem is that MIC is an input bridge and now we will have also
> output bridge (Toshiba DSI/LVDS converter).
> So we will have to distinguish them.
> 
>>
>> And in case of Exynos5433 SoC, SMIES(Samsung Mobile Image Enhancement System) can be located between DECON and MIPI-DSI devices also.
>> Therefore, having specific name isn't reasonable.
> 
> So probably in_bridge would be a better name. I will rephrase message
> and bridge name.

Good idea. :)

Thanks,
Inki Dae

> 
> Regars
> Andrzej
> 
> 
>>
>> Thanks,
>> Inki Dae
>>
>>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>> ---
>>>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 16 ++++++++--------
>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>>> index eae44fd..9599e6b 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
>>> @@ -279,7 +279,7 @@ struct exynos_dsi {
>>>  	struct list_head transfer_list;
>>>  
>>>  	const struct exynos_dsi_driver_data *driver_data;
>>> -	struct device_node *bridge_node;
>>> +	struct device_node *mic_bridge_node;
>>>  };
>>>  
>>>  #define host_to_dsi(host) container_of(host, struct exynos_dsi, dsi_host)
>>> @@ -1631,7 +1631,7 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
>>>  	if (ret < 0)
>>>  		return ret;
>>>  
>>> -	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
>>> +	dsi->mic_bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
>>>  
>>>  	return 0;
>>>  }
>>> @@ -1642,7 +1642,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>>>  	struct drm_encoder *encoder = dev_get_drvdata(dev);
>>>  	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
>>>  	struct drm_device *drm_dev = data;
>>> -	struct drm_bridge *bridge;
>>> +	struct drm_bridge *mic_bridge;
>>>  	int ret;
>>>  
>>>  	drm_encoder_init(drm_dev, encoder, &exynos_dsi_encoder_funcs,
>>> @@ -1661,10 +1661,10 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>>>  		return ret;
>>>  	}
>>>  
>>> -	if (dsi->bridge_node) {
>>> -		bridge = of_drm_find_bridge(dsi->bridge_node);
>>> -		if (bridge)
>>> -			drm_bridge_attach(encoder, bridge, NULL);
>>> +	if (dsi->mic_bridge_node) {
>>> +		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
>>> +		if (mic_bridge)
>>> +			drm_bridge_attach(encoder, mic_bridge, NULL);
>>>  	}
>>>  
>>>  	return mipi_dsi_host_register(&dsi->dsi_host);
>>> @@ -1783,7 +1783,7 @@ static int exynos_dsi_remove(struct platform_device *pdev)
>>>  {
>>>  	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
>>>  
>>> -	of_node_put(dsi->bridge_node);
>>> +	of_node_put(dsi->mic_bridge_node);
>>>  
>>>  	pm_runtime_disable(&pdev->dev);
>>>  
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
