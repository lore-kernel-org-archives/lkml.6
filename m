Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18855C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EC821788
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0UN2wh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EC821788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeHRTDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:03:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37203 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeHRTDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so6111860eds.4;
        Sat, 18 Aug 2018 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B4nh1qoBDdAlf4BAquX86kWLPz+KpHPDSJM8Y8HD+d4=;
        b=G0UN2wh6ipnwa+yp2JeZKTS2n2WnkgbBZkjnizlCb9D1TCeLpPKUVSqjoGXIPNm/Cs
         /QMMD7Bki8bqC+jJbefTrfcpCQPcDPGpA8/HLDSepwCduPH/o/V4hmZ5fG+tjqKIyCVR
         GN/5bXcXviOJndhxIicc53os0TaCQStJu8YZmQ5KKnM8LjrTn5XFJvV0TvVmjfqCdM9s
         7ZfBNRsdkMGeMmUG2XmxdcLB3nowOktTSB+MlKVRvBtxL4ZNaS3BEsd3LzOIe1VOpkbJ
         uskV8flbesKx8rHo7ck/x3NuiOoroSylNp6PEnhmmgfh5SX0Xi6yQ9tlcN2CE0xXEJgx
         /6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B4nh1qoBDdAlf4BAquX86kWLPz+KpHPDSJM8Y8HD+d4=;
        b=Gby2HlgglcFUALweH7ynPeuzyybMPPsvs+lcHjxTXl+oPo1CzBJZs/Y0hasrZCJ+AU
         rl54Sbnhaa/qPDPCWhYX7tAQs06aqx0rz5fx3x26l2Ay9XBH5MY8wUOohalLJ8sfqASJ
         YMWEV4XMS+bVewVrSTda5BkzqUdMKns5I0DI1TYcMPUGUBx6+gUll7uyFZmE4hdysGEJ
         wXPt2PixzXQAbdI3NJyMn9eMEQHqeQXBrKyfj5yzZAagBorGkWVzN53/ywL7dWSa38VS
         C6685a9T4P0nbCZLfl+aY2C+EBpQAXdX90zqugvLgYyMcZi1K4qpPEMj6BBr1/IYhRjl
         EwsQ==
X-Gm-Message-State: AOUpUlFW2WVg9Ss9nSPmVLPV6uU1fmoIf/mIKfPxxsy8cjnT1j6Y9Tu3
        7JQuKg17vVoPKlzEE+UeN/U=
X-Google-Smtp-Source: AA+uWPwBU+0OVoYsnHjpSWKukBiYjDK8l7/ObJzwx060aMfVQKmQ9r1Kn5qvKqsZvdYyGj21ycUX8Q==
X-Received: by 2002:a50:e0c9:: with SMTP id j9-v6mr47467846edl.198.1534607736597;
        Sat, 18 Aug 2018 08:55:36 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/19] IOMMU: Tegra GART driver clean up and optimization
Date:   Sat, 18 Aug 2018 18:54:11 +0300
Message-Id: <20180818155430.5586-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In the previous iteration Thierry Reding suggested that it is better to
break/change GART's device-tree ABI in order to integrate it with Memory
Controller without much churning. So this series now includes the device
tree changes.

After making GART to disallow more than one active IOMMU domain at a time,
I realized that the domain clients managing code has a few significant bugs
and now they are fixed. During the bugs squashing, I found that drivers code
require a major cleanup and hence there are now couple more patches that make
the code less tangled and easier to maintain as a result.

Changelog:

v3: Memory Controller integration part has been reworked and now GART's
    device-tree binding is changed. Adding Rob Herring for the device-tree
    changes reviewing.

    GART now disallows more than one active domain at a time.

    Fixed "spinlock recursion", "NULL pointer dereference" and "detaching
    of all devices from inactive domains".

    New code-refactoring patches.

    The previously standalone patch "memory: tegra: Don't invoke Tegra30+
    specific memory timing setup on Tegra20" is now included into this
    series because there is a dependency on that patch and it wasn't applied
    yet.

v2: Addressed review comments from Robin Murphy to v1 by moving devices
    iommu_fwspec check to gart_iommu_add_device().

    Dropped the "Provide single domain and group for all devices" patch from
    the series for now because after some more considering it became not
    exactly apparent whether that is what we need, that was also suggested
    by Robin Murphy in the review comment. Maybe something like a runtime
    IOMMU usage for devices would be a better solution, allowing to implement
    transparent context switching of virtual IOMMU domains.

    Some very minor code cleanups, reworded commit messages.

Dmitry Osipenko (19):
  iommu/tegra: gart: Remove pr_fmt and clean up includes
  iommu/tegra: gart: Clean up driver probe errors handling
  iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
  iommu: Introduce iotlb_sync_map callback
  iommu/tegra: gart: Optimize mapping / unmapping performance
  dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
  ARM: dts: tegra20: Update Memory Controller node to the new binding
  memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
    Tegra20
  memory: tegra: Adapt to Tegra20 device-tree binding changes
  memory: tegra: Read client ID on GART page fault
  iommu/tegra: gart: Integrate with Memory Controller driver
  iommu/tegra: gart: Fix spinlock recursion
  iommu/tegra: gart: Fix NULL pointer dereference
  iommu/tegra: gart: Allow only one active domain at a time
  iommu/tegra: gart: Don't use managed resources
  iommu/tegra: gart: Prepend error/debug messages with "GART:"
  iommu/tegra: gart: Don't detach devices from inactive domains
  iommu/tegra: gart: Simplify clients-tracking code
  iommu/tegra: gart: Perform code refactoring

 .../bindings/iommu/nvidia,tegra20-gart.txt    |  14 -
 .../memory-controllers/nvidia,tegra20-mc.txt  |  23 +-
 arch/arm/boot/dts/tegra20.dtsi                |  13 +-
 drivers/iommu/Kconfig                         |   1 +
 drivers/iommu/iommu.c                         |   8 +-
 drivers/iommu/tegra-gart.c                    | 466 +++++++-----------
 drivers/memory/tegra/mc.c                     |  83 +++-
 drivers/memory/tegra/mc.h                     |   6 -
 include/linux/iommu.h                         |   1 +
 include/soc/tegra/mc.h                        |  29 +-
 10 files changed, 287 insertions(+), 357 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

-- 
2.18.0

