Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDF5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 13:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6573D2070C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 13:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbeL0NLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 08:11:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3680 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726761AbeL0NLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 08:11:33 -0500
X-UUID: b69ba60ec1fd4f30a6cb9e773edd9e70-20181227
X-UUID: b69ba60ec1fd4f30a6cb9e773edd9e70-20181227
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <shun-chih.yu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1015387575; Thu, 27 Dec 2018 21:11:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Dec
 2018 21:11:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Dec 2018 21:11:03 +0800
From:   <shun-chih.yu@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_wsdupstream@mediatek.com>
Subject: [PATCH v4] add support for Mediatek Command-Queue DMA controller on MT6765 SoC
Date:   Thu, 27 Dec 2018 21:10:56 +0800
Message-ID: <1545916258-18218-1-git-send-email-shun-chih.yu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
- simplify the ISR and management on descriptors by removing tasklet and ASYNC_TX_ENABLE_CHANNEL_SWITCH
- remove useless field in mtk_cqdma_vdesc structure
- change dev_info to dev_dbg
- fix typos

Changes since v2:
- fix build warning for kernel with DMA address in 32-bit

Changes since v1:
- remove unused macros, typos
- leverage ASYNC_TX_ENABLE_CHANNEL_SWITCH to maintain DMA descriptor list


Shun-Chih Yu (2):
  dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller
    bindings
  dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for
    MT6765 SoC

 .../devicetree/bindings/dma/mtk-cqdma.txt     |  31 +
 drivers/dma/mediatek/Kconfig                  |  12 +
 drivers/dma/mediatek/Makefile                 |   1 +
 drivers/dma/mediatek/mtk-cqdma.c              | 867 ++++++++++++++++++
 4 files changed, 911 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
 create mode 100644 drivers/dma/mediatek/mtk-cqdma.c
