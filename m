Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA0EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98EF2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfA2Hce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:32:34 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:5051 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726994AbfA2Hc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:32:28 -0500
X-UUID: d0f32703f2c94b9fafbfc01cec1fb371-20190129
X-UUID: d0f32703f2c94b9fafbfc01cec1fb371-20190129
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 246413804; Tue, 29 Jan 2019 15:32:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 15:32:10 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 15:32:10 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: [PATCH 00/10] support gce on mt8183 platform
Date:   Tue, 29 Jan 2019 15:31:57 +0800
Message-ID: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MTK will support gce function on mt8183 platform.
	soc: mediatek: add mt8183 compatible name
	dt-binding: gce: add gce header file for mt8183

Besides above patches, we refine gce driver on those patches.
	soc: mediatek: move the CMDQ_IRQ_MASK into cmdq driver data
	soc: mediatek: clear the event in cmdq initial flow

In ordet to enhance the convenience of gce usage, we add new helper
functions and refine the method of instruction combining. 
	soc: mediatek: add subsys-base address transform function
	soc: mediatek: add register device function
	soc: mediatek: add cmdq_dev_get_event function
	soc: mediatek: add packet encoder function
	soc: mediatek: change the argument of write and write_mask API
	soc: mediatek: add polling function

Bibby Hsieh (10):
  soc: mediatek: add mt8183 compatible name
  dt-binding: gce: add gce header file for mt8183
  soc: mediatek: move the CMDQ_IRQ_MASK into cmdq driver data
  soc: mediatek: clear the event in cmdq initial flow
  soc: mediatek: add subsys-base address transform function
  soc: mediatek: add register device function
  soc: mediatek: add cmdq_dev_get_event function
  soc: mediatek: add packet encoder function
  soc: mediatek: change the argument of write and write_mask API
  soc: mediatek: add polling function

 .../devicetree/bindings/mailbox/mtk-gce.txt        |   6 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  18 +-
 drivers/soc/mediatek/mtk-cmdq-helper.c             | 212 +++++++++++++++++----
 include/dt-bindings/gce/mt8183-gce.h               | 177 +++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |   5 +
 include/linux/soc/mediatek/mtk-cmdq.h              |  52 +++--
 6 files changed, 412 insertions(+), 58 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8183-gce.h

-- 
1.9.1

