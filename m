Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA313C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F1B22DFB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="QMQSGcdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F1B22DFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeF0Oik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:38:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36444 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeF0Oij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:38:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id o26-v6so1840294ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Bu2gvn5oyuwNT9pu+fFNn7LgJkox3neyzpzNYi5WvGw=;
        b=QMQSGcdUi36xHmZ2+1+dUa5/OiJcZ/C7bLqTfjsldOEQKAhiKhoCfCLzoID2MQQZxh
         qCwyhaUxpjhRb0tB9ijIMencIcvvCiMgP8dx5AycFwM/hnMEeASbQmkU+B8pijXgYRtr
         ijwnoDoBJ8F7AyScKsHGzSJkyPc7FYrVMhLhK655L6prHRggZJMUhGrdsXRwLrEy28LM
         6bvuw8HRjxrGX7vEwQPR0FUgnyPoXF9bvuOv3xNxK4DXEXPBKMUf1wWmO7aLS7PbWEgL
         L02++CnrmI+h4R7pFl4hQEf8xgUGPO38X4+PejFaXSbLvuXIOHrxDxGEOX3F5DDzCRBW
         gpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Bu2gvn5oyuwNT9pu+fFNn7LgJkox3neyzpzNYi5WvGw=;
        b=lQNVAXGfboUJKl1ra7untLJAObtFBe5/T3kRT2MY/IIwlhGj4rQRePZ/fQd+aFcqV4
         Cj7KukD+DW21ZjsAJmwTsHKqwrgDvbO+ZhdMHMUc+Fbu57yDZ1um6syp/upnQjVAx+OS
         V4G9DlNb7luyuGCXeNdFc6U3pmhcn7GtcuxPPqHOe71cnnthJOdFv0MyrDIbmLtk5F6J
         AFmm9X8ZrtJhgMrb+moJnXc0P4pl7DDR/UFBvGffQaZeh/H9k9FKLf1WS9CpWcQfbzwp
         x7Vdv+hz1iR8mDjg728WDIef5yIjE018YFqpYg1Q7wPKOambEc0K6/LEBkmP4f2GckyU
         PEeQ==
X-Gm-Message-State: APt69E04YU9/7/SQoVtennhv7B4rkB1Hwg9iY+ai4YsfLaEpMN5BjYZ7
        xYm4jb28Whtp7azbjYbzueExIv2C
X-Google-Smtp-Source: ADUXVKLLiJ2jk/kvE+AOP2PCOzzasTEE3phFXH7WuQ5CrwM8RKBeoQHsM5OKv0sC1RykL1Ar70zE3g==
X-Received: by 2002:a2e:5d5d:: with SMTP id r90-v6mr4278179ljb.125.1530110317236;
        Wed, 27 Jun 2018 07:38:37 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id s5-v6sm731821ljh.9.2018.06.27.07.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 07:38:35 -0700 (PDT)
Date:   Wed, 27 Jun 2018 07:38:14 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180627143814.fg7v6sjupytb3eyb@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 86676c4685f774d818f7a6c401c925bbf2a92903:

  arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boards (2018-06-27 07:14:47 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.18-rc

A handful of fixes, nothing really concerning and most touching devicetree
files for various platforms.

I also regenerated the shared multiplatform defconfigs; they have drifted
quite a bit due to Kconfig changes and reordering, and several platform
maintainers tried doing the same which resulted in a lot of conflict pain
-- this way we get everybody onto the same base for next merge window.

----------------------------------------------------------------
Andy Gross (1):
      Merge tag 'qcom-fixes-for-4.18-rc1' into linus

Anson Huang (1):
      soc: imx: gpcv2: correct PGC offset

Arnd Bergmann (1):
      qcom: cmd-db: enforce CONFIG_OF_RESERVED_MEM dependency

Dinh Nguyen (1):
      ARM: dts: socfpga: Fix NAND controller node compatible for Arria10

Florian Fainelli (6):
      MAINAINTERS: Corrected Broadcom Northstar2 entry
      MAINTAINERS: Update Broadcom iProc entry with Stingray
      ARM: dts: NSP: Fix i2c controller interrupt type
      ARM: dts: NSP: Fix PCIe controllers interrupt types
      ARM: dts: HR2: Fix interrupt types for i2c and PCIe
      ARM: dts: BCM5301x: Fix i2c controller interrupt type

Geert Uytterhoeven (2):
      soc: renesas: rcar-sysc: Make PM domain initialization more robust
      ARM: Always build secure_cntvoff.S on ARM V7 to fix shmobile !SMP build

Katsuhiro Suzuki (1):
      arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boards

Marek Vasut (2):
      ARM: dts: socfpga: Fix NAND controller clock supply
      ARM: dts: socfpga: Fix NAND controller node compatible

Miquel Raynal (1):
      arm64: dts: marvell: fix CP110 ICU node size

Oleksij Rempel (1):
      ARM: dts: imx6sx: fix irq for pcie bridge

Olof Johansson (11):
      Merge tag 'mvebu-fixes-4.17-2' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'renesas-fixes-for-v4.18' of https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'imx-fixes-4.18' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'arm-soc/for-4.18/devicetree-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'arm-soc/for-4.18/devicetree-arm64-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'arm-soc/for-4.18/maintainers-arm64-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'qcom-fixes-for-4.18-rc1' of git://git.kernel.org/.../agross/linux into fixes
      arm64: defconfig: renormalize based on recent additions
      ARM: multi_v7_defconfig: renormalize based on recent additions
      Merge tag 'socfpga_nand_fix_v4.17' of git://git.kernel.org/.../dinguyen/linux into fixes
      Merge tag 'qcom-fixes-for-4.18-rc2' of git://git.kernel.org/.../agross/linux into fixes

Ray Jui (5):
      ARM: dts: Cygnus: Fix I2C controller interrupt type
      ARM: dts: Cygnus: Fix PCIe controller interrupt type
      arm64: dts: ns2: Fix I2C controller interrupt type
      arm64: dts: ns2: Fix PCIe controller interrupt type
      arm64: dts: Stingray: Fix I2C controller interrupt type

Rob Herring (1):
      arm64: dts: msm8916: fix Coresight ETF graph connections

Scott Branden (2):
      arm64: dts: specify 1.8V EMMC capabilities for bcm958742k
      arm64: dts: specify 1.8V EMMC capabilities for bcm958742t

Sean Nyekjaer (1):
      ARM: dts: imx6q: Use correct SDMA script for SPI5 core

Srinivas Kandagatla (1):
      arm64: dts: apq8096-db820c: disable uart0 by default

Thor Thayer (2):
      arm64: dts: stratix10: Fix SPI nodes for Stratix10
      ARM: dts: Fix SPI node for Arria10

Viresh Kumar (1):
      arm: dts: armada: Fix "#cooling-cells" property's name

 MAINTAINERS                                        |   6 +-
 arch/arm/boot/dts/armada-385-synology-ds116.dts    |   2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  24 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                     |  24 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  32 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |   2 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   2 +-
 arch/arm/boot/dts/socfpga.dtsi                     |   4 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   5 +-
 arch/arm/common/Makefile                           |   2 +-
 arch/arm/configs/multi_v7_defconfig                | 378 +++++++++------------
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   6 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |   8 +-
 .../boot/dts/broadcom/stingray/bcm958742k.dts      |   4 +
 .../boot/dts/broadcom/stingray/bcm958742t.dts      |   4 +
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   4 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |   2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   4 +-
 .../boot/dts/socionext/uniphier-ld11-global.dts    |   2 +-
 .../boot/dts/socionext/uniphier-ld20-global.dts    |   2 +-
 arch/arm64/configs/defconfig                       | 102 +++---
 drivers/soc/imx/gpcv2.c                            |  13 +-
 drivers/soc/qcom/Kconfig                           |   3 +-
 drivers/soc/renesas/rcar-sysc.c                    |  35 +-
 26 files changed, 310 insertions(+), 364 deletions(-)
