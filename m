Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031913AbeCBPoq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:44:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15479 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934173AbeCBPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:44:41 -0500
From: yannick fertre <yannick.fertre@st.com>
To: Vikas Manocha <vikas.manocha@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
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
Subject: [PATCH v2 00/10] splash screen on the stm32f769 disco board
Date: Fri, 2 Mar 2018 16:44:01 +0100
Message-ID: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 configs/stm32f769-disco_defconfig  |  63 +++
 drivers/video/Kconfig              |  32 ++
 drivers/video/Makefile             |   4 +
 drivers/video/dw_mipi_dsi.c        | 822 +++++++++++++++++++++++++++++++++++++
 drivers/video/mipi_display.c       | 807 ++++++++++++++++++++++++++++++++++++
 drivers/video/orisetech_otm8009a.c | 329 +++++++++++++++
 drivers/video/raydium-rm68200.c    | 329 +++++++++++++++
 drivers/video/stm32/Kconfig        |  10 +
 drivers/video/stm32/Makefile       |   1 +
 drivers/video/stm32/stm32_dsi.c    | 427 +++++++++++++++++++
 drivers/video/stm32/stm32_ltdc.c   | 144 ++++---
 include/dw_mipi_dsi.h              |  32 ++
 include/mipi_display.h             | 257 +++++++++++-
 15 files changed, 3285 insertions(+), 55 deletions(-)
 create mode 100644 configs/stm32f769-disco_defconfig
 create mode 100644 drivers/video/dw_mipi_dsi.c
 create mode 100644 drivers/video/mipi_display.c
 create mode 100644 drivers/video/orisetech_otm8009a.c
 create mode 100644 drivers/video/raydium-rm68200.c
 create mode 100644 drivers/video/stm32/stm32_dsi.c
 create mode 100644 include/dw_mipi_dsi.h

-- 
1.9.1
