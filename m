Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A91C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A08320651
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBZNLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:11:37 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:42904 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725954AbfBZNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:11:36 -0500
X-UUID: 66d6fc32e4a74797b90edd9f41c12c86-20190226
X-UUID: 66d6fc32e4a74797b90edd9f41c12c86-20190226
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 540794434; Tue, 26 Feb 2019 21:11:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Feb 2019 21:11:28 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Feb 2019 21:11:28 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>, <robh@kernel.org>
Subject: [PATCH v5 0/5] add i2c support for mt8183
Date:   Tue, 26 Feb 2019 21:10:55 +0800
Message-ID: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4595AA4059D5953ADD7EA443CC5FE4EC174A697B85D113DB26D7187A30A7C2712000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on 5.0-rc1 and provide five patches to support
mt8183 IC.

Main changes compared to v4:
--modify the commit of arb clock dt-binding
--split a patch(3/3) into three(3/5 4/5 5/5)

Main changes compared to v3:
--remove the patches which have been applied to for-next
--remove i2c fallback for i3c controller 

Main changes compared to v2:
--update commit message
--add Reviewed-by from Rob Herring, Nicolas and Sean

Main changes compared to v1:
--remove useless dt-binding for mt7629
--split a patch into two(2/6 3/6)
--muti-user feature was dropped

Qii Wang (5):
  i2c: mediatek: Add offsets array for new i2c registers
  dt-bindings: i2c: Add Mediatek MT8183 i2c binding
  i2c: mediatek: Add arb clock in i2c driver
  i2c: mediatek: Add i2c and apdma sync in i2c driver
  i2c: mediatek: Add i2c support for MediaTek MT8183

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |   4 +-
 drivers/i2c/busses/i2c-mt65xx.c                   | 246 ++++++++++++++++------
 2 files changed, 188 insertions(+), 62 deletions(-)

-- 
1.9.1
