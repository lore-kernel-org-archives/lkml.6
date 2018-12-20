Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FC0218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mxsD0hrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbeLTRxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:53:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42504 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388195AbeLTRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:53:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220175341euoutp02eaaca7e115440d45474753daa901abdb~yHAMOE3iZ0529305293euoutp026
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 17:53:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220175341euoutp02eaaca7e115440d45474753daa901abdb~yHAMOE3iZ0529305293euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545328421;
        bh=7R+qDZhiCWmhvURf1JYJL7DAbduo/6tr4ettz4Rh0BE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mxsD0hrVv46YabGvBkMZf6DM0VWlJdene55cG2AkV4FlaFpI/HKns2CdrOmbBfCJZ
         Rg7bNvrhD6tpUYGxHa9vCkydBqb4CESdE1WLWj9mFbXh8Brsj5ZVNjWQtGYQwIZHzN
         I39TIiuuLoyllR//amvRniR8oYWr50/lLVjn6ziA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220175340eucas1p1071015833742f5b468b0cd76c5c9ccef~yHALjzPFW0750907509eucas1p1j;
        Thu, 20 Dec 2018 17:53:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 67.95.04294.427DB1C5; Thu, 20
        Dec 2018 17:53:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181220175339eucas1p18dd5e1d55a773b4b5f08df3b94716f08~yHAKgyp3n0473604736eucas1p1D;
        Thu, 20 Dec 2018 17:53:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181220175339eusmtrp2e0858c446ea8307aebc2ec513b40be46~yHAKSfkdr1632016320eusmtrp2f;
        Thu, 20 Dec 2018 17:53:39 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c5-5c1bd724e271
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.9F.04128.327DB1C5; Thu, 20
        Dec 2018 17:53:39 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181220175338eusmtip10209efd4f6f8602c614bf2c82458307f~yHAJyI7Qf2493024930eusmtip14;
        Thu, 20 Dec 2018 17:53:38 +0000 (GMT)
Subject: Re: [PATCH v2] media: omap2: omapfb: convert to
 DEFINE_SHOW_ATTRIBUTE
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     fengguang.wu@intel.com, mchehab+samsung@kernel.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8bfa8290-cf27-a270-8809-1a6070b139b1@samsung.com>
Date:   Thu, 20 Dec 2018 18:53:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181202041448.10049-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7oq16VjDLZ/Vra48vU9m8X75+uZ
        LU70fWC1uLxrDpvF7CX9LBbvP3UyWcz9PYHNgd1j56y77B6L97xk8ti0qpPN4373cSaPz5vk
        AlijuGxSUnMyy1KL9O0SuDJ6931gL3jOVPH4ehdzA+MSpi5GTg4JAROJhQtXAdlcHEICKxgl
        nj99zgrhfGGU2DF3MRuE85lR4s2BOXAtd6/vhqpazigx/es0qKr3jBKvO1cyglQJCwRI/P3f
        xgJiiwioSayY+A6sg1lgE6PE4ZsdYKPYBKwkJravAmvgFbCTmPBkD1Ccg4NFQFXi2SdbEFNU
        IEKi/4w6RIWgxMmZT8BGcgpYSzxatBpsCrOAgcSRRXNYIWx5ie1v5zCDrJIQWMUucWrvf3aI
        q10kHsy+DPWBsMSr41ug4jIS/3fOZ4JomA705q+lLBDOekaJNWeOQXVYSxw+fpEV5CIJAUeJ
        t73OECafxI23ghCL+SQmbZvODBHmlehoE4JoVJPYsGwDG8yqrp0rmSFsD4mdC6+zTmBUnIXk
        tVlI3pmF5J0FjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAtPN6X/Hv+xg3PUn6RCj
        AAejEg/vhe3SMUKsiWXFlbmHGCU4mJVEeNcfAgrxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4
        EC0kkJ5YkpqdmlqQWgSTZeLglGpg9JDoWngk/PnZDMZHN2ZK8YXF9v21nx2RbG3dbTyDTaub
        /9Ny8XNnDaa3H7v7aPKlbwvUPvn4bvVOlHEsFYo+Lbb/xE19/VULl+60fSFm//7MhOjfJla8
        k/gdvrCUez42T33jx2ih+lRNh+fBwk79xBmnn6xyrt0z94DDk7ONYlYlrXt+8r2vVGIpzkg0
        1GIuKk4EAH02iHMzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7rK16VjDE5Nl7S48vU9m8X75+uZ
        LU70fWC1uLxrDpvF7CX9LBbvP3UyWcz9PYHNgd1j56y77B6L97xk8ti0qpPN4373cSaPz5vk
        Alij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ6
        931gL3jOVPH4ehdzA+MSpi5GTg4JAROJu9d3s3YxcnEICSxllLiyYzVbFyMHUEJG4vj6Moga
        YYk/17rYIGreMkrcm/aFFSQhLOAnsaHrHhuILSKgJrFi4juoQX2MEnufbWICcZgFNjFKHJ0y
        FWwdm4CVxMT2VYwgNq+AncSEJ3uYQLaxCKhKPPtkCxIWFYiQuPWwgwWiRFDi5MwnYDangLXE
        o0WrwcYwC+hJ7Lj+ixXClpfY/nYO8wRGwVlIWmYhKZuFpGwBI/MqRpHU0uLc9NxiI73ixNzi
        0rx0veT83E2MwCjaduznlh2MXe+CDzEKcDAq8fBq7JKOEWJNLCuuzD3EKMHBrCTCu/4QUIg3
        JbGyKrUoP76oNCe1+BCjKdAPE5mlRJPzgRGeVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2x
        JDU7NbUgtQimj4mDU6qBMWxF6YTNM5sfrdo156cb+97pbr8L2e8dPx18yVZ4je3ptvv7Z016
        KZWc/nGhYdYPRduWL4c6rKS19ALTpLbnb7iof+Jx5b02PYW1F49aNDyyPxR876LJ+knsyxs5
        P+dFHrdPa1nr8U9GY6rMqciM3VKOwvc/a7patpd5/5k0b8a+OB+mkyfXGymxFGckGmoxFxUn
        AgBIZDAyuAIAAA==
X-CMS-MailID: 20181220175339eucas1p18dd5e1d55a773b4b5f08df3b94716f08
X-Msg-Generator: CA
X-RootMTR: 20181202041516epcas2p15e1891900f58e7da0a4a18148ffa8060
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181202041516epcas2p15e1891900f58e7da0a4a18148ffa8060
References: <CGME20181202041516epcas2p15e1891900f58e7da0a4a18148ffa8060@epcas2p1.samsung.com>
        <20181202041448.10049-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/02/2018 05:14 AM, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Patch queued for 4.21, thanks.

[ subject line was fixed to "fbdev" from "media" while applying ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
