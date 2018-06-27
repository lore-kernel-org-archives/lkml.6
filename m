Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D410C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5116C25E23
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5116C25E23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933185AbeF0LQd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:16:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51544 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932242AbeF0LQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:16:31 -0400
X-UUID: abca11c0455a462fa32d018016246a25-20180627
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1813034705; Wed, 27 Jun 2018 19:16:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 27 Jun 2018 19:16:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 19:16:24 +0800
From:   Houlong Wei <houlong.wei@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK HU <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, <ginny.chen@mediatek.com>,
        <enzhu.wang@mediatek.com>
Subject: [PATCH v22 0/4] MediaTek MT8173 CMDQ support
Date:   Wed, 27 Jun 2018 19:16:08 +0800
Message-ID: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
to help write registers with critical time limitation, such as
updating display configuration during the vblank. It controls Global
Command Engine (GCE) hardware to achieve this requirement.

Changes since v21:
 -rebase on v4.18-rc1
 -remove subsys code and event id definition from mtk-cmdq-helper.c
 -add mt8173-gce.h to define the subsys code and envent id
Changes since v20:
 -rebase on v4.15-rc1
 -move dma_map_single outside of spinlock
Changes since v19:
- rebase to v4.10-rc2

Houlong Wei (4):
  dt-bindings: soc: Add documentation for the MediaTek GCE unit
  mailbox: mediatek: Add Mediatek CMDQ driver
  arm64: dts: mt8173: Add GCE node
  soc: mediatek: Add Mediatek CMDQ helper

 .../devicetree/bindings/mailbox/mtk-gce.txt        |   65 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   11 +
 drivers/mailbox/Kconfig                            |   10 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  633 ++++++++++++++++++++
 drivers/soc/mediatek/Kconfig                       |   12 +
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c             |  258 ++++++++
 include/dt-bindings/gce/mt8173-gce.h               |   48 ++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |   70 +++
 include/linux/soc/mediatek/mtk-cmdq.h              |  132 ++++
 11 files changed, 1242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
 create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/dt-bindings/gce/mt8173-gce.h
 create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

-- 
1.7.9.5 

