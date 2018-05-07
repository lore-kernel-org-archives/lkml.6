Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZoOZxPbswzKrL2ial2DQEsAcOmV1FyVJ+EsNHCtv6xYJ96rYx5gQjv1mCko1Ka3Evj40Pw9
ARC-Seal: i=1; a=rsa-sha256; t=1525697251; cv=none;
        d=google.com; s=arc-20160816;
        b=F/JHpYK7QHihs1AtpZn01Z407OmwJ56XIPnHChWHjSAscpyVYCfzEbSqepPfl0RvX/
         wVeOIcBN7e+5LWrwqul935pwzgQy1xAmekOcrPfuEiehDnYX/7Rr20nzCeHTCulIC/iq
         2ERBODo0wOvIDZSfqj4VlWGGhFxy4btbCC8DqtrxCJ2ZHQTPzgloZs7Rd7/9RfUbO40L
         oUENoO2SvQjqU4/XwLMll32Xl0rxrHucni0IarldqVfDKfR7xgL52oY3uuIhNFOAFhTI
         V72XibvQs7qiqkGIqrs1zFGeqX/Ew2wW+mH+elC0Cw/5XU6ujK2pczqRGVCyJTmLqTHC
         z39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=v8Bd1GAovCe6fO5aLnggs8gkJj2B8wdz9ZLBym8F/fM=;
        b=WOrwPLDpP3YHS12EVYfwOiWl0H19uh/RMdtWIpMHo7mvTw7F8JXAcM2/lk2gC1SNOs
         PXzecWRF4NumQhLiov63VeLP20IBi7SlhC/4iiBIA8bn8rdG6wzcm9K1mQAvAP08xCDt
         68/CcBSfAKicGplcDHSOMKotPrm32kP+E3mJQIWNt4H2TsUjfAS6TObOmGTVAvGSAe1L
         l4wi2ySytCAr9LW0HEa6MjQmw2jDNCiIwrp/sfT0R93oXy0V+8cFxueWlehkvJCWbm6k
         8115OIV/9jc1ylzkm0irmPdveHxoFGkpW1KqajIEi1nyaAlMsXfTucQ7uAIPofSvd1AK
         4VhQ==
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
Subject: [PATCH v3 02/14] drivers: soc: sunxi: Add dedicated compatibles for the A13, A20 and A33
Date: Mon,  7 May 2018 14:44:48 +0200
Message-Id: <20180507124500.20434-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809521273033296?=
X-GMAIL-MSGID: =?utf-8?q?1599809521273033296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This introduces platform-specific compatibles for the A13, A20 and A33
SRAM driver. No particular adaptation for these platforms is required at
this point, although this might become the case in the future.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 74cb81f37bd6..43ebc3bd33f2 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -315,6 +315,9 @@ static int sunxi_sram_probe(struct platform_device *pdev)
 
 static const struct of_device_id sunxi_sram_dt_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sram-controller" },
+	{ .compatible = "allwinner,sun5i-a13-sram-controller" },
+	{ .compatible = "allwinner,sun7i-a20-sram-controller" },
+	{ .compatible = "allwinner,sun8i-a33-sram-controller" },
 	{ .compatible = "allwinner,sun50i-a64-sram-controller" },
 	{ },
 };
-- 
2.16.3
