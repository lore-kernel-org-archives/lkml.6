Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeCXX0n (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 19:26:43 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:4860 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbeCXX0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 19:26:42 -0400
From: Alban Bedel <albeu@free.fr>
To: linux-kernel@vger.kernel.org
Cc: Alban Bedel <albeu@free.fr>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v3 2/3] doc: bindings: Add bindings documentation for mtd nvmem
Date: Sun, 25 Mar 2018 00:24:58 +0100
Message-Id: <1521933899-362-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521933899-362-1-git-send-email-albeu@free.fr>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Config data for drivers, like MAC addresses, is often stored in MTD.
Add a binding that define how such data storage can be represented in
device tree.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
Changelog:
v2: * Added a "Required properties" section with the nvmem-provider
      property
v3: * Fixed my name in From and Signed-off-by
    * Moved to the new nvmem binding with the nvmem-cells subnode
---
 .../devicetree/bindings/nvmem/mtd-nvmem.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mtd-nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/mtd-nvmem.txt b/Documentation/devicetree/bindings/nvmem/mtd-nvmem.txt
new file mode 100644
index 0000000..c819a69
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mtd-nvmem.txt
@@ -0,0 +1,27 @@
+= NVMEM in MTD =
+
+Config data for drivers, like MAC addresses, is often stored in MTD.
+An MTD device, or one of its partition, can be defined as a NVMEM provider
+by having an 'nvmem-cells' subnode as defined in nvmem.txt.
+
+Example:
+
+	flash@0 {
+		...
+
+		partition@2 {
+			label = "art";
+			reg = <0x7F0000 0x010000>;
+			read-only;
+
+			nvmem-cells {
+				compatible = "nvmem-cells";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				eeprom@1000 {
+					reg = <0x1000 0x1000>;
+				};
+			};
+		};
+	};
-- 
2.7.4
