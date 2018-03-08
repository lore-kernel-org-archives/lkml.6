Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELvIG4VxkVMGpdkgjJFK4FwMGKBXdmDyqgcG0Zkg6LO5ORKegLpemEOE/HXBK18UupIxu+l5
ARC-Seal: i=1; a=rsa-sha256; t=1520494358; cv=none;
        d=google.com; s=arc-20160816;
        b=V16V6x9KnJsJu/FZe0mv84axY0DU0ocRlH2hhdYObJhv8rs8KRMBteDRYMiSoQlLdQ
         UPxBXeXKZ41Q2sbKTWOPCK/DjLWFQH8OtnpLBLBgisW9fkEN7ofrX8dyjO/iqT1Gj/vB
         rf4b7nRm91VMLoNR2fYWLE7i4p4U/PFGnLAnJYGHsLmkZrpI2vXzvUIu7U6bAUQ0lkNh
         OKzgRFjzTBBdI4lQlvN8+ci7zRXDgO8uE489wPnJD0tQrr2EaaXTmLOeVpU8flxpTQ7r
         ZBk9ZPVXm2+QqijDF8RjAJKPu2qwBDNvp0BAi4H8MpK554scTIKBcPokd+HiInsdj5At
         5HNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=b5XMop040f1T6xhoMdd33QkcesO5VU4qhNVo2HofzUo=;
        b=LNRE8YWVaBtE1ATb1+CgtE88tbzhPBCopbudS1fLq0tscwGah8zytBAtAyTsf/s5eh
         ZZL9RplGU4vNtK3V6DMbi47ma2JR41yk6fbY5zcqQzefWI4bJlu7o0VaalYXRnwJIY52
         Is31iFaf0WS3TtvgtvUGyg1pByI4inBjHNWwZj+4aAtfjbTFL5EbWXJYDH2u33hjR3Ti
         Wu24Keq1qJfUX+jpyHhOlDSynAvYxxXTbMmC+v9+FH5TqgxUBhMVEfpBa3hJNPmjCfXz
         w14zyxW8pL2kPfQ1niZRn/OejWUHe4/QXhP+cDBqTbHUmalUGsFju0wnEL6Jp+o1D9Cp
         MfZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.13 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.13 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <1d485442e60a007ee60408f07531de68>
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
	Emil Renner Berthing <kernel@esmil.dk>,
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
Subject: [PATCH v5 0/3] gpio-keys: Add support for specifying wakeup event action
Date: Thu,  8 Mar 2018 15:32:10 +0800
Message-Id: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594353892075991862?=
X-GMAIL-MSGID: =?utf-8?q?1594353892075991862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On chromebook kevin, we are using gpio-keys for pen insert event. But
we only want it to wakeup the system when ejecting the pen.

So we may need to change the interrupt trigger type during suspending.

Changes in v5:
Remove unneeded irq_wake flag as Andy suggested.

Changes in v4:
Add dt-binding gpio-keys.h, stop saving irq trigger type, add enable/disable wakeup helpers as Dmitry suggested.
Include dt-binding gpio-keys.h

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
  arm64: dts: rockchip: kevin: Avoid wakeup when inserting the pen

 .../devicetree/bindings/input/gpio-keys.txt        |  8 +++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  3 ++
 drivers/input/keyboard/gpio_keys.c                 | 63 ++++++++++++++++++++--
 include/dt-bindings/input/gpio-keys.h              | 13 +++++
 include/linux/gpio_keys.h                          |  2 +
 5 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/input/gpio-keys.h

-- 
2.11.0
