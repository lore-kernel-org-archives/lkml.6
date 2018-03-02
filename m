Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423471AbeCBPdD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:33:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32790 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1423074AbeCBPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:32:59 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v2 0/2] drm/panel: Add support for Raydium RM68200 panel
Date: Fri, 2 Mar 2018 16:32:20 +0100
Message-ID: <20180302153222.4377-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280
TFT LCD panel connected using a MIPI-DSI video interface.

Version 2:
- Add Rob Herring Reviewed-by on dt-bindings.
- Update Kconfig & driver thanks to Thierry Reding comments: no more
  DRV_NAME, DRM_WARN_ONCE instead of DRV_NAME where applicable, use
  backlight_enable/disable() & devm_of_find_backlight(), no extra
  gpio reset to 0, no more msg if successful, use RM68200 instead of
  rm68200 where necessary.

Version 1:
- Initial commit

Philippe Cornu (2):
  dt-bindings/display/panel: Add support for Raydium rm68200 dsi panel
  drm/panel: Add support for Raydium RM68200 panel driver

 .../bindings/display/panel/raydium,rm68200.txt     |  25 ++
 drivers/gpu/drm/panel/Kconfig                      |   8 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      | 437 +++++++++++++++++++++
 4 files changed, 471 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
 create mode 100755 drivers/gpu/drm/panel/panel-raydium-rm68200.c

-- 
2.15.1
