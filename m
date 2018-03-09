Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELu7mxUEOdPtz/uSHiYiJgZ8SCfwgO7CW3iyQcb7h0MHn9TUq2gxeJsSGVJDX/X/IyNKpMwI
ARC-Seal: i=1; a=rsa-sha256; t=1520585165; cv=none;
        d=google.com; s=arc-20160816;
        b=jeSOhW/oGqpqwZUFGOWH3XF6nOwdv/6w8Rlr3wynOO36YLY2MH3oRsCTaO/dv5xMCr
         /k/L6bNye5sFUuYNEqKRhGTEg8mvvdyJQlw9y06mgpswIaDWuF2LaHbTr3Wza9d4p0uD
         tpuKvnL8kaKHmqrFTrO19DDZ6HddwGA2eKdSLLv572KPh0EMIQEfIGegrCJPOawhIetz
         gsRcIDjcfcBLbGQPBEgZ7zMQt9UwH0+UTQwHIrhuTkESDcTmFsJ290bUcJOgxlH45jkC
         0lZZoYnYbdUglNdaHdLWHcslL8Br7fAp1rAhZy0mTqK7uOyqctsllLg6gRydkHWX3aaz
         Yx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=E3kv+mGR12tVt+SN1GF1RRZvuxcUl7vKFNvK1uECuBA=;
        b=Cn6Ie2THHWbRQuPrePPPRvhZENm/t/0Q6ioQa1dert7XLzv/zaVa4SzZPEgn6bQY24
         YeMJJjs4GlrXHzgS/M8TUVgrFrebLMWfd//fOytu4XutUprx5hoD1mIuPusmQGYe6+1N
         6watb4U6m+2r0zrn/VtzHjmivV4HQH2zg4os8mAQKAcn+JJ+asLxT1Z2Rb+qhZKGk961
         UuTzEfYEKlZiy5t58pt3pxwhK+rPVjoZudg46hIii7ehSPcRQJSc8IrqbzTb4VPe+6Jt
         N2WtTZuFhi6NKFWKFqTTdnygDyH4ZAZT1dJzu0irx/Fa0DhDrrfUUNesdSi4rtGsJYd0
         1apA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.21 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.21 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <908b49015ed0b0c8654ba686b6ad74d6>
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
Subject: [RESEND PATCH v4 3/4] clk: lpc32xx: Set name of regmap_config
Date: Fri,  9 Mar 2018 16:43:50 +0800
Message-Id: <20180309084351.32009-4-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
References: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594449109397082422?=
X-GMAIL-MSGID: =?utf-8?q?1594449109397082422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

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
