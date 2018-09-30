Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4C4C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60F3206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcDOGTaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60F3206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeJAFXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:23:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41779 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeJAFXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id q39-v6so7075353lfi.8;
        Sun, 30 Sep 2018 15:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hpcf+yyEuwdAVdHwTmoGJPJeoEPherqEqKSae8kwd+g=;
        b=dcDOGTaCWs0hyEQ8zTqLAMZJaJV7f8a2Zvwhr245yKlsl27LMUwmV211TuLM+s6pV8
         IOzTP6aY6/hdNtohFFsz6gs72O9DK8BtiBXF9A7r9BGufEanYg+YxWbwJbiFbemMzQpu
         30BWKbyrC9t2fdhwiPbrwy4Ly78pgksuLBMghoxkyE7JlZ2miXro0/CHzANA1c+ypptP
         xIzdOvgB6sJ8uLguLtRMv9AEVYbiJG0Lxgpl7SI3wozhTS7CacWuefcsrwiYmGAcfJUj
         1++IfiT0RWwycPtWgHE1MYkowzboXJBd4P0g4eBLcu5ljGEKLLYyaimZ2v2RcCXOZqg8
         dnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hpcf+yyEuwdAVdHwTmoGJPJeoEPherqEqKSae8kwd+g=;
        b=evQT5556S7AFnvqabeovNlSIJ7zRHErc+BFRmxeoc4fjvzPQSyORxHSyr3DR8XDSnm
         aEulwHOwJUNmKuahbXKPOdVV9rdPxCnHzAFJFYPsyVTBR26z+St8vAnYZMg/U/iQD0Ad
         uGxSQ109Umn8xch7LtLJKtn4wGXibCxKaGjixSfj2L1wzDedTcr5+9fAuExuckrA7PHY
         A4KoHxkxbLSlU+MAOExep1LIzgdWLiAv7IqPIn3QiyiCBZuhAeqB6aQQ0DaPyGh0mW+K
         IE7Jp6kUQvuhIOtSZD7p/lpLAurv9qmadznoBm/xkYRY/xKtNam6JzUPpyrSYMdFTKHd
         bZRA==
X-Gm-Message-State: ABuFfogc/arwJe7yEdAV/wTlkz7GDlcX4Ky1CsbfvI/I+/yDRu6Zhpcd
        C3FJoD+Hr5vh3eN7YyMyPQM=
X-Google-Smtp-Source: ACcGV62S5OhG6/X0nN07RxLKe4h2zhVS3dmdVQpWRyhJXZ8ykilgWsr4rv12xcQNicTLoeOZhYyttA==
X-Received: by 2002:a19:a2c1:: with SMTP id l184-v6mr4109706lfe.33.1538347733922;
        Sun, 30 Sep 2018 15:48:53 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:48:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/21] IOMMU: Tegra GART driver clean up and optimization
Date:   Mon,  1 Oct 2018 01:48:12 +0300
Message-Id: <20180930224833.28809-1-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
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

Dmitry Osipenko (21):
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
 drivers/iommu/tegra-gart.c                    | 489 +++++++-----------
 drivers/memory/tegra/mc.c                     |  93 +++-
 drivers/memory/tegra/mc.h                     |  10 +-
 include/linux/iommu.h                         |   1 +
 include/soc/tegra/mc.h                        |  29 +-
 10 files changed, 306 insertions(+), 381 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

-- 
2.19.0

