Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZo7C1vj7qco9XPmB/wk+zEHPK/3bXMbHoCvJNjm6/1NSkC8pgb/iHoCFXe8yzZRnWEeXrjz
ARC-Seal: i=1; a=rsa-sha256; t=1525697252; cv=none;
        d=google.com; s=arc-20160816;
        b=aDBTxa9CX4Pphseoy5jMKtv3xA3YTI0c7shSdvCBfeWPDmF8hcWoaXK6bzszwyZUsF
         gYEGsd9x4B20SzjeXqEz+8I1nSR9ZwonDJ8UMvP4lSvgnYc2uLK8vsSl5cH38DN5lNzK
         9McL4qQjfPBPVYzxRSmATZAg8BEM6chzv7CPhT5gG1wQbtDE5pgf8658ke2U1052KJJT
         v5AyskpeZrtWWBXPO+t2oSVq/6bUsfUw1CH//R0L3qAm9Z27GKQQeYtIPSMEqjenPT6O
         qduhOlO/4qFmlCtmVzgCvmnxeYkgD0HJ+PxAGr6+JOvNxVI4oUVPuayTLvkWI/ZVDTQf
         wO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Oi/EU8GZvzwn8MW/bDtmUdP5rvUjzbrvSUkj3WSu8zo=;
        b=jpmGYfuaRN1oZdLSEhV7jAYGycRhqPVEBaxgD9+TPYnrjSnUgWzcRZmB4IVtwZHU/d
         WjIm8SxxlbbVNggz+fvbptPqZA01dzr6mh/6uOblrxg7YqmWujWpvKbMUViRs2Clb3zL
         NrrgbD7UVOpIz52UAkolF99oHfe6wY5K3iO3NM4hC/73BkOKbLehIuUV5nU6le/s5Wf3
         LTKUEQEhmzF5aPUuvZ07SYOyTe8Bajy3zJkVL7E7OMrHMVvWWSXcZWmfI3VZoNt93c2R
         Tqa/ojcwovKbC90GhOukN6Ch2Mg6KnavtfmW7aG3JCti+As0DgQe47/2hFq1/f+YxRnj
         dRaQ==
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
Subject: [PATCH v3 04/14] ARM: dts: sun7i-a20: Use dedicated SRAM controller compatible
Date: Mon,  7 May 2018 14:44:50 +0200
Message-Id: <20180507124500.20434-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809522188381521?=
X-GMAIL-MSGID: =?utf-8?q?1599809522188381521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the newly-introduced SRAM controller compatible for the A20 instead
of its A10 fashion.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e529e4ff2174..b179e05408e4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -240,7 +240,7 @@
 		ranges;
 
 		sram-controller@1c00000 {
-			compatible = "allwinner,sun4i-a10-sram-controller";
+			compatible = "allwinner,sun7i-a20-sram-controller";
 			reg = <0x01c00000 0x30>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.16.3
