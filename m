Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZr2zreKXeUiwlb7NXuvLfYOTF1zeOPhtNqGnd59Hmigc35baBX6GwUJrW0oZx1xNoW2z50C
ARC-Seal: i=1; a=rsa-sha256; t=1525697258; cv=none;
        d=google.com; s=arc-20160816;
        b=l6gqqv4yZNZpatLBryxHMVD3ZBNmvyYKXRDtJ43tqmFmkfqdScOCiUbE885MiphHtq
         FUQJTTV9Ot/FK2+ehV32GSstCJkUOJ8y0tNasOKoc2w8+g/0dmP6Q3KegwBhgIp9G1e4
         DKajaqaW4w2zXY+OBhnC+Vl0zAQWTdtooMnRZT3zU3ruGK/15rtyKUlDCZNnmKsuozqg
         tLp/RsUVEnwqz8a6h3hM2bu7y42FHgBKhzxQYbUmYFdVvBtJpmtQVPOdzSqQ/kWfrW3S
         RcJLAFFn5VDDdlxkdCX0oaOAzFL1A1Sm0Y28eep/q5C1pQgm/vLgzfBiLHL70b3Blq8f
         O5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=B23KMsxP1oNPZ3lNkXfqxkYWfcZb/5q6myxaWRZzLD4=;
        b=TgPI8iutCgLuJ25l/B9VTqcEv82QRvsARob6JxHiyzaxjlp3g6nn8IMsvvGxqlOewb
         eLGy6WmB9/+eekCpSe0pyuVlDQozWFzgGTLhfxeDBYx7oXl0X74hdXG/4Ghk3vS+Nu8X
         ikFc6zvOARtFCU4jcx1W63RN+ccPUgeeq35hmImJe0GgzeADssOyLaX/+H0bFK55xGki
         PP6MTuMGTkBlA9jqPMx74fKsCU4/RUMsHaIeYLQl1BI/N9URIJ/JXP2KETxZrfxUVZTD
         906n2Z0ydW2q2GOQHAafA78Wc4Whhi+itMiI6XHXUtnNjw/LgOkcd4OPjRWQIEl1nI4H
         ElZA==
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
Subject: [PATCH v3 14/14] ARM: dts: sun8i-a33: Add Video Engine and reserved memory nodes
Date: Mon,  7 May 2018 14:45:00 +0200
Message-Id: <20180507124500.20434-15-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809528631829736?=
X-GMAIL-MSGID: =?utf-8?q?1599809528631829736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds nodes for the Video Engine and the associated reserved memory
for the A33. Up to 96 MiB of memory are dedicated to the CMA pool.

The VPU can only map the first 256 MiB of DRAM, so the reserved memory
pool has to be located in that area. Following Allwinner's decision in
downstream software, the last 96 MiB of the first 256 MiB of RAM are
reserved for this purpose.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 97a976b3b1ef..5308a49601f6 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -181,6 +181,21 @@
 		reg = <0x40000000 0x80000000>;
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
 	sound: sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "sun8i-a33-audio";
@@ -262,6 +277,23 @@
 			};
 		};
 
+		vpu: video-codec@01c0e000 {
+			compatible = "allwinner,sun8i-a33-video-engine";
+			reg = <0x01c0e000 0x1000>;
+
+			clocks = <&ccu CLK_BUS_VE>, <&ccu CLK_VE>,
+				 <&ccu CLK_DRAM_VE>;
+			clock-names = "ahb", "mod", "ram";
+
+			assigned-clocks = <&ccu CLK_VE>;
+			assigned-clock-rates = <320000000>;
+
+			resets = <&ccu RST_BUS_VE>;
+
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			allwinner,sram = <&ve_sram 1>;
+		};
+
 		crypto: crypto-engine@1c15000 {
 			compatible = "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
-- 
2.16.3
