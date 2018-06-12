Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1B67AC004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2FE208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="OxWhaYdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2FE208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934351AbeFLACp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:02:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36450 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934155AbeFLACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:02:21 -0400
Received: by mail-pg0-f67.google.com with SMTP id m5-v6so10535443pgd.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w4MCASmbObdVJXaNKbHRPa+xYHPkItPQxetU/BJ7G7s=;
        b=OxWhaYdrEmLmJFu4lWCIKN116jf15bXZfYBnScg9xxN1ABha8Ftvz9eqcaQfONFhhE
         W8bnpdZId2jv3D/ZlVKe7p1fFJQD5DusCUMYKSgm/a4AGj+B7HxGeXpcOJhT+0UI9AJ2
         7BzR/BqHpmrf26m3kSC1BJPHFmDvzqla1Uulhe+BNN755Sf8lJ14iUzAKy4fgWyTmKZq
         iEmjULv8rafwDUGExBOeY53x6Nr5AR6UsSW8ikKzwAp4Yf6cSuSMOfcl6ynVhgLhY33I
         BOULcmsFmgMniEHEX7ky1mSmOBwUv5svd+x4Pi3fCLWidbsQgBpJszWPtOEq0QvJ6ndN
         XccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w4MCASmbObdVJXaNKbHRPa+xYHPkItPQxetU/BJ7G7s=;
        b=hLxAw6FsL/5jM0xm40SI3g4tiTYda+M+nhw994IpAr1Kt97DWUZR+ThoMGQbTJUGY+
         FsqGW+brz+QdNO3YkOepIxh9giIWWxPnUAO8nKoepCFGrRGtFnn5Hd4d6xZfiJIH7AwG
         8CD9peenxRl6X+fA+pV36nbmEwehegM5x7rdLbpR8HGIUQdchnklI7Q9LxVFCqEcOlcJ
         9lywMz2h0k2cyxujTyUT0Gf8By2o0ho+evVCZzmfcoECfGYLESW9mtLE1vtf+RdVKt4r
         Ch4zBX6yLZocHhEukTj2K/gbe3RKw0M0oSRdIIg7HVlGQNoz/HsVJr08RDdYCt9aqhLB
         TX0g==
X-Gm-Message-State: APt69E2wTFejMDNoScugx5ry9GE8q/xykR9bHq0PbMhjIeCr5yyiiDMg
        kWzmRZI4DFyWRHZcyDMY/HsFYw==
X-Google-Smtp-Source: ADUXVKJl6ktHwCLZc+JvrQjYb+FXbIHLlFjPkHia49Aw0ohY6pHOqNyO7phfUDSa2OYu/gs/X53nWw==
X-Received: by 2002:a65:5c46:: with SMTP id v6-v6mr1057891pgr.127.1528761740207;
        Mon, 11 Jun 2018 17:02:20 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id c27-v6sm82016623pfl.63.2018.06.11.17.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:02:17 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 3/4] ARM: SoC driver updates
Date:   Mon, 11 Jun 2018 17:01:41 -0700
Message-Id: <20180612000142.28883-4-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612000142.28883-1-olof@lixom.net>
References: <20180612000142.28883-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This branch contains platform-related driver updates for ARM and ARM64.

Highlights:
- ARM SCMI (System Control & Management Interface) driver cleanups
- Hisilicon support for LPC bus w/ ACPI
- Reset driver updates for several platforms: Uniphier,
- Rockchip power domain bindings and hardware descriptions for several SoCs.
- Tegra memory controller reset improvements


Conflicts: None

----------------------------------------------------------------

The following changes since commit f6842ec05a77253b953ab67152915fe7df887d40:

  Merge branch 'next/dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to 32561354b16944e784e82a2011765c50e77e1c56:

  ARM: tegra: fix compile-testing PCI host driver

----------------------------------------------------------------

Andrey Smirnov (2):
      soc: imx: gpcv2: Do not pass static memory as platform data
      soc: imx: gpc: Do not pass static memory as platform data

Arnd Bergmann (1):
      ARM: tegra: fix compile-testing PCI host driver

Bartosz Golaszewski (2):
      memory: aemif: don't rely on kbuild for driver's name
      memory: aemif: add support for board files

Caesar Wang (3):
      dt-bindings: power: add RK3036 SoCs header for power-domain
      dt-bindings: power: add binding for rk3036 power domains
      soc: rockchip: power-domain: add power domain support for rk3036

Dmitry Osipenko (14):
      dt-bindings: memory: tegra: Add hot resets definitions
      memory: tegra: Do not handle spurious interrupts
      memory: tegra: Setup interrupts mask before requesting IRQ
      memory: tegra: Apply interrupts mask per SoC
      memory: tegra: Remove unused headers inclusions
      memory: tegra: Squash tegra20-mc into common tegra-mc driver
      memory: tegra: Introduce memory client hot reset
      memory: tegra: Add Tegra20 memory controller hot resets
      memory: tegra: Add Tegra30 memory controller hot resets
      memory: tegra: Add Tegra114 memory controller hot resets
      memory: tegra: Add Tegra124 memory controller hot resets
      memory: tegra: Register SMMU after MC driver became ready
      memory: tegra: Remove Tegra114 SATA and AFI reset definitions
      dt-bindings: memory: tegra: Remove Tegra114 SATA and AFI reset definitions

Elaine Zhang (6):
      dt-bindings: power: add RK3128 SoCs header for power-domain
      dt-bindings: power: add binding for rk3128 power domains
      soc: rockchip: power-domain: add power domain support for rk3128
      dt-bindings: power: add RK3228 SoCs header for power-domain
      dt-bindings: power: add binding for rk3228 power domains
      soc: rockchip: power-domain: add power domain support for rk3228

Finley Xiao (4):
      soc: rockchip: power-domain: Fix wrong value when power up pd with writemask
      dt-bindings: power: add PX30 SoCs header for power-domain
      dt-bindings: power: add binding for px30 power domains
      soc: rockchip: power-domain: add power domain support for px30

Florian Fainelli (1):
      memory: brcmstb: dpfe: Remove need for dpfe_dev

John Garry (3):
      HISI LPC: Stop using MFD APIs
      HISI LPC: Re-Add ACPI child enumeration support
      HISI LPC: Add ACPI UART support

Katsuhiro Suzuki (1):
      reset: uniphier: add LD11/LD20 stream demux system reset control

Kunihiko Hayashi (2):
      reset: uniphier: add PCIe reset control support
      reset: uniphier: add SATA reset control support and change SATA-PHY ID

Lokesh Vutla (1):
      firmware: ti_sci: Switch to SPDX Licensing

Marek Szyprowski (1):
      soc: samsung: pm_domains: Deprecate support for clocks

Matthias Brugger (1):
      Merge commit 'f15cd6d99198e9c15229aefec639a34a6e8174c6' into v.4.17-next/soc-test

Olof Johansson (12):
      Merge tag 'soc_drivers_for_4.18' of git://git.kernel.org/.../ssantosh/linux-keystone into next/drivers
      Merge tag 'gpmc-omap-for-v4.18' of https://github.com/rogerq/linux into next/drivers
      Merge tag 'hisi-drivers-for-4.18' of git://github.com/hisilicon/linux-hisi into next/drivers
      Merge tag 'arm-soc/for-4.18/drivers' of https://github.com/Broadcom/stblinux into next/drivers
      Merge tag 'samsung-drivers-4.18' of https://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'v4.17-next-soc' of https://git.kernel.org/.../matthias.bgg/linux into next/drivers
      Merge tag 'scmi-updates-4.18' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers
      Merge tag 'reset-for-4.18' of git://git.pengutronix.de/pza/linux into next/drivers
      Merge tag 'v4.18-rockchip-drivers-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'tegra-for-4.18-memory-v2' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'imx-drivers-4.18' of git://git.kernel.org/.../shawnguo/linux into next/drivers
      Merge tag 'v4.18-rockchip-drivers-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers

Roger Quadros (1):
      memory: omap-gpmc: Avoid redundant NULL check

Ryder Lee (1):
      soc: mediatek: use of_device_get_match_data()

Sean Wang (5):
      soc: mediatek: reuse read[l,x]_poll_timeout helpers
      soc: mediatek: reuse regmap_read_poll_timeout helpers
      soc: mediatek: introduce a CAPS flag for scp_domain_data
      soc: mediatek: add a fixed wait for SRAM stable
      soc: mediatek: remove unneeded semicolon

Stefan Agner (1):
      bus: arm-cci: remove unnecessary unreachable()

Sudeep Holla (8):
      firmware: arm_scmi: improve code readability using bitfield accessor macros
      firmware: arm_scmi: fix kernel-docs documentation
      firmware: arm_scmi: rename get_transition_latency and add_opps_to_device
      firmware: arm_scmi: rename scmi_xfer_{init,get,put}
      firmware: arm_scmi: drop unused `con_priv` structure member
      firmware: arm_scmi: remove unnecessary bitmap_zero
      firmware: arm_scmi: improve exit paths and code readability
      firmware: arm_scmi: simplify exit path by returning on error

Thierry Reding (1):
      memory: tegra: Add Tegra210 memory controller hot resets

Vasyl Gomonovych (1):
      soc: ti: knav_qmss: Use percpu instead atomic for stats counter


 .../devicetree/bindings/power/pd-samsung.txt    |  20 +-
 .../bindings/soc/rockchip/power_domain.txt      |  12 +
 drivers/bus/Kconfig                             |   1 -
 drivers/bus/arm-cci.c                           |   2 -
 drivers/bus/hisi_lpc.c                          | 159 ++++----
 drivers/cpufreq/scmi-cpufreq.c                  |   4 +-
 drivers/firmware/arm_scmi/base.c                |  43 ++-
 drivers/firmware/arm_scmi/bus.c                 |  22 +-
 drivers/firmware/arm_scmi/clock.c               |  24 +-
 drivers/firmware/arm_scmi/common.h              |  22 +-
 drivers/firmware/arm_scmi/driver.c              | 109 +++---
 drivers/firmware/arm_scmi/perf.c                |  38 +-
 drivers/firmware/arm_scmi/power.c               |  16 +-
 drivers/firmware/arm_scmi/sensors.c             |  20 +-
 drivers/firmware/ti_sci.c                       |  10 +-
 drivers/firmware/ti_sci.h                       |  30 +-
 drivers/memory/Kconfig                          |  10 -
 drivers/memory/Makefile                         |   1 -
 drivers/memory/brcmstb_dpfe.c                   |  42 +--
 drivers/memory/omap-gpmc.c                      |   4 +-
 drivers/memory/tegra/Makefile                   |   1 +
 drivers/memory/tegra/mc.c                       | 362 +++++++++++++++++--
 drivers/memory/tegra/mc.h                       |  22 ++
 drivers/memory/tegra/tegra114.c                 |  33 ++
 drivers/memory/tegra/tegra124.c                 |  48 +++
 drivers/memory/tegra/tegra20.c                  | 296 +++++++++++++++
 drivers/memory/tegra/tegra210.c                 |  53 ++-
 drivers/memory/tegra/tegra30.c                  |  35 ++
 drivers/memory/tegra20-mc.c                     | 254 -------------
 drivers/memory/ti-aemif.c                       |  60 +--
 drivers/reset/reset-uniphier.c                  |  13 +-
 drivers/soc/imx/gpc.c                           |  18 +-
 drivers/soc/imx/gpcv2.c                         |  22 +-
 drivers/soc/mediatek/mtk-infracfg.c             |  46 +--
 drivers/soc/mediatek/mtk-pmic-wrap.c            |  13 +-
 drivers/soc/mediatek/mtk-scpsys.c               | 167 ++++-----
 drivers/soc/rockchip/pm_domains.c               | 117 +++++-
 drivers/soc/samsung/pm_domains.c                |  90 +----
 drivers/soc/ti/knav_qmss.h                      |  14 +-
 drivers/soc/ti/knav_qmss_queue.c                |  60 ++-
 include/dt-bindings/memory/tegra114-mc.h        |  17 +
 include/dt-bindings/memory/tegra124-mc.h        |  25 ++
 include/dt-bindings/memory/tegra20-mc.h         |  21 ++
 include/dt-bindings/memory/tegra210-mc.h        |  31 ++
 include/dt-bindings/memory/tegra30-mc.h         |  19 +
 include/dt-bindings/power/px30-power.h          |  27 ++
 include/dt-bindings/power/rk3036-power.h        |  13 +
 include/dt-bindings/power/rk3128-power.h        |  14 +
 include/dt-bindings/power/rk3228-power.h        |  21 ++
 include/linux/platform_data/ti-aemif.h          |  25 ++
 include/linux/scmi_protocol.h                   |  18 +-
 include/linux/soc/ti/ti_sci_protocol.h          |  10 +-
 include/soc/tegra/cpuidle.h                     |   2 +-
 include/soc/tegra/mc.h                          |  37 +-
 54 files changed, 1677 insertions(+), 916 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra20.c
 delete mode 100644 drivers/memory/tegra20-mc.c
 create mode 100644 include/dt-bindings/memory/tegra20-mc.h
 create mode 100644 include/dt-bindings/power/px30-power.h
 create mode 100644 include/dt-bindings/power/rk3036-power.h
 create mode 100644 include/dt-bindings/power/rk3128-power.h
 create mode 100644 include/dt-bindings/power/rk3228-power.h
