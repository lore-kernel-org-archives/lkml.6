Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 21848C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4325208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nkpp97jK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bJ2gFv1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4325208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeFNHHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:07:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeFNHHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:07:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 46F746074D; Thu, 14 Jun 2018 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528960033;
        bh=NDfBQPxdrbhj6xDZaGIQ/8ksbjVd2QPpfZlVpTSIiOs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Nkpp97jKdH2DAAbB6JPbADYPiGdcqoBlEN1uIiW0lvM06K2Mtg6+yWVwHC8igjOK6
         hgxjfTsc20AxLyk041l7pYh4kWzVs1Pkv3r5kgRqbmtf9xhmNFd84r7fQYIy+CdovV
         cA3VGpKJ9XgauGTszbtlaPXeEbl5UPbR6aMnCDME=
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com [209.85.216.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F0DB60159;
        Thu, 14 Jun 2018 07:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528960032;
        bh=NDfBQPxdrbhj6xDZaGIQ/8ksbjVd2QPpfZlVpTSIiOs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=bJ2gFv1W6elJCnPKEEqL8FJzIVjMTjQMx6AmWD1RypWf46fhm9sLfYgYROSmz/whn
         S4wG1oavahXYOveqFVO6fmKs8ng1fd/9qFtev3m7Gl2y6Fb65wsKKeHxDMWtblI0z7
         ndM+D7qPjl1AEkkU0V1RHjaWCuHo7+dhF8+yhxK0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F0DB60159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f173.google.com with SMTP id l33-v6so4850709qta.11;
        Thu, 14 Jun 2018 00:07:12 -0700 (PDT)
X-Gm-Message-State: APt69E2owuDfHtBbX55i7vyB/R+MsSRwdYHt3Dlml/GCubQlf/f7SxRD
        /QeTk9wBrt5wR9U5OsrVz0FG0PVa8RI3yn2ggzk=
X-Google-Smtp-Source: ADUXVKIHWrHMvQC2l8JPUV6bDngG8i+F8feIWBBfUM2PjFJlf6OF1zT4rUsl2RmCal2ztk/UQhHFBmgonHKnMIqd9AE=
X-Received: by 2002:a0c:e7cf:: with SMTP id c15-v6mr1156733qvo.109.1528960031883;
 Thu, 14 Jun 2018 00:07:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 00:07:11
 -0700 (PDT)
In-Reply-To: <20180612140610.31190-1-niklas.cassel@linaro.org>
References: <20180612140610.31190-1-niklas.cassel@linaro.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 14 Jun 2018 12:37:11 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEFwY3e2js2fabTsOC=R9H1Eeetas83-fxDRop2KXWzbw@mail.gmail.com>
Message-ID: <CAFp+6iEFwY3e2js2fabTsOC=R9H1Eeetas83-fxDRop2KXWzbw@mail.gmail.com>
Subject: Re: [PATCH RESEND] iommu/msm: Don't call iommu_device_{,un}link from
 atomic context
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi NIklas,

On Tue, Jun 12, 2018 at 7:36 PM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> Fixes the following splat during boot:
>
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:747
> in_atomic(): 1, irqs_disabled(): 128, pid: 77, name: kworker/2:1
> 4 locks held by kworker/2:1/77:
>  #0: (ptrval) ((wq_completion)"events"){+.+.}, at: process_one_work+0x1fc/0x8fc
>  #1: (ptrval) (deferred_probe_work){+.+.}, at: process_one_work+0x1fc/0x8fc
>  #2: (ptrval) (&dev->mutex){....}, at: __device_attach+0x40/0x178
>  #3: (ptrval) (msm_iommu_lock){....}, at: msm_iommu_add_device+0x28/0xcc
> irq event stamp: 348
> hardirqs last  enabled at (347): [<c049dc18>] kfree+0xe0/0x3c0
> hardirqs last disabled at (348): [<c0c35cac>] _raw_spin_lock_irqsave+0x2c/0x68
> softirqs last  enabled at (0): [<c0322fd8>] copy_process.part.5+0x280/0x1a68
> softirqs last disabled at (0): [<00000000>]   (null)
> Preemption disabled at:
> [<00000000>]   (null)
> CPU: 2 PID: 77 Comm: kworker/2:1 Not tainted 4.17.0-rc5-wt-ath-01075-gaca0516bb4cf #239
> Hardware name: Generic DT based system
> Workqueue: events deferred_probe_work_func
> [<c0314e00>] (unwind_backtrace) from [<c030fc70>] (show_stack+0x20/0x24)
> [<c030fc70>] (show_stack) from [<c0c16ad8>] (dump_stack+0xa0/0xcc)
> [<c0c16ad8>] (dump_stack) from [<c035a978>] (___might_sleep+0x1f8/0x2d4)
> ath10k_sdio mmc2:0001:1: Direct firmware load for ath10k/QCA9377/hw1.0/board-2.bin failed with error -2
> [<c035a978>] (___might_sleep) from [<c035aac4>] (__might_sleep+0x70/0xa8)
> [<c035aac4>] (__might_sleep) from [<c0c3066c>] (__mutex_lock+0x50/0xb28)
> [<c0c3066c>] (__mutex_lock) from [<c0c31170>] (mutex_lock_nested+0x2c/0x34)
> ath10k_sdio mmc2:0001:1: board_file api 1 bmi_id N/A crc32 544289f7
> [<c0c31170>] (mutex_lock_nested) from [<c052d798>] (kernfs_find_and_get_ns+0x30/0x5c)
> [<c052d798>] (kernfs_find_and_get_ns) from [<c0531cc8>] (sysfs_add_link_to_group+0x28/0x58)
> [<c0531cc8>] (sysfs_add_link_to_group) from [<c07ef75c>] (iommu_device_link+0x50/0xb4)
> [<c07ef75c>] (iommu_device_link) from [<c07f2288>] (msm_iommu_add_device+0xa0/0xcc)
> [<c07f2288>] (msm_iommu_add_device) from [<c07ec6d0>] (add_iommu_group+0x3c/0x64)
> [<c07ec6d0>] (add_iommu_group) from [<c07f9d40>] (bus_for_each_dev+0x84/0xc4)
> [<c07f9d40>] (bus_for_each_dev) from [<c07ec7c8>] (bus_set_iommu+0xd0/0x10c)
> [<c07ec7c8>] (bus_set_iommu) from [<c07f1a68>] (msm_iommu_probe+0x5b8/0x66c)
> [<c07f1a68>] (msm_iommu_probe) from [<c07feaa8>] (platform_drv_probe+0x60/0xbc)
> [<c07feaa8>] (platform_drv_probe) from [<c07fc1fc>] (driver_probe_device+0x30c/0x4cc)
> [<c07fc1fc>] (driver_probe_device) from [<c07fc59c>] (__device_attach_driver+0xac/0x14c)
> [<c07fc59c>] (__device_attach_driver) from [<c07f9e14>] (bus_for_each_drv+0x68/0xc8)
> [<c07f9e14>] (bus_for_each_drv) from [<c07fbd3c>] (__device_attach+0xe4/0x178)
> [<c07fbd3c>] (__device_attach) from [<c07fc698>] (device_initial_probe+0x1c/0x20)
> [<c07fc698>] (device_initial_probe) from [<c07faee8>] (bus_probe_device+0x98/0xa0)
> [<c07faee8>] (bus_probe_device) from [<c07fb4f4>] (deferred_probe_work_func+0x74/0x198)
> [<c07fb4f4>] (deferred_probe_work_func) from [<c0348eb4>] (process_one_work+0x2c4/0x8fc)
> [<c0348eb4>] (process_one_work) from [<c03497b0>] (worker_thread+0x2c4/0x5cc)
> [<c03497b0>] (worker_thread) from [<c0350d10>] (kthread+0x180/0x188)
> [<c0350d10>] (kthread) from [<c03010b4>] (ret_from_fork+0x14/0x20)
>
> Fixes: 42df43b36163 ("iommu/msm: Make use of iommu_device_register interface")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---

Thanks for the patch.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Best regards
Vivek

>  drivers/iommu/msm_iommu.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 0d3350463a3f..9a95c9b9d0d8 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -395,20 +395,15 @@ static int msm_iommu_add_device(struct device *dev)
>         struct msm_iommu_dev *iommu;
>         struct iommu_group *group;
>         unsigned long flags;
> -       int ret = 0;
>
>         spin_lock_irqsave(&msm_iommu_lock, flags);
> -
>         iommu = find_iommu_for_dev(dev);
> +       spin_unlock_irqrestore(&msm_iommu_lock, flags);
> +
>         if (iommu)
>                 iommu_device_link(&iommu->iommu, dev);
>         else
> -               ret = -ENODEV;
> -
> -       spin_unlock_irqrestore(&msm_iommu_lock, flags);
> -
> -       if (ret)
> -               return ret;
> +               return -ENODEV;
>
>         group = iommu_group_get_for_dev(dev);
>         if (IS_ERR(group))
> @@ -425,13 +420,12 @@ static void msm_iommu_remove_device(struct device *dev)
>         unsigned long flags;
>
>         spin_lock_irqsave(&msm_iommu_lock, flags);
> -
>         iommu = find_iommu_for_dev(dev);
> +       spin_unlock_irqrestore(&msm_iommu_lock, flags);
> +
>         if (iommu)
>                 iommu_device_unlink(&iommu->iommu, dev);
>
> -       spin_unlock_irqrestore(&msm_iommu_lock, flags);
> -
>         iommu_group_remove_device(dev);
>  }
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
