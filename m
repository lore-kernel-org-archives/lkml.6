Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED3EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FD621906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390517AbeLUM7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:59:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:17998 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388300AbeLUM7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:59:08 -0500
X-UUID: 2f6c8cbe66c544658895d7790e39d41b-20181221
X-UUID: 2f6c8cbe66c544658895d7790e39d41b-20181221
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 289836634; Fri, 21 Dec 2018 20:59:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Dec 2018 20:59:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 20:59:00 +0800
From:   qii wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <ryder.lee@mediatek.com>
Subject: [PATCH v2 0/6] add i2c support for mt7629 and mt8183
Date:   Fri, 21 Dec 2018 20:58:25 +0800
Message-ID: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DF36B84E0977480FA1322E4329AF15C8299D57D43890E15D9ED0E3E788AB5D402000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on 4.20-rc1 and provide five patches to support
mt7629 and mt8183 IC.

Main changes compared to v1:
--remove useless dt-binding for mt7629
--split a patch into two(2/6 3/6)
--muti-user feature was dropped

qii wang (6):
  dt-bindings: i2c: Add Mediatek MT7629 i2c binding
  i2c: mediatek: speeds is replaced by macros definitions
  i2c: mediatek: remove completion_done()
  i2c: mediatek: Add offsets array for new i2c registers
  dt-bindings: i2c: Add Mediatek MT8183 i2c binding
  i2c: mediatek: Add i2c support for MediaTek MT8183

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    7 +-
 drivers/i2c/busses/i2c-mt65xx.c                   |  288 ++++++++++++++++-----
 2 files changed, 227 insertions(+), 68 deletions(-)

-- 
1.7.9.5

