Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELvpwUX8GaEvhPh4xPlLTcLHxKVaWaxCi8SqK68ohgjrpeTW4grVTtxkL4bzfOfr6Tg4Jwm+
ARC-Seal: i=1; a=rsa-sha256; t=1520848352; cv=none;
        d=google.com; s=arc-20160816;
        b=hR3Bg+gqs8JU1PPTaf0LHsz0vNQbV21RnixJf+NGGt4LxH/gpGsTxBLp6riEu9CI21
         1KwPPOWpU22YWzi1zg4D5eSEuQqejZgfC/aWrA/OKxDvCGJyJDBq702scDrDQKo9H0PC
         RvKUpxPmsfjyMBv41mBt2o0rU+UOl0EzDItDfHKokcjNTSEVnJp31cCYLGhNZ/Hz/SkX
         PwKihdJ2h8zMMVrN92nZDC+L0mtOnWDpAqBT6h/Qh/thGVyqfUxV6su4OFek7S3WGJVe
         Zj7bgI6y6hf38ma2mMvGJLpjwa4p1ulXJ7vLpr15IYBWX1XQm9tGnMf2grfGxAHF9Uo2
         X4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=vrq9xPlpVoxMV8AosembuvntIVi+nofJ2Zn/WLKlg7A=;
        b=Qnycez4S5AYm+RBF/YiDg7KfiR0yX5VO7SxX++bZtRxW/Cgh2f5QZvDxTjbx9StHaR
         g5lSsIj+EauXbNc7wdaCbKOHnsULueGutXWm4DkVjYut1LUTWYrNYMCYpm9k2JYXmVne
         NiNOzlpopGCVLXbJeD8TwXFGDKv2b2XRqGu721ILIXz9lkZS84wWF0sjdnbYO7pYlrFt
         ida5ulFu8q0SHGisp0ywKhrkcZjDokBTln9Di70DimBTpg79f2uLw9aJ6suTz5cbPzTU
         Uy+olkjKLj0Q58Bf5rX8RszDefzfcFo50WVmgzPfoTdjAqA5r2I0wfboYTR8j4F03Uwd
         OTnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.14 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.14 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <26a21b388c7d413342f3b2ccfae2ac99>
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
	linux-rtc@vger.kernel.org,
	Sylvain Lemieux <slemieux.tyco@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Stephen Boyd <sboyd@kernel.org>,
	Gabriel Fernandez <gabriel.fernandez@st.com>,
	linux-clk@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Russell King <linux@armlinux.org.uk>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v5 0/4] Set name of regmap_config
Date: Mon, 12 Mar 2018 17:51:38 +0800
Message-Id: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594725081994949457?=
X-GMAIL-MSGID: =?utf-8?q?1594725081994949457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


After 9b947a13e7f6 ("regmap: use debugfs even when no device"), we are
allowing regmap to create debugfs without a valid device. Some of them
would end up using "dummy*" as debugfs name.

This series try to set names in some regmap_config to avoid that.


Changes in v5:
CC lee.jones@linaro.org

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
