Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5687C282EB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9E32173C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfAUIAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:00:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:27838 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729230AbfAUIAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:00:48 -0500
X-UUID: 412e15dc94c34cc7b9157f141ffe1d3c-20190121
X-UUID: 412e15dc94c34cc7b9157f141ffe1d3c-20190121
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1242355900; Mon, 21 Jan 2019 16:00:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 16:00:40 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 16:00:40 +0800
From:   qii wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <xinping.qian@mediatek.com>, <liguo.zhang@mediatek.com>
Subject: [PATCH v3 3/6] i2c: mediatek: remove completion_done()
Date:   Mon, 21 Jan 2019 15:59:31 +0800
Message-ID: <1548057574-8061-4-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BD04568AAD2438B9AE4E2F2E4F11C55897C6B3871F67A3D7D6B42F2AB5D0C97A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Completion_done() is useless when we don't use its return value,
so we remove it.

Signed-off-by: qii wang <qii.wang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 7396449..660de1e 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -642,8 +642,6 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		return -ETIMEDOUT;
 	}
 
-	completion_done(&i2c->msg_complete);
-
 	if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
 		dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
 		mtk_i2c_init_hw(i2c);
-- 
1.7.9.5

