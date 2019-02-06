Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C7CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6D5218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YjkzD+nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfBFHhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:37:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43490 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:37:22 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190206073720euoutp0161f08baca9bb8eea4ea451b7de70d753~Atjv7ktjT0163201632euoutp01D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Feb 2019 07:37:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190206073720euoutp0161f08baca9bb8eea4ea451b7de70d753~Atjv7ktjT0163201632euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549438640;
        bh=7sIQJjlPdGCwToZ8r0WoOLQI3Bpa2/lSbfznut460IQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YjkzD+nluKrPztWNxcCYt72sz6JwaSPYgCqyw20325LZ9UwLjmtTU8CBLgn9p/g9s
         xBV/IdTReFTR865JQN/RJy8DK7RYcqGLhPDH9bX6zSCTl4lWqixOUmkZWHOOMfCs9t
         exHrGDjg2z1c+iWlc01Ixn8G2cU1PVe3StxsSar4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190206073720eucas1p1141857c4cd91039cb795a2b349dfc5ac~AtjvbZii_2639626396eucas1p1a;
        Wed,  6 Feb 2019 07:37:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.B2.04806.FAE8A5C5; Wed,  6
        Feb 2019 07:37:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190206073718eucas1p1899ad5f1552a818baa997fb16aab6795~AtjuYIvBp2203422034eucas1p1p;
        Wed,  6 Feb 2019 07:37:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190206073718eusmtrp19e79f703233fd2455d0f0f1538346a78~AtjuJ237M0576305763eusmtrp1Q;
        Wed,  6 Feb 2019 07:37:18 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-59-5c5a8eafe3df
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.85.04128.EAE8A5C5; Wed,  6
        Feb 2019 07:37:18 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190206073718eusmtip1bab7d45da6290b9fadecacd4947871e1~AtjtycNmt0208802088eusmtip1j;
        Wed,  6 Feb 2019 07:37:18 +0000 (GMT)
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
To:     Thierry Reding <thierry.reding@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <0c7e53b3-c9b8-aa57-0317-dcf7ff522721@samsung.com>
Date:   Wed, 6 Feb 2019 08:37:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190205222912.GC1372@mithrandir>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7rr+6JiDK4v1rNYufook8WC/dYW
        l3fNYbM4+OEJq8XPXfNYHFg91sxbw+ixc9Zddo/JN5Yzeuy+2cDm8XmTXABrFJdNSmpOZllq
        kb5dAldGe49PwSuuindnvrA2MN7g6GLk5JAQMJFo+beZvYuRi0NIYAWjxJGWb6wQzhdGib2n
        v0NlPjNKnFl7mRGmZend8ywQieWMEt2PZzJBOO8ZJV7N+MMCUiUsECQxf9J+MFtEwF/i2van
        rCA2s0CmxOknrWA2m4ChRNfbLjYQm1fATuLlmg/sIDaLgIrEtQ8LmEBsUYEYiSnnjrBD1AhK
        nJz5BGwmp4C+xIaPXxghZspLbH87hxnCFpe49WQ+2EESAvPYJdZ+vgPUzAHkuEjc+MQN8YGw
        xKvjW9ghbBmJ05N7WCDqmxkl2mfMYodwehglts7ZwQZRZS1x+PhFVpBBzAKaEut36UOEHSXW
        Pz/ACDGfT+LGW0GIG/gkJm2bzgwR5pXoaBOCqFaTmHV8HdzagxcuMU9gVJqF5LNZSL6ZheSb
        WQh7FzCyrGIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMNqf/Hf+6g3Hfn6RDjAIcjEo8
        vBrdkTFCrIllxZW5hxglOJiVRHjX9EbFCPGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQ
        nliSmp2aWpBaBJNl4uCUamDcJD5p44meHedSFV9aZm8N5ZAPf2Z75ZK9/Lq0pFCFnRuXlX9d
        9mxl73vTjsL7h95UnnkjFJNRuDOx6sfyecynT9mreerNTLJZ8KR8f4HQ1XXV7f949ZUmvf4Z
        ErKwf9kvx3P9qk7B33+sXyV8qvgEh3u8n346j1t0yLuG2VdS5ZL2XmbX7clXYinOSDTUYi4q
        TgQAs7QmDzIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7rr+qJiDBYuV7RYufook8WC/dYW
        l3fNYbM4+OEJq8XPXfNYHFg91sxbw+ixc9Zddo/JN5Yzeuy+2cDm8XmTXABrlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl5Ge49PwSuuindnvrA2
        MN7g6GLk5JAQMJFYevc8C4gtJLCUUWLpq1yIuIzEyWkNrBC2sMSfa11sXYxcQDVvGSVuPN4I
        1iAsECQxf9J+IJuDQ0TAV2LHFAWQMLNApsT+pYuYIOovM0kcvHKYDSTBJmAo0fW2C8zmFbCT
        eLnmAzuIzSKgInHtwwImkDmiAjESV88xQpQISpyc+QRsFaeAvsSGj18YIearS/yZd4kZwpaX
        2P52DpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefn
        bmIERta2Yz+37GDsehd8iFGAg1GJh1ejOzJGiDWxrLgy9xCjBAezkgivSmtUjBBvSmJlVWpR
        fnxRaU5q8SFGU6DfJjJLiSbnA6M+ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampB
        ahFMHxMHp1QDY3yRw5aed60LdetuysVUfX2syR99NfLDlmktvtdeh2o8myJk1S3l+Ty4xfGU
        UPCvjrb33utdas7N0lqTMOfnR8v7zvxTag8aVMvyW/B9Li2rL2QM5i26bcLyz2qj88VYVYbS
        JY7X3txr5di98Q2vdKLJ7YzL2zga56hd6zycm+og/rNv0iV+JZbijERDLeai4kQAqfrp9sIC
        AAA=
X-CMS-MailID: 20190206073718eucas1p1899ad5f1552a818baa997fb16aab6795
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190205223004epcas1p43c4cc25c1dff610859ee1b1c9fa81f8e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190205223004epcas1p43c4cc25c1dff610859ee1b1c9fa81f8e
References: <20190205110602.27717-1-thierry.reding@gmail.com>
        <20190205161036.GA782@lst.de> <20190205162057.GA29974@ulmo>
        <20190205163837.GA1222@lst.de> <20190205175611.GA7052@ulmo>
        <20190205180218.GB2882@lst.de>
        <CGME20190205223004epcas1p43c4cc25c1dff610859ee1b1c9fa81f8e@epcas1p4.samsung.com>
        <20190205222912.GC1372@mithrandir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 2019-02-05 23:29, Thierry Reding wrote:
> On Tue, Feb 05, 2019 at 07:02:18PM +0100, Christoph Hellwig wrote:
>> On Tue, Feb 05, 2019 at 06:56:11PM +0100, Thierry Reding wrote:
>>> Sure, here you go:
>>>
>>> 	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/host1x/cdma.c#n106
>> Yes, I think we I can come up with a nicer helper for that.
> One thing I could also try is to remove direct IOMMU API usage at least
> from the host1x driver. I think this might work nowadays.
>
> For Tegra DRM we still need direct IOMMU API usage because we need to be
> able to map into an IOMMU domain without knowing the struct device *
> that we're mapping for (it could be needed by any of up to four display
> controllers). For host1x we always only have one struct device *, so the
> DMA mapping API should be good enough.

In case of Tegra DRM you may try to use Exynos DRM approach. Exynos DRM
also consists of more than one DMA capable device and uses one common
IOMMU address space for them. It is achieved by attaching all those
devices to the IOMMU domain of the first CRTC device that has been
registered. Then that device is used for DMA-mapping calls. It is not
very elegant, but works fine and allows to use standard DMA-mapping calls.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

