Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZpaJu6PH+uZUNlA3kbYY6HVkWiTcKcm6FgtY0JbfEab7BjuCfQ9WsTZM1y8Xkn7wnkpTTJ0
ARC-Seal: i=1; a=rsa-sha256; t=1525697257; cv=none;
        d=google.com; s=arc-20160816;
        b=pNQZGHxpnVhQtw+/e/zKwFWYG0VNBy9ODS64rfxQ3j6YO1taQyCzHIpKtYYGAM2U5U
         ZXIFlErof7HyZKDq8qmtGjV6sW8pD5yh5hR2aB8dCLn5VZO8IkYqwY9U9eTSbRKukUlv
         oRZT1xklmkDSnGId1ufQKo/pfwM0NbN/SwjSP4jWCINMpXe4DBlslRD1E2UMeebtX9Qe
         42yQ+lzRrTRc0DqDSLrAG/HjvAaz7X1lKbjpzEPqX0XfGZTYdf1HNSYgbgqeobuFyG4V
         oeM+qf/40Dp1f/z2Ql/doYpHxVA6hysgdg3KwweAlR8fQhm7bdT3oXFUO6u+cmdpCbTw
         KsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3uaK95uCb/KVWZZ8HkZvxn6aApd3GF0KLkPLHpqDqlM=;
        b=FbAROIYWLJEjga22eOmkiAnGdOACe8LXwVRSi31MshKGNC5K2LydY1JpATioqvTLx1
         WYRZs3Cx6PlujZSQ+/55JQ/luUfN82XbjdZ+aF9ZKSOb3Wi7WHK1FN1IadxKswB5TSKw
         tzAmj8bU6qoJVRXnKMNpe8SOrqx0VKO3A7p1gvMRdHkjQFhEtrL/t3JEU5dNdba/yzPY
         we1mPLoIO/9mD3yWmOl9uJVV5R/K3gYKXJky21eflgFUs1oRxQ3Jj+4nRIF3+Ua15AVM
         yJvn8DW7iloZxY7P75M2Rm2JbUk3r4awpg7RSqoaVNFn+4SaIlP7SBIbqYpmZZdigDDy
         gg1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of paul.kocialkowski@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=paul.kocialkowski@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of paul.kocialkowski@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=paul.kocialkowski@bootlin.com
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Yannick Fertre <yannick.fertre@st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugues Fruchet <hugues.fruchet@st.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Florent Revest <florent.revest@free-electrons.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Smitha T Murthy <smitha.t@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Randy Li <ayaka@soulik.info>
Subject: [PATCH v3 12/14] ARM: dts: sun5i: Add Video Engine and reserved memory nodes
Date: Mon,  7 May 2018 14:44:58 +0200
Message-Id: <20180507124500.20434-13-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809527758853559?=
X-GMAIL-MSGID: =?utf-8?q?1599809527758853559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds nodes for the Video Engine and the associated reserved memory
for sun5i-based platforms. Up to 96 MiB of memory are dedicated to the
CMA pool.

The VPU can only map the first 256 MiB of DRAM, so the reserved memory
pool has to be located in that area. Following Allwinner's decision in
downstream software, the last 96 MiB of the first 256 MiB of RAM are
reserved for this purpose.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 6fa9e28edc59..306d265622e2 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -108,6 +108,21 @@
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* Address must be kept in the lower 256 MiBs of DRAM for VE. */
+		cma_pool: cma@4a000000 {
+			compatible = "shared-dma-pool";
+			size = <0x6000000>;
+			alloc-ranges = <0x4a000000 0x6000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
 	soc@1c00000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -292,6 +307,22 @@
 			};
 		};
 
+		vpu: video-codec@1c0e000 {
+			compatible = "allwinner,sun5i-a13-video-engine";
+			reg = <0x01c0e000 0x1000>;
+
+			clocks = <&ccu CLK_AHB_VE>, <&ccu CLK_VE>,
+				 <&ccu CLK_DRAM_VE>;
+			clock-names = "ahb", "mod", "ram";
+
+			assigned-clocks = <&ccu CLK_VE>;
+			assigned-clock-rates = <320000000>;
+
+			resets = <&ccu RST_VE>;
+			interrupts = <53>;
+			allwinner,sram = <&ve_sram 1>;
+		};
+
 		mmc0: mmc@1c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.16.3
