Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754890AbeDTM4v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:56:51 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:18378 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeDTM4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:56:49 -0400
From: <jan.tuerk@emtrion.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Fabio Estevam" <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "Jan Tuerk" <jan.tuerk@emtrion.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/6] Add basic support for emtrion emCON-MX6 modules
Date: Fri, 20 Apr 2018 14:50:47 +0200
Message-ID: <20180420125108.14197-1-jan.tuerk@emtrion.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171220134710.64479-2-jan.tuerk@emtrion.com>
References: <20171220134710.64479-2-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-23794.006
X-TM-AS-Result: No--4.728400-8.000000-31
X-TM-AS-MatchedID: 702311-704421-704410-704425-706719-705441-188198-700454-7
        04156-701236-700839-705753-703087-705718-702898-188019-701016-862004-700016
        -703529-847575-148004-148036-42000-42003-55
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

Changes for v3:
  [PATCH v3 1/6] drm/panel: Add support for the EDT ETM0700G0BDH6
    - moved Documentation into seperate commit ([PATCH v3/6])

  [PATCH v3 2/6] drm/panel: Add support for the EDT ETM0700G0EDH6
	- new Patch, adding additionally compatible for the new hardware type

  [PATCH v3 3/6] dt-bindings: display: Document the EDT et* displays in one file.
	- new Patch, as requested by Rob Herring document the EDT Displays in a single file

  [PATCH v3 4/6] ARM: dts: imx: Add an cpu0 label for imx6dl devices.
    - Unchanged
  [PATCH v3 5/6] ARM: dts: Add support for emtrion emCON-MX6 series
	- change License Header to SPDX + dual-license without licence text.
    - coding-style fixes
  [PATCH v3 6/6] ARM: imx_v6_v7_defconfig: Enable DA0963 PMIC support.
	- Rebased and merged

 Documentation/devicetree/bindings/arm/emtrion.txt  |  13 +
 .../bindings/display/panel/edt,et-series.txt       |  39 +
 .../bindings/display/panel/edt,et057090dhu.txt     |   7 -
 .../bindings/display/panel/edt,et070080dh6.txt     |  10 -
 .../bindings/display/panel/edt,etm0700g0dh6.txt    |  10 -
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx6dl-emcon-avari.dts           | 224 ++++++
 arch/arm/boot/dts/imx6dl-emcon.dtsi                |  27 +
 arch/arm/boot/dts/imx6dl.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6q-emcon-avari.dts            | 224 ++++++
 arch/arm/boot/dts/imx6q-emcon.dtsi                 |  27 +
 arch/arm/boot/dts/imx6qdl-emcon.dtsi               | 838 +++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   3 +
 drivers/gpu/drm/panel/panel-simple.c               |  18 +
 14 files changed, 1416 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/edt,et-series.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6q-emcon.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi

-- 
2.11.0
