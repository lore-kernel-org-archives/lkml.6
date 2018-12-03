Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE34C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6194420851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pGbHn6FQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6194420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeLCLGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:06:45 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55375 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeLCLGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:06:44 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181203110607euoutp02b66f3531e0b1477f08317f8b5baf890f~szees6cVL2284822848euoutp02B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 11:06:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181203110607euoutp02b66f3531e0b1477f08317f8b5baf890f~szees6cVL2284822848euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543835167;
        bh=453vY79VxG5AXnicXiTkyq36NdlXB2SFHuwAEHjLlvc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pGbHn6FQ1B6kBXzQLPjuVKFuaeLatHdFoj2DiuX/5cArlxOPf29GNpPRG/ZV31SXY
         0SEcsgITZcCY7690lyl/Ac4fY9n6g1p9+gdnw/DbCcvv4ANdX67OJ8Wg6RZV7GF8Yl
         xsNYeZQXyYHO7HhXEkQZkNlGOASSMDQS2uy+haXI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181203110606eucas1p19c7aa4e336672a64cac859d5003667e9~szedvmkhk2006920069eucas1p18;
        Mon,  3 Dec 2018 11:06:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3E.2C.04441.D1E050C5; Mon,  3
        Dec 2018 11:06:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181203110604eucas1p29c43d8e35bf7a4f7a531de649cac94fe~szecUiHjV3041530415eucas1p2U;
        Mon,  3 Dec 2018 11:06:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181203110604eusmtrp12a97c7cdf36b1ba7fb5e071762e50df2~szecFaB9t1775917759eusmtrp1W;
        Mon,  3 Dec 2018 11:06:04 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-53-5c050e1d2878
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8C.5A.04128.C1E050C5; Mon,  3
        Dec 2018 11:06:04 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181203110603eusmtip1ae3d0fb648565810d1ddcf2db493134f~szebTFv-l1675716757eusmtip1Z;
        Mon,  3 Dec 2018 11:06:03 +0000 (GMT)
Subject: Re: [PATCH] of/device: add blacklist for iommu dma_ops
To:     Tomasz Figa <tfiga@chromium.org>, Rob Clark <robdclark@gmail.com>
Cc:     "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        freedreno <freedreno@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <afa0a41e-8ffe-ffb9-9d0c-fd05d83fd143@samsung.com>
Date:   Mon, 3 Dec 2018 12:06:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CWRKGA2=TEpYvnLuBzu6=2h1i_YtmN_FusyFuLy5BpdQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1CMYRTHPe9t35bdeWzouJSxjKEhdsbwzGTIdd7xxZ1BZOm1NbaV3cr1
        Q1NTWNdlBm07SqILE5rakqEpZWtSSi4xmtZY1m2F1NQYVq839O3///3Pec45Mw9Pa1K4MXys
        KUE0m/RGLadknPf7Hk4PVrORM3Pcc8jxpnqKpBz2scTvtNEkq6aJJY1XqjjyuLuTIw5vIyIZ
        n/wcKbhaS5HsynBiq2xUkNYKB0e8F3tpknanRkGqvnhY0n6jv7Yr7RdH6vrKafL+ax0TEShc
        u3ANCZnJLYzQeuI4JdzpyWaEW/Z2hVBceIQTynrcrNBx1EUJZ9rykHD7eTIndBWHrBi6UTk3
        WjTGJonmGfO2KmMenCvi4ot0e/35ViYZdU+2ogAe8CxIqXnNWJGS1+B8BJmtngHzHcHbrp8K
        2XQhaO7M5/625J38iOQgD0Fq7l1KNp0Iyj6nUFJVIJ4PpWffKCQ9Ai8B1zcXJxXR2MmCrc9N
        SwGHdWD1WfsDnlfheXDPCxJm8CSorXvPSHgkjoQK70EJq/BwqM/w/MEBeCUUe4mEaTweynwO
        WtZB8MKT9WcdwCU8+NtKB5ZeDN4jl1lZB8IHV4lC1uOg4cwxRm5IRXDovF0hm2MISh3lA93h
        cM/VwkqTaTwVrlfMkCTgBVDbM1+WamjzDZd3UMNp5zlaxio4nK6R35gMdlfRv6lVzY/oU0hr
        H3SYfdA19kHX2P+PzUZMIQoSEy1xBtGiM4l7wiz6OEuiyRC2fVdcMer/mQ2/XN/KUfejbdUI
        80g7TBURxURqWH2SZV9cNQKe1o5Qxe/uR6po/b79onlXlDnRKFqq0Vie0QapDgxxb9Jggz5B
        3CmK8aL5b0rxAWOSkcFm7FhMwqc9j1o2Z2HBy1Xq9vStvinhhmfrqZax3CWdu/xHrBJGaZ6q
        JrwO2VCSqg2pM1esbX7R0ZPriV/kL9NvyXWMDq1cHZFwvWN2+hRqoiNY3Ws0rWn7vvRJfVKD
        LuZdX1pQYFVO0/KbpzbHOgtflQQv29G9LmNkjG1zaK83S8tYYvS6UNps0f8GsM8Kt5UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsVy+t/xu7oyfKwxBi0rhCx6z51ksmjqeMtq
        8X/bRGaL+UfOsVqcXXaQzeLK1/dsFnOen2W0mPnmP5vFytVHmSwW7Le2mLj/LLvF5V1z2Cye
        L/zBbNG69wi7xcEPT1gt7m4Aqv3c+o/N4sTPHcwWLz+eYHEQ9lgzbw2jx+yGiywel/t6mTz2
        flvA4rFz1l12j02rOtk8tn97wOpxv/s4k8fkG8sZPXbfbGDz+LxJLoA7Ss+mKL+0JFUhI7+4
        xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jzPR1bAXrDCv+r+hiaWD8
        qtbFyMkhIWAisbz/NWMXIxeHkMBSRomHTSuZIBIyEienNbBC2MISf651sUEUvWWU+Ln1OxtI
        QljAXmLrtKfsILaIgKvE8U/HweLMAjtYJd7dFIRouMwosXraLRaQBJuAoUTXW5BJHBy8AnYS
        h59LgIRZBFQkjp54CVYiKhAjMeXya7DFvAKCEidnPmEBKecUCJTY9NwCYry6xJ95l5ghbHmJ
        7W/nQNniEreezGeawCg0C0n3LCQts5C0zELSsoCRZRWjSGppcW56brGRXnFibnFpXrpecn7u
        JkZgkth27OeWHYxd74IPMQpwMCrx8DrEs8QIsSaWFVfmHmKU4GBWEuEtKAQK8aYkVlalFuXH
        F5XmpBYfYjQF+m0is5Rocj4wgeWVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgt
        gulj4uCUamBMWbkl2klN0MVChTeo/6fNf6nbN+XsHSPTtzQW3GMMW/fTZcKNg7P0LcNrm3/n
        NrzptskvlE//Xln3Xl3zf+j1HpX++Vf0thi8v7H778WMJ0K3X1ff5GG7clDSWolt2fJFTeVH
        kh7kWd+7Xr9HuutyV0sRS9nTwwcPLmiU32y+tsnirNrTRVpKLMUZiYZazEXFiQCAWpqWKAMA
        AA==
X-CMS-MailID: 20181203110604eucas1p29c43d8e35bf7a4f7a531de649cac94fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203001139epcas3p1f4daa2df3e1ac378b284df32b4932b11
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203001139epcas3p1f4daa2df3e1ac378b284df32b4932b11
References: <20181201165348.24140-1-robdclark@gmail.com>
        <CGME20181203001139epcas3p1f4daa2df3e1ac378b284df32b4932b11@epcas3p1.samsung.com>
        <CAAFQd5CWRKGA2=TEpYvnLuBzu6=2h1i_YtmN_FusyFuLy5BpdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 2018-12-03 01:10, Tomasz Figa wrote:
> On Sat, Dec 1, 2018 at 8:54 AM Rob Clark <robdclark@gmail.com> wrote:
>> This solves a problem we see with drm/msm, caused by getting
>> iommu_dma_ops while we attach our own domain and manage it directly at
>> the iommu API level:
>>
>>   [0000000000000038] user address but active_mm is swapper
>>   Internal error: Oops: 96000005 [#1] PREEMPT SMP
>>   Modules linked in:
>>   CPU: 7 PID: 70 Comm: kworker/7:1 Tainted: G        W         4.19.3 #90
>>   Hardware name: xxx (DT)
>>   Workqueue: events deferred_probe_work_func
>>   pstate: 80c00009 (Nzcv daif +PAN +UAO)
>>   pc : iommu_dma_map_sg+0x7c/0x2c8
>>   lr : iommu_dma_map_sg+0x40/0x2c8
>>   sp : ffffff80095eb4f0
>>   x29: ffffff80095eb4f0 x28: 0000000000000000
>>   x27: ffffffc0f9431578 x26: 0000000000000000
>>   x25: 00000000ffffffff x24: 0000000000000003
>>   x23: 0000000000000001 x22: ffffffc0fa9ac010
>>   x21: 0000000000000000 x20: ffffffc0fab40980
>>   x19: ffffffc0fab40980 x18: 0000000000000003
>>   x17: 00000000000001c4 x16: 0000000000000007
>>   x15: 000000000000000e x14: ffffffffffffffff
>>   x13: ffff000000000000 x12: 0000000000000028
>>   x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
>>   x9 : 0000000000000000 x8 : ffffffc0fab409a0
>>   x7 : 0000000000000000 x6 : 0000000000000002
>>   x5 : 0000000100000000 x4 : 0000000000000000
>>   x3 : 0000000000000001 x2 : 0000000000000002
>>   x1 : ffffffc0f9431578 x0 : 0000000000000000
>>   Process kworker/7:1 (pid: 70, stack limit = 0x0000000017d08ffb)
>>   Call trace:
>>    iommu_dma_map_sg+0x7c/0x2c8
>>    __iommu_map_sg_attrs+0x70/0x84
>>    get_pages+0x170/0x1e8
>>    msm_gem_get_iova+0x8c/0x128
>>    _msm_gem_kernel_new+0x6c/0xc8
>>    msm_gem_kernel_new+0x4c/0x58
>>    dsi_tx_buf_alloc_6g+0x4c/0x8c
>>    msm_dsi_host_modeset_init+0xc8/0x108
>>    msm_dsi_modeset_init+0x54/0x18c
>>    _dpu_kms_drm_obj_init+0x430/0x474
>>    dpu_kms_hw_init+0x5f8/0x6b4
>>    msm_drm_bind+0x360/0x6c8
>>    try_to_bring_up_master.part.7+0x28/0x70
>>    component_master_add_with_match+0xe8/0x124
>>    msm_pdev_probe+0x294/0x2b4
>>    platform_drv_probe+0x58/0xa4
>>    really_probe+0x150/0x294
>>    driver_probe_device+0xac/0xe8
>>    __device_attach_driver+0xa4/0xb4
>>    bus_for_each_drv+0x98/0xc8
>>    __device_attach+0xac/0x12c
>>    device_initial_probe+0x24/0x30
>>    bus_probe_device+0x38/0x98
>>    deferred_probe_work_func+0x78/0xa4
>>    process_one_work+0x24c/0x3dc
>>    worker_thread+0x280/0x360
>>    kthread+0x134/0x13c
>>    ret_from_fork+0x10/0x18
>>   Code: d2800004 91000725 6b17039f 5400048a (f9401f40)
>>   ---[ end trace f22dda57f3648e2c ]---
>>   Kernel panic - not syncing: Fatal exception
>>   SMP: stopping secondary CPUs
>>   Kernel Offset: disabled
>>   CPU features: 0x0,22802a18
>>   Memory Limit: none
>>
>> The problem is that when drm/msm does it's own iommu_attach_device(),
>> now the domain returned by iommu_get_domain_for_dev() is drm/msm's
>> domain, and it doesn't have domain->iova_cookie.
>>
>> We kind of avoided this problem prior to sdm845/dpu because the iommu
>> was attached to the mdp node in dt, which is a child of the toplevel
>> mdss node (which corresponds to the dev passed in dma_map_sg()).  But
>> with sdm845, now the iommu is attached at the mdss level so we hit the
>> iommu_dma_ops in dma_map_sg().
>>
>> But auto allocating/attaching a domain before the driver is probed was
>> already a blocking problem for enabling per-context pagetables for the
>> GPU.  This problem is also now solved with this patch.
>>
>> Fixes: 97890ba9289c dma-mapping: detect and configure IOMMU in of_dma_configure
>> Tested-by: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> ---
>> This is an alternative/replacement for [1].  What it lacks in elegance
>> it makes up for in practicality ;-)
>>
>> [1] https://patchwork.freedesktop.org/patch/264930/
>>
>>  drivers/of/device.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index 5957cd4fa262..15ffee00fb22 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -72,6 +72,14 @@ int of_device_add(struct platform_device *ofdev)
>>         return device_add(&ofdev->dev);
>>  }
>>
>> +static const struct of_device_id iommu_blacklist[] = {
>> +       { .compatible = "qcom,mdp4" },
>> +       { .compatible = "qcom,mdss" },
>> +       { .compatible = "qcom,sdm845-mdss" },
>> +       { .compatible = "qcom,adreno" },
>> +       {}
>> +};
>> +
>>  /**
>>   * of_dma_configure - Setup DMA configuration
>>   * @dev:       Device to apply DMA configuration
>> @@ -164,6 +172,20 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>>         dev_dbg(dev, "device is%sbehind an iommu\n",
>>                 iommu ? " " : " not ");
>>
>> +       /*
>> +        * There is at least one case where the driver wants to directly
>> +        * manage the IOMMU, but if we end up with iommu dma_ops, that
>> +        * interferes with the drivers ability to use dma_map_sg() for
>> +        * cache operations.  Since we don't currently have a better
>> +        * solution, and this code runs before the driver is probed and
>> +        * has a chance to intervene, use a simple blacklist to avoid
>> +        * ending up with iommu dma_ops:
>> +        */
>> +       if (of_match_device(iommu_blacklist, dev)) {
>> +               dev_dbg(dev, "skipping iommu hookup\n");
>> +               iommu = NULL;
>> +       }
>> +
>>         arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
>>
>>         return 0;
>> --
>> 2.19.2
>>
> +Marek Szyprowski who I believe had a similar problem with Exynos DRM before.
>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>


Thanks for adding me. So far Exynos DRM use other workaround, see commit
1feda5eb77fc ("drm/exynos: Use selected dma_dev default iommu domain
instead of a fake one"). Here is the link to the thread with more
comments and background:
https://www.spinics.net/lists/arm-kernel/msg676100.html

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

