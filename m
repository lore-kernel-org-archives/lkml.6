Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELtF1VbRky+XT7xxWdrOUZZYHHoiSh7Qm3Nz/ecUD9gYinXfLCC5gvyP4hUUAfj538deqZQo
ARC-Seal: i=1; a=rsa-sha256; t=1520585109; cv=none;
        d=google.com; s=arc-20160816;
        b=P7Cph1wC52HOZ9gdrZj8mPhBrbSB4p18YEww9u7OhxetQSaTER4QTEHrmNyyVHKRHq
         HrWPPqMhjCeStbW4HMPI4MY7CjW77M/nXpkEZ0GM2/5yJsEXY35DHMBqWiMDxXx/2muY
         cQjD3/tkRKujhQAkWC0p32Z1g//wABa4oxxLilRwWfel78oXUcxH5PgINUkmVEeO6HeB
         nFBUyimxqaaMgEdixdsBKf7Cr2xoFPjfp00W00+VXHcJWw5ZS9oRs0chZu5ItKJEpr5A
         BdT4/r7J+NixW02M0FQNHmfw0rNfYBIChT4a//lGegCVmcpseeRjOR4VeaYJE/+fWQ8k
         q4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=ugN1saNeDXORmUf17Sd8cKGATwssbR4XGmJkAoMCGrE=;
        b=NHZf2yrgxFlRzdNj0AUkIDzL4QZtqV502wSk+leAabOMt1kAmBgrmhKTmo3KAyOgri
         kYs7GXNz6GoteWlEbK7I2JAXEs26LxuizeRQAKiYFz7kCQtk7z2OZtgYuV2obGVjAQm3
         h+MoGbYBh01vqsdPRpH+Hnb7QqYfvViwYKZ8ILzMjmG4BXEDIkCOdSqAH3qw5iT5U+PZ
         m+2QliDVfqY5ZmFRCYzKI8dVVatgAPM2gPRytVswt8jUBeag5qmNlLmb8TlhCrpwdhSg
         Hyzjs5hecpVhX7Q3tbiALunVQVuwTkLagN04jvrhN8DyqdtD6SLaQX7gICPvRpOC8lGL
         idFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.24 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.24 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <9631457aed92c8818697badf8219d971>
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
	linux-rtc@vger.kernel.org,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Stephen Boyd <sboyd@kernel.org>,
	Gabriel Fernandez <gabriel.fernandez@st.com>,
	linux-clk@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Russell King <linux@armlinux.org.uk>,
	Lee Jones <lee.jones@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [RESEND PATCH v4 0/4] Set name of regmap_config
Date: Fri,  9 Mar 2018 16:43:47 +0800
Message-Id: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594449051425323365?=
X-GMAIL-MSGID: =?utf-8?q?1594449051425323365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


After 9b947a13e7f6 ("regmap: use debugfs even when no device"), we are
allowing regmap to create debugfs without a valid device. Some of them
would end up using "dummy*" as debugfs name.

This series try to set names in some regmap_config to avoid that.


Changes in v4:
Not to use rtc dev to init regmap, the gpbr is not directly related to
the rtc.

Changes in v3:
Modify commit message.

Jeffy Chen (4):
  mfd: syscon: Set name of regmap_config
  rtc: at91sam9: Set name of regmap_config
  clk: lpc32xx: Set name of regmap_config
  ARM: rockchip: Set name of regmap_config

 arch/arm/mach-rockchip/platsmp.c | 1 +
 drivers/clk/nxp/clk-lpc32xx.c    | 1 +
 drivers/mfd/syscon.c             | 1 +
 drivers/rtc/rtc-at91sam9.c       | 1 +
 4 files changed, 4 insertions(+)

-- 
2.11.0
