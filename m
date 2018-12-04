Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E33EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D8D20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNO2qQaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D8D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLDW35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:29:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeLDW35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:29:57 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259EF208E7;
        Tue,  4 Dec 2018 22:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543962596;
        bh=2AaQdhHE6a7RY8KWoJRauk2rhPHWBXN7bJX0ytebjiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hNO2qQafxIJJ8aRADxW+nZeDVKyPmiCG4JUVAp/T9vkVU1BjGMFZQ2k65QdwYlzY2
         gT1ummmcBqllvj78DgA7IDe5kQ1jjwGm0SKjtKd+4MertgHvanlwjFswbTuGUyBho9
         Md/ay222IiAkRhuU7gWAUC+j0TZ3BUFzKEEtceMo=
Received: by mail-qt1-f171.google.com with SMTP id n32so20070176qte.11;
        Tue, 04 Dec 2018 14:29:56 -0800 (PST)
X-Gm-Message-State: AA+aEWZA5UYxee8w0uQGxmDKukj/fwhda8kodibPrqB/nj5aETXEnOCr
        QuuqwPwAEqjYrX6qTYAXmYFUVMUx93jITWWZxw==
X-Google-Smtp-Source: AFSGD/U7CpwyGdv8rHIKI7u/8etxvdQGP0TL0644C5OSFv+wLiexG7OWGALhPbyTF4W4oaoAw9PYJrpTlH1t252lDSQ=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr21550141qts.144.1543962595304;
 Tue, 04 Dec 2018 14:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20181201165348.24140-1-robdclark@gmail.com>
In-Reply-To: <20181201165348.24140-1-robdclark@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 4 Dec 2018 16:29:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJmPqis46Un91QyhXgdrVtfATMP_hTp6wSeSAfc8MLFfw@mail.gmail.com>
Message-ID: <CAL_JsqJmPqis46Un91QyhXgdrVtfATMP_hTp6wSeSAfc8MLFfw@mail.gmail.com>
Subject: Re: [PATCH] of/device: add blacklist for iommu dma_ops
To:     Rob Clark <robdclark@gmail.com>
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        freedreno <freedreno@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 10:54 AM Rob Clark <robdclark@gmail.com> wrote:
>
> This solves a problem we see with drm/msm, caused by getting
> iommu_dma_ops while we attach our own domain and manage it directly at
> the iommu API level:
>
>   [0000000000000038] user address but active_mm is swapper
>   Internal error: Oops: 96000005 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 7 PID: 70 Comm: kworker/7:1 Tainted: G        W         4.19.3 #90
>   Hardware name: xxx (DT)
>   Workqueue: events deferred_probe_work_func
>   pstate: 80c00009 (Nzcv daif +PAN +UAO)
>   pc : iommu_dma_map_sg+0x7c/0x2c8
>   lr : iommu_dma_map_sg+0x40/0x2c8
>   sp : ffffff80095eb4f0
>   x29: ffffff80095eb4f0 x28: 0000000000000000
>   x27: ffffffc0f9431578 x26: 0000000000000000
>   x25: 00000000ffffffff x24: 0000000000000003
>   x23: 0000000000000001 x22: ffffffc0fa9ac010
>   x21: 0000000000000000 x20: ffffffc0fab40980
>   x19: ffffffc0fab40980 x18: 0000000000000003
>   x17: 00000000000001c4 x16: 0000000000000007
>   x15: 000000000000000e x14: ffffffffffffffff
>   x13: ffff000000000000 x12: 0000000000000028
>   x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
>   x9 : 0000000000000000 x8 : ffffffc0fab409a0
>   x7 : 0000000000000000 x6 : 0000000000000002
>   x5 : 0000000100000000 x4 : 0000000000000000
>   x3 : 0000000000000001 x2 : 0000000000000002
>   x1 : ffffffc0f9431578 x0 : 0000000000000000
>   Process kworker/7:1 (pid: 70, stack limit = 0x0000000017d08ffb)
>   Call trace:
>    iommu_dma_map_sg+0x7c/0x2c8
>    __iommu_map_sg_attrs+0x70/0x84
>    get_pages+0x170/0x1e8
>    msm_gem_get_iova+0x8c/0x128
>    _msm_gem_kernel_new+0x6c/0xc8
>    msm_gem_kernel_new+0x4c/0x58
>    dsi_tx_buf_alloc_6g+0x4c/0x8c
>    msm_dsi_host_modeset_init+0xc8/0x108
>    msm_dsi_modeset_init+0x54/0x18c
>    _dpu_kms_drm_obj_init+0x430/0x474
>    dpu_kms_hw_init+0x5f8/0x6b4
>    msm_drm_bind+0x360/0x6c8
>    try_to_bring_up_master.part.7+0x28/0x70
>    component_master_add_with_match+0xe8/0x124
>    msm_pdev_probe+0x294/0x2b4
>    platform_drv_probe+0x58/0xa4
>    really_probe+0x150/0x294
>    driver_probe_device+0xac/0xe8
>    __device_attach_driver+0xa4/0xb4
>    bus_for_each_drv+0x98/0xc8
>    __device_attach+0xac/0x12c
>    device_initial_probe+0x24/0x30
>    bus_probe_device+0x38/0x98
>    deferred_probe_work_func+0x78/0xa4
>    process_one_work+0x24c/0x3dc
>    worker_thread+0x280/0x360
>    kthread+0x134/0x13c
>    ret_from_fork+0x10/0x18
>   Code: d2800004 91000725 6b17039f 5400048a (f9401f40)
>   ---[ end trace f22dda57f3648e2c ]---
>   Kernel panic - not syncing: Fatal exception
>   SMP: stopping secondary CPUs
>   Kernel Offset: disabled
>   CPU features: 0x0,22802a18
>   Memory Limit: none
>
> The problem is that when drm/msm does it's own iommu_attach_device(),
> now the domain returned by iommu_get_domain_for_dev() is drm/msm's
> domain, and it doesn't have domain->iova_cookie.
>
> We kind of avoided this problem prior to sdm845/dpu because the iommu
> was attached to the mdp node in dt, which is a child of the toplevel
> mdss node (which corresponds to the dev passed in dma_map_sg()).  But
> with sdm845, now the iommu is attached at the mdss level so we hit the
> iommu_dma_ops in dma_map_sg().
>
> But auto allocating/attaching a domain before the driver is probed was
> already a blocking problem for enabling per-context pagetables for the
> GPU.  This problem is also now solved with this patch.
>
> Fixes: 97890ba9289c dma-mapping: detect and configure IOMMU in of_dma_configure
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
> This is an alternative/replacement for [1].  What it lacks in elegance
> it makes up for in practicality ;-)
>
> [1] https://patchwork.freedesktop.org/patch/264930/
>
>  drivers/of/device.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 5957cd4fa262..15ffee00fb22 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -72,6 +72,14 @@ int of_device_add(struct platform_device *ofdev)
>         return device_add(&ofdev->dev);
>  }
>
> +static const struct of_device_id iommu_blacklist[] = {
> +       { .compatible = "qcom,mdp4" },
> +       { .compatible = "qcom,mdss" },
> +       { .compatible = "qcom,sdm845-mdss" },
> +       { .compatible = "qcom,adreno" },
> +       {}
> +};

Not completely clear to whether this is still needed or not, but this
really won't scale. Why can't the driver for these devices override
whatever has been setup by default?

Rob
