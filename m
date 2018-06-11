Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XxsHK/TrHVuyIQAAmS7hNA
	; Mon, 11 Jun 2018 03:26:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9E78E60792; Mon, 11 Jun 2018 03:26:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0F18A6070A;
	Mon, 11 Jun 2018 03:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F18A6070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeFKD0m (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:26:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24350 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753785AbeFKD0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:26:40 -0400
X-UUID: 1227ac61af5e43bfa3467b85a758d1d2-20180611
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 407655709; Mon, 11 Jun 2018 11:26:38 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 11 Jun 2018 11:26:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 11 Jun 2018 11:26:35 +0800
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v5 00/28] Add support for mediatek SOC MT2712
Date: Mon, 11 Jun 2018 11:25:52 +0800
Message-ID: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for the Mediatek MT2712 DISP subsystem.
MT2712 is base on MT8173, there are some difference as following:
MT2712 support three disp output(two ovl and one rdma)

Change in v5:
- Keep the value of MAX_CONNECTOR, because it is useless
- Add the new patch for component DPI1
- Add the new patch for component DSI2
- Add the new patch for component DSI3
- Add some connection from RDMA0/RDMA1/RDMA2 to 
  DPI0/DPI1/DSI1/DSI2/DSI3
- Add the new patch about DPI1/DSI2/DSI3 support for mutex
- Add the new patch about DPI1/DSI1/DSI2/DSI3 in comp_init
- Change ddp path DSI2 to DSI3 in third path

Stu Hsieh (28):
  drm/mediatek: update dt-bindings for mt2712
  drm/mediatek: support maximum 64 mutex mod
  drm/mediatek: add ddp component AAL1
  drm/mediatek: add ddp component OD1
  drm/mediatek: add ddp component PWM1
  drm/mediatek: add ddp component PWM2
  drm/mediatek: add component DPI1
  drm/mediatek: add component DSI2
  drm/mediatek: add component DSI3
  drm/mediatek: add connection from OD1 to RDMA1
  drm/mediatek: add connection from RDMA0 to DPI0
  drm/mediatek: add connection from RDMA0 to DSI2
  drm/mediatek: add connection from RDMA0 to DSI3
  drm/mediatek: add connection from RDMA1 to DPI1
  drm/mediatek: add connection from RDMA1 to DSI1
  drm/mediatek: add connection from RDMA1 to DSI2
  drm/mediatek: add connection from RDMA1 to DSI3
  drm/mediatek: add connection from RDMA2 to DPI0
  drm/mediatek: add connection from RDMA2 to DPI1
  drm/mediatek: add connection from RDMA2 to DSI1
  drm/mediatek: add connection from RDMA2 to DSI2
  drm/mediatek: add connection from RDMA2 to DSI3
  drm/mediatek: add DPI1 support for mutex
  drm/mediatek: add DSI2 support for mutex
  drm/mediatek: add DSI3 support for mutex
  drm/mediatek: add DPI1/DSI1/DSI2/DSI3 in comp_init
  drm/mediatek: add third ddp path
  drm/mediatek: Add support for mediatek SOC MT2712

 .../bindings/display/mediatek/mediatek,disp.txt    |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 227 ++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  15 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  10 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  47 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   5 +-
 7 files changed, 270 insertions(+), 39 deletions(-)

-- 
2.12.5
