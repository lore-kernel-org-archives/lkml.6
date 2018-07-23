Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E7CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7645720874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AaSOE1s6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bnoy1dhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7645720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbeGWGxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:53:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeGWGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:53:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 185D16074D; Mon, 23 Jul 2018 05:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532325224;
        bh=ziXkyQtGS+BCjCFwHMgs2RjsjU0MHF2K0nChqfcQi+c=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=AaSOE1s60prPxHWGlKxrdKMwjheBIC6dQ/PRmbFRc7xP0pRu26JyLOXY//Sh/ywwz
         4d9pKP9wSIfJRZRU+Ejfx9cKEqfhQQ8/zFQbw+deFjjo4VW5zZLZG03spxRUd8Kk28
         xikD9How+dJmpPw3TaRnGQ0OpXQYCjeeAwzdG9mo=
Received: from mail-qt0-f175.google.com (mail-qt0-f175.google.com [209.85.216.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DD5060B12;
        Mon, 23 Jul 2018 05:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532325222;
        bh=ziXkyQtGS+BCjCFwHMgs2RjsjU0MHF2K0nChqfcQi+c=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Bnoy1dhjkblkoSV/YRcbzIGh3u1NNRyEvzI18LoqjzYygxbkXrIIXuzb2eT/1Hpir
         IH0LFO/Gp/QcVJVEOcea8oTHt1LLTcicCD/EZmwKskRg0HHSVBOUSPUaNc/X6J8gb0
         rAv7eJpvSddioS62rUXKR8xGdpIncDHjHgQa3QXE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DD5060B12
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f175.google.com with SMTP id y5-v6so15448105qti.12;
        Sun, 22 Jul 2018 22:53:42 -0700 (PDT)
X-Gm-Message-State: AOUpUlE3tNKg9XrLMgtALKDx2RbToHwTTf7OltpzxRY6M9HluHoC81qH
        qJa5NXyZySa9QA2jvIn7zUkNa5j4z35moND6rHI=
X-Google-Smtp-Source: AAOMgpf2H2ppcLoJ8xzSca7jVUfn3XSHDoUx86IlvH3KDnnO4ONBSSxubpJdTaez+aI2JWo2qpwg5gV5Wq3qWMCBBOU=
X-Received: by 2002:a0c:c489:: with SMTP id u9-v6mr9934888qvi.11.1532325221720;
 Sun, 22 Jul 2018 22:53:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:f25:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 22:53:41 -0700 (PDT)
In-Reply-To: <20180719101539.6104-1-vivek.gautam@codeaurora.org>
References: <20180719101539.6104-1-vivek.gautam@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 23 Jul 2018 11:23:41 +0530
X-Gmail-Original-Message-ID: <CAFp+6iER6_1MoCWJZeTsXja_ykOz32-3LB_EVNCm6uQWyh5mAA@mail.gmail.com>
Message-ID: <CAFp+6iER6_1MoCWJZeTsXja_ykOz32-3LB_EVNCm6uQWyh5mAA@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] iommu/arm-smmu: Add runtime pm/sleep support
To:     Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "robh+dt" <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 3:45 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> This series provides the support for turning on the arm-smmu's
> clocks/power domains using runtime pm. This is done using
> device links between smmu and client devices. The device link
> framework keeps the two devices in correct order for power-cycling
> across runtime PM or across system-wide PM.
>
> With addition of a new device link flag DL_FLAG_AUTOREMOVE_SUPPLIER [8]
> (available in linux-next of Rafael's linux-pm tree [9]), the device links
> created between arm-smmu and its clients will be automatically purged
> when arm-smmu driver unbinds from its device.
>
> As not all implementations support clock/power gating, we are checking
> for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
> power management for such smmu implementations that can support it.
> Otherwise, the clocks are turned to be always on in .probe until .remove.
> With conditional runtime pm now, we avoid touching dev->power.lock
> in fastpaths for smmu implementations that don't need to do anything
> useful with pm_runtime.
> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
> calls in map/unmap callbacks so that the clients do not have to
> worry about handling any of the arm-smmu's power.
>
> This series also adds support for Qcom's arm-smmu-v2 variant that
> has different clocks and power requirements.
>
> Previous version of this patch series is @ [2].
>
> Tested this series on msm8996, and sdm845 after pulling in Rafael's linux-pm
> linux-next[9] and Joerg's iommu next[10] branches.

Hi Rafael,

If the changes look good to you now, can you please consider giving your Ack.
Thanks.

Hi Robin, Will,
If the series looks good to you, and if there's a chance, can you
please consider
picking this series for 4.19. Thanks.

Best regards
Vivek

>
> [v13]
>    Addressing Rafael's comments:
>    * Added .suspend pm callback to disable the clocks in system wide suspend.
>    * Added corresponding clock enable in .resume pm callback.
>    * Explicitly enabling/disabling the clocks now when runtime PM is disabled.
>    * device_link_add() doesn't depend on pm_runtime_enabled() as we can
>      use device links across system suspend/resume too.
>
>    Addressing Robin's comments:
>    * Making device_link_add failures as non-fatal.
>
>    * Removed IOMMU_OF_DECLARE() declaration as we don't need this after Rob's
>      patch that removed all of these declarations.
>
> [v12]
>    * Use new device link's flag introduced in [8] -
>      DL_FLAG_AUTOREMOVE_SUPPLIER. With this devices links are automatically
>      purged when arm-smmu driver unbinds.
>    * Using pm_runtime_force_suspend() instead of pm_runtime_disable() to
>      avoid following warning from arm_smmu_device_remove()
>
>      [295711.537507] ------------[ cut here ]------------
>      [295711.544226] Unpreparing enabled smmu_mdp_ahb_clk
>      [295711.549099] WARNING: CPU: 0 PID: 1 at ../drivers/clk/clk.c:697
>                      clk_core_unprepare+0xd8/0xe0
>      ...
>      [295711.674073] Call trace:
>      [295711.679454]  clk_core_unprepare+0xd8/0xe0
>      [295711.682059]  clk_unprepare+0x28/0x40
>      [295711.685964]  clk_bulk_unprepare+0x28/0x40
>      [295711.689701]  arm_smmu_device_remove+0x88/0xd8
>      [295711.693692]  arm_smmu_device_shutdown+0xc/0x18
>      [295711.698120]  platform_drv_shutdown+0x20/0x30
>
> [v11]
>    * Some more cleanups for device link. We don't need an explicit
>      delete for device link from the driver, but just set the flag
>      DL_FLAG_AUTOREMOVE.
>      device_link_add() API description says -
>      "If the DL_FLAG_AUTOREMOVE is set, the link will be removed
>      automatically when the consumer device driver unbinds."
>    * Addressed the comments for 'smmu' in arm_smmu_map/unmap().
>    * Dropped the patch [7] that introduced device_link_del_dev() API.
>
> [v10]
>    * Introduce device_link_del_dev() API to delete the link between
>      given consumer and supplier devices. The users of device link
>      do not need to store link pointer to delete the link later.
>      They can straightaway use this API by passing consumer and
>      supplier devices.
>    * Made corresponding changes to arm-smmu driver patch handling the
>      device links.
>    * Dropped the patch [6] that was adding device_link_find() API to
>      device core layer. device_link_del_dev() serves the purpose to
>      directly delete the link between two given devices.
>
> [v9]
>    * Removed 'rpm_supported' flag, instead checking on pm_domain
>      to enable runtime pm.
>    * Creating device link only when the runtime pm is enabled, as we
>      don't need a device link besides managing the power dependency
>      between supplier and consumer devices.
>    * Introducing a patch to add device_link_find() API that finds
>      and existing link between supplier and consumer devices.
>      Also, made necessary change to device_link_add() to use this API.
>    * arm_smmu_remove_device() now uses this device_link_find() to find
>      the device link between smmu device and the master device, and then
>      delete this link.
>    * Dropped the destroy_domain_context() fix [5] as it was rather,
>      introducing catastrophically bad problem by destroying
>      'good dev's domain context.
>    * Added 'Reviwed-by' tag for Tomasz's review.
>
> [v8]
>    * Major change -
>      - Added a flag 'rpm_supported' which each platform that supports
>        runtime pm, can enable, and we enable runtime_pm over arm-smmu
>        only when this flag is set.
>      - Adding the conditional pm_runtime_get/put() calls to .map, .unmap
>        and .attach_dev ops.
>      - Dropped the patch [3] that exported pm_runtim_get/put_suupliers(),
>        and also dropped the user driver patch [4] for these APIs.
>
>    * Clock code further cleanup
>      - doing only clk_bulk_enable() and clk_bulk_disable() in runtime pm
>        callbacks. We shouldn't be taking a slow path (clk_prepare/unprepare())
>        from these runtime pm callbacks. Thereby, moved clk_bulk_prepare() to
>        arm_smmu_device_probe(), and clk_bulk_unprepare() to
>        arm_smmu_device_remove().
>      - clk data filling to a common method arm_smmu_fill_clk_data() that
>        fills the clock ids and number of clocks.
>
>    * Addressed other nits and comments
>      - device_link_add() error path fixed.
>      - Fix for checking negative error value from pm_runtime_get_sync().
>      - Documentation redo.
>
>    * Added another patch fixing the error path in arm_smmu_attach_dev()
>      to destroy allocated domain context.
>
> [v7]
>    * Addressed review comments given by Robin Murphy -
>      - Added device_link_del() in .remove_device path.
>      - Error path cleanup in arm_smmu_add_device().
>      - Added pm_runtime_get/put_sync() in .remove path, and replaced
>         pm_runtime_force_suspend() with pm_runtime_disable().
>      - clk_names cleanup in arm_smmu_init_clks()
>    * Added 'Reviewed-by' given by Rob H.
>
> ** Change logs for previous versions is available in last series [4].
>
>
> [1] https://patchwork.kernel.org/patch/10204925/
> [2] https://lkml.org/lkml/2018/7/8/124
> [3] https://patchwork.kernel.org/patch/10204945/
> [4] https://patchwork.kernel.org/patch/10204925/
> [5] https://patchwork.kernel.org/patch/10254105/
> [6] https://patchwork.kernel.org/patch/10277975/
> [7] https://patchwork.kernel.org/patch/10281613/
> [8] https://patchwork.kernel.org/patch/10491481/
> [9] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next
> [10] https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=next
>
> Sricharan R (3):
>   iommu/arm-smmu: Add pm_runtime/sleep ops
>   iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
>   iommu/arm-smmu: Add the device_link between masters and smmu
>
> Vivek Gautam (1):
>   iommu/arm-smmu: Add support for qcom,smmu-v2 variant
>
>  .../devicetree/bindings/iommu/arm,smmu.txt         |  42 +++++
>  drivers/iommu/arm-smmu.c                           | 192 +++++++++++++++++++--
>  2 files changed, 224 insertions(+), 10 deletions(-)
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
