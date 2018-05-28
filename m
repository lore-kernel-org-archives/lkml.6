Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939228AbeE1NcO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033901AbeE1Kqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:46:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 123/496] arm64: dts: cavium: fix PCI bus dtc warnings
Date: Mon, 28 May 2018 11:58:28 +0200
Message-Id: <20180528100325.113324987@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit e2c8d283c4e2f468bed1bcfedb80b670b1bc8ab1 ]

dtc recently added PCI bus checks. Fix these warnings:

arch/arm64/boot/dts/cavium/thunder2-99xx.dtb: Warning (pci_bridge): Node /pci missing bus-range for PCI bridge
arch/arm64/boot/dts/cavium/thunder2-99xx.dtb: Warning (unit_address_vs_reg): Node /pci has a reg or ranges property, but no unit name

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
@@ -98,7 +98,7 @@
 		clock-output-names = "clk125mhz";
 	};
 
-	pci {
+	pcie@30000000 {
 		compatible = "pci-host-ecam-generic";
 		device_type = "pci";
 		#interrupt-cells = <1>;
@@ -118,6 +118,7 @@
 		ranges =
 		  <0x02000000    0 0x40000000    0 0x40000000    0 0x20000000
 		   0x43000000 0x40 0x00000000 0x40 0x00000000 0x20 0x00000000>;
+		bus-range = <0 0xff>;
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map =
 		      /* addr  pin  ic   icaddr  icintr */
