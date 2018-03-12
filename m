Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELsQEOjsGbOQ3MVu+6LY5TXFJ+P5h+eUE9z1OAQzMvbTF9EqrleFYBg9M09eslW3OfvagfGA
ARC-Seal: i=1; a=rsa-sha256; t=1520848367; cv=none;
        d=google.com; s=arc-20160816;
        b=C+D1lfFvOPq8kf3clb+DHKE+FtbDgNJMe1WY48s0l4+dk6H8xUW7QCB0YfZKFkWJqZ
         +jJB5qmNoPLQQ5DloZ5IYbR6xf9TfsMsWZiOpeCspacXkfmJ4P1pdo1CCK9okLhIaS9h
         HyqQJ+LxRPs2dz4HqoeUcGTBjO5xy0nIPDp+8mCqRzQ4r3iRasXW86AVJllU9ER4rRJE
         HWx+D7meknUcFV16oVVXhi1KWBIaSjJqZ3LXBCrHbTEGBGfbUu1GLLSreR16Mkxj2feV
         BOXratLfLUj96ByFGEXhrALwui3ZTv5LqIr/3nkOP4xmO4HRfXp42LgcIIA/eszQUGS+
         TIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=k00JDhweUI5wQomvIaZcuFSotOkCJxhmn3JYFxDVE8k=;
        b=G0sImHZQgtm+0Bkj/eQK3YDnw8dPlFaq+5Hvj1ygH/4yJhmKw05AvbszkhUNu9b4h1
         9Q9yU0EtVp53wEP1Vq8+eNEJX73UeiAAOW9LRCL26xF2wKaRvKFzN9mCqFiKTZlt94mB
         4C4us1QjeuD3rgN2chOKCprmyMbDQHN29rcY49D3/uA0R+8WZ9rgkj01Sano6IQcn7er
         vpAyCxAjwvxuPM9dmZn7Wjuk8BQUxXZBEmZ8JbNdf7TqELdWHyINnWojn3jUUY2JrQhC
         yCZGGtR1bfyEcekCxTR6HNMq34WO/6AexmhcU5ElPVjzavaaglHDrtAdmpLchlKXXs3a
         Ok1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.18 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.18 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <3f0b703c7f5a813160aa9503ee1c897d>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com
Cc: Guenter Roeck <linux@roeck-us.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Joseph Lo <josephl@nvidia.com>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	lee.jones@linaro.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Heiko Stuebner <heiko@sntech.de>,
	Brian Norris <briannorris@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	linux-rockchip@lists.infradead.org,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	devicetree@vger.kernel.org,
	stephen lu <lumotuwe@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Gabriel Fernandez <gabriel.fernandez@st.com>,
	linux-clk@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v5 3/4] clk: lpc32xx: Set name of regmap_config
Date: Mon, 12 Mar 2018 17:51:41 +0800
Message-Id: <20180312095142.30854-4-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594725097578676295?=
X-GMAIL-MSGID: =?utf-8?q?1594725097578676295?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/clk/nxp/clk-lpc32xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index f5d815f577e0..a2a0a7f3bc57 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -67,6 +67,7 @@
 #define LPC32XX_USB_CLK_STS		0xF8
 
 static struct regmap_config lpc32xx_scb_regmap_config = {
+	.name = "lpc32xx-scb",
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
2.11.0
