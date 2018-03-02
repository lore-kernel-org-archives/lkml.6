Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELtM0yasfBFIRbVBMtHF3gAkRVnJ1nEr9ij0U0Vyvic+njVNC/ivBngHfxFf78ClSCTWvCMN
ARC-Seal: i=1; a=rsa-sha256; t=1519962706; cv=none;
        d=google.com; s=arc-20160816;
        b=xQMLgaNxIL5TE/O9vHP7H0aWmtJ82JEMN3ClV9KEkT0WlvYrF712AXByx5bRrEQTQh
         GZ+nuNQspDAYTzuZYV/aSrukSSQfvme1MCbsoNrzC6l5sbxQt/8zqZ6JtOTQZenCBeEn
         6ZYumfPvxDPB5JiPvo5ogUZsji9A2HSMmt8rf/BG5XWyq1BiTEwwtr8KhfaCyl6r7rxZ
         myY5IQzcR92twrVMPGxbhYGina7c0KAqgyIsgeGE6xom8V7l9fE1VUIZjDs4qPBeNOOm
         3QZzXkOm7HnJvaZHDiyPBJNM/W+qbiSeK3R3uQwbO3h+15RonoLOe+c6l646xcCcx8Fy
         XVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=xN1nZkbsy/FXN6oh0zEn7n4iJVz5npzRrVrkLGDnaGQ=;
        b=i8BBEvOaU1LBgJ+ZKld67o176SE6csQowa8xCDL1HzDXDFyui8vQeW7TslkqyHI+SY
         Dx3BVHzd0BRcG1HVshq53zXmcMlSP7iJG3h2NFl4ol+JdIYNFaFqR04iseb/W00zsqE7
         qEyxEj0rEVE0MvrUvOG8LcI6fAeBrZEgiuNFWPHXQvs2tnM7zPOyHXGHooK0zOi1fyt9
         5dOuW1UuW69oIudvZ4dMyPunY/pooi86gjvy7ElJoe0cSh75RNLwO2okpDYlVn2eifG1
         1EYqouwgnLKT3MdZCbzR2Riw9LHkCSjvTPNwW7/Wr95d1gEM4vUeX6FyTHnGnyp0BLHp
         D0tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.25 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.25 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <9a10a6e118595b04a2a76f7962c4bfc0>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com,
	heiko@sntech.de,
	dtor@google.com,
	dianders@google.com,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Joseph Lo <josephl@nvidia.com>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Yao <markyao0591@gmail.com>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
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
	Emil Renner Berthing <kernel@esmil.dk>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/3] gpio-keys: Add support for specifying wakeup event action
Date: Fri,  2 Mar 2018 11:50:59 +0800
Message-Id: <20180302035102.10084-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796413605255897?=
X-GMAIL-MSGID: =?utf-8?q?1593796413605255897?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On chromebook kevin, we are using gpio-keys for pen insert event. But
we only want it to wakeup the system when ejecting the pen.

So we may need to change the interrupt trigger type during suspending.

Changes in v3:
Adding more comments as Brian suggested.

Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.
Specify wakeup event action instead of irq trigger type as Brian
suggested.
Specify wakeup event action instead of irq trigger type as Brian
suggested.

Jeffy Chen (3):
  Input: gpio-keys - add support for wakeup event action
  Input: gpio-keys - allow setting wakeup event action in DT
  arm64: dts: rockchip: Avoid wakeup when inserting the pen

 .../devicetree/bindings/input/gpio-keys.txt        |  8 +++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  2 ++
 drivers/input/keyboard/gpio_keys.c                 | 39 ++++++++++++++++++++++
 include/linux/gpio_keys.h                          |  2 ++
 include/uapi/linux/input-event-codes.h             |  9 +++++
 5 files changed, 60 insertions(+)

-- 
2.11.0
