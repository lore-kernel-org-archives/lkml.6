Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3030C00319
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A986220989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfBYCJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:09:26 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:41282 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725991AbfBYCJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:09:25 -0500
X-UUID: 4108df188aa944f08e12e0f96e639957-20190225
X-UUID: 4108df188aa944f08e12e0f96e639957-20190225
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 16261610; Mon, 25 Feb 2019 10:09:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 25 Feb
 2019 10:09:18 +0800
Received: from mszsdaap41.mediatek.inc (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Feb 2019 10:09:17 +0800
From:   wangyan wang <wangyan.wang@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     wangyan wang <wangyan.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH V6 0/8] make mt7623 clock of hdmi stable
Date:   Mon, 25 Feb 2019 10:09:04 +0800
Message-ID: <20190225020912.29120-1-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wangyan Wang <wangyan.wang@mediatek.com>

V6 adopt maintainer's suggestion.
Here is the change list between V5 & V6
1. change "unsigned char mux_flags;" to "u8 mux_flags;" to
match with the struct in " clk: mediatek: add MUX_GATE_FLAGS_2".


chunhui dai (8):
  drm/mediatek: recalculate hdmi phy clock of MT2701 by querying
    hardware
  drm/mediatek: move the setting of fixed divider
  drm/mediatek: using different flags of clk for HDMI phy
  drm/mediatek: fix the rate and divder of hdmi phy for MT2701
  clk: mediatek: add MUX_GATE_FLAGS_2
  clk: mediatek: using CLK_MUX_ROUND_CLOSEST for the clock of dpi1_sel
  drm/mediatek: using new factor for tvdpll in MT2701
  drm/mediatek: fix the rate of parent for hdmi phy in MT2701

 drivers/clk/mediatek/clk-mt2701.c              |  4 +-
 drivers/clk/mediatek/clk-mtk.c                 |  2 +-
 drivers/clk/mediatek/clk-mtk.h                 | 20 ++++++---
 drivers/gpu/drm/mediatek/mtk_dpi.c             |  8 ++--
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 34 ++++------------
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  7 +---
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 56 +++++++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 23 +++++++++++
 8 files changed, 102 insertions(+), 52 deletions(-)

-- 
2.14.1

