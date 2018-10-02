Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430C3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE50206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE50206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeJBULQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeJBULP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:15 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 57CF6C2A;
        Tue,  2 Oct 2018 13:27:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rosen Penev <rosenp@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 078/228] staging: mt7621-dts: Fix remaining pcie warnings
Date:   Tue,  2 Oct 2018 06:22:55 -0700
Message-Id: <20181002132504.626677057@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit d0233204fbc10f003d1ef077f57341c2feca4002 ]

This currently fixes the remaining dtb warnings:

Node /pcie@1e140000/pcie0 has a reg or ranges property, but no unit name
Node /pcie@1e140000/pcie1 has a reg or ranges property, but no unit name
Node /pcie@1e140000/pcie2 has a reg or ranges property, but no unit name
Node /pcie@1e140000/pcie0 node name is not "pci" or "pcie"
Node /pcie@1e140000/pcie0 missing ranges for PCI bridge (or not a bridge)
Node /pcie@1e140000/pcie0 missing bus-range for PCI bridge
Node /pcie@1e140000/pcie1 node name is not "pci" or "pcie"
Node /pcie@1e140000/pcie1 missing ranges for PCI bridge (or not a bridge)
Node /pcie@1e140000/pcie1 missing bus-range for PCI bridge
Node /pcie@1e140000/pcie2 node name is not "pci" or "pcie"
Node /pcie@1e140000/pcie2 missing ranges for PCI bridge (or not a bridge)
Node /pcie@1e140000/pcie2 missing bus-range for PCI bridge
Warning (unit_address_format): Failed prerequisite 'pci_bridge'
Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'

device_type was removed since according to documentation, it's deprecated
for pci(e) devices.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/mt7621-dts/gbpc1.dts   |    2 ++
 drivers/staging/mt7621-dts/mt7621.dtsi |   21 +++++++++------------
 2 files changed, 11 insertions(+), 12 deletions(-)

--- a/drivers/staging/mt7621-dts/gbpc1.dts
+++ b/drivers/staging/mt7621-dts/gbpc1.dts
@@ -113,6 +113,8 @@
 };
 
 &pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
 	status = "okay";
 };
 
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -447,31 +447,28 @@
 		clocks = <&clkctrl 24 &clkctrl 25 &clkctrl 26>;
 		clock-names = "pcie0", "pcie1", "pcie2";
 
-		pcie0 {
+		pcie@0,0 {
 			reg = <0x0000 0 0 0 0>;
-
 			#address-cells = <3>;
 			#size-cells = <2>;
-
-			device_type = "pci";
+			ranges;
+			bus-range = <0x00 0xff>;
 		};
 
-		pcie1 {
+		pcie@1,0 {
 			reg = <0x0800 0 0 0 0>;
-
 			#address-cells = <3>;
 			#size-cells = <2>;
-
-			device_type = "pci";
+			ranges;
+			bus-range = <0x00 0xff>;
 		};
 
-		pcie2 {
+		pcie@2,0 {
 			reg = <0x1000 0 0 0 0>;
-
 			#address-cells = <3>;
 			#size-cells = <2>;
-
-			device_type = "pci";
+			ranges;
+			bus-range = <0x00 0xff>;
 		};
 	};
 };


