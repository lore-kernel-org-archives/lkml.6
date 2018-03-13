Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeCMNvn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:51:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:62943 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753064AbeCMNvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:51:39 -0400
From: yannick fertre <yannick.fertre@st.com>
To: Vikas Manocha <vikas.manocha@st.com>, Tom Rini <trini@konsulko.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Patrice Chotard" <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        "Simon Glass" <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <u-boot@lists.denx.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/10] splash screen on the stm32f769 disco board
Date: Tue, 13 Mar 2018 14:49:59 +0100
Message-ID: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 3:
- Replace some pr_error, pr_warn or pr_info by dev_error, dev_warn & dev_info.
- Refresh stm32f769-disco_defconfig with last modification done on v2018.3-rc4.
- rework include files ordering.

Version 2:
- Replace debug log by pr_error, pr_warn or pr_info.
- Rework bridge between ltdc & dsi panel
- Rework backligh management (with or witout gpio)
- Rework panel otm8009a
- Add new panel raydium rm68200

Version 1:
- Initial commit

This serie contains all patchsets needed for displaying a splash screen 
on the stm32f769 disco board.
A new config has been created configs/stm32f769-disco_defconfig.
This is necessary due to the difference of panels between stm32f769-disco &
stm32f746-disco boards.
This serie depends on:
  http://patchwork.ozlabs.org/patch/870938/
  http://patchwork.ozlabs.org/cover/880576/
yannick fertre (10):
  video: stm32: stm32_ltdc: add bridge to display controller
  video: stm32: stm32_ltdc: update debug log
  video: add support of MIPI DSI interface
  video: add support of panel OTM8009A
  video: add MIPI DSI host controller bridge
  video: add support of STM32 MIPI DSI controller driver
  video: add support of panel rm68200
  arm: dts: stm32: add dsi for STM32F746
  arm: dts: stm32: add display for STM32F769 disco board
  board: Add STM32F769 SoC, discovery board support

 arch/arm/dts/stm32f746.dtsi        |  12 +
 arch/arm/dts/stm32f769-disco.dts   |  71 ++++
 configs/stm32f769-disco_defconfig  |  65 +++
 drivers/video/Kconfig              |  32 ++
 drivers/video/Makefile             |   4 +
 drivers/video/dw_mipi_dsi.c        | 822 +++++++++++++++++++++++++++++++++++++
 drivers/video/mipi_display.c       | 807 ++++++++++++++++++++++++++++++++++++
 drivers/video/orisetech_otm8009a.c | 327 +++++++++++++++
 drivers/video/raydium-rm68200.c    | 326 +++++++++++++++
 drivers/video/stm32/Kconfig        |  10 +
 drivers/video/stm32/Makefile       |   1 +
 drivers/video/stm32/stm32_dsi.c    | 426 +++++++++++++++++++
 drivers/video/stm32/stm32_ltdc.c   | 144 ++++---
 include/dw_mipi_dsi.h              |  34 ++
 include/mipi_display.h             | 257 +++++++++++-
 15 files changed, 3279 insertions(+), 59 deletions(-)
 create mode 100644 configs/stm32f769-disco_defconfig
 create mode 100644 drivers/video/dw_mipi_dsi.c
 create mode 100644 drivers/video/mipi_display.c
 create mode 100644 drivers/video/orisetech_otm8009a.c
 create mode 100644 drivers/video/raydium-rm68200.c
 create mode 100644 drivers/video/stm32/stm32_dsi.c
 create mode 100644 include/dw_mipi_dsi.h

-- 
1.9.1
