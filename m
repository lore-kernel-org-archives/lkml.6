Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0367EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DD4218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfAXKpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:45:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54354 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727126AbfAXKps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:45:48 -0500
X-UUID: 39a4808f1eec4181bfed2e9624fa4bd8-20190124
X-UUID: 39a4808f1eec4181bfed2e9624fa4bd8-20190124
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <shun-chih.yu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1321334590; Thu, 24 Jan 2019 18:45:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 18:45:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Jan 2019 18:45:34 +0800
From:   <shun-chih.yu@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_wsdupstream@mediatek.com>
Subject: [PATCH] remove redundant queue structure for Mediatek Command-Queue DMA controller
Date:   Thu, 24 Jan 2019 18:44:38 +0800
Message-ID: <1548326680-16454-1-git-send-email-shun-chih.yu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 29A1CBC80D30C4C1786840970F8100F513FF59606270EDED170F51BB7A09873C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support for MediaTek Command-Queue DMA controller in dt-bindings, and simplifies the controller by removing redundant structures.

Main changes to the initial version:
- remove redundant queue structure in mtk_cqdma_pchan
- remove redundant completion management
- remove redundant tasklet management
- fix wrong residue assignment in mtk_cqdma_tx_status
- fix typos

The result of dmatest shown below:
dmatest: dma0chan0-copy2: summary 5000 tests, 0 failures 3500 iops 28037 KB/s
dmatest: dma0chan0-copy4: summary 5000 tests, 0 failures 3494 iops 27612 KB/s
dmatest: dma0chan0-copy1: summary 5000 tests, 0 failures 3491 iops 27749 KB/s
dmatest: dma0chan0-copy7: summary 5000 tests, 0 failures 3673 iops 29092 KB/s 
dmatest: dma0chan0-copy6: summary 5000 tests, 0 failures 3763 iops 30237 KB/s 
dmatest: dma0chan0-copy0: summary 5000 tests, 0 failures 3730 iops 30131 KB/s
dmatest: dma0chan0-copy3: summary 5000 tests, 0 failures 3717 iops 29569 KB/s
dmatest: dma0chan0-copy5: summary 5000 tests, 0 failures 3699 iops 29302 KB/s

Shun-Chih Yu (2):
  dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller
    bindings
  dmaengine: mediatek-cqdma: remove redundant queue structure

 .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 ++
 drivers/dma/mediatek/mtk-cqdma.c                   |  399 +++++---------------
 2 files changed, 129 insertions(+), 301 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt

