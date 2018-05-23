Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeEWEhr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:37:47 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:43037 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbeEWEhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:37:43 -0400
X-Google-Smtp-Source: AB8JxZowreHJZTpRU5PBktPfMNRU4X34zQI1y4eD/Y1PzL8QTbBkGvTMcapVaiLxBPf78dfV6htM4g==
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.18
Date: Tue, 22 May 2018 23:37:39 -0500
Message-Id: <1527050261-19887-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.18

for you to fetch changes up to 57fc67ef0d35af11fbb1b928e359b370889994ae:

  arm64: dts: qcom: msm8996: Add ufs related nodes (2018-05-22 23:29:03 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.18

* Add support for SDM845 and associated peripherals
* Fix gic_irq_domain_translation warnings on Qualcomm platforms
* Add binding for GENI SE, Qualcomm bluetooth, and Command DB
* Add support for SDHCI and ramoops on MSM8992
* Fixup qcom,pcie devices to pcie
* Add wlan, bluetooth, and micro SD supplies on db820c
* Add UFS related nodes on MSM8996

----------------------------------------------------------------
Arnd Bergmann (1):
      arm64: dts: qcom: rename qcom,pcie devices to pcie

Bjorn Andersson (1):
      arm64: dts: qcom: msm8996: Add ufs related nodes

Douglas Anderson (4):
      arm64: dts: sdm845: Fix xo_board clock name and speed
      arm64: dts: sdm845: Add command DB node
      arm64: dts: qcom: sdm845: Sort nodes in the reserved mem by address
      arm64: dts: qcom: sdm845: Sort nodes in the soc by address

Jeremy McNicoll (2):
      arm64: dts: Enable onboard SDHCI on msm8992
      arm64: dts: msm8992: add pstore-ramoops support

Karthikeyan Ramasubramanian (1):
      dt-bindings: soc: qcom: Add device tree binding for GENI SE

Mahesh Sivasubramanian (1):
      dt-bindings: introduce Command DB for QCOM SoCs

Rajendra Nayak (1):
      arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP

Sibi S (2):
      arm64: dts: qcom: Add APSS shared mailbox node to SDM845
      arm64: dts: qcom: Add SDM845 SMEM nodes

Srinivas Kandagatla (3):
      arm64: dts: apq8096-db820c: Enable wlan and bt en pins
      arm64: dts: apq8096-db820c: Add micro sd card supplies
      arm64: dts: msm8916: fix gic_irq_domain_translate warnings

Thierry Escande (3):
      arm64: dts: apq8096-db820c: enable bluetooth node
      dt-bindings: net: bluetooth: Add qualcomm-bluetooth
      arm64: dts: msm8996: fix gic_irq_domain_translate warnings

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  30 ++
 .../bindings/reserved-memory/qcom,cmd-db.txt       |  37 +++
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 119 ++++++++
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi  |  26 ++
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  32 ++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  77 ++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  18 +-
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     |  17 ++
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |  60 ++++
 arch/arm64/boot/dts/qcom/msm8992.dtsi              |  87 +++++-
 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi      | 276 +++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 120 +++++++-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |  15 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 327 +++++++++++++++++++++
 15 files changed, 1217 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
