Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BE8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E7320844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E7320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbeHAMfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:35:07 -0400
Received: from nbd.name ([46.4.11.11]:55686 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387462AbeHAMfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:35:07 -0400
From:   John Crispin <john@phrozen.org>
To:     Alban Bedel <albeu@free.fr>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 0/3] phy: qcom-ipq4019-usb: add new driver
Date:   Wed,  1 Aug 2018 12:49:38 +0200
Message-Id: <20180801104941.29432-1-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a PHY driver for the Qualcomm Dakota SoC

Changes V1->V2
* fix the compat string inside the binding doc
* fix up the reset names inside the binding doc
* reflect the above changes in the driver and dts/i files

John Crispin (3):
  dt-bindings: phy-qcom-ipq4019-usb: add binding document
  phy: qcom-ipq4019-usb: add driver for QCOM/IPQ4019
  qcom: ipq4019: add USB devicetree nodes

 .../bindings/phy/phy-qcom-ipq4019-usb.txt          |  21 +++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi      |  20 +++
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |  76 ++++++++
 drivers/phy/qualcomm/Kconfig                       |   7 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c        | 193 +++++++++++++++++++++
 6 files changed, 318 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-qcom-ipq4019-usb.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c

-- 
2.11.0

