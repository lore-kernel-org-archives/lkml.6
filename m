Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E298C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7750E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeL0HfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 02:35:00 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:51588 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728319AbeL0He6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 02:34:58 -0500
X-UUID: 5f8b781084354860943b6d486fbaded4-20181227
X-UUID: 5f8b781084354860943b6d486fbaded4-20181227
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1925364063; Thu, 27 Dec 2018 15:34:46 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Dec 2018 15:34:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Dec 2018 15:34:43 +0800
From:   <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Min Guo <min.guo@mediatek.com>
Subject: [PATCH 0/4] Add MediaTek MUSB Controller Driver
Date:   Thu, 27 Dec 2018 15:34:22 +0800
Message-ID: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Guo <min.guo@mediatek.com>

These patches introduce the MediaTek MUSB controller driver.

The driver can be configured as Dual-Role Device (DRD),
Peripheral Only and Host Only modes. This has beed tested on
MT2701 with a variety of devices in host mode and with the 
f_mass gadget driver in peripheral mode, plugging otg cables
in/out a lot of times in all possible imaginable plug orders

Min Guo (4):
  dt-bindings: usb: musb: Add support for MediaTek musb controller
  arm: dts: mt2701: Add usb2 device nodes
  usb: musb: Move musbhsdma macro definition to musb_dma.h
  usb: musb: Add support for MediaTek musb controller

 .../devicetree/bindings/usb/mediatek,musb.txt      |  49 ++
 arch/arm/boot/dts/mt2701-evb.dts                   |  21 +
 arch/arm/boot/dts/mt2701.dtsi                      |  34 ++
 drivers/usb/musb/Kconfig                           |   8 +-
 drivers/usb/musb/Makefile                          |   1 +
 drivers/usb/musb/mediatek.c                        | 562 +++++++++++++++++++++
 drivers/usb/musb/musb_core.c                       |  10 +
 drivers/usb/musb/musb_core.h                       |   1 +
 drivers/usb/musb/musb_dma.h                        |   7 +
 drivers/usb/musb/musb_host.c                       |  79 ++-
 drivers/usb/musb/musb_regs.h                       |   6 +
 drivers/usb/musb/musbhsdma.c                       |  41 +-
 12 files changed, 782 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
 create mode 100644 drivers/usb/musb/mediatek.c

-- 
1.9.1

