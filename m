Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175F2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C810B2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C810B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbeISD02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:26:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:59611 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbeISD01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:26:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 14:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,391,1531810800"; 
   d="scan'208";a="87270304"
Received: from maru.jf.intel.com ([10.54.51.77])
  by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2018 14:51:36 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
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
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v8 01/12] dt-bindings: Add a document of PECI subsystem
Date:   Tue, 18 Sep 2018 14:51:13 -0700
Message-Id: <20180918215124.14003-2-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a document of generic PECI bus, adapter and client
driver.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
---
 .../devicetree/bindings/peci/peci.txt         | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci.txt

diff --git a/Documentation/devicetree/bindings/peci/peci.txt b/Documentation/devicetree/bindings/peci/peci.txt
new file mode 100644
index 000000000000..864b7ab4e9fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci.txt
@@ -0,0 +1,43 @@
+Generic device tree configuration for PECI adapters
+===================================================
+
+Required properties:
+- #address-cells : Should be <1>. Read more about client addresses below.
+- #size-cells    : Should be <0>. Read more about client addresses below.
+
+The cells properties above define that an address of CPU clients of a PECI bus
+are described by a single value.
+
+Example:
+	peci0: peci-bus@0 {
+		compatible = "vendor,soc-peci";
+		reg = <0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+Generic device tree configuration for PECI clients
+==================================================
+
+Required properties:
+- compatible : Should contain name of PECI client.
+- reg        : Should contain address of a client CPU. Address range of CPU
+	       clients starts from 0x30 based on PECI specification.
+
+Example:
+	peci-bus@0 {
+		compatible = "vendor,soc-peci";
+		reg = <0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		peci-client@30 {
+			compatible = "intel,peci-client";
+			reg = <0x30>;
+		};
+
+		peci-client@31 {
+			compatible = "intel,peci-client";
+			reg = <0x31>;
+		};
+	};
-- 
2.18.0

