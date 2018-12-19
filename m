Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C87FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37999218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m5cevB4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbeLSOx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:53:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51183 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbeLSOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:53:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181219145354euoutp0121c004414aeb5666f863580bdf24e851~xw57oYVph0142801428euoutp01X
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:53:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181219145354euoutp0121c004414aeb5666f863580bdf24e851~xw57oYVph0142801428euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545231234;
        bh=Y6bmY2JKspcwn36FGEDiw039IZbORcTtwHojQmWMEvs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=m5cevB4MVC92v8wi1SGLXsbe/0P6NHbLlD4HG3QKFTz5ztl/ARqo76cM0Sn9BJqPM
         MWHSvdB6zzQhaFXUAXMwIQYEhR9/0IcW2ouXpCl1F21uL3HK/PX2lEcC/fZ+UlLVQe
         PUqwwHdfaN/gxNtLxFr02FadV7C2c02yGfnZqeYU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181219145353eucas1p1b6b72a4ecb4cb7a7faa12421ed46d20a~xw56o3wRy0942009420eucas1p1T;
        Wed, 19 Dec 2018 14:53:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AB.50.04806.18B5A1C5; Wed, 19
        Dec 2018 14:53:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181219145352eucas1p2230eb8770876d17bbd641016bcdb6b03~xw55vhbCj2562125621eucas1p2f;
        Wed, 19 Dec 2018 14:53:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181219145352eusmtrp14b3d862bcba330624df6a0420f887785~xw55hHchr2672226722eusmtrp1Z;
        Wed, 19 Dec 2018 14:53:52 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-fc-5c1a5b81ef49
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C1.BB.04128.08B5A1C5; Wed, 19
        Dec 2018 14:53:52 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181219145351eusmtip183f1b898b9f4727c2967eb2a503cca3b~xw55KXPPH0345903459eusmtip1f;
        Wed, 19 Dec 2018 14:53:51 +0000 (GMT)
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de, Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <442867b9-2d36-4b14-56ee-b4bb8e6be4c0@samsung.com>
Date:   Wed, 19 Dec 2018 15:53:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219143451.GY16835@8bytes.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7qN0VIxBtd3Mlss2G9t0Tl7A7vF
        5FNzmSzOnweyLu+aw2Zx8MMTVovlp3awOLB7PDk4j8ljzbw1jB6bVnWyeUy+sZzRY/Ppao/P
        m+QC2KK4bFJSczLLUov07RK4MqZN2cFUsEakom35GaYGxi0CXYycHBICJhILp39i6WLk4hAS
        WMEo8evCVTYI5wujRNfsk1DOZ0aJHU/fMsO0nFr4gh0isZxR4tKec0wQzntGiY4T79hBqoQF
        fCQu9DSAdYgIKElc/9zKClLELHCCUeLG12WsIAk2AUOJrrddbCA2r4CdxN0TO8HiLAKqEr3/
        v4DFRQViJJ427GOBqBGUODnzCZjNKWAg8fzUHLB6ZgF5ie1v5zBD2OISt57MB7tIQmATu8SX
        plnsEHe7SEztuQn1g7DEq+NboOIyEqcn97BANDQzSrTPmMUO4fQwSmyds4MNospa4vDxi0Dr
        OIBWaEqs36UPEXaUOHqwhw0kLCHAJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJzDq+Dm7twQuX
        mCcwKs1C8tosJO/MQvLOLIS9CxhZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgSmo9P/
        jn/dwbjvT9IhRgEORiUe3hlRUjFCrIllxZW5hxglOJiVRHhvmACFeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1ME5d7WK1fOaN0Guv5acvK1efHHXoWbt+
        5PENVhOUP20ymdW9QvH0m+OSMQtWzyy/OG99ncyLotBs096SA/oHl35cFxS+dM+2smunazYW
        Cv1xTwwPnnN4h9DHLydeLHOq6pw+d0v6ef91x/L6Y/lnvZU4bPpYw34Gf01Ph8K7/1OmVf7p
        647WlrytxFKckWioxVxUnAgADjdFtEMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7oN0VIxBhO2cFgs2G9t0Tl7A7vF
        5FNzmSzOnweyLu+aw2Zx8MMTVovlp3awOLB7PDk4j8ljzbw1jB6bVnWyeUy+sZzRY/Ppao/P
        m+QC2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0
        MqZN2cFUsEakom35GaYGxi0CXYycHBICJhKnFr5g72Lk4hASWMoosfLzOjaIhIzEyWkNrBC2
        sMSfa11sEEVvGSUWfV7GCJIQFvCRuNDTwAxiiwgoSVz/3MoKUsQscIJR4vmpDkaIjj4miS2z
        p4F1sAkYSnS97QJbwStgJ3H3xE6wFSwCqhK9/78AxTk4RAViJJ4tqIYoEZQ4OfMJC4jNKWAA
        NHMOWDmzgLrEn3mXmCFseYntb+dA2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlx
        bnpusZFecWJucWleul5yfu4mRmD0bTv2c8sOxq53wYcYBTgYlXh4Z0RJxQixJpYVV+YeYpTg
        YFYS4b1hAhTiTUmsrEotyo8vKs1JLT7EaAr020RmKdHkfGBiyCuJNzQ1NLewNDQ3Njc2s1AS
        5z1vUBklJJCeWJKanZpakFoE08fEwSnVwKgbGWFfz2cStPL9zFpB6Wqpsz3br/27u5A7hnH/
        mYqON+8DQ91V/s69EMl88OiqDc6xkZfuVC+KcrkbLSPtWPMpw2zCZ43OYP1pXfsNBdRFZx9t
        MrFZ99d9QbnHYhG/RX0Z14/kbV08t7IxValFckud9FTWWoeSbd0TJm7KuJp0T2+iYMazTCWW
        4oxEQy3mouJEAGASdGzUAgAA
X-CMS-MailID: 20181219145352eucas1p2230eb8770876d17bbd641016bcdb6b03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6
References: <20181211150513.15161-1-joro@8bytes.org>
        <CGME20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6@epcas5p4.samsung.com>
        <20181211150513.15161-4-joro@8bytes.org>
        <30d86186-e0a2-2be1-2295-20510fbd74ba@samsung.com>
        <20181219143451.GY16835@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2018-12-19 15:34, Joerg Roedel wrote:
> Hi Marek,
>
> thanks for the report!
>
> On Wed, Dec 19, 2018 at 10:54:18AM +0100, Marek Szyprowski wrote:
>> On 2018-12-11 16:05, Joerg Roedel wrote:
>>> From: Joerg Roedel <jroedel@suse.de>
>>>
>>> Make sure to invoke this call-back through the proper
>>> function of the IOMMU-API.
>>>
>>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>>> ---
>>>  drivers/iommu/of_iommu.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>> index c5dd63072529..4d4847de727e 100644
>>> --- a/drivers/iommu/of_iommu.c
>>> +++ b/drivers/iommu/of_iommu.c
>>> @@ -218,10 +218,10 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>>  		ops = dev->iommu_fwspec->ops;
>>>  	/*
>>>  	 * If we have reason to believe the IOMMU driver missed the initial
>>> -	 * add_device callback for dev, replay it to get things in order.
>>> +	 * probe for dev, replay it to get things in order.
>>>  	 */
>>> -	if (ops && ops->add_device && dev->bus && !dev->iommu_group)
>>> -		err = ops->add_device(dev);
>>> +	if (dev->bus && !dev->iommu_group)
>>> +		err = iommu_probe_device(dev);
>> This change removes a check for NULL ops, what causes NULL pointer
>> exception on first device without IOMMU.
> Bummer, this check was supposed to be in iommu_probe_device(), but
> apparently it got lost. Does the attached patch fix it?

Yes, it fixes this issue.

>> I'm also not sure if this is a good idea to call iommu_probe_device(),
>> which comes from dev->bus->iommu_ops, which might be different from ops
>> from local variable.
> The local variable comes from dev->iommu_fwspec->ops, which should be
> exactly the same as dev->bus->iommu_ops. I'll leave that for now until
> it turns out to be a problem (which I don't expect).
>
>
> Regards,
>
> 	Joerg
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a2131751dcff..3ed4db334341 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -114,10 +114,14 @@ void iommu_device_unregister(struct iommu_device *iommu)
>  int iommu_probe_device(struct device *dev)
>  {
>  	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +	int ret = -EINVAL;
>  
>  	WARN_ON(dev->iommu_group);
>  
> -	return ops->add_device(dev);
> +	if (ops)
> +		ret = ops->add_device(dev);
> +
> +	return ret;
>  }
>  
>  void iommu_release_device(struct device *dev)
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

