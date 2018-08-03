Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D67C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6615A216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6615A216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeHCFGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:06:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:62146 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727610AbeHCFFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:05:38 -0400
X-UUID: 228cc5b3c54a4a0b807f572be33776c7-20180803
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 932321943; Fri, 03 Aug 2018 11:11:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 3 Aug 2018 11:11:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 3 Aug 2018 11:11:10 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v2 00/15] Add RDMA memory mode support for mediatek SOC MT2712
Date:   Fri, 3 Aug 2018 11:10:53 +0800
Message-ID: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add RDMA memory mode support for mediatek SOC MT2712.
MT2712 has three display data path, including three HW engine,
two OVL and one RDMA.

The RDMA used in third ddp and it need to be set memory mode,
then RDMA could read data from memory and output to panel.

Change in v2:
- Remove some modification about dummy buffer in patch
  "drm/mediatek: add memory mode for RDMA":
  Register setting about reset and MATRIX_INT_MTX_SEL_DEFAULT.
- Remove some patches about dummy buffer as folowing:
  "drm/mediatek: add drm_device in RDMA for mamory mode to reaquest buffer"
  "drm/mediatek: add dummy buffer for RDMA memory mode"
- Rename and modify the v1 patch
  "drm/mediatek: add layer number condition for RDMA to control plane"
  as following patches to get the layer number by module.
  "drm/mediatek: add function to get layer number for component"
  "drm/mediatek: add callback function to return OVL layer number"
  "drm/mediatek: add callback function to return RDMA layer number"
  "drm/mediatek: use layer_nr function to get layer number to init plane"
- Remove v1 patch
  "drm/mediatek: fixed the error value for add DSI1 in mutex"
  This patch would be send in the future.

Stu Hsieh (15):
  drm/mediatek: add connection from RDMA0 to DPI1
  drm/mediatek: add connection from RDMA0 to DSI1
  drm/mediatek: add connection from RDMA1 to DSI0
  drm/mediatek: add connection from RDMA2 to DSI0
  drm/mediatek: add RDMA memory mode for crtc created
  drm/mediatek: add memory mode for RDMA
  drm/mediatek: add layer config to set RDMA for plane setting
  drm/mediatek: add RGB color format support for RDMA
  drm/mediatek: add YUYV/UYVY color format support for RDMA
  drm/mediatek: add function to get layer number for component
  drm/mediatek: add callback function to return OVL layer number
  drm/mediatek: add callback function to return RDMA layer number
  drm/mediatek: use layer_nr function to get layer number to init plane
  drm/mediatek: update some variable name from ovl to comp
  drm/mediatek: fix connection from RDMA2 to DSI1

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 10 +++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 99 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 60 +++++++++++------
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 18 +++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  8 +++
 6 files changed, 174 insertions(+), 25 deletions(-)

-- 
2.12.5.2.gbdf23ab

