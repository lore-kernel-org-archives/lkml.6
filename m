Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753729AbeE3PK1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:10:27 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38718 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeE3PKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:10:23 -0400
X-Google-Smtp-Source: ADUXVKLS90zFr0yWobMJfU47PbO058JzuBWd94i2MjzDWpJ1r6ngCCn1CvGcJ70b+dQ9Qo4Kfw1zZA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Tegra20 External Memory Controller driver
Date: Wed, 30 May 2018 18:06:42 +0300
Message-Id: <20180530150646.19030-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Couple years ago the Tegra20 EMC driver was removed from the kernel
due to incompatible changes in the Tegra's clock driver. This patchset
introduces a modernized EMC driver. Currently the sole purpose of the
driver is to initialize DRAM frequency to maximum rate during of the
kernels boot-up. Later we may consider implementing dynamic memory
frequency scaling, utilizing functionality provided by this driver.

Dmitry Osipenko (4):
  dt: bindings: tegra20-emc: Document interrupt property
  ARM: dts: tegra20: Add interrupt to External Memory Controller
  clk: tegra20: Turn EMC clock gate into divider
  memory: tegra: Introduce Tegra20 EMC driver

 .../bindings/arm/tegra/nvidia,tegra20-emc.txt |   2 +
 arch/arm/boot/dts/tegra20.dtsi                |   1 +
 drivers/clk/tegra/clk-tegra20.c               |  39 +-
 drivers/memory/tegra/Kconfig                  |  10 +
 drivers/memory/tegra/Makefile                 |   1 +
 drivers/memory/tegra/tegra20-emc.c            | 573 ++++++++++++++++++
 6 files changed, 616 insertions(+), 10 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra20-emc.c

-- 
2.17.0
