Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZpPc6qL7GEzNKErzDsIwue+lD+6NNjkAjKPRUH04YY9Vcwu2S+Xh0rbgUJZXT9SwzdRGJ0c
ARC-Seal: i=1; a=rsa-sha256; t=1525697252; cv=none;
        d=google.com; s=arc-20160816;
        b=W+JlSHuL1s7nJX699vhZyLOjGevfYabicfW+rPLtIdusuNP1rVUEsxNsCYX/HIoVJW
         fRZeRGdwEWWNJ3V11t32BdJmoCHTOCAAaGZKGWANlYo85EYedwgUy2tQ4wGlsBOkXOtV
         xyFi/P8NpIhhFboq9NnfdvxBo+IJQXtIKIgC4VebluwvMWt3BxcqjG4bm8mt4+BSHDft
         S8jGvhkJi8NiwhSsnh6NyRxm0naDEycR0hrXC+ow7EKQhH5zqPn2RyenefdRm+KSfQJI
         +c35mSgFDtCUtXgxJVT5HdOXSwD18qCq7gNZFKW42kTm6XOXh1sk2HCQKrlVco91bfFZ
         pfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gxi7gG12XYr0WQ4Z7ipFVhpME7zhWEM4aYHSxcLFNgU=;
        b=qzwFnu24X7K08f9cPZ0FmeyUlj8Bg2KiygaJr2nFvlZlCfoPg8JSNkJyuwLwkS3weE
         GRP598kJTAjx4HwNNknfdLk4J4SIfM5qbMNGYR5JT4zJAO6R/Yttvh5/Senl32aMr2Ss
         90rKDR8Rj19ECrKbbwTl11Ohx/koMDkTw7yGBvWC31m0KuTeFDN1eenTwtazZ9E+vpL8
         pxHyo/ulWDoxF7eCOxQfSyVJ/gMWW+ifIIevoiuYrZ8worotQfjo/Un6g19ldK0P06YZ
         blmB5p0ieh340ngi5sDKdCEQkqPKQGcF13uXY96p8dp4FR5hiYaVL+mInCZZy2C42oyP
         GKKg==
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
Subject: [PATCH v3 03/14] ARM: dts: sun5i: Use dedicated SRAM controller compatible
Date: Mon,  7 May 2018 14:44:49 +0200
Message-Id: <20180507124500.20434-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809522077574994?=
X-GMAIL-MSGID: =?utf-8?q?1599809522077574994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the newly-introduced SRAM controller compatible for the A13 and
other sun5i platforms instead of its A10 fashion.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 07f2248ed5f8..72433f38b4e4 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -115,7 +115,7 @@
 		ranges;
 
 		sram-controller@1c00000 {
-			compatible = "allwinner,sun4i-a10-sram-controller";
+			compatible = "allwinner,sun5i-a13-sram-controller";
 			reg = <0x01c00000 0x30>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.16.3
