Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZpayyiwpHNUPL4Lw40+ktZ1e/D0BtT9TB86H8RpoefDS3Es5afFCOf1fvJP+wh2bUWcrVlF
ARC-Seal: i=1; a=rsa-sha256; t=1525697256; cv=none;
        d=google.com; s=arc-20160816;
        b=mdDAJQy/swUyFeXWOKIEIUteFAKsezjxfN0sQp/6VwAHAUx4SQAp1sF+ZjGqK9kVy5
         G9GgNOTiCWGHAkv60gNKZNgczO7yYzkHbGKbbxv93g2c4WCPQ9MWhlK5m/M1Ap+npTtR
         alf9gmcOyZwLKCjC9ZtAxJkYmPhcwqB5pLtl72h680BFFbRf5HFeD2z7UGFAAxI5BPnn
         OMbiBPRhtE+kkM8uGWop+SITEJ2KHMNAFDu6Xb5gSuJHuqSvz40A1TOYnC/KWCqQHXiY
         dkJkP9j2z7EVYKLUVvZtUmX+sGAH2Cxi1DFhM87VzTkbuzwn/eb5NvGDSQVgJ6eKuAB8
         Z7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=sgxIwCx7V0yiftA4rAZtA9D+vl5NcBd3lFkmF+K+sk4=;
        b=uSYxEBIs7vSHZJdQ3p/MO0Dy2fdJF0/5TuXuyZScAy8H/zReAEHB6EDbr4T5CNmfyc
         dqWmBCvmoAEDoYM6rriR20OyNQa0pxfwozd5T80MPdrN4GKhjVCWCkAL9QY7dq92Cllf
         NxXmk3AwTc7qx/DmO2VoC8QL1QJSdkLJJWl4Tb5wouIBHjrfDO4NT3ZdtOKCzgI9ltAV
         Sj2zH98Wv8uf4bfYNp08db5jiJB5ee1G9qJqhxBG6/UQnxBK/cerv6D5ZpPyf6WqyitJ
         qfPicQq19Ta7CTrSQvdjFz6kEofKqeVfnSVtEEFSf9U+4wqRgEV9ydluQYu4XUDzJM2G
         2Oyg==
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
Subject: [PATCH v3 10/14] dt-bindings: media: Document bindings for the Sunxi-Cedrus VPU driver
Date: Mon,  7 May 2018 14:44:56 +0200
Message-Id: <20180507124500.20434-11-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809526277615436?=
X-GMAIL-MSGID: =?utf-8?q?1599809526277615436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds a device-tree binding document that specifies the properties
used by the Sunxi-Cedurs VPU driver, as well as examples.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../devicetree/bindings/media/sunxi-cedrus.txt     | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/sunxi-cedrus.txt

diff --git a/Documentation/devicetree/bindings/media/sunxi-cedrus.txt b/Documentation/devicetree/bindings/media/sunxi-cedrus.txt
new file mode 100644
index 000000000000..4c3f2b596ded
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/sunxi-cedrus.txt
@@ -0,0 +1,58 @@
+Device-tree bindings for the VPU found in Allwinner SoCs, referred to as the
+Video Engine (VE) in Allwinner literature.
+
+The VPU can only access the first 256 MiB of DRAM, that are DMA-mapped starting
+from the DRAM base. This requires specific memory allocation and handling.
+
+Required properties:
+- compatible		: must be one of the following compatibles:
+			- "allwinner,sun4i-a10-video-engine"
+			- "allwinner,sun5i-a13-video-engine"
+			- "allwinner,sun7i-a20-video-engine"
+			- "allwinner,sun8i-a33-video-engine"
+- reg			: register base and length of VE;
+- clocks		: list of clock specifiers, corresponding to entries in
+			  the clock-names property;
+- clock-names		: should contain "ahb", "mod" and "ram" entries;
+- assigned-clocks	: list of clocks assigned to the VE;
+- assigned-clocks-rates	: list of clock rates for the clocks assigned to the VE;
+- resets		: phandle for reset;
+- interrupts		: VE interrupt number;
+- allwinner,sram	: SRAM region to use with the VE.
+
+Optional properties:
+- memory-region		: CMA pool to use for buffers allocation instead of the
+			  default CMA pool.
+
+Example:
+
+reserved-memory {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	/* Address must be kept in the lower 256 MiBs of DRAM for VE. */
+	cma_pool: cma@4a000000 {
+		compatible = "shared-dma-pool";
+		size = <0x6000000>;
+		alloc-ranges = <0x4a000000 0x6000000>;
+		reusable;
+		linux,cma-default;
+	};
+};
+
+video-codec@1c0e000 {
+	compatible = "allwinner,sun7i-a20-video-engine";
+	reg = <0x01c0e000 0x1000>;
+
+	clocks = <&ccu CLK_AHB_VE>, <&ccu CLK_VE>,
+		 <&ccu CLK_DRAM_VE>;
+	clock-names = "ahb", "mod", "ram";
+
+	assigned-clocks = <&ccu CLK_VE>;
+	assigned-clock-rates = <320000000>;
+
+	resets = <&ccu RST_VE>;
+	interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+	allwinner,sram = <&ve_sram 1>;
+};
-- 
2.16.3
