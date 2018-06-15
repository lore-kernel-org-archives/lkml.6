Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A4DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84C3208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84C3208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966175AbeFOQpe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:45:34 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:57296 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966100AbeFOQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:45:29 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from oleksandrs@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 15 Jun 2018 19:47:50 +0300
Received: from r-vnc16.mtr.labs.mlnx (r-vnc16.mtr.labs.mlnx [10.208.0.16])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w5FGjNR8025558;
        Fri, 15 Jun 2018 19:45:23 +0300
From:   Oleksandr Shamray <oleksandrs@mellanox.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch,
        linux-serial@vger.kernel.org, vadimp@mellanox.com,
        system-sw-low-level@mellanox.com, robh+dt@kernel.org,
        openocd-devel-owner@lists.sourceforge.net,
        linux-api@vger.kernel.org, davem@davemloft.net, mchehab@kernel.org,
        Oleksandr Shamray <oleksandrs@mellanox.com>
Subject: [patch v26 3/4] Documentation: jtag: Add bindings for Aspeed SoC 24xx and 25xx families JTAG master driver
Date:   Fri, 15 Jun 2018 19:45:22 +0300
Message-Id: <1529081123-30873-4-git-send-email-oleksandrs@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1529081123-30873-1-git-send-email-oleksandrs@mellanox.com>
References: <1529081123-30873-1-git-send-email-oleksandrs@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been tested on Mellanox system with BMC equipped with
Aspeed 2520 SoC for programming CPLD devices.

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v21->v22
v20->v21
v19->v20
v18->v19

v17->v18
v16->v17
v15->v16
Comments pointed by Joel Stanley <joel.stan@gmail.com>
- change clocks = <&clk_apb> to proper clocks = <&syscon ASPEED_CLK_APB>
- add reset descriptions in bndings file

v14->v15
v13->v14
v12->v13
v11->v12
v10->v11
v9->v10
v8->v9
v7->v8
Comments pointed by pointed by Joel Stanley <joel.stan@gmail.com>
- Change compatible string to ast2400 and ast2000

V6->v7
Comments pointed by Tobias Klauser <tklauser@distanz.ch>
 - Fix spell "Doccumentation" -> "Documentation"

v5->v6
Comments pointed by Tobias Klauser <tklauser@distanz.ch>
- Small nit: s/documentation/Documentation/

v4->v5

V3->v4
Comments pointed by Rob Herring <robh@kernel.org>
- delete unnecessary "status" and "reg-shift" descriptions in
  bndings file

v2->v3
Comments pointed by Rob Herring <robh@kernel.org>
- split Aspeed jtag driver and binding to sepatrate patches
- delete unnecessary "status" and "reg-shift" descriptions in
  bndings file
---
 .../devicetree/bindings/jtag/aspeed-jtag.txt       |   22 ++++++++++++++++++++
 MAINTAINERS                                        |    1 +
 2 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.txt

diff --git a/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt b/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
new file mode 100644
index 0000000..7c36eb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
@@ -0,0 +1,22 @@
+Aspeed JTAG driver for ast2400 and ast2500 SoC
+
+Required properties:
+- compatible:		Should be one of
+      - "aspeed,ast2400-jtag"
+      - "aspeed,ast2500-jtag"
+- reg			contains the offset and length of the JTAG memory
+			region
+- clocks		root clock of bus, should reference the APB
+			clock in the second cell
+- resets		phandle to reset controller with the reset number in
+			the second cell
+- interrupts		should contain JTAG controller interrupt
+
+Example:
+jtag: jtag@1e6e4000 {
+	compatible = "aspeed,ast2500-jtag";
+	reg = <0x1e6e4000 0x1c>;
+	clocks = <&syscon ASPEED_CLK_APB>;
+	resets = <&syscon ASPEED_RESET_JTAG_MASTER>;
+	interrupts = <43>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index e7b8b2c..a5e5f75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7617,6 +7617,7 @@ S:	Maintained
 F:	include/linux/jtag.h
 F:	include/uapi/linux/jtag.h
 F:	drivers/jtag/
+F:	Documentation/devicetree/bindings/jtag/
 
 K10TEMP HARDWARE MONITORING DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
-- 
1.7.1

