Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2878FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A0C2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A0C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbeJVVxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:53:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50978 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbeJVVw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:52:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 685EA20DE8; Mon, 22 Oct 2018 15:34:18 +0200 (CEST)
Received: from localhost.localdomain (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 98684207A3;
        Mon, 22 Oct 2018 15:34:07 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 4/9] dt-bindings: i3c: Document core bindings
Date:   Mon, 22 Oct 2018 15:33:59 +0200
Message-Id: <20181022133404.2061-5-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022133404.2061-1-boris.brezillon@bootlin.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new I3C subsystem has been added and a generic description has been
created to represent the I3C bus and the devices connected on it.

Document this generic representation.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Rob,

Can you have a look at this v9. I know you previously acked this
binding but I changed a bit the way we declare I2C devices and thus
had to drop your Ack.
The IS_I2C_DEV bit no long exists, and we instead consider that any
device with the 2nd reg entry set to 0 is an I2C device, which is
just fine because this entry is supposed to contain the upper part of
the Provisional ID which is basically the MIPI manufacturer ID,
and 0 is not a valid manufacturer ID.

By doing that we make reg definition more straightforward and can
drop the ugly {I2C,I3C}_DEV() macros.

Regards,

Boris

Changes in v9:
- Rework the way we encode the I2C vs I3C device in the reg property
  so that we don't need the funky macros to define and I3C or I2C dev
- Drop Rob's Reviewed-by

Changes in v8:
- None

Changes in v7:
- None

Changes in v6:
- None

Changes in v5:
- Add Rob's R-b

Changes in v4:
- Clarify the fact that static address == I3C address and dynamic
  address == I3C address
- Use i2c-scl-hz in the example

Changes in v3:
- Rename {i2c,i3c}-scl-frequency DT prop into {i2c,i3c}-scl-hz
- Rework the way we expose the provisional ID and LVR information
- Rename dynamic-address into assigned-address
- Enforce the I3C master node name

Changes in v2:
- Define how to describe I3C devices in the DT and when it should be
  used. Note that the parsing of I3C devices is not yet implemented in
  the framework. Will be added when someone really needs it.
---
 Documentation/devicetree/bindings/i3c/i3c.txt | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt

diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentation/devicetree/bindings/i3c/i3c.txt
new file mode 100644
index 000000000000..7021468e0205
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/i3c.txt
@@ -0,0 +1,138 @@
+Generic device tree bindings for I3C busses
+===========================================
+
+This document describes generic bindings that should be used to describe I3C
+busses in a device tree.
+
+Required properties
+-------------------
+
+- #address-cells  - should be <3>. Read more about addresses below.
+- #size-cells     - should be <0>.
+- compatible      - name of the I3C master controller driving the I3C bus
+
+For other required properties e.g. to describe register sets,
+clocks, etc. check the binding documentation of the specific driver.
+The node describing an I3C bus should be named i3c-master.
+
+Optional properties
+-------------------
+
+These properties may not be supported by all I3C master drivers. Each I3C
+master bindings should specify which of them are supported.
+
+- i3c-scl-hz: frequency of the SCL signal used for I3C transfers.
+	      When undefined the core sets it to 12.5MHz.
+
+- i2c-scl-hz: frequency of the SCL signal used for I2C transfers.
+	      When undefined, the core looks at LVR (Legacy Virtual Register)
+	      values of I2C devices described in the device tree to determine
+	      the maximum I2C frequency.
+
+I2C devices
+===========
+
+Each I2C device connected to the bus should be described in a subnode. All
+properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
+valid here, but several new properties have been added.
+
+New constraint on existing properties:
+--------------------------------------
+- reg: contains 3 cells
+  + first cell : still encoding the I2C address
+
+  + second cell: shall be 0
+
+  + third cell: shall encode the I3C LVR (Legacy Virtual Register)
+	bit[31:8]: unused/ignored
+	bit[7:5]: I2C device index. Possible values
+	* 0: I2C device has a 50 ns spike filter
+	* 1: I2C device does not have a 50 ns spike filter but supports high
+	     frequency on SCL
+	* 2: I2C device does not have a 50 ns spike filter and is not tolerant
+	     to high frequencies
+	* 3-7: reserved
+
+	bit[4]: tell whether the device operates in FM (Fast Mode) or FM+ mode
+	* 0: FM+ mode
+	* 1: FM mode
+
+	bit[3:0]: device type
+	* 0-15: reserved
+
+I3C devices
+===========
+
+All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
+are thus discoverable. So, by default, I3C devices do not have to be described
+in the device tree.
+This being said, one might want to attach extra resources to these devices,
+and those resources may have to be described in the device tree, which in turn
+means we have to describe I3C devices.
+
+Another use case for describing an I3C device in the device tree is when this
+I3C device has a static I2C address and we want to assign it a specific I3C
+dynamic address before the DAA takes place (so that other devices on the bus
+can't take this dynamic address).
+
+The I3C device should be names <device-type>@<static-i2c-address>,<i3c-pid>,
+where device-type is describing the type of device connected on the bus
+(gpio-controller, sensor, ...).
+
+Required properties
+-------------------
+- reg: contains 3 cells
+  + first cell : encodes the static I2C address. Should be 0 if the device does
+		 not have one (0 is not a valid I2C address).
+
+  + second and third cells: should encode the ProvisionalID. The second cell
+			    contains the manufacturer ID left-shifted by 1.
+			    The third cell contains ORing of the part ID
+			    left-shifted by 16, the instance ID left-shifted
+			    by 12 and the extra information. This encoding is
+			    following the PID definition provided by the I3C
+			    specification.
+
+Optional properties
+-------------------
+- assigned-address: dynamic address to be assigned to this device. This
+		    property is only valid if the I3C device has a static
+		    address (first cell of the reg property != 0).
+
+
+Example:
+
+	i3c-master@d040000 {
+		compatible = "cdns,i3c-master";
+		clocks = <&coreclock>, <&i3csysclock>;
+		clock-names = "pclk", "sysclk";
+		interrupts = <3 0>;
+		reg = <0x0d040000 0x1000>;
+		#address-cells = <3>;
+		#size-cells = <0>;
+
+		status = "okay";
+		i2c-scl-hz = <100000>;
+
+		/* I2C device. */
+		nunchuk: nunchuk@52 {
+			compatible = "nintendo,nunchuk";
+			reg = <0x52 0x80000010 0x0>;
+		};
+
+		/* I3C device with a static I2C address. */
+		thermal_sensor: sensor@68,39200144004 {
+			reg = <0x68 0x392 0x144004>;
+			assigned-address = <0xa>;
+		};
+
+		/*
+		 * I3C device without a static I2C address but requiring
+		 * resources described in the DT.
+		 */
+		sensor@0,39200154004 {
+			reg = <0x0 0x392 0x154004>;
+			clocks = <&clock_provider 0>;
+		};
+	};
+
-- 
2.17.1

