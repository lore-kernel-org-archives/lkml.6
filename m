Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025ACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAC521850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeLSHXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:23:16 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56986 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725298AbeLSHW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:22:59 -0500
X-UUID: 0fb3a570a99641718333fc68b8a2d477-20181219
X-UUID: 0fb3a570a99641718333fc68b8a2d477-20181219
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 64279765; Wed, 19 Dec 2018 15:22:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Dec 2018 15:22:51 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Dec 2018 15:22:44 +0800
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
Subject: [v3, PATCH 0/2] add ethernet binding and modify ethernet driver for mt2712
Date:   Wed, 19 Dec 2018 15:22:39 +0800
Message-ID: <1545204161-15742-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v3:
resend this series base on the latest net-next tree.

changes in v2 as comments from Sean:
1. fix typo.
2. use capital letters for RMII/MII/RGMII in driver and bindings.

v1:
This new series is the result of discussion in:
http://lkml.org/lkml/2018/12/13/1007
http://lkml.org/lkml/2018/12/14/53

1. ethernet binding file move to this series.
2. remove fine tune property in device tree
3. remove fine tune flow in ethernet driver
4. set rgmii timing according to the value in device tree,
and don't care whether phy insert internal delay  or not.

Biao Huang (2):
  net-next: dt-binding: dwmac-mediatek: remove fine-tune property
  net-next: stmmac: dwmac-mediatek: remove fine-tune property

 .../devicetree/bindings/net/mediatek-dwmac.txt     |   31 +++------
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |   71 +++++++-------------
 2 files changed, 35 insertions(+), 67 deletions(-)

-- 
1.7.9.5

