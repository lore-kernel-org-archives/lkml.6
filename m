Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AG47ELsAkVhAA9uFUXfdN5czHOJXk2+i83MTHlow/F+aor3prKG2jEcH9EtSGsiuUxppRmWr3wME
ARC-Seal: i=1; a=rsa-sha256; t=1519950206; cv=none;
        d=google.com; s=arc-20160816;
        b=VBxqtZMpLuNRJ2bIdVqCv/6p6mNid79B8ralEmGndBmD/pVhjdcZuj5IpjSgOC/yJS
         LB5t3Yfu3HcGJc4PN733LuJiDGETf5EeLpsa91Rgo9ST7xsrPyGedlhsImkkUmeoS61q
         x49U6sbLDF7SeEmqF1yOzu280wGUKTUJmZsqGmwWMwYRIMRacBPnTy/bFaYiQshfBx8D
         NUrWx7YAwtpabrqO45Hso1fzdGjMcfu1OO26+I2ziexmwnu8lSQ6+xU6WL2v9WJcbMYb
         qR9rSUlgfWkZIb0wY7Cmxw63fZrk+LSFYT07JhrpTrgp7a+czjaN741k4jhGJCRMe+V7
         f7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Wcaiq27gfz7vSknLrdffwD+gj240wBh5K5BVPdj5dA0=;
        b=vH8jpN7ZXGpWKOs1gy3PFqo1GxGlimrl/dEk7RJBEDHTCZ/AxpIZrNnSrIqPF+kkyF
         y5rWmLV+ZTM1L4aEAWS50WEIYjVIY4Gvi2rvdXP13C9wd2QyaDU1MJWgRFQo1LblGGuw
         MdfOQ+bdKF1UruwjwoSiPiSrNABmh2wIoxG6c5E7uLk9kJqe5VTR+41iB3UdAoM1Yx4K
         X4nylmJMAi+M4YLEQr6z9m1prJmKfd1w0bo5GQTM7ItH2LAXDddm7M0yQXkbwJnZ3MCx
         lkP2jLOOINn6ABDtNhyQsSF7CZiAUkSqTFsoaOFaVUKSPoJypUf3ycilGSopVM4mmCto
         7mPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="35279644"
From: richard.gong@linux.intel.com
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	dinguyen@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	atull@kernel.org,
	mdf@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	yves.vandervennet@linux.intel.com,
	richard.gong@linux.intel.com,
	Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2 2/7] arm64: dts: stratix10: add service driver binding to base dtsi
Date: Thu,  1 Mar 2018 18:19:30 -0600
Message-Id: <1519949975-13548-3-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783308155174081?=
X-GMAIL-MSGID: =?utf-8?q?1593783308155174081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Add Intel Stratix10 service layer to the device tree

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: Change to put service layer driver node under the firmware node
    Change compatible to "intel, stratix10-svc"
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 5a6a699..4395e76 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -24,6 +24,20 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		service_reserved: svcbuffer@0 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x0 0x0 0x1000000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -433,5 +447,13 @@
 			resets = <&rst WATCHDOG3_RESET>;
 			status = "disabled";
 		};
+
+		firmware {
+			svc {
+				compatible = "intel,stratix10-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+			};
+		};
 	};
 };
-- 
2.7.4
