Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZoQI55iGOVk7X/f18oqe2qPom69FtqgqY8f4xW38ZoEA3sjSV0qaUcHzpPGz18MIhtRJPWk
ARC-Seal: i=1; a=rsa-sha256; t=1525697254; cv=none;
        d=google.com; s=arc-20160816;
        b=m4jAI0v4s8FGp2dTcryxBth35T4l9cGvocyOX5I7t9jro+ViNJ5i/5tKVC6l8AKzKc
         LbxWqgMMG30+PY3+beIVHGX+lqAn9opYGsSlcY9IiXgRSmykfyTQ5sQI9lcDQ+Bz7CWx
         x1jc/7144LIWDEIqpuerie0fEdiHR5mh4QDzLNcwOpkqRRe3G/mVZMVoziNu318KYtdQ
         gl9KmzlXUZKZq8ZVEuAvH5VnlnjqwJRAHY7Q1hYNJmTo1sFCYSHzGbC3aSDCdWIR0aCh
         4MXpkzYYfB/364SPTAziJRy/KeScRAu32mUZqGjlY6IdCKJaCkiRT0ZpB9NXkYrqKzUO
         +Gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=uiviAfDh07ZwZbc8rQUWpoGHzb95F6U0TgBR6cthWUc=;
        b=fEZDGZdIKdQ2gmBQ32Eps79+zf9hT1G1OvgmRLeOlTT5ETyawxkLAR0cjue8FQxpF8
         dLYQTV0wznhVL8OWPBVn+fSrM5Kd15rTFhgBKzRnP4YxVnCOD5Rm8LOEbUb3kFvBfym2
         zYyztdvNhzVydpft+0SWJEMn3iJqRUnxVf4QfwrzvmEbn1cPAquvupU2b2ueTNFYFjWC
         e7RjL0hXMJTbWKi56fP2zSefrW9BZBzoFk8DNMzD9MqHdaMH7dAzMQ3jfqLLJERXgcdx
         SXl68b50JV+fMkYXn8tAokrLW1hJhIJqhFCtnUNwu+HXNjeNwdxEWZ0uv2D41hi/v1Ni
         VeDw==
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
Subject: [PATCH v3 07/14] ARM: sun8i-a33: Add SRAM controller node and C1 SRAM region
Date: Mon,  7 May 2018 14:44:53 +0200
Message-Id: <20180507124500.20434-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809524439461353?=
X-GMAIL-MSGID: =?utf-8?q?1599809524439461353?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maxime Ripard <maxime.ripard@bootlin.com>

This adds a SRAM controller node for the A33, with support for the C1
SRAM region that is shared between the Video Engine and the CPU.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index a21f2ed07a52..97a976b3b1ef 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -204,6 +204,28 @@
 	};
 
 	soc@1c00000 {
+		sram-controller@1c00000 {
+			compatible = "allwinner,sun8i-a33-sram-controller";
+			reg = <0x01c00000 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_c: sram@1d00000 {
+				compatible = "mmio-sram";
+				reg = <0x01d00000 0xd00000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x01d00000 0xd00000>;
+
+				ve_sram: sram-section@0 {
+					compatible = "allwinner,sun8i-a33-sram-c1",
+						     "allwinner,sun4i-a10-sram-c1";
+					reg = <0x000000 0x80000>;
+				};
+			};
+		};
+
 		tcon0: lcd-controller@1c0c000 {
 			compatible = "allwinner,sun8i-a33-tcon";
 			reg = <0x01c0c000 0x1000>;
-- 
2.16.3
