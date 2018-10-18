Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981BAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504BD21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504BD21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJRPtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:49:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7038 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726031AbeJRPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:49:16 -0400
X-UUID: c272e98317314a91a8a20174a1862ba8-20181018
X-UUID: c272e98317314a91a8a20174a1862ba8-20181018
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <shun-chih.yu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1645721796; Thu, 18 Oct 2018 15:49:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Oct 2018 15:49:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Oct 2018 15:49:24 +0800
From:   <shun-chih.yu@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_wsdupstream@mediatek.com>
Subject: [PATCH v3] add support for Mediatek Command-Queue DMA controller on MT6765 SoC
Date:   Thu, 18 Oct 2018 15:49:09 +0800
Message-ID: <1539848951-14798-1-git-send-email-shun-chih.yu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AF58D6D0DAB9842F051060ACC9C3933A15FB9811D0F67077BCB39713D3B222C32000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

 .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 +
 drivers/dma/mediatek/Kconfig                       |   13 +
 drivers/dma/mediatek/Makefile                      |    1 +
 drivers/dma/mediatek/mtk-cqdma.c                   |  951 ++++++++++++++++++++
 4 files changed, 996 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
 create mode 100644 drivers/dma/mediatek/mtk-cqdma.c

