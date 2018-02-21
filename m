Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x227ZpZ33VSTdKs43Xw3aTwZLnrxSRu3wQhdFB/vMRVMC6bXe9ewzmymjIiAlLr/OVmwCDQOn
ARC-Seal: i=1; a=rsa-sha256; t=1519229777; cv=none;
        d=google.com; s=arc-20160816;
        b=gaq2Icqho5Bk0gDLtWExdGryZXAjI9hdQQJfY5FQpqdNuOm5laK1Mk4D9XT+LUqU/m
         5wNmd799X9h8dXdzOcXcTUL/EXuWm8W8TnwTSUy9a9g8tXGyy0XOWZjyJS2YXPNRTzS7
         4L5XmLzCCpLJ3MKvEti/iFBvO8HG4T7xmZcs4V5/ahKlSCSya+t93jSYJn72zDGND1Ul
         noi5SZn8J0gBhEeQId9lIw5Mqt9weWjVFN9bexnVuvaTH/H2qFZVR1W4bNeclK2q22Wl
         /DaNLhLrwOASCeKzBWz6qeElPYJdoWZ5ycXkOKHQo1PaW2ozJnXa8LmetNjdXm+EIA2I
         WpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=yM4xAM47Dzrk9o8lf+w1P0injSJiW/h8o38I6A13apo=;
        b=xiaiTlvPPQ6zTniEqL5K9FnnrV6umGnmCl3ORYsCgtFFX2fsMG9uXBs5UfGumdiqo5
         Q23DehJz7JrX1obzJLsMgK0WcZ7fMJTGZsgBRQs5A92gsIICoQFtTH9EPr731wLLj4I3
         BiYInvSlOOKse3MF6X/uxreFZKqYSiL6Esa4Ofb8lRsZXqN3SkDKaWn/CLCAUdPKS8mG
         SbHWyNkYqVzwY4XzODDrnUdzQEPhsHU+EA91TNGOhPy2v1xNOEPSKTTelPBwWp/lltZH
         h5aQcCXZWwzbFpc7sZDzu92AWYoKSOaUmzcUmxsDjw1UKBhBrx8ke9+pEIzmTTVSNBKT
         eIWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="29617842"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: joel@jms.id.au,
	andrew@aj.id.au,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	benh@kernel.crashing.org,
	andrew@lunn.ch
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
Date: Wed, 21 Feb 2018 08:16:00 -0800
Message-Id: <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027883264098537?=
X-GMAIL-MSGID: =?utf-8?q?1593027883264098537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a dt-bindings document of PECI adapter driver for Aspeed
AST24xx/25xx SoCs.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 .../devicetree/bindings/peci/peci-aspeed.txt       | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt

diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
new file mode 100644
index 000000000000..8a86f346d550
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
@@ -0,0 +1,73 @@
+Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
+
+Required properties:
+- compatible
+	"aspeed,ast2400-peci" or "aspeed,ast2500-peci"
+	- aspeed,ast2400-peci: Aspeed AST2400 family PECI controller
+	- aspeed,ast2500-peci: Aspeed AST2500 family PECI controller
+
+- reg
+	Should contain PECI registers location and length.
+
+- #address-cells
+	Should be <1>.
+
+- #size-cells
+	Should be <0>.
+
+- interrupts
+	Should contain PECI interrupt.
+
+- clocks
+	Should contain clock source for PECI hardware module. Should reference
+	clkin clock.
+
+- clock_frequency
+	Should contain the operation frequency of PECI hardware module.
+	187500 ~ 24000000
+
+Optional properties:
+- msg-timing-nego
+	Message timing negotiation period. This value will determine the period
+	of message timing negotiation to be issued by PECI controller. The unit
+	of the programmed value is four times of PECI clock period.
+	0 ~ 255 (default: 1)
+
+- addr-timing-nego
+	Address timing negotiation period. This value will determine the period
+	of address timing negotiation to be issued by PECI controller. The unit
+	of the programmed value is four times of PECI clock period.
+	0 ~ 255 (default: 1)
+
+- rd-sampling-point
+	Read sampling point selection. The whole period of a bit time will be
+	divided into 16 time frames. This value will determine which time frame
+	this controller will sample PECI signal for data read back. Usually in
+	the middle of a bit time is the best.
+	0 ~ 15 (default: 8)
+
+- cmd_timeout_ms
+	Command timeout in units of ms.
+	1 ~ 60000 (default: 1000)
+
+Example:
+	peci: peci@1e78b000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x1e78b000 0x60>;
+
+		peci0: peci-bus@0 {
+			compatible = "aspeed,ast2500-peci";
+			reg = <0x0 0x60>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <15>;
+			clocks = <&clk_clkin>;
+			clock-frequency = <24000000>;
+			msg-timing-nego = <1>;
+			addr-timing-nego = <1>;
+			rd-sampling-point = <8>;
+			cmd-timeout-ms = <1000>;
+		};
+	};
\ No newline at end of file
-- 
2.16.1
