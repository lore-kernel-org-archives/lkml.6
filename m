Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C93AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D9520874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D9520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965654AbeFSHkp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:40:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29811 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S937314AbeFSHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:34:56 -0400
X-UUID: f530a1cf31dc495e9058a5e9ce3d11da-20180619
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 912512552; Tue, 19 Jun 2018 15:34:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 19 Jun 2018 15:34:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 19 Jun 2018 15:34:46 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v6 00/29] Add support for mediatek SOC MT2712
Date:   Tue, 19 Jun 2018 15:34:01 +0800
Message-ID: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for the Mediatek MT2712 DISP subsystem.
MT2712 is base on MT8173, there are some difference as following:
MT2712 support three disp output(two ovl and one rdma)

Change in v6:
- Update DDP_COMPONENT_DSI2 to DDP_COMPONENT_DSI3 in the patch
  "drm/mediatek: add component DSI3"
- Separate the patch
  "drm/mediatek: add DPI1/DSI1/DSI2/DSI3 in comp_init" in v5
  to following patch:
  drm/mediatek: add component DPI1
  drm/mediatek: add component DSI2
  drm/mediatek: add component DSI3
  drm/mediatek: add the DSI1 for component init condition
- Update the RDMA definition term from "MOUT" to "SOUT"
- Add new patch
  "drm/mediatek: Update the definition of connection from RDMA1 to DPI0"

Stu Hsieh (29):
  drm/mediatek: update dt-bindings for mt2712
  drm/mediatek: support maximum 64 mutex mod
  drm/mediatek: add ddp component AAL1
  drm/mediatek: add ddp component OD1
  drm/mediatek: add ddp component PWM1
  drm/mediatek: add ddp component PWM2
  drm/mediatek: add component DPI1
  drm/mediatek: add component DSI2
  drm/mediatek: add component DSI3
  drm/mediatek: add the DSI1 for component init condition
  drm/mediatek: add connection from OD1 to RDMA1
  drm/mediatek: Update the definition of connection from RDMA1 to DPI0
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
  drm/mediatek: add third ddp path
  drm/mediatek: Add support for mediatek SOC MT2712

 .../bindings/display/mediatek/mediatek,disp.txt    |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 235 ++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  15 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  10 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  47 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   5 +-
 7 files changed, 274 insertions(+), 43 deletions(-)

-- 
2.12.5

