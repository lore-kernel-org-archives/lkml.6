Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1369ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A6F205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A6F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbeGXJWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:22:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49507 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388383AbeGXJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:22:46 -0400
X-UUID: 9413908b84cb4d63bd5aa8bf664c03d5-20180724
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 143181075; Tue, 24 Jul 2018 16:17:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 24 Jul 2018 16:17:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 24 Jul 2018 16:17:19 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v1 00/15] Add RDMA memory mode support for mediatek SOC MT2712
Date:   Tue, 24 Jul 2018 16:17:00 +0800
Message-ID: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
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
  drm/mediatek: add drm_device in RDMA for mamory mode to reaquest
    buffer
  drm/mediatek: add dummy buffer for RDMA memory mode
  drm/mediatek: add layer number condition for RDMA to control plane
  drm/mediatek: Update some variable name from ovl to comp
  drm/mediatek: fixed the error value for add DSI1 in mutex
  drm/mediatek: fixed connection from RDMA2 to DSI1

 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 122 +++++++++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  59 +++++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |   4 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |  20 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   2 +
 5 files changed, 181 insertions(+), 26 deletions(-)

-- 
2.12.5

