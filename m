Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C704E208E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C704E208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeHXLIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:08:46 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:31486 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeHXLIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:08:46 -0400
Received: from droid10.amlogic.com (10.18.11.213) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Fri, 24 Aug 2018
 15:35:39 +0800
From:   Hanjie Lin <hanjie.lin@amlogic.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Hanjie Lin <hanjie.lin@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] add the Amlogic Meson PCIe controller driver. 
Date:   Fri, 24 Aug 2018 15:36:02 +0800
Message-ID: <1535096165-45827-1-git-send-email-hanjie.lin@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.213]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
PCI core. This patchset add the driver and dt-bindings of the controller.

Changes since v1: [0]
 - use gpio lib instead open code
 - move 'apb' and 'port' reset from phy driver
 - format correcting

[0] : https://lkml.org/lkml/2018/8/14/70

Yue Wang (2):
  dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe
    controller
  PCI: meson: add the Amlogic Meson PCIe controller driver

 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  63 +++
 drivers/pci/controller/dwc/Kconfig                 |  12 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-meson.c             | 613 +++++++++++++++++++++
 4 files changed, 689 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
 create mode 100644 drivers/pci/controller/dwc/pci-meson.c

-- 
2.7.4

