Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELvxt8RSY1fqny9I7yANcbxhse4HC7litHhJnRd/ctYypmNWSn3F4INAtfd+m0SW9A+cZ0uD
ARC-Seal: i=1; a=rsa-sha256; t=1520848360; cv=none;
        d=google.com; s=arc-20160816;
        b=YNmhfM6Xc0GcOB75ja63fMsvbhwcBUrDswyzN2EV6PBuiI6cKPUE5jvMMxy7+ElJwt
         hAXB7ybxx0cC6382UrAkOSD1ZSJuejs4633+lQ1EghxA/rgjtAxQU7ZptbpIp8xrq3bk
         nKcTvewb0Mro9uLH604W5o48hSOT/Quu60bU7STYnLrB9b1wgvHLYHip6JDevJwsjPK8
         tu6w/Dos0hkeFzYJEU/V8Mu5nQCC0+eZJ8kPoG4yxf3CPIHW2my2Y+UdNLJdj8noveRE
         /v5bXmbsgA9rnbyLbkDU8NOTQq9vLNWCX2usbSDLyGMAJi5kO7WLGWgZ0J0XWarKsTfl
         uPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3S2DHxaqCUG83ouj+24b7L8ps7g5gk3oWX9BsjnfTV8=;
        b=WDUuvWhqR+ES0yEACAxNw4FZaKnt16iFQeT4q84/xvyzaDwqDgsF+AiI+TzH39Azj1
         1YSKjBWyIlnu6xFr5u23sxNn47jHNM+vrcqiqh4LWGj/WxlqN9YRyl1F9liTAsNq9USF
         7sheMf09XDsXpUgFxeU+hrS+p39tl/NznuBlnDyDZc8P9VEoMWOSnFS3Qgh0IhMoQrQ8
         LORRRnRyX2JK+6FrPoDmsTPUVshrYFlpVNyGYQL8ZL1RomJ0CvNWlaIIOY//gA5B133i
         JUuV81Mz2wSTFms6wLwfgQU9CHZMOlZScniKgK1PlOj9JiS4a4FZdtaoHRwtBUoAxdcP
         e9/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.11 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.11 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <6dc16bf22685ae8efa65a66c2bcc9bd7>
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
	Alessandro Zummo <a.zummo@towertech.it>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v5 2/4] rtc: at91sam9: Set name of regmap_config
Date: Mon, 12 Mar 2018 17:51:40 +0800
Message-Id: <20180312095142.30854-3-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594725090849470563?=
X-GMAIL-MSGID: =?utf-8?q?1594725090849470563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5: None
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
