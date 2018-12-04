Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777DCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6BE208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oyMkbJX1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bGVpudX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6BE208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLDGe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:34:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDGe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:34:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 29F7E60312; Tue,  4 Dec 2018 06:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543905296;
        bh=59MIBGWbaukqrskIjiGYVrH6FXBqeGgQuQnnJ0zs6o4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oyMkbJX1+iNBp6SMZPX/nmnRnABcnbU+zKEv0CONgrK+St4RwtszgGhwwxBt1+C4k
         OrIEAVwJ77s3bShlWRLakjxXPFUytjnns5vi3OdlVtQkAu8gBi8t0W4XBYiDIWCclj
         8ejJ6dmPQ5ZqpF2dfoJbzHVwfZ5SdjtSgLFrRj+8=
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3BB7960312;
        Tue,  4 Dec 2018 06:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543905295;
        bh=59MIBGWbaukqrskIjiGYVrH6FXBqeGgQuQnnJ0zs6o4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bGVpudX5TEHvr/JtMU7cLccM9S8/mgKVfJHYWLZqv4TOkbO2r3y7jYzGUxLlgRIR5
         g+KtpLfR9LwMRpXYIeaTd2lUptrDz1EJ3yLxxIDn7zVXF8I0ud8SsbCcSwgduAGzx+
         d9j4PZifaklpci/olwKv9Y093n4eZ+vwa4bZGvp0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BB7960312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f170.google.com with SMTP id a132so8981765qkg.1;
        Mon, 03 Dec 2018 22:34:55 -0800 (PST)
X-Gm-Message-State: AA+aEWY0XsEhRPcotvAjBhdifnNpp/wjnGZUq5xFvt/Pj1YCUPRKYK/P
        8E6FEYTjMYGvXi3JYzWT1xjD7KIVbFAxPDsNusY=
X-Google-Smtp-Source: AFSGD/Xe4kIFlBULthAKnu8MoiQYyuXeGkJjJ6gSV8IXz0TJqdTzNcqHrNjFbqlaglNfaU9SkdigTVCHuiitDDe4Fr4=
X-Received: by 2002:ae9:ed51:: with SMTP id c78mr17252433qkg.85.1543905294461;
 Mon, 03 Dec 2018 22:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20181201165348.24140-1-robdclark@gmail.com> <a29008a3-8eff-260d-5c93-9757a729f9e0@arm.com>
 <CAF6AEGvo0-oWNKcz6BEA8Eh250FL4rXaBVYXuJGBtshPk4jz+g@mail.gmail.com>
In-Reply-To: <CAF6AEGvo0-oWNKcz6BEA8Eh250FL4rXaBVYXuJGBtshPk4jz+g@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 4 Dec 2018 12:04:42 +0530
X-Gmail-Original-Message-ID: <CAFp+6iH8x4ieK5QqrYcAnLALpQL4KC3E507KHurJJV1Gh1Z=Ng@mail.gmail.com>
Message-ID: <CAFp+6iH8x4ieK5QqrYcAnLALpQL4KC3E507KHurJJV1Gh1Z=Ng@mail.gmail.com>
Subject: Re: [PATCH] of/device: add blacklist for iommu dma_ops
To:     Rob Clark <robdclark@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, daniel@ffwll.ch,
        frowand.list@gmail.com, David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
        freedreno <freedreno@lists.freedesktop.org>, hch@lst.de,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 7:56 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Mon, Dec 3, 2018 at 7:45 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > Hi Rob,
> >
> > On 01/12/2018 16:53, Rob Clark wrote:
> > > This solves a problem we see with drm/msm, caused by getting
> > > iommu_dma_ops while we attach our own domain and manage it directly at
> > > the iommu API level:
> > >
> > >    [0000000000000038] user address but active_mm is swapper
> > >    Internal error: Oops: 96000005 [#1] PREEMPT SMP
> > >    Modules linked in:
> > >    CPU: 7 PID: 70 Comm: kworker/7:1 Tainted: G        W         4.19.3 #90
> > >    Hardware name: xxx (DT)
> > >    Workqueue: events deferred_probe_work_func
> > >    pstate: 80c00009 (Nzcv daif +PAN +UAO)
> > >    pc : iommu_dma_map_sg+0x7c/0x2c8
> > >    lr : iommu_dma_map_sg+0x40/0x2c8
> > >    sp : ffffff80095eb4f0
> > >    x29: ffffff80095eb4f0 x28: 0000000000000000
> > >    x27: ffffffc0f9431578 x26: 0000000000000000
> > >    x25: 00000000ffffffff x24: 0000000000000003
> > >    x23: 0000000000000001 x22: ffffffc0fa9ac010
> > >    x21: 0000000000000000 x20: ffffffc0fab40980
> > >    x19: ffffffc0fab40980 x18: 0000000000000003
> > >    x17: 00000000000001c4 x16: 0000000000000007
> > >    x15: 000000000000000e x14: ffffffffffffffff
> > >    x13: ffff000000000000 x12: 0000000000000028
> > >    x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> > >    x9 : 0000000000000000 x8 : ffffffc0fab409a0
> > >    x7 : 0000000000000000 x6 : 0000000000000002
> > >    x5 : 0000000100000000 x4 : 0000000000000000
> > >    x3 : 0000000000000001 x2 : 0000000000000002
> > >    x1 : ffffffc0f9431578 x0 : 0000000000000000
> > >    Process kworker/7:1 (pid: 70, stack limit = 0x0000000017d08ffb)
> > >    Call trace:
> > >     iommu_dma_map_sg+0x7c/0x2c8
> > >     __iommu_map_sg_attrs+0x70/0x84
> > >     get_pages+0x170/0x1e8
> > >     msm_gem_get_iova+0x8c/0x128
> > >     _msm_gem_kernel_new+0x6c/0xc8
> > >     msm_gem_kernel_new+0x4c/0x58
> > >     dsi_tx_buf_alloc_6g+0x4c/0x8c
> > >     msm_dsi_host_modeset_init+0xc8/0x108
> > >     msm_dsi_modeset_init+0x54/0x18c
> > >     _dpu_kms_drm_obj_init+0x430/0x474
> > >     dpu_kms_hw_init+0x5f8/0x6b4
> > >     msm_drm_bind+0x360/0x6c8
> > >     try_to_bring_up_master.part.7+0x28/0x70
> > >     component_master_add_with_match+0xe8/0x124
> > >     msm_pdev_probe+0x294/0x2b4
> > >     platform_drv_probe+0x58/0xa4
> > >     really_probe+0x150/0x294
> > >     driver_probe_device+0xac/0xe8
> > >     __device_attach_driver+0xa4/0xb4
> > >     bus_for_each_drv+0x98/0xc8
> > >     __device_attach+0xac/0x12c
> > >     device_initial_probe+0x24/0x30
> > >     bus_probe_device+0x38/0x98
> > >     deferred_probe_work_func+0x78/0xa4
> > >     process_one_work+0x24c/0x3dc
> > >     worker_thread+0x280/0x360
> > >     kthread+0x134/0x13c
> > >     ret_from_fork+0x10/0x18
> > >    Code: d2800004 91000725 6b17039f 5400048a (f9401f40)
> > >    ---[ end trace f22dda57f3648e2c ]---
> > >    Kernel panic - not syncing: Fatal exception
> > >    SMP: stopping secondary CPUs
> > >    Kernel Offset: disabled
> > >    CPU features: 0x0,22802a18
> > >    Memory Limit: none
> > >
> > > The problem is that when drm/msm does it's own iommu_attach_device(),
> > > now the domain returned by iommu_get_domain_for_dev() is drm/msm's
> > > domain, and it doesn't have domain->iova_cookie.
> >
> > Does this crash still happen with 4.20-rc? Because as of 6af588fed391 it
> > really shouldn't.
> >
> > > We kind of avoided this problem prior to sdm845/dpu because the iommu
> > > was attached to the mdp node in dt, which is a child of the toplevel
> > > mdss node (which corresponds to the dev passed in dma_map_sg()).  But
> > > with sdm845, now the iommu is attached at the mdss level so we hit the
> > > iommu_dma_ops in dma_map_sg().
> > >
> > > But auto allocating/attaching a domain before the driver is probed was
> > > already a blocking problem for enabling per-context pagetables for the
> > > GPU.  This problem is also now solved with this patch.
> >
> > s/solved/worked around/
> >
> > If you want a guarantee of actually getting a specific hardware context
> > allocated for a given domain, there needs to be code in the IOMMU driver
> > to understand and honour that. Implicitly depending on whatever happens
> > to fall out of current driver behaviour on current systems is not a real
> > solution.
> >
> > > Fixes: 97890ba9289c dma-mapping: detect and configure IOMMU in of_dma_configure
> >
> > That's rather misleading, since the crash described above depends on at
> > least two other major changes which came long after that commit.
> >
> > It's not that I don't understand exactly what you want here - just that
> > this commit message isn't a coherent justification for that ;)
> >
> > > Tested-by: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > ---
> > > This is an alternative/replacement for [1].  What it lacks in elegance
> > > it makes up for in practicality ;-)
> > >
> > > [1] https://patchwork.freedesktop.org/patch/264930/
> > >
> > >   drivers/of/device.c | 22 ++++++++++++++++++++++
> > >   1 file changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > > index 5957cd4fa262..15ffee00fb22 100644
> > > --- a/drivers/of/device.c
> > > +++ b/drivers/of/device.c
> > > @@ -72,6 +72,14 @@ int of_device_add(struct platform_device *ofdev)
> > >       return device_add(&ofdev->dev);
> > >   }
> > >
> > > +static const struct of_device_id iommu_blacklist[] = {
> > > +     { .compatible = "qcom,mdp4" },
> > > +     { .compatible = "qcom,mdss" },
> > > +     { .compatible = "qcom,sdm845-mdss" },
> > > +     { .compatible = "qcom,adreno" },
> > > +     {}
> > > +};
> > > +
> > >   /**
> > >    * of_dma_configure - Setup DMA configuration
> > >    * @dev:    Device to apply DMA configuration
> > > @@ -164,6 +172,20 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
> > >       dev_dbg(dev, "device is%sbehind an iommu\n",
> > >               iommu ? " " : " not ");
> > >
> > > +     /*
> > > +      * There is at least one case where the driver wants to directly
> > > +      * manage the IOMMU, but if we end up with iommu dma_ops, that
> > > +      * interferes with the drivers ability to use dma_map_sg() for
> > > +      * cache operations.  Since we don't currently have a better
> > > +      * solution, and this code runs before the driver is probed and
> > > +      * has a chance to intervene, use a simple blacklist to avoid
> > > +      * ending up with iommu dma_ops:
> > > +      */
> > > +     if (of_match_device(iommu_blacklist, dev)) {
> > > +             dev_dbg(dev, "skipping iommu hookup\n");
> > > +             iommu = NULL;
> > > +     }
> >
> > Given that a default domain will already have been allocated by the time
> > we get here, regardless of whether we pretend of_iommu_configure() did
> > nothing, I'm puzzled as to how this change is 'solving' that aspect as
> > claimed :/
>
> Possibly I'm reading this wrong.. I thought it is not created until
> arm_iommu_create_mapping()..
>
> but hmm, I guess I was looking at the armv7 code.  Seems to be
> different on arm64.. ugg..
>
> > Is CONFIG_IOMMU_DEFAULT_PASSTHROUGH a sufficient workaround for msm at
> > the moment, or do you have other devices which do actually want
> > iommu_dma_ops?
>
> I think there are at least a few other devices (venus, camera, maybe
> some others that are not wired up yet?)

Yes, for msm, the drm devices do not want the default DMA domain, whereas
the V4L devices - video and camera rely completely on DMA iommu domain
and use the dma mapping apis to manage things.
So enabling CONFIG_IOMMU_DEFAULT_PASSTHROUGH for msm platforms
is not the desired configuration.
Moreover, we can't enable this config with upstream kernels anyways.

Thanks
Vivek

>
> BR,
> -R
>
> >
> > Robin.
> >
> > > +
> > >       arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
> > >
> > >       return 0;
> > >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
