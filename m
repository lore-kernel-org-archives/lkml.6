Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD18EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DCA208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5SVwK0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DCA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbeKPW0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:26:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43661 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeKPW0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:26:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id g26-v6so20093722lja.10;
        Fri, 16 Nov 2018 04:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P/C68tgBr/36IQsfLFjmZArudu2HhHEJ47qviEqux4M=;
        b=W5SVwK0kdQzds8MMopWODpByMR+/UhB+I4nSJVPORykkUCpdY+3Cbsf6Vjoe6KwJd7
         sWoYvVGu8nkXzpwGwqBYECtqX8rfDkNLUry15T2xX3LJrBk8jzSiUicIfllvOqtjhjm8
         AMc3uPEert7Sou/UPWWlap3WEQkK7qy7UGPo6uxWrAit8ED9czyCHuH1WDvWsUlZGRNp
         8IjruBeN8IsxbgRfl7gkuSx+n5Rr7gU2TWfZidplEK1EWQnFcHUxQVmokzdxdQfWTOWH
         9ZmJBeHlmjRhKUoaAlcnvLh9iCxuRaD42qxh2u3X10eClmOqwEOK14kuQdaclshsLSjl
         mBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P/C68tgBr/36IQsfLFjmZArudu2HhHEJ47qviEqux4M=;
        b=AZrWkkVSFJryaru3dLapo2t9JJnHOC5ud6OYvWXtCsKWGC26Z48atHxgjPIitdtAl8
         om6HvtKbwD2y/KckxnoByshpLPx0spVbQcga0d+5yu+U8cNITQv/FDn5qajIh2r2vBOQ
         y2zTAzjMtvQlMN2Dn5CEXECWJbj+AV9AyAHr7RD1aaNU4YzBSFCPjPahMBX68WlbWc+j
         6MWmuJcnKuAA8jHE15rkcfQziL7yXOce+CvF0MDX5hRZGBqeczGSC4j0rhhVYo3PqrQU
         QtH1njju6G69TbRiiqtyy0eQNYXJaDX+pqnOYF7pc+Y9YerGMCZFejsDyUSzVkRENpZ1
         MQdA==
X-Gm-Message-State: AA+aEWaiw7OnkZbh71Jmed/ErbFkCnCLO16LEA4gp+pueeKz00b9+run
        gAJU5JLeUcOsY7YajG2r6JIUHt2F
X-Google-Smtp-Source: AFSGD/WmjY6t1NZqiJJZTTYeFBax7pIHw3qBX9w6WKOFI7Y4WDEQiZ2rfRaSpMdU6rC+Yr9uDWfhnA==
X-Received: by 2002:a2e:612:: with SMTP id 18-v6mr2617302ljg.125.1542370467645;
        Fri, 16 Nov 2018 04:14:27 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id f95-v6sm4817210lji.76.2018.11.16.04.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 04:14:26 -0800 (PST)
Subject: Re: [PATCH v5 00/21] IOMMU: Tegra GART driver clean up and
 optimization
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180930224833.28809-1-digetx@gmail.com>
Message-ID: <12b55bb4-1a52-1045-cc99-f8e4eaf2bdf5@gmail.com>
Date:   Fri, 16 Nov 2018 15:13:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.2018 1:48, Dmitry Osipenko wrote:
> Hello,
> 
> This patch-series integrates the GART (IOMMU) driver with the Memory
> Controller driver, that allows to report the name of a faulty memory
> client on GART page fault. A major code clean up and performance
> optimization is performed in this series as well.
> 
> Changelog:
> 
> v5: Addressed review comments from Thierry Reding to v4. Added WARN_ON() to
>     make sure that active domain isn't getting released, kept include headers
>     where necessary, etc.. All changes are quite minor.
> 
>     Added new patch "memory: tegra: Use relaxed versions of readl/writel".
> 
> v4: In the v3 Rob Herring requested to make device-tree binding changes
>     backwards-compatible with the older kernels, that is achieved by
>     changing the 'compatible' value of the DT node.
> 
>     The code-refactoring patches got some more (minor) polish.
> 
>     Added new patch "memory: tegra: Use of_device_get_match_data()".
> 
> v3: Memory Controller integration part has been reworked and now GART's
>     device-tree binding is changed. Adding Rob Herring for the device-tree
>     changes reviewing.
> 
>     GART now disallows more than one active domain at a time.
> 
>     Fixed "spinlock recursion", "NULL pointer dereference" and "detaching
>     of all devices from inactive domains".
> 
>     New code-refactoring patches.
> 
>     The previously standalone patch "memory: tegra: Don't invoke Tegra30+
>     specific memory timing setup on Tegra20" is now included into this
>     series because there is a dependency on that patch and it wasn't applied
>     yet.
> 
> v2: Addressed review comments from Robin Murphy to v1 by moving devices
>     iommu_fwspec check to gart_iommu_add_device().
> 
>     Dropped the "Provide single domain and group for all devices" patch from
>     the series for now because after some more considering it became not
>     exactly apparent whether that is what we need, that was also suggested
>     by Robin Murphy in the review comment. Maybe something like a runtime
>     IOMMU usage for devices would be a better solution, allowing to implement
>     transparent context switching of virtual IOMMU domains.
> 
>     Some very minor code cleanups, reworded commit messages.
> 
> Dmitry Osipenko (21):
>   iommu/tegra: gart: Remove pr_fmt and clean up includes
>   iommu/tegra: gart: Clean up driver probe errors handling
>   iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
>   iommu: Introduce iotlb_sync_map callback
>   iommu/tegra: gart: Optimize mapping / unmapping performance
>   dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
>   ARM: dts: tegra20: Update Memory Controller node to the new binding
>   memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
>     Tegra20
>   memory: tegra: Adapt to Tegra20 device-tree binding changes
>   memory: tegra: Read client ID on GART page fault
>   memory: tegra: Use of_device_get_match_data()
>   memory: tegra: Use relaxed versions of readl/writel
>   iommu/tegra: gart: Integrate with Memory Controller driver
>   iommu/tegra: gart: Fix spinlock recursion
>   iommu/tegra: gart: Fix NULL pointer dereference
>   iommu/tegra: gart: Allow only one active domain at a time
>   iommu/tegra: gart: Don't use managed resources
>   iommu/tegra: gart: Prepend error/debug messages with "gart:"
>   iommu/tegra: gart: Don't detach devices from inactive domains
>   iommu/tegra: gart: Simplify clients-tracking code
>   iommu/tegra: gart: Perform code refactoring
> 
>  .../bindings/iommu/nvidia,tegra20-gart.txt    |  14 -
>  .../memory-controllers/nvidia,tegra20-mc.txt  |  27 +-
>  arch/arm/boot/dts/tegra20.dtsi                |  15 +-
>  drivers/iommu/Kconfig                         |   1 +
>  drivers/iommu/iommu.c                         |   8 +-
>  drivers/iommu/tegra-gart.c                    | 489 +++++++-----------
>  drivers/memory/tegra/mc.c                     |  93 +++-
>  drivers/memory/tegra/mc.h                     |  10 +-
>  include/linux/iommu.h                         |   1 +
>  include/soc/tegra/mc.h                        |  29 +-
>  10 files changed, 306 insertions(+), 381 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> 

Hello Thierry,

This patchset should be in a good shape, could you please take a look at the (minor) changes done in v5 and give r-b/ack to the remaining patches? Will be very nice if this series could finally land, especially in the light of upcoming DRM/HOST1x (re-)work.
