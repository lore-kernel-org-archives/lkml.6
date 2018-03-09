Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELucyX6Tzm1BoLu0QtOsZJL7odCIPdJecHI0C+8EZSOJ5RKPkOqZJat3ke9yf520YpO/Y4Iw
ARC-Seal: i=1; a=rsa-sha256; t=1520585149; cv=none;
        d=google.com; s=arc-20160816;
        b=Hco+BCSlnmEFln72+WsWcol3F7975ctIRogXQdZm7cSemeOg7ry3KuyOfCyOeFvbDR
         6lD1ANVsoxiUpFXVAk3e6ef1C0lgDlrPD9iHsZzN2mZ+GsSWxcu48Ny5sWk6DPscTiBp
         BhIXG/J55M/HP/xkNYPGLu4+wqyop2GkMJysaEuArZ828X1skAvOvDOoZIeAdCHlKFLg
         6ylhoYpONLVJzRix6AqQQTl6TEkpb4oZQUIc5kZkR0FCxxXEYo7U8uWrOuzfLEBySbCK
         oYmA/jMyckf1y2/TgY0zVI/j5MmWotOKGFpmvRauSw+D5ChSUdCmE9vsufyItos2I/0J
         3Cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=7Ip+hQEhapXMb4uV6ga7rXAGPTEnxXg8PptDLbkfBxM=;
        b=CcjdXfesMnW+MGWfu71hUk4LkZlFaPDeMDyqbQds4XfgZ3u89QBYlkTaxJq1B4Dp6W
         dRhEoFgmkNC1h63fRvCMGyV+XFbhcHTYQev7gbSKQjysrHZQR3XdDEb0BEA5jmGTrk24
         DoP+abiinsM/m8SsJmKGudpSkrmlBHiKSCkU0D0aiVmrtbqip8lYe+3rT7jmcTFFsUQK
         w7ucWOry5pToQiDAMXYKfrp/hwCD8sDRydUX4dKncfP1ITbCQWJE2NTSbYIYYh1/ebiw
         PzvUR2kDRQUL+lnOF3J+NlyiE1RLNG0fLwxxb7NhdbSkpvyY+bnrrS6BIhR1eWQqg6vc
         77zg==
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
X-UNIQUE-TAG: <e6f5af254cd7f3ace2c95cbc2d16da04>
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
	Alessandro Zummo <a.zummo@towertech.it>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [RESEND PATCH v4 2/4] rtc: at91sam9: Set name of regmap_config
Date: Fri,  9 Mar 2018 16:43:49 +0800
Message-Id: <20180309084351.32009-3-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
References: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594449093751226765?=
X-GMAIL-MSGID: =?utf-8?q?1594449093751226765?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4:
Not to use rtc dev to init regmap, the gpbr is not directly related to
the rtc.

Changes in v3: None

 drivers/rtc/rtc-at91sam9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 7418a763ce52..ee71e647fd43 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -349,6 +349,7 @@ static const struct rtc_class_ops at91_rtc_ops = {
 };
 
 static const struct regmap_config gpbr_regmap_config = {
+	.name = "gpbr",
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
2.11.0
