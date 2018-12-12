Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E57C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617C02080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVie0Buf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617C02080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeLLUwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:52:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35595 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLUwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:52:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so9447577pfi.2;
        Wed, 12 Dec 2018 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QL/fH6yYMula8jLl5mVxMOT2iB/Q14YZLve/5K/uPA=;
        b=EVie0BufpDMJK68/nW+z6XIs0mNSUuKUS1OCctFyKh20QNM/i/0bUnx2cIK/OeVnbd
         FBZ0t/VwGZnoBa0WSSsEoc6YDv1sI36mXMlnHX4QBtPpcoOfBQwqsE4qvfzJSFsf8rjL
         K+KT4v91SZPSb6UMC2Gnd1BPZq5F9sTvOcMIeDkVzEaRPM/SpnFMttXpw+A7wTnjl5st
         PD49j9CkvD9aFQMJIGxNqGNTq0Febx51KmdqCy6IIMQUAI1FDgAaAskU1O9gdRk8TFRi
         dB8icsYbcs9QpmqLerg0Jv6a90Ah+h+81jRvXZdEq99/W3CimdxD8fmlhHWIeR9KFDK9
         4hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QL/fH6yYMula8jLl5mVxMOT2iB/Q14YZLve/5K/uPA=;
        b=GfdE5kUxzdDqjw2oNJWsLrJjgCBdJ22VLgKHfrr7rW6m45Bv4MwIZDM1BegEsc3Ow6
         n7amLwuAa80095LSf/OExid3UgsX3/gaMJ/riJhDCnFXVqgB+lrGMRmwvurKmHN6McyN
         YCQ3zZWMm+aR9ebAg4rp+M9E2zRKjbyEEtRLygBiQiCvfcJKRGTSKrgZdwqX2bVyTN4f
         /KSGngGmOmaiVPDfpkg4jeXFb5ZylHZbOQ3PeQdAD7JTyMpM28b+X0NONNDiAeIR7cq8
         QW3PTGcmonb4pO65EOaXwMQCJ1YI+hvoz1bJ/oSEusHek1qkCinzzWvnOPc+6pPdWG92
         /nsA==
X-Gm-Message-State: AA+aEWbbSFtak4XkFAr3pWAxAjtXcUAwRSziSnobpiwT6Ob6k+WvzjCo
        pBq0HMd3rs7Uw39hE7PgPBNS+7Oa
X-Google-Smtp-Source: AFSGD/USlGCi2khfP+qmShIH90OWlkWTWJjqPhbdjWo3MnBy7PPPtlF1Iy6c9jIYY6O+KqCXVyzG4w==
X-Received: by 2002:a65:6542:: with SMTP id a2mr19352743pgw.389.1544647918822;
        Wed, 12 Dec 2018 12:51:58 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:51:58 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/24] Tegra GART driver clean up and optimization
Date:   Wed, 12 Dec 2018 23:38:43 +0300
Message-Id: <20181212203907.23461-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch-series integrates the GART (IOMMU) driver with the Memory
Controller driver, that allows to report the name of a faulty memory
client on GART page fault. A major code clean up and performance
optimization is performed in this series as well.

Changelog:

v7: Addressed review comments to v6 from Thierry Reding.

    Added three new (minor) patches that further prettifying the drivers
    code.

    New patches in v7:
        1) "memory: tegra: Do not try to probe SMMU on Tegra20"
        2) "memory: tegra: Do not ask for IRQ sharing"
        3) "memory: tegra: Clean up error messages"

    Incorporated another "one-line" change into the "perform code refactoring"
    patch: now GART translation is kept disabled in HW while GART is suspended.

v6: v5 that is re-based on the recent linux-next.

v5: Addressed review comments from Thierry Reding to v4. Added WARN_ON() to
    make sure that active domain isn't getting released, kept include headers
    where necessary, etc.. All changes are quite minor.

    Added new patch "memory: tegra: Use relaxed versions of readl/writel".

v4: In the v3 Rob Herring requested to make device-tree binding changes
    backwards-compatible with the older kernels, that is achieved by
    changing the 'compatible' value of the DT node.

    The code-refactoring patches got some more (minor) polish.

    Added new patch "memory: tegra: Use of_device_get_match_data()".

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

Dmitry Osipenko (24):
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
  memory: tegra: Use of_device_get_match_data()
  memory: tegra: Use relaxed versions of readl/writel
  iommu/tegra: gart: Integrate with Memory Controller driver
  memory: tegra: Do not try to probe SMMU on Tegra20
  memory: tegra: Do not ask for IRQ sharing
  memory: tegra: Clean up error messages
  iommu/tegra: gart: Fix spinlock recursion
  iommu/tegra: gart: Fix NULL pointer dereference
  iommu/tegra: gart: Allow only one active domain at a time
  iommu/tegra: gart: Don't use managed resources
  iommu/tegra: gart: Prepend error/debug messages with "gart:"
  iommu/tegra: gart: Don't detach devices from inactive domains
  iommu/tegra: gart: Simplify clients-tracking code
  iommu/tegra: gart: Perform code refactoring

 .../bindings/iommu/nvidia,tegra20-gart.txt    |  14 -
 .../memory-controllers/nvidia,tegra20-mc.txt  |  27 +-
 arch/arm/boot/dts/tegra20.dtsi                |  15 +-
 drivers/iommu/Kconfig                         |   1 +
 drivers/iommu/iommu.c                         |   8 +-
 drivers/iommu/tegra-gart.c                    | 473 +++++++-----------
 drivers/iommu/tegra-smmu.c                    |   4 -
 drivers/memory/tegra/mc.c                     | 118 +++--
 drivers/memory/tegra/mc.h                     |  10 +-
 include/linux/iommu.h                         |   1 +
 include/soc/tegra/mc.h                        |  27 +-
 11 files changed, 323 insertions(+), 375 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

-- 
2.20.0

