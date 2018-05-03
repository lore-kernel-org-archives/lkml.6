Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeECXwK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:52:10 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40862 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeECXwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:52:08 -0400
X-Google-Smtp-Source: AB8JxZpMsGit4xX8PAysSQ39yvS+r/9up4lxiVKm97l5bE+h5ABrZdtFBdloze0G5JHgRFo7GwLCVQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Support IOMMU for 2d/3d on Tegra30/114
Date: Fri,  4 May 2018 02:47:18 +0300
Message-Id: <20180503234723.4368-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables IOMMU support for 2d/3d HW on Tegra30/114, as a result
userspace that uses 2d/3d could work with the active IOMMU.

Dmitry Osipenko (5):
  drm/tegra: dc: Balance IOMMU group refcounting
  drm/tegra: gr2d: Add IOMMU support
  drm/tegra: gr3d: Add IOMMU support
  ARM: dts: tegra30: Add IOMMU nodes to Host1x and its clients
  ARM: dts: tegra114: Add IOMMU nodes to Host1x and its clients

 arch/arm/boot/dts/tegra114.dtsi |  5 +++++
 arch/arm/boot/dts/tegra30.dtsi  | 14 +++++++++++++
 drivers/gpu/drm/tegra/dc.c      | 35 ++++++++++++++++-----------------
 drivers/gpu/drm/tegra/dc.h      |  2 +-
 drivers/gpu/drm/tegra/drm.h     |  2 +-
 drivers/gpu/drm/tegra/gr2d.c    | 31 +++++++++++++++++++++++++++--
 drivers/gpu/drm/tegra/gr3d.c    | 27 +++++++++++++++++++++++++
 7 files changed, 94 insertions(+), 22 deletions(-)

-- 
2.17.0
