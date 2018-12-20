Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952DA21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="feY9Pt/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbeLTQ5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:57:00 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38488 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbeLTQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:57:00 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220165657euoutp013423177ad71cc0228cae9adbf2ae377a~yGOqWtJ1f0205702057euoutp01-
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 16:56:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220165657euoutp013423177ad71cc0228cae9adbf2ae377a~yGOqWtJ1f0205702057euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545325018;
        bh=4ia7kJBN3xe9Zuv9vaJov1S1QuP8OGX4OcrqvZOrVoc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=feY9Pt/KDEgD8gC98FGxQ6X5YuDk9R45p/u2Ra+3F5sIIZEsBHe+e1xeHfYj/P8Xx
         WY7M6dMAc9BtVPW1GSPWoBqIngZ8il51A5AeM/J/bPw/EqjiLetORLdyBD5UWp6Ueg
         FyYuy2zZ+1jBKghcbouXEGb/HcxGhzsb/pLQJKoo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220165657eucas1p2d9c21f7da3627a6c3a8dd90eac26b4a6~yGOqEDyh60994909949eucas1p20;
        Thu, 20 Dec 2018 16:56:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 34.A2.04294.9D9CB1C5; Thu, 20
        Dec 2018 16:56:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181220165656eucas1p2a198d2ffce86d6ffde6c7da0f4de8eb8~yGOpEi3802397123971eucas1p2Z;
        Thu, 20 Dec 2018 16:56:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181220165656eusmtrp25eee81efb3b4c0e4b681cf7f7da22e92~yGOo2GUMP0072800728eusmtrp28;
        Thu, 20 Dec 2018 16:56:56 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-aa-5c1bc9d94cd9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.18.04284.8D9CB1C5; Thu, 20
        Dec 2018 16:56:56 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181220165656eusmtip2a87538fed8dff9201bf3fd4b9ef81c4e~yGOohbOeq0791107911eusmtip2W;
        Thu, 20 Dec 2018 16:56:55 +0000 (GMT)
Subject: Re: [PATCH -next] video: fbdev: pxafb: Fix
 "WARNING: invalid free of devm_ allocated data"
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     daniel@zonque.org, robert.jarzmik@free.fr,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <69dc564b-fb9d-98c0-6b31-2de9e0363c33@samsung.com>
Date:   Thu, 20 Dec 2018 17:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <a24ef622-d811-dd6e-450f-a75bf4392215@samsung.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7o3T0rHGNz7LmbR9PcVi8WVr+/Z
        LE70fWC1uLxrDpvFrDfCFne+PmdxYPPoX/eZ1aPlyFtWj/vdx5k8Pm+S89i+ezlLAGsUl01K
        ak5mWWqRvl0CV8bd1x+ZC9azVKxuv8bWwHieuYuRk0NCwERi86Uupi5GLg4hgRWMEn07fzNC
        OF8YJR5d2wHlfGaUeDb1PEsXIwdYy/erXBDx5YwSs09vh2p/zyix7e1qVpC5wgKpEg/Xb2YE
        sUUE1CRaTm1hBiliFuhmlHix+jE7SIJNwEpiYvsqsCJeATuJz1feMYFsYBFQlTjYJwNiigpE
        SPSfUYeoEJQ4OfMJC4jNKWAvceLLJzCbWcBA4siiOawQtrzE9rdzwFZJCExnl/gwfwUrxJ8u
        Ev9X/WaEsIUlXh3fwg5hy0j83zmfCaqBUeLNr6UsEM56Rok1Z44xQVRZSxw+fhFqkqPEycv9
        0KDgk7jxVhBiM5/EpG3TmSHCvBIdbUIQ1WoSG5ZtYIPZ1bVzJTTcPSSuvbvAOoFRcRaS32Yh
        +WcWkn8WMDKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEwxp/8d/7KDcdefpEOMAhyM
        Sjy8F7ZLxwixJpYVV+YeYpTgYFYS4V1/CCjEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQ
        QHpiSWp2ampBahFMlomDU6qBUXze640nk5mPlqiynU8zV3VIf6B3PLssafXCf319ttWXZ166
        eNJvQ8zCid+/m7tGcZnHWC0Qbmg5G3bu+P/j19de9rFgejyhujzL7Fb9zs9qurH1L89WKfRf
        btn1ZMve2XePR7I2hW19ks3ws2GycvW+Lo/Vu1o/Hs3s79gq8mXWh5Ln19hzFyqxFGckGmox
        FxUnAgCk/dgLLQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7o3TkrHGBw5L2jR9PcVi8WVr+/Z
        LE70fWC1uLxrDpvFrDfCFne+PmdxYPPoX/eZ1aPlyFtWj/vdx5k8Pm+S89i+ezlLAGuUnk1R
        fmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbd1x+ZC9az
        VKxuv8bWwHieuYuRg0NCwETi+1WuLkYuDiGBpYwSN9snMULEZSSOry/rYuQEMoUl/lzrYgOx
        hQTeMko0bnABsYUFUiXendrBDmKLCKhJtJzawgwx5zCjxOH+xUwgDrNAN1DD3YWMIFVsAlYS
        E9tXgdm8AnYSn6+8YwJZxiKgKnGwTwYkLCoQIXHrYQcLRImgxMmZT8BsTgF7iRNfPoHZzAJ6
        Ejuu/2KFsOUltr+dwzyBUXAWkpZZSMpmISlbwMi8ilEktbQ4Nz232FCvODG3uDQvXS85P3cT
        IzBqth37uXkH46WNwYcYBTgYlXh4NXZJxwixJpYVV+YeYpTgYFYS4V1/CCjEm5JYWZValB9f
        VJqTWnyI0RToh4nMUqLJ+cCIziuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE
        08fEwSnVwOh5Ql33Q88Oo4hpR7ync3+dqSz0PPp6uqHyJB315uo6xaytAg2GLu/K+vc9X1E6
        3f7C38L8Di6Bk83zeGW6TdT+1K16dDbjhGP0S3O95wy7tvAVys7efjJ419P2Ba26jdcai+12
        mPquCZnK0TpHUcvdZeMF2Z45nrfYm1mEnJ7UL5NI3SmqqcRSnJFoqMVcVJwIAA3hkgmwAgAA
X-CMS-MailID: 20181220165656eucas1p2a198d2ffce86d6ffde6c7da0f4de8eb8
X-Msg-Generator: CA
X-RootMTR: 20181116110325epcas4p1a18c4e9d98ede25027bc198065d988dd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181116110325epcas4p1a18c4e9d98ede25027bc198065d988dd
References: <CGME20181116110325epcas4p1a18c4e9d98ede25027bc198065d988dd@epcas4p1.samsung.com>
        <20181116110255.19736-1-yuehaibing@huawei.com>
        <a24ef622-d811-dd6e-450f-a75bf4392215@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/20/2018 05:55 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 11/16/2018 12:02 PM, YueHaibing wrote:
>> 'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.
>>
>> This gives this error message:
>>   ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Patch queued for 4.21, thanks.

I've just noticed v2, I will queue it instead..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
