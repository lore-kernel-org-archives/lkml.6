Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEBAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFEC20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UHh90Wwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392115AbfAPKg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:36:57 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51603 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731958AbfAPKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:36:57 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190116103655euoutp0124398f7059d756a96c73beff8a429a08~6TdjFkoou2480624806euoutp01l
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:36:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190116103655euoutp0124398f7059d756a96c73beff8a429a08~6TdjFkoou2480624806euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547635015;
        bh=ftbTReww1KSdTJelR5LMhyUhmrnhYK1Ep9I6yDYu89M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UHh90Wwbb0xsI8dHtu2JttIIFuqgkJRpfK07ATqOV7KslZI9ytRAkVG8xp3nln7pU
         MVRPYYqozL9Y6IbFSPCNWJ8oBdWuFOIg+Pnr5N8KRdiDx5VLB7pKgqlERP4oqBUIhr
         1HsS3dYNIJcPC5XOLFcgikXF1yNd0BUAMs8iaPm4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190116103654eucas1p1e4dea5f9ab8e1dcb31f3bef7ad2ebdfd~6TdiOEtLa0817708177eucas1p1J;
        Wed, 16 Jan 2019 10:36:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 94.AA.04441.6490F3C5; Wed, 16
        Jan 2019 10:36:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190116103653eucas1p122bd1a979a2d621332b720580c157908~6TdhIumgF2551925519eucas1p1U;
        Wed, 16 Jan 2019 10:36:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190116103653eusmtrp2e7e23e0103bed7435e7904eab4d231cf~6Tdg4hHwV0861408614eusmtrp2G;
        Wed, 16 Jan 2019 10:36:53 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-51-5c3f0946cc2b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B4.3D.04128.4490F3C5; Wed, 16
        Jan 2019 10:36:52 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190116103652eusmtip19286f6cd05e62a098de76ae2ded752e6~6TdgVwWbl2642126421eusmtip1Q;
        Wed, 16 Jan 2019 10:36:52 +0000 (GMT)
Subject: Re: [PATCH] Revert
 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
To:     Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ben Skeggs <bskeggs@redhat.com>,
        Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a24660a6-a9d7-ce97-5e2b-17928981551c@samsung.com>
Date:   Wed, 16 Jan 2019 11:36:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGuzs7s+PibnfXwpO9twcZpQn9MaVYgcRAUpFUZEJNNa2Vq7Lj
        I3uQYFmslVlZtpqP8FFqru/UqNDIzQxtZ0nUkFI3emFp2kMKy2my/O873zm/+50Dlyb0baQX
        fSAyhjdHchEGSq2sbR5tX77ebU3YCkuVmqnIsJHMu6IziLlV8kjB5D7wZyr7O0jG2ZBFMWJq
        moJpHHSRTHLJIMm8+KFdq2ZLs0sR6+xwEGxV/gn2UmcRYu92JVLsWLOKPZf0kWI/3X9Oseer
        ixE7XDlnszpUHbCPjzgQx5t9A3erw1/39BPRdbrDb0twImrQWpAbDXglpNpspAWpaT2+iSDt
        bTeSixEEYssHSi6GEbT2ZhMTSPqdR4TcKEKQIRb/5T8h+JrzeJynaQ/MQbtrowRMw8HQd+/y
        H4DAjQr4Lg5RUoPCfmAZsPzRGhwITksHKWklXgQ/xS5Kemc6DoNTTrU8ooOWay6lpN2wP9iu
        JCNJE3guJNVkErL2hG5XjkLKAtyngtru05S8dRCUFQwiWXvAe3u1Staz4Ff9BJCE4HSGVSUX
        ZxHUZNX9pf3hod1BShsR2BtsDb6yvQ4qq5wqyQashc4BnbyEFi7WXiVkWwNnkvXy9GKw2sv+
        xTY+E4kLyGCddJp10jnWSedY/+fmImUx8uRjBZORF/wi+XgfgTMJsZFGn71Rpko0/stax+yf
        69AXcU8TwjQyuGuY0MAwPcnFCQmmJgQ0YZimGc0ftzT7uIQjvDlqlzk2ghea0ExaafDUHJ3y
        aqceG7kY/hDPR/Pmia6CdvNKRNuPz1h25Kmf07uj9V24Y2PFwAg9P/il6VvnArsjP+Gior5k
        k6NHF7bEWF70JM6ypVec6tjw5mSbT562kJ3tClAVdG1t3pHrlVnmWxrtlRPSy/WnOdzHVl1K
        PbjttvkYsbrmSkrIPGFtUN7+lqHMxphOsTzd48b19EKf4JSE+IURyKAUwjm/pYRZ4H4Dvozt
        oGEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7ounPYxBo/O2VhsnLGe1eLl8g5G
        i5WrjzJZLNhvbbHp8TVWi8u75rBZXOqfyGRx8MMTVou21R9YLW7/5nPg8lgzbw2jx+VrF5k9
        Ni+p95h8Yzmjx+6bDWwe/46xe/Q2v2PzeL/vKptH35ZVjB6fN8kFcEXp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZTy9+5i5YIdgxYvVAg2Mu/i6
        GDk5JARMJKZuP8rcxcjFISSwlFFiZ8MXFoiEjMTJaQ2sELawxJ9rXWwQRW8ZJVbOXM8EkhAW
        SJRoW3gRzBYR8JF4tHcK2CRmgYNMEiveTYQae59RYv+uq8wgVWwChhJdb0FGcXLwCthJXO66
        BraCRUBV4s+lm2BxUYEYiVlP+tghagQlTs58AnYSp4C1xPppbYwgNrOAusSfeZeYIWx5ieat
        s6FscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMj
        MH63Hfu5ZQdj17vgQ4wCHIxKPLwWUXYxQqyJZcWVuYcYJTiYlUR4fy4BCvGmJFZWpRblxxeV
        5qQWH2I0BXpuIrOUaHI+MLXklcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLp
        Y+LglGpg7EqfsK7szYz9NzWf1x84H7r4yY8fjjE/L0eaPunP5v5Tc36d8YWZkiXxze9SVZly
        A1bnRzk+WNhbOo/X0+plzsv/m904A6aLBUgr/NxzqeKNdQ37yZ0CV4pKXI2UP/olKc0V+ig0
        f51E7GeG6SGvZ91P6TtssYT1dgL3j7vGIgq9pmz7/z5TUWIpzkg01GIuKk4EAA2xHqb1AgAA
X-CMS-MailID: 20190116103653eucas1p122bd1a979a2d621332b720580c157908
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
        <20190114132240.12125-1-m.szyprowski@samsung.com>
        <20190114160902.GB9218@ulmo> <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2019-01-14 17:38, Robin Murphy wrote:
> On 14/01/2019 16:09, Thierry Reding wrote:
>> On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
>>> This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
>>>
>>> That patch broke IOMMU support for devices, which fails to probe for
>>> the
>>> first time and use deferred probe approach. When non-NULL dma_ops is
>>> set
>>> in arm_iommu_detach_device(), the given device later ignored by
>>> arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
>>>
>>> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in
>>> arm_iommu_detach_device()"
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>   arch/arm/mm/dma-mapping.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> Can you point out exactly what drivers break because of this change? We
>> need to find a solution that works for everyone. Reverting is only
>> marginally useful because somebody will just end up wanting to revert
>> the revert because a different driver is now broken.
>
> At first glance, it sounds like what we really want is for
> arch_teardown_iommu_ops() to completely clear any ops that
> arch_setup_dma_ops() installed - does the below suffice?

I've initially also thought about similar fix, but then I found the
commit 1874619a7df4b14b23b14877e705ae15325773e3, which was the source of
this problem.

Robin: do you plan to send this fix as a complete patch or do you want
me to resend it with the above commit message and your's suggested-by?

>
> Robin.
>
> ----->8-----
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f1e2922e447c..1e3e08a1c456 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
>          return;
>
>      arm_teardown_iommu_dma_ops(dev);
> +    /* Let arch_setup_dma_ops() start again from scratch upon
> re-probe */
> +    set_dma_ops(dev, NULL);
>  }
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

