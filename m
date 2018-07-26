Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3B2C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576302088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHXVgNzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576302088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbeG0Alc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:41:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40448 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbeG0Alc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:41:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id y200-v6so2318663lfd.7;
        Thu, 26 Jul 2018 16:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZdYIEyrIZl741x3N+P1wcgc/lwAS+OM52HOIIYQ4X64=;
        b=KHXVgNzkcZc4EjrAr1NUOrKPZDWt/2siLqQvaRG+siZJvV7qe8gIR/IRJhYSSnMDCf
         H/4vZreS476ERWutYoa4/8NH0dQk7bUb9OPDy/pKwZAFlyC/PaRSA5Tnf0gPbpuTnUpJ
         2KSbB0Zf8Uxpsnpc17TQhNh3pyWFxlJbWmE5fEbaZJKAD0ODhnuoYnnX2+x++BnvuLFx
         f84c3l5cGHXeuakfroRKMOhbPUIqLU+GxrybntPQ2rNtGeXnuSc1+QlUzVosux8UWPGF
         9xkW9wS9XrHuc/5YUOFiXiraGIaRQ9G7+3QdXLk/bRkLNaaFy0TZHrN19fzIhV9IoQ+R
         LPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZdYIEyrIZl741x3N+P1wcgc/lwAS+OM52HOIIYQ4X64=;
        b=fyaLOdDZRM34DIXYjPgBWH3zB1OwUdMioFBaBH+EG4/2W12R0v6Mwej2bnLybJp79r
         w0QjQfMd3tnWrN/PMsJRP8T9SFAf453Ka3JbKOD2SuUQOo0NUSNbrBC1fCw2DQ9c+5/e
         VlfNoOVqbK1WeDAgsElmKPIGVUmtsgup5oqpb0BuJ3YFsgSmunrk/1YW/h1BNTNlvUVc
         jz/ZQAcWOpOrJOKV05eKEt1sh6uM5GMG5YatxaBF1nrJciMn6WEEorFa2crhZlII0KrB
         Zw0TuSBmVYDHCV5ORF50uc4X2R+jLNFxRj+DoEMRR4oZEz2eeyG3w8bwqmrHF5K888cY
         67kQ==
X-Gm-Message-State: AOUpUlHIO36X6I/FOnRn/HgULAN5p3Whzm89v6zc8XLhcNA3hFdYuz5T
        OT5142NAn6p3BI8afofru90=
X-Google-Smtp-Source: AAOMgpehgaYJ1xTq5qn0yQgJXn5QANyUJQ94R+Jt8JdowGIwBTLxttoSaZE6Dpg4EcWs6dlQ/4brlw==
X-Received: by 2002:a19:1888:: with SMTP id 8-v6mr2399027lfy.121.1532647349859;
        Thu, 26 Jul 2018 16:22:29 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q15-v6sm411541ljg.62.2018.07.26.16.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 16:22:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Date:   Fri, 27 Jul 2018 02:16:18 +0300
Message-Id: <20180726231624.21084-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There is a trouble on ARM with DMA allocations made by device drivers,
the trouble is that DMA allocations are getting implicitly backed with
IOMMU mapping by the driver core if IOMMU presents in a system and IOMMU
could handle device. This is an undesired behaviour for drivers that
manage IOMMU by themselves, like NVIDIA Tegra GPU driver. On arm32 the
implicit backing happens if CONFIG_ARM_DMA_USE_IOMMU=y (multiplatform
kernel configuration), on arm64 it happens if IOMMU domain type for a
device is equal to IOMMU_DOMAIN_DMA.

The proposed solution adds a new option to the base device driver
structure that allows device drivers to explicitly convey to the drivers
core that the implicit IOMMU backing for devices must not happen.

Dmitry Osipenko (6):
  driver core: Add option for disabling of backing devices DMA with
    IOMMU
  of/device: Don't back devices DMA with IOMMU if that's undesired by
    driver
  drm/tegra: Avoid implicit DMA backing with IOMMU
  gpu: host1x: Avoid implicit DMA backing with IOMMU
  drm/nouveau: tegra: Universally avoid implicit DMA backing with IOMMU
  Revert "drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping"

 drivers/gpu/drm/nouveau/nouveau_platform.c         |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 -------------
 drivers/gpu/drm/tegra/dc.c                         |  1 +
 drivers/gpu/drm/tegra/gr2d.c                       |  1 +
 drivers/gpu/drm/tegra/gr3d.c                       |  1 +
 drivers/gpu/drm/tegra/vic.c                        |  1 +
 drivers/gpu/host1x/dev.c                           |  1 +
 drivers/of/device.c                                |  7 +++++++
 include/linux/device.h                             |  2 ++
 9 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.18.0

