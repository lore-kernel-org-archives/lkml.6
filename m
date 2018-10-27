Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C59C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5030E2086E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5030E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeJ0SkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 14:40:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728337AbeJ0SkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 14:40:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 28FF8E4A1284A;
        Sat, 27 Oct 2018 17:59:51 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 27 Oct 2018 17:59:46 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>
Subject: [PATCH 00/10] Add support for usb on Hikey960
Date:   Sat, 27 Oct 2018 17:58:10 +0800
Message-ID: <20181027095820.40056-1-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds support for usb functionality of Hikey960, includes:
- dwc3 driver for Hisilicon Kirin Soc hi3660
- usb driver for HiKey960 board
- some adjustment in dwc3, usb gadget and typec driver
- dts for support usb of HiKey960

Yu Chen (10):
  dt-bindings: usb: add support for dwc3 controller on HiSilicon SoCs
  dt-bindings: phy: Add support for HiSilicon's hi3660 USB PHY
  dt-bindings: misc: Add bindings for HiSilicon usb hub and data role
    switch functionality on HiKey960
  usb: dwc3: dwc3-hisi: Add code for dwc3 of Hisilicon Soc Platform
  usb: dwc3: Add two quirks for Hisilicon Kirin Soc Platform
  phy: Add usb phy support for hi3660 Soc of Hisilicon
  hikey960: Support usb functionality of Hikey960
  usb: typec: Add support for usb role switch in rt1711h driver
  usb: gadget: Add configfs attribuite for controling
    match_existing_only
  dts: hi3660: Add support for usb on Hikey960

 .../bindings/misc/hisilicon-hikey-usb.txt          |  24 ++
 .../devicetree/bindings/phy/phy-hi3660-usb3.txt    |  21 ++
 .../devicetree/bindings/usb/dwc3-hisi.txt          |  53 ++++
 MAINTAINERS                                        |  10 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |  35 +++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  52 ++++
 drivers/misc/Kconfig                               |   7 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/hisi_hikey_usb.c                      | 319 ++++++++++++++++++++
 drivers/phy/hisilicon/Kconfig                      |  10 +
 drivers/phy/hisilicon/Makefile                     |   1 +
 drivers/phy/hisilicon/phy-hi3660-usb3.c            | 254 ++++++++++++++++
 drivers/usb/dwc3/Kconfig                           |   8 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            |  43 +++
 drivers/usb/dwc3/core.h                            |   7 +
 drivers/usb/dwc3/dwc3-hisi.c                       | 335 +++++++++++++++++++++
 drivers/usb/dwc3/gadget.c                          |   2 +-
 drivers/usb/gadget/configfs.c                      |  32 ++
 drivers/usb/typec/tcpm/tcpci_rt1711h.c             |  15 +
 20 files changed, 1229 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-hisi.txt
 create mode 100644 drivers/misc/hisi_hikey_usb.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-usb3.c
 create mode 100644 drivers/usb/dwc3/dwc3-hisi.c

-- 
2.15.0-rc2

