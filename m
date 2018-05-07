Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZoeOwF67qFuXNKlYBqr0G72hAnCo1iM9Z7f6K8uTgNekl311w11JS12+o/Ma1fZ5PNkZR2R
ARC-Seal: i=1; a=rsa-sha256; t=1525697253; cv=none;
        d=google.com; s=arc-20160816;
        b=YaHnaCAS9Cf3QSyrshvqFSFFtx+CzX0EI/Ra2BFe1jOaY3gh0Ttwg91wu+1XsL31nF
         7EbS6BbUcnvK2zzEoFWIyULyag+4CQ3JKSflqtZ3uM77IYN4YG6uX1j6urAzc0HuYZ0w
         oHzKWGVA6aIkpCFrar6XJj4CUf4R6gKu8fj8IbqEa9gXGYqZ2DNY0bk2CWVz+bRAVa1q
         XK5f1yW98rvQ5ALSX0Y0pUJxrjH5wORx3uyEIjJkBAWHC9NFfyRc9j2E5Y+Jh8FuBD/5
         uPsJoUOzwItdoashJ07gh2fg7pDuVih0xKuNW3XFhoCOVPNEBiXLU5ENO/OhlSI+ddW0
         CH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=M7EIUFIZ8yh8Pdl0P8PhgXwJRWPYxxujTtU3+gYoXUw=;
        b=qfqlCbk1aTIDO79WpChZJFC83NAIL5LstxwRCmtza8S1vkFHThb493i/yZQsog/QnG
         e9/G17cetDeBTbQZ31LyWXlL8N7N+xIT1zzhyF3ZCe9PzTH3ywtDC8AUenXM+loqjT6i
         qsGCwx0ANP+diqozykOOJjrSJO8bcR+zxrCDzI2W+bpJReW1AgAXZmfczAeS/ZYaROsm
         6lRdyLIXqF3Rd5dc4QZszRqHLfjC34Z0683CwrMtn/5SF3ArxbTr388OFY2o9Rj/w4Bc
         F6oyPEfzWeNHYR9ySPxr3A7IiRoFbWvqzzNXwMQMTHmEdpu2NRl/jt3iQkzvBLDMp8R3
         mgYQ==
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
Subject: [PATCH v3 05/14] ARM: sun5i: Add support for the C1 SRAM region with the SRAM controller
Date: Mon,  7 May 2018 14:44:51 +0200
Message-Id: <20180507124500.20434-6-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809522795461915?=
X-GMAIL-MSGID: =?utf-8?q?1599809522795461915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maxime Ripard <maxime.ripard@bootlin.com>

This adds support for the C1 SRAM region (to be used with the SRAM
controller driver) for sun5i-based platforms. The region is shared
between the Video Engine and the CPU.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 72433f38b4e4..6fa9e28edc59 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -135,6 +135,20 @@
 				status = "disabled";
 			};
 
+			sram_c: sram@1d00000 {
+				compatible = "mmio-sram";
+				reg = <0x01d00000 0xd00000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x01d00000 0xd00000>;
+
+				ve_sram: sram-section@0 {
+					compatible = "allwinner,sun5i-a13-sram-c1",
+						     "allwinner,sun4i-a10-sram-c1";
+					reg = <0x000000 0x80000>;
+				};
+			};
+
 			sram_d: sram@10000 {
 				compatible = "mmio-sram";
 				reg = <0x00010000 0x1000>;
-- 
2.16.3
