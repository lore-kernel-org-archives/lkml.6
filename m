Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94707C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E4214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HK8s0Twq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfA2Iz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:55:57 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58020 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfA2Iz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:55:57 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190129085555euoutp0116ed997973f7088ca8cb7829c61ab20e~_ReFHfqpc0605906059euoutp01X
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:55:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190129085555euoutp0116ed997973f7088ca8cb7829c61ab20e~_ReFHfqpc0605906059euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548752155;
        bh=HWWJRD/F39wd5bMMzYGgGh41xrQ71R5TE5To9H1MHdg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HK8s0TwqMfLe1wnPF0XfUAkvI3MA5EbNL9pAk3tOyRyb9melIKDKWp2+W3xfU0Xlt
         7Zb4DJZadOVxUa4J+tg3H0boWmM65C0S1qNoIhzt82D5r/apuQcyCpqveP3j61MDE5
         Y/xQ26vWQpLs6lvpYtUyvq7r+l07vMEwdXzl5GHI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190129085554eucas1p2ccfae275f14f78d128e6231259474754~_ReENMNt92103821038eucas1p2k;
        Tue, 29 Jan 2019 08:55:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 65.48.04806.A15105C5; Tue, 29
        Jan 2019 08:55:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190129085553eucas1p2b6b4789a8f29e34563dcebd524086b24~_ReDNceu73159631596eucas1p23;
        Tue, 29 Jan 2019 08:55:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190129085553eusmtrp2db17e0edbef1e22f6141c2c006d9b3ea~_ReC86M2R1767517675eusmtrp2d;
        Tue, 29 Jan 2019 08:55:53 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-08-5c50151a2a6c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 20.49.04128.915105C5; Tue, 29
        Jan 2019 08:55:53 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190129085552eusmtip23a51c0299a0f5f38db47435208b6dac4~_ReCMnL_b2633726337eusmtip2y;
        Tue, 29 Jan 2019 08:55:52 +0000 (GMT)
Subject: Re: [PATCH 1/4] IOMMU: Make dwo drivers use stateless device links
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f6d582d6-0bfc-d732-3f68-b850e4b17f99@samsung.com>
Date:   Tue, 29 Jan 2019 09:55:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3532356.d9GMSSLOvP@aspire.rjw.lan>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUyNYRjueb/O2+HUc45a99Kws2HZcArbO7XURnvND/nDVkmHXoU6ck6F
        okkRJ5WUj44i64ukfKTScAjnIEq1PseWzUrmaFZqqaS3t+jfdd/XdV/3fT17WFI1TLuy+3Qx
        gl6njVQzcqraMtq00tU5IFjzvM+N665opLnJ6iySSy6sZLiRzvcMl/02n+B68rsI7mxWkYzL
        GS8luNa6PIYbTH+JuPqLTxD3tW8h966hheZG665RnPXODl9HvrW9meSfDBdQ/CPTJxl/9Uwu
        zX9sf8zw5vxyGZ85oeGr2lIpfsJkpviMqjLEP2hI4AfvL+KvpFbTAYpAuXeYELkvTtCv9gmV
        RyT1n2aiJ5VHTrWNESdQm4MR2bOA10Jy+lnKiOSsCt9E8HBglJCKIQQjNWkzzCCCH8ZxYnbE
        Zk6hJaIUwWBv+UwxgGBoWJxn2QV4C3z+6CUOOOFE6Mr+TYoaEv8kwZxZMO3EYA8w2oyMiBXY
        B/oLzk1jCi+FytbbSPRxxsFwqlUuSZTwJvcLJWJ7rIGcu5m0iEm8GGpseaSEXaD7y/XpCICL
        WRjN6qFEH8AbYThXJgVYAN+sVTPYDSYfzeqTEaReMcmk4tzUY+TVMpLKC15Ym2nRiMTuUFm3
        Wmr7gaUojZb8HaDTppRucIAL1ZdJqa2AM6dVknoZmKwV/9Y+/9BCnkdq05xkpjlpTHPSmP7v
        LUBUGXIRYg1R4YJhjU44vMqgjTLE6sJX7TkYdR9N/caGP9Zftejp+O56hFmknq/QMFuDVbQ2
        znA0qh4BS6qdFB5jUy1FmPZovKA/uEsfGykY6tFCllK7KBLseoJUOFwbIxwQhGhBP8sSrL3r
        CbQux9+/STmS1hv/o+J8b3HIdoeTbTdSXJR2YYR3Bh4K/O7h+crdJ2jJw4jDm5P9mgOWf3p2
        3CvRLStpk6Uk1+bXUcT4W7e8aTq0vT2E1m+L278hsSQ9fN6GvbdCGc36YzsHPFcSjl01vp49
        672LLYUZv1pslSO6e+aO1421l9Qxljo1ZYjQeqwg9QbtX8KHMxOJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42I5/e/4PV1J0YAYgwenxCxurTvHavF/20Rm
        i+bF69ksvt84y2Yx+dRcJosHc28yWXROXMJuMeXPciaLy7vmsFl87j3CaHFo6l5GixfPpS3O
        nL7EavFz1zwWi+Nrwx34PS5fu8jssffbAhaPnbPusnvM7pjJ6nHn2h42j/1z17B79P818Nhy
        tZ3F4++s/SwefVtWMXpsPl3t8XmTnMeM9m2sAbxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpG
        JpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmNL9vYCv4LVrRe/c3UwHiVr4uRk0NCwETi7f4W
        1i5GLg4hgaWMEocaLrBDJGQkTk5rYIWwhSX+XOtigyh6yygxf+1Sli5GDg5hAW+Jh3esQeIi
        Ag2MElPebWIHcZgFPjNL3Hn2CKpjJaPEgobZYKPYBAwlut6CjOLk4BWwk3i5oAfMZhFQlVh/
        eTUjiC0qECMx60kfO0SNoMTJmU9YQGxOAQOJKRv6weYwC6hL/Jl3iRnClpfY/nYOlC0ucevJ
        fKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgQmhG3Hfm7Z
        wdj1LvgQowAHoxIPrwGbf4wQa2JZcWXuIUYJDmYlEV7D30Ah3pTEyqrUovz4otKc1OJDjKZA
        z01klhJNzgcmq7ySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxSDYyy
        SveurA18OfPMgzzl9P2hvvzrjqQtiZZ8dp0pP9TrcRdj4v8stimW7EkSL29LX/91nGtTzvU/
        QrWfKhj/u6303a5+7/b3KRpmj+0sH9WWbtIwKry4et7HbsttPpmKJZcuFC91eOGyuITluuK8
        tYeOrWfddjp82hLtfZMd43fe22d7/cWdzTYPlViKMxINtZiLihMBxvmB3B4DAAA=
X-CMS-MailID: 20190129085553eucas1p2b6b4789a8f29e34563dcebd524086b24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190128231505epcas3p195bf340a9bd6195028051b2a91c977e3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128231505epcas3p195bf340a9bd6195028051b2a91c977e3
References: <2405639.4es7pRLqn0@aspire.rjw.lan>
        <CGME20190128231505epcas3p195bf340a9bd6195028051b2a91c977e3@epcas3p1.samsung.com>
        <3532356.d9GMSSLOvP@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 2019-01-29 00:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The device links used by rockchip-iommu and exynos-iommu are
> completely managed by these drivers within the IOMMU framework,
> so there is no reason to involve the driver core in the management
> of these links.
>
> For this reason, make rockchip-iommu and exynos-iommu pass
> DL_FLAG_STATELESS in flags to device_link_add(), so that the device
> links used by them are stateless.
>
> [Note that this change is requisite for a subsequent one that will
>  rework the management of stateful device links in the driver core
>  and it will not be compatible with the two drivers in question any
>  more.]
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Indeed there is no need to use driver-state tracking feature of device
links in this case.

For the Exynos IOMMU driver:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>  drivers/iommu/exynos-iommu.c   |    1 +
>  drivers/iommu/rockchip-iommu.c |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/iommu/rockchip-iommu.c
> ===================================================================
> --- linux-pm.orig/drivers/iommu/rockchip-iommu.c
> +++ linux-pm/drivers/iommu/rockchip-iommu.c
> @@ -1071,7 +1071,8 @@ static int rk_iommu_add_device(struct de
>  	iommu_group_put(group);
>  
>  	iommu_device_link(&iommu->iommu, dev);
> -	data->link = device_link_add(dev, iommu->dev, DL_FLAG_PM_RUNTIME);
> +	data->link = device_link_add(dev, iommu->dev,
> +				     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
>  
>  	return 0;
>  }
> Index: linux-pm/drivers/iommu/exynos-iommu.c
> ===================================================================
> --- linux-pm.orig/drivers/iommu/exynos-iommu.c
> +++ linux-pm/drivers/iommu/exynos-iommu.c
> @@ -1260,6 +1260,7 @@ static int exynos_iommu_add_device(struc
>  		 * direct calls to pm_runtime_get/put in this driver.
>  		 */
>  		data->link = device_link_add(dev, data->sysmmu,
> +					     DL_FLAG_STATELESS |
>  					     DL_FLAG_PM_RUNTIME);
>  	}
>  	iommu_group_put(group);
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

