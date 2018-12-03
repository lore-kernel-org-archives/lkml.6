Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8336C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CAE20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CAE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeLCNel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:34:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50123 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725867AbeLCNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:34:41 -0500
X-UUID: a1efa8c13c7e4004971bf6d866b113d3-20181203
X-UUID: a1efa8c13c7e4004971bf6d866b113d3-20181203
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 530171079; Mon, 03 Dec 2018 21:33:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 21:33:12 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 21:33:12 +0800
From:   <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <ryder.lee@mediatek.com>
Subject: [PATCH 0/5] add i2c support for mt7629 and mt8183
Date:   Mon, 3 Dec 2018 21:32:49 +0800
Message-ID: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8E072DB0354E077C2B99CB5FFAFCEA8DAD95B2F0D8AB772B76E6E2D277AF67DA2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on 4.20-rc1 and provide five patches to support
mt7629 and mt8183 IC.

qii wang (5):
  dt-bindings: i2c: Add Mediatek MT7629 i2c binding
  i2c: mediatek: remove useless code and replace definitions
  i2c: mediatek: Add offsets array for new i2c registers
  dt-bindings: i2c: Add Mediatek MT8183 i2c binding
  i2c: mediatek: Add i2c compatible for MediaTek MT8183

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    8 +-
 drivers/i2c/busses/i2c-mt65xx.c                   |  299 ++++++++++++++++-----
 2 files changed, 239 insertions(+), 68 deletions(-)

-- 
1.7.9.5
