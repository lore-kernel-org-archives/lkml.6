Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA71C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EA520831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="folkwLO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EA520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeLIUbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40930 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLIUbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:01 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so6505135lfe.7;
        Sun, 09 Dec 2018 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Amc6OpX9BaFx2cE46smM6XLXyJEsuJWhnHrPd9EGHzY=;
        b=folkwLO5zBHQt3X+6BV95VBBslk03ByNQSSAxALma8OgCZzXy/fFPyNlxRVFiofkTJ
         smCB2mXck5d5KwwDlHtyoUJvRFhGiKmVzZMvNaJ8MMzHmsgl6nayMTouEDDZW2z77WNP
         2E2+SrvataQgdYrlPM6N7bqzvTYEAv/g38k4tIW9d3rOdBoI8Foq920aau4XecQN40Dn
         EjLlUG1eF/kVExT+JMzQMfY8yqRXXGsjsAgMDG+XbDYG3bXVzmbZAGdKSWJ69aLUId++
         Pi/6NwicoM0neHDsZlEDybsSXhTNWn9+GEt5jMu9aa8Lq54XUNAFStPsjJ+mjw8awoZ8
         eTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Amc6OpX9BaFx2cE46smM6XLXyJEsuJWhnHrPd9EGHzY=;
        b=OY9lL1vvclFczpFr5DUzBoQTIf+QD5nnVAiIwy8vI5M6boVtQjfgvdLm1MNa8PTNpj
         jSMlOQT98X/fIn/fepfF2mhaRMkkOeVWO9JH5qzdFZkI91u2ovuhk09GAYZ92y6CvAug
         EQcZV0mhXIV1esQlQ5YIaZFl9VJ3u+MAMKFMNg+c8RxKF4G1U5aU9IG4bx0odancP9LA
         OwmCCvuIYL0H4AMJdnzP+N8StINfJRptQyTQugs/fktVEDYPa7B4trahDpxNjjbwVBxA
         MNau6itrlZxMP3WTEBUpJWWyDK3w48GgF+PFzBhLUuDwEeXefrmoiZifMCvcBnB7SnQe
         YYpg==
X-Gm-Message-State: AA+aEWbJXdfwbZ+pueTm8A6O8hYhycCBcFcpUBWVHP/39coYLp8tvRtv
        ofw7J+7C4Umz+gxFVnhEkec=
X-Google-Smtp-Source: AFSGD/Vl9Q0PN9P/0PW4fLIgp4F2OX286wlzJCq0psrORLA7LpFhhCvmoTxPY3xngLXLpquYclOnFw==
X-Received: by 2002:a19:9c92:: with SMTP id f140mr5083620lfe.41.1544387457009;
        Sun, 09 Dec 2018 12:30:57 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:30:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/21] IOMMU: Tegra GART driver clean up and optimization
Date:   Sun,  9 Dec 2018 23:29:29 +0300
Message-Id: <20181209202950.31486-1-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
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
 drivers/iommu/tegra-gart.c                    | 470 +++++++-----------
 drivers/memory/tegra/mc.c                     |  93 +++-
 drivers/memory/tegra/mc.h                     |  10 +-
 include/linux/iommu.h                         |   1 +
 include/soc/tegra/mc.h                        |  29 +-
 10 files changed, 307 insertions(+), 361 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

-- 
2.19.1

