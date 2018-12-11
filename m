Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378DFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB94A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB94A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeLKFh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:37:59 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:49795 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727849AbeLKFh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:37:58 -0500
X-UUID: c5bf67ea02a5448b899a485b0565e5ab-20181211
X-UUID: c5bf67ea02a5448b899a485b0565e5ab-20181211
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1755209803; Tue, 11 Dec 2018 13:37:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Dec 2018 13:37:49 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Dec 2018 13:37:48 +0800
From:   Long Cheng <long.cheng@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH v5 0/2] add uart DMA function 
Date:   Tue, 11 Dec 2018 13:37:23 +0800
Message-ID: <1544506645-27979-1-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F1B53AF904294C972B7BDD82D3FD6BBF1AD3A14DB688C1A509C0C6F61A16E2972000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Mediatek SOCs, the uart can support DMA function.
Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.

This series contains document bindings, Kconfig to control the function enable or not,
device tree including interrupt and dma device node, the code of UART DM

Changes compared to v4:
-modify Kconfig depends on.
Changes compared to v3:
-fix CONFIG_PM, will cause build fail
Changes compared to v2:
-remove unimportant parameters
-instead of cookie, use APIs of virtual channel.
-use of_dma_xlate_by_chan_id.
Changes compared to v1:
-mian revised file, 8250_mtk_dma.c
--parameters renamed for standard
--remove atomic operation

Long Cheng (2):
  dmaengine: 8250_mtk_dma: add Mediatek uart DMA support
  arm: dts: mt2712: add uart APDMA to device tree

 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   50 ++
 drivers/dma/mediatek/8250_mtk_dma.c       |  830 +++++++++++++++++++++++++++++
 drivers/dma/mediatek/Kconfig              |   11 +
 drivers/dma/mediatek/Makefile             |    1 +
 4 files changed, 892 insertions(+)
 create mode 100644 drivers/dma/mediatek/8250_mtk_dma.c

-- 
1.7.9.5

