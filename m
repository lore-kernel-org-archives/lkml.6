Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZoyFEDd7YH7zFcqhF4ZCvYlczW6fdgnhdS3AZom8Be1jw0hF0RetLYTxE8n50eNAGPu+g7w
ARC-Seal: i=1; a=rsa-sha256; t=1525697253; cv=none;
        d=google.com; s=arc-20160816;
        b=J+1mCzH8jZP/tUAStMMQZEXkiYTI6kPdZvfOm+9HbYnDWX8q5JQxYJO7Lj9BgjnY4Z
         cmATqzK+Jkh4sClAbBOwN6ChmH9f+idrHs6pBgK1YlJzkSFCanXp8oSZeiXy4EDIEYr2
         z0fF8OdUYGOShFj/s+WZz91dfm9s6gTWE1/zl5O2OV5RPV0HnDV+749CL/Eurxisdpz4
         KVp8af49lUwtOXTpVpwML/JeSA9xqzBY5Xy1qQhU+ebaaD5SYwAR5toYx6CL9xovyT4Z
         1nub/7d5a+5VId1zMV1KE6sXrp2mJuyY3QddVA1TuNpw9X+zEAlGrw/zIxrLpybbqtTK
         NA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=M5W3gvGTOTG9Al0qP7uzJxBTNP/zDjXZwXNwwL2m6Tw=;
        b=LmRIEhD/jmhBD/td4TRpRJ0aklyfZQIf8fOkmXRZyJcJvzk6WyLd3Cc3e9glwqznoJ
         IzPX9OL8fffdpOzwdWkZEOqmFgl/r1G2oiX9FmpRaf2eamuY1MqOsc4vCmEAklUULOaN
         7YsjSpSRDPR5sJ9afwMvHG7dNXNfZgZedYaRJoA1kR6C4S15Jt0TSy6ISHK9x/xx6JRl
         HS94JxYM4AbBVJdiGoxFbpbWVAp2ZQQIjgZC0MeMx9jnkCzbDVj25PPFn84bQmvnNSkT
         vnlwiHXKMB/1LLRhmNy2L/kteGJrObcQS9EawlbGRJKDiPnnjoIt92aXVW03MTsxSYil
         Z+Nw==
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
Subject: [PATCH v3 06/14] ARM: sun7i-a20: Add support for the C1 SRAM region with the SRAM controller
Date: Mon,  7 May 2018 14:44:52 +0200
Message-Id: <20180507124500.20434-7-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809523794723293?=
X-GMAIL-MSGID: =?utf-8?q?1599809523794723293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maxime Ripard <maxime.ripard@bootlin.com>

This adds support for the C1 SRAM region (to be used with the SRAM
controller driver) for the A20 platform. The region is shared
between the Video Engine and the CPU.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index b179e05408e4..9bb6c35fb850 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -273,6 +273,20 @@
 					status = "disabled";
 				};
 			};
+
+			sram_c: sram@1d00000 {
+				compatible = "mmio-sram";
+				reg = <0x01d00000 0xd00000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x01d00000 0xd00000>;
+
+				ve_sram: sram-section@0 {
+					compatible = "allwinner,sun7i-a20-sram-c1",
+						     "allwinner,sun4i-a10-sram-c1";
+					reg = <0x000000 0x80000>;
+				};
+			};
 		};
 
 		nmi_intc: interrupt-controller@1c00030 {
-- 
2.16.3
