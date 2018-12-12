Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD1BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E692086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E692086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeLLJgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:36:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3358 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726617AbeLLJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:36:15 -0500
X-UUID: 24007c7db5544aa399e52006acc07eb5-20181212
X-UUID: 24007c7db5544aa399e52006acc07eb5-20181212
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 532604860; Wed, 12 Dec 2018 17:35:57 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 17:35:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Dec 2018 17:35:53 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>
CC:     <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <nelson.chang@mediatek.com>, <matthias.bgg@gmail.com>,
        <biao.huang@mediatek.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>,
        <andrew@lunn.ch>
Subject: [v6, PATCH 0/2] add Ethernet driver support for mt2712
Date:   Wed, 12 Dec 2018 17:35:30 +0800
Message-ID: <1544607332-29921-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6591352EF4A2D8B84B96720AD430D40B02690301532B82060EB1480892F5AD312000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6:
 modifications according to comments from Rob/Andrew/Sean:
 1. use delay_ps instead of delay stage.
 2. add comments in driver to avoid confusion.
 2. rewrite set_delay function.
 3. modify binding document for properties: tx-delay-ps/rx-delay-ps/pericfg etc.

Biao Huang (2):
  net:stmmac: dwmac-mediatek: add support for mt2712
  dt-binding: mediatek-dwmac: add binding document for MediaTek MT2712
    DWMAC

 .../devicetree/bindings/net/mediatek-dwmac.txt     |   87 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |    8 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  408 ++++++++++++++++++++ 
 4 files changed, 504 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c

--
1.7.9.5

