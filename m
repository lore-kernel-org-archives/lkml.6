Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AH8x224m30xmu20bpBZa9OBgjWl7H5h0NFVmBO0xY8LWov5iFb8g/YWU1OOI5ROIDiXvpiiLjORm
ARC-Seal: i=1; a=rsa-sha256; t=1518177348; cv=none;
        d=google.com; s=arc-20160816;
        b=jES/RkzBO/IwaqteW3/Mmeg34q/mPI1nCvywdUJTO7djpacT7nMqQu7tmvtKPBLyaJ
         yVN6RYnVT1MKujWlhBPoH1b+I27uFvuNUHrt6jaIdaHYKfiEe0ej2mddWPBJyeBqgrLB
         AH4HxVfO0v5PvWcvqM4tipnOKFAgUdX91eYRdCSPGEuJnu4zLJmLmtVrSC9sXTCbowvC
         HrzFA4HRTWOBoEVItzD5PU8AJhlWsanwdMjMFrf055+IrSyHnZvfelT1R8yH12tYhUpE
         QMH9ZLBHVT3Pdsm3/X1SXJn3xY+DE/BKgeRt/dBHmH83iOUPrKCWjNWo4TohCOwWUDZ9
         2j1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=LeKB8CQTGidxopG093AvLCXkJhQtmhNzhfWi31UWc1w=;
        b=hK4RpOgXncXIZIGtMmbEy0riHtQY2hmquC+Qpw9G9cp03sBR7l0f892BXI0dH2a5Xu
         gkwVE8uo4VaaT3J40oEBYeFDigwoG9fBk7a9EdvfYOp5bVr5vpWz6KHOOhYj1Hi8ZEDx
         s/Prz+lOGVqJ8ZEa4qvRxEWOgFgDGBBfoxBBLCgxqfv35uwDm8noJBwPMRr9lm53MrFi
         tGokp7SqraGQKz0KwsDBcIYJdkyby072LOHat7jpmQ+W4nGT5BTjC/ALd1M3J8jMKCvP
         Om5blhZWHCJVftMx6LN9RiCDgiybGY5F6pVmzPOFLzYuzWRGkvP7RjS+X7OGzSZb+xMH
         5tOQ==
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
X-UNIQUE-TAG: <e181df13398397706a4d16b8051030ca>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com,
	dtor@google.com,
	dianders@google.com,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Guenter Roeck <linux@roeck-us.net>,
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
	Matthias Kaehlcke <mka@chromium.org>,
	devicetree@vger.kernel.org,
	stephen lu <lumotuwe@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/3] gpio-keys: Add support for specifying wakeup interrupt trigger type
Date: Fri,  9 Feb 2018 19:55:07 +0800
Message-Id: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591924330873383134?=
X-GMAIL-MSGID: =?utf-8?q?1591924330873383134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On chromebook kevin, we are using gpio-keys for pen insert event. But
we only want it to wakeup the system when ejecting the pen.

So we may need to change the interrupt trigger type during suspending.


Jeffy Chen (3):
  Input: gpio-keys - add support for wakeup interrupt trigger type
  Input: gpio-keys - allow setting wakeup interrupt trigger type in DT
  arm64: dts: rockchip: Avoid wakeup when inserting the pen

 .../devicetree/bindings/input/gpio-keys.txt          |  9 +++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts    |  2 ++
 drivers/input/keyboard/gpio_keys.c                   | 20 ++++++++++++++++++--
 include/linux/gpio_keys.h                            |  2 ++
 4 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.11.0
