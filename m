Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9533FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E1020880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E1020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbeGWWv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:51:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:8908 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388187AbeGWWvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:51:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 14:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,394,1526367600"; 
   d="scan'208";a="66923116"
Received: from maru.jf.intel.com ([10.54.51.80])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jul 2018 14:48:43 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Milton Miller II <miltonm@us.ibm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Robin Murphy <robin.murphy@arm.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v7 04/12] dt-bindings: Add a document of PECI adapter driver for ASPEED AST24xx/25xx SoCs
Date:   Mon, 23 Jul 2018 14:47:43 -0700
Message-Id: <20180723214751.1733-5-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
References: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a dt-bindings document of PECI adapter driver for ASPEED
AST24xx/25xx SoCs.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason M Biils <jason.m.bills@linux.intel.com>
Cc: Milton Miller II <miltonm@us.ibm.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../devicetree/bindings/peci/peci-aspeed.txt  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt

diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
new file mode 100644
index 000000000000..cdca73a3b7d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
@@ -0,0 +1,55 @@
+Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
+
+Required properties:
+- compatible        : Should be one of:
+			"aspeed,ast2400-peci"
+			"aspeed,ast2500-peci"
+- reg               : Should contain PECI controller registers location and
+		      length.
+- #address-cells    : Should be <1> required to define a client address.
+- #size-cells       : Should be <0> required to define a client address.
+- interrupts        : Should contain PECI controller interrupt.
+- clocks            : Should contain clock source for PECI controller. Should
+		      reference the external oscillator clock in the second
+		      cell.
+- resets            : Should contain phandle to reset controller with the reset
+		      number in the second cell.
+- clock-frequency   : Should contain the operation frequency of PECI controller
+		      in units of Hz.
+		      187500 ~ 24000000
+
+Optional properties:
+- msg-timing        : Message timing negotiation period. This value will
+		      determine the period of message timing negotiation to be
+		      issued by PECI controller. The unit of the programmed
+		      value is four times of PECI clock period.
+		      0 ~ 255 (default: 1)
+- addr-timing       : Address timing negotiation period. This value will
+		      determine the period of address timing negotiation to be
+		      issued by PECI controller. The unit of the programmed
+		      value is four times of PECI clock period.
+		      0 ~ 255 (default: 1)
+- rd-sampling-point : Read sampling point selection. The whole period of a bit
+		      time will be divided into 16 time frames. This value will
+		      determine the time frame in which the controller will
+		      sample PECI signal for data read back. Usually in the
+		      middle of a bit time is the best.
+		      0 ~ 15 (default: 8)
+- cmd-timeout-ms    : Command timeout in units of ms.
+		      1 ~ 60000 (default: 1000)
+
+Example:
+	peci0: peci-bus@0 {
+		compatible = "aspeed,ast2500-peci";
+		reg = <0x0 0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <15>;
+		clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+		resets = <&syscon ASPEED_RESET_PECI>;
+		clock-frequency = <24000000>;
+		msg-timing = <1>;
+		addr-timing = <1>;
+		rd-sampling-point = <8>;
+		cmd-timeout-ms = <1000>;
+	};
-- 
2.18.0

