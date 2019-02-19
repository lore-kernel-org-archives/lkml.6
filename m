Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08653C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FEC21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfBSJOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:14:17 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:20639 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbfBSJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:14:16 -0500
X-UUID: 0efd1e5546de456fabaaeb24b13259ad-20190219
X-UUID: 0efd1e5546de456fabaaeb24b13259ad-20190219
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1507291545; Tue, 19 Feb 2019 17:14:10 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 17:14:08 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 19 Feb 2019 17:14:07 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>
Subject: [PATCH v1 0/2] drm/mediatek: add mipi_tx driver for mt8183
Date:   Tue, 19 Feb 2019 17:14:02 +0800
Message-ID: <20190219091404.89370-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183 has different setting to MT8173(exist chip). We add mt8183 mipi_tx driver.
1) Separate mipi_tx to common part and chip relate part.
2) Add mt8183 mipi_tx driver

Changes since v0:
- Separate two independent patches.

Jitao Shi (2):
  drm/mediatek: separate mipi_tx to different file
  drm/mediatek: add mipi_tx driver for mt8183

 drivers/gpu/drm/mediatek/Makefile             |   1 +
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 352 ++----------------
 drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  52 +++
 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c | 290 +++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 168 +++++++++
 5 files changed, 548 insertions(+), 315 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mipi_tx.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c

-- 
2.20.1

