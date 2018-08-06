Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AD1219CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AD1219CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeHFOHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:07:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3495 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729775AbeHFOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:07:16 -0400
X-UUID: 918c4d95d6e44357b7596ff80576bcef-20180806
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 443682576; Mon, 06 Aug 2018 19:58:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 6 Aug 2018 19:58:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 6 Aug 2018 19:58:22 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v3 00/13] Add RDMA memory mode support for mediatek SOC MT2712
Date:   Mon, 6 Aug 2018 19:58:07 +0800
Message-ID: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
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

Change in v3:
- Merge patch
  "drm/mediatek: add memory mode for RDMA" and
  "drm/mediatek: add layer config to set RDMA for plane setting"
  to "drm/mediatek: add memory mode and layer_config for RDMA"
- Move the "RDMA memory mode setting" from rdma_config to
  rdma_layer_config in patch
  "drm/mediatek: add memory mode and layer_config for RDMA"
- Remove the pathch
  "drm/mediatek: add RDMA memory mode for crtc created"
- add the return statement in patch
  "drm/mediatek: add function to get layer number for component"
  to abvoid warning message in build time
- Return layer_nr is 4 in patch
  "drm/mediatek: add callback function to return OVL layer number"
- Return layer_nr is 1 in patch
  "drm/mediatek: add callback function to return RDMA layer number"
- Dynamaic define the size of planes by layer_nr in patch
  "drm/mediatek: use layer_nr function to get layer number to init plane"
- Use ?: to init crtc for OVL or RDMA in patch
  "drm/mediatek: use layer_nr function to get layer number to init plane"

Stu Hsieh (13):
  drm/mediatek: add connection from RDMA0 to DPI1
  drm/mediatek: add connection from RDMA0 to DSI1
  drm/mediatek: add connection from RDMA1 to DSI0
  drm/mediatek: add connection from RDMA2 to DSI0
  drm/mediatek: add memory mode and layer_config for RDMA
  drm/mediatek: add RGB color format support for RDMA
  drm/mediatek: add YUYV/UYVY color format support for RDMA
  drm/mediatek: add function to get layer number for component
  drm/mediatek: add callback function to return OVL layer number
  drm/mediatek: add callback function to return RDMA layer number
  drm/mediatek: use layer_nr function to get layer number to init plane
  drm/mediatek: update some variable name from ovl to comp
  drm/mediatek: fix connection from RDMA2 to DSI1

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  6 +++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 83 +++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 63 +++++++++++++---------
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |  3 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 18 ++++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  9 ++++
 6 files changed, 153 insertions(+), 29 deletions(-)

-- 
2.12.5.2.gbdf23ab

