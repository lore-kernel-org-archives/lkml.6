Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14FBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7BA218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZR0DifR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeLSJyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:54:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47422 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbeLSJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:54:24 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181219095421euoutp0100238ca97b2042e6d3c340eb1948374c~xs0ZcodOb2830828308euoutp01c
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:54:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181219095421euoutp0100238ca97b2042e6d3c340eb1948374c~xs0ZcodOb2830828308euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545213261;
        bh=KUy7ni1XgxOt4znMhWvVZ+IZsCl+aL9yNW0Vn+JNawE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZR0DifR3nwiQdAhL/GccxsWgDa6dRzO8uJ5a7fxghOIQi2jYV5v19FLqTg2e25Xxh
         +lUCgsVQBhU2Bf3+nEP2fe7k4IES/4YCWAvfsg0fSi/YmOCR2M2plAGtjoPRq+xhfP
         s4qsG2L6hQa4exGgq+2uF6Z3EV/6Z1Qf12REbODc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181219095421eucas1p2b5a62961eed60f46c4f780bc335609f3~xs0Yr98Ul0171301713eucas1p2p;
        Wed, 19 Dec 2018 09:54:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 82.B4.04806.C451A1C5; Wed, 19
        Dec 2018 09:54:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181219095420eucas1p17dcf5ec60601a335dbdfd48c7132038c~xs0XtY3vR1721517215eucas1p1n;
        Wed, 19 Dec 2018 09:54:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181219095419eusmtrp2dc4ef983ecbf7fbfccc8c840e4235eae~xs0Xe2guz1185511855eusmtrp2Z;
        Wed, 19 Dec 2018 09:54:19 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-af-5c1a154ceefb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C4.F0.04128.B451A1C5; Wed, 19
        Dec 2018 09:54:19 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181219095419eusmtip2ebf6a57b20d08641a13b0311bb6dc57f~xs0XKfOB41296712967eusmtip2i;
        Wed, 19 Dec 2018 09:54:19 +0000 (GMT)
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, jroedel@suse.de,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <30d86186-e0a2-2be1-2295-20510fbd74ba@samsung.com>
Date:   Wed, 19 Dec 2018 10:54:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181211150513.15161-4-joro@8bytes.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7o+olIxBoevmFgs2G9t0Tl7A7vF
        5FNzmSzOnweyLu+aw2Zx8MMTVovlp3awOLB7PDk4j8ljzbw1jB6bVnWyeUy+sZzRY/Ppao/P
        m+QC2KK4bFJSczLLUov07RK4MloP+hfM5Km4/GQVYwPjI84uRk4OCQETifOTz7J1MXJxCAms
        YJT4sOQFO4TzhVHi1IduVgjnM6NEQ9sPZpiWjS0noRLLGSVO77nOCOG8Z5TYuruRFaRKWMBH
        4kJPA1iHiICLxPUfl8HmMgssY5Q4vmcNC0iCTcBQouttFxuIzStgJ7H6zWGwOIuAqsSDmT/A
        BokKxEg8bdjHAlEjKHFy5hMgm4ODU8BUYupsGZAws4C8xPa3c5ghbHGJW0/mM0FcuoldYl5H
        NITtIjFl+X6oD4QlXh3fwg5hy0j83wlSzwVkNzNKtM+YxQ7h9AB9M2cHG0SVtcTh4xdZQRYz
        C2hKrN+lDxF2lDh6sIcNJCwhwCdx460gxA18EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl5gn
        MCrNQvLYLCTfzELyzSyEvQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJqLT/45/
        3cG470/SIUYBDkYlHt4HSpIxQqyJZcWVuYcYJTiYlUR4L0UDhXhTEiurUovy44tKc1KLDzFK
        c7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTAWPz1ZHSbyXuJloouuwjPe6HVty33PdD9j
        3S1Ytn7RShm1ba/7EljFZPVELQ7+kds532RX+bMlqY2yk47Ff+rlOr3MY8+P8jUH/nOHWvqc
        Ysxa8HVO+PImvtW+3vW6/hm2dz/P9ddwmiedpC/QdMjgYKNn8vGHCkvF3l4rNcgW+HOawel7
        9SUlluKMREMt5qLiRACIdRlVQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7reolIxBs1XDC0W7Le26Jy9gd1i
        8qm5TBbnzwNZl3fNYbM4+OEJq8XyUztYHNg9nhycx+SxZt4aRo9NqzrZPCbfWM7osfl0tcfn
        TXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6
        Ga0H/Qtm8lRcfrKKsYHxEWcXIyeHhICJxMaWk6wgtpDAUkaJvxclIOIyEienNbBC2MISf651
        sXUxcgHVvGWUWPOziQUkISzgI3Ghp4EZxBYRcJG4/uMyO0gRs8AyRon2/9OYIDo2M0osbPrA
        BlLFJmAo0fW2C8zmFbCTWP3mMNgkFgFViQczfwCt4+AQFYiReLagGqJEUOLkzCcsIGFOAVOJ
        qbNlQMLMAuoSf+ZdYoaw5SW2v50DZYtL3Hoyn2kCo9AsJN2zkLTMQtIyC0nLAkaWVYwiqaXF
        uem5xUZ6xYm5xaV56XrJ+bmbGIFxt+3Yzy07GLveBR9iFOBgVOLh7VKQjBFiTSwrrsw9xCjB
        wawkwnspGijEm5JYWZValB9fVJqTWnyI0RTotYnMUqLJ+cCUkFcSb2hqaG5haWhubG5sZqEk
        znveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgZH1t+X7B95vZzDE2s51qnkrbrXobbXYpPO7xNXV
        d4u9j6qb8yHFlq0t7YWf5v0KA7VN6VJC+Xpbpn2Ov9qxxSefgfln1Ls+rZMvbMrnf2iPUr9W
        PHG/3L2uUPsZ7G8eqJ18Os/3Pw+viVBitGHxf68lW7/KKIjtttjM3bDUsOdKrrN8VIz+ESWW
        4oxEQy3mouJEADhMl5zRAgAA
X-CMS-MailID: 20181219095420eucas1p17dcf5ec60601a335dbdfd48c7132038c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6
References: <20181211150513.15161-1-joro@8bytes.org>
        <CGME20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6@epcas5p4.samsung.com>
        <20181211150513.15161-4-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This patch landed in today's linux-next and causes a regression.

On 2018-12-11 16:05, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Make sure to invoke this call-back through the proper
> function of the IOMMU-API.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/of_iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index c5dd63072529..4d4847de727e 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -218,10 +218,10 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  		ops = dev->iommu_fwspec->ops;
>  	/*
>  	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * add_device callback for dev, replay it to get things in order.
> +	 * probe for dev, replay it to get things in order.
>  	 */
> -	if (ops && ops->add_device && dev->bus && !dev->iommu_group)
> -		err = ops->add_device(dev);
> +	if (dev->bus && !dev->iommu_group)
> +		err = iommu_probe_device(dev);

This change removes a check for NULL ops, what causes NULL pointer
exception on first device without IOMMU.

I'm also not sure if this is a good idea to call iommu_probe_device(),
which comes from dev->bus->iommu_ops, which might be different from ops
from local variable.

>  
>  	/* Ignore all other errors apart from EPROBE_DEFER */
>  	if (err == -EPROBE_DEFER) {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

