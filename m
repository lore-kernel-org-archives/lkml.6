Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758335AbeD0NY4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:24:56 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:54625 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758128AbeD0NYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:24:54 -0400
From: <jan.tuerk@emtrion.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "GitAuthor: Jan Tuerk" <jan.tuerk@emtrion.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/7] Add basic support for emtrion emCON-MX6 modules
Date: Fri, 27 Apr 2018 15:24:35 +0200
Message-ID: <20180427132445.3458-1-jan.tuerk@emtrion.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420125108.14197-1-jan.tuerk@emtrion.com>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-23808.007
X-TM-AS-Result: No--6.623000-8.000000-31
X-TM-AS-MatchedID: 704410-704425-705441-188198-701236-702311-704421-704156-7
        08855-701604-702898-188019-701016-862004-700016-703529-847575-148004-148036
        -42000-42003
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

Changes for v4:
  - re-arrange the Patch-series to match the DT-submitting-patches
  - Additional patch for the Documentation of the new DT-bindings

[PATCH v4 1/7] dt-bindings: display: Document the EDT et* displays in one file.
  - no change (re-arranged 3/6 => 1/7)

[PATCH v4 2/7] drm/panel: Add support for the EDT ETM0700G0BDH6
  - no change (re-arranged 1/6 => 2/7)

[PATCH v4 3/7] drm/panel: Add support for the EDT ETM0700G0EDH6
  - no change (re-arranged 2/6 => 3/7)

[PATCH v4 4/7] ARM: dts: imx: Add an cpu0 label for imx6dl devices.
  - no change

[PATCH v4 5/7] dt-bindings: arm: Document emtrion emCON-MX6 bindings
  - separate patch for the emtrion emCON-MX6 DT-bindings

[PATCH v4 6/7] ARM: dts: Add support for emtrion emCON-MX6 series
  - alphabetically sort the DT
  - moved duplicated Avari baseboard code into separate file.

[PATCH v4 7/7] ARM: imx_v6_v7_defconfig: Enable DA0963 PMIC support.
  - unchaged

 Documentation/devicetree/bindings/arm/emtrion.txt  |  13 +
 .../bindings/display/panel/edt,et-series.txt       |  39 +
 .../bindings/display/panel/edt,et057090dhu.txt     |   7 -
 .../bindings/display/panel/edt,et070080dh6.txt     |  10 -
 .../bindings/display/panel/edt,etm0700g0dh6.txt    |  10 -
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx6dl-emcon-avari.dts           |  17 +
 arch/arm/boot/dts/imx6dl-emcon.dtsi                |  28 +
 arch/arm/boot/dts/imx6dl.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6q-emcon-avari.dts            |  17 +
 arch/arm/boot/dts/imx6q-emcon.dtsi                 |  28 +
 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi         | 208 ++++++
 arch/arm/boot/dts/imx6qdl-emcon.dtsi               | 826 +++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   3 +
 drivers/gpu/drm/panel/panel-simple.c               |  18 +
 15 files changed, 1200 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/edt,et-series.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6q-emcon.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi

-- 
2.11.0
