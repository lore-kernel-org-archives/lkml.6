Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbeE1Gih (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:38:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28463 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753341AbeE1Gie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:38:34 -0400
X-UUID: 1679eed64af842c8b6cedc8dbcf570b1-20180528
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v4 0/9] Add support for mediatek SOC MT2712
Date: Mon, 28 May 2018 14:38:18 +0800
Message-ID: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for the Mediatek MT2712 DISP subsystem.
MT2712 is base on MT8173, there are some difference as following:
MT2712 support three disp output(two ovl and one rdma)

Change in v4:
- Move some modification about AAL1 from patch
  "Add support for mediatek SOC MT2712" to
  "add ddp component AAL1"
- Move some modification about OD1 from patch
  "Add support for mediatek SOC MT2712" to
  "add ddp component OD1"
- Move some modification about PWM2 from patch
  "Add support for mediatek SOC MT2712" to
  "add ddp component PWM2"
- Move some modification about third ddp path from patch
  "Add support for mediatek SOC MT2712" to
  "add third ddp path"
- Move the definition OD1_MOUT_EN_RDMA1 from patch
  "Add support for mediatek SOC MT2712" to
  "add connection from OD1 to RDMA1"
- Rebase the patch "add connection from OD1 to RDMA1" after
  "add ddp component OD1"
- Rebase the patch "add third ddp path" before
  "Add support for mediatek SOC MT2712"
- Modify the 2712 MUTEX MODULE in the order by index
- Added patch for ddp component PWM1
- For patch "add third ddp path"
  Add the condition in mtk_crtc_create() that if there
  is no ddp path, then return 0 to avoid the null crtc

Change in v3:
- Added patch for ddp component AAL1
- Added patch for ddp component OD1
- Added patch for ddp component PWM2
- Added patch to create third ddp path
- Rebase patch "support maximum 64 mutex mod" before
  "Add support for mediatek SOC MT2712"
- Rebase patch "add connection from OD1 to RDMA1" before
  "Add support for mediatek SOC MT2712"
- Remove two definition about RDMA0 and RDMA2
- Change the definition about mutex module from
  bitwise to index

Changes in v2:
- update dt-bindings for mt2712
- Added patch to connection from OD1 to RDMA1
- Added patch to support maximum 64 mutex mod
- rewrite mutex mod condition for reducing one byte
- Change the component name AAL/OD to AAL0/OD0 for naming consistency
- Move the compatible information about dpi to other patch which modify
  the dpi driver for mt2712

Stu Hsieh (9):
  drm/mediatek: update dt-bindings for mt2712
  drm/mediatek: support maximum 64 mutex mod
  drm/mediatek: add ddp component AAL1
  drm/mediatek: add ddp component OD1
  drm/mediatek: add ddp component PWM1
  drm/mediatek: add ddp component PWM2
  drm/mediatek: add connection from OD1 to RDMA1
  drm/mediatek: add third ddp path
  drm/mediatek: Add support for mediatek SOC MT2712

 .../bindings/display/mediatek/mediatek,disp.txt    |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 124 +++++++++++++++------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |   8 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |   7 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  47 +++++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   7 +-
 7 files changed, 158 insertions(+), 40 deletions(-)

-- 
2.12.5
