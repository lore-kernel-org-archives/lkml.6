Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A032CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A22B217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeLRCmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:42:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36430 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726276AbeLRCmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:42:32 -0500
X-UUID: a1acedb5118c4b418507959ec5ccd0cf-20181218
X-UUID: a1acedb5118c4b418507959ec5ccd0cf-20181218
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 156738609; Tue, 18 Dec 2018 10:42:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Dec 2018 10:42:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 10:42:25 +0800
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
Subject: [PATCH 0/2] add ethernet binding and modify ethernet driver for mt2712
Date:   Tue, 18 Dec 2018 10:42:15 +0800
Message-ID: <1545100937-16093-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new series is the result of discussion in:
http://lkml.org/lkml/2018/12/13/1007
http://lkml.org/lkml/2018/12/14/53

1. ethernet binding file move to this series.
2. remove fine tune property in device tree
3. remove fine tune flow in ethernet driver
4. set rgmii timing according to the value in device tree,
and don't care whether phy insert internal delay  or not.

Biao Huang (2):
  dt-binding: mediatek-dwmac: add binding document for MediaTek MT2712
    DWMAC
  net-next: stmmac: dwmac-mediatek: remove fine-tune property

 .../devicetree/bindings/net/mediatek-dwmac.txt     |   78 ++++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |   71 ++++++------------
 2 files changed, 102 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt

-- 
1.7.9.5

