Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELulysFfVPJJF68TCU867ioriuJrcy/PWbpWhx7qwElBjOi+lSJZU/3qoY3oMeYIYu69ZmnO
ARC-Seal: i=1; a=rsa-sha256; t=1520322290; cv=none;
        d=google.com; s=arc-20160816;
        b=ENHHCAMscstsaAV1Lq0bgsNaw8K/tBQyA571v6Rr7mHfWgbrp+GgNKf2ej5y+CyofR
         cvW0NLmL7rG1CdwZVFG55zWMZdogAU6HN2XF5kHT6ZnGGMSqzSWa+8HbEIEb9jnHjKI2
         Ngnzm+yVuqDBwnCk0f2eGXSXWisBzC0QdKoKvYHv09kOU2C4yhDHFuLVZoh+4drXJ+zw
         6kXbULop2TrhngS9/BDqWvAlKGtxqG5bb8EtUSCeVkrozbTDOIXX5AEx62pmuIRBJ8N5
         FEZXXwYLNvQZXRL3V6icNR5ZQXFfq1g5lCIvWkCiqK+kQApV713Yaoqe/cUdnECOh9w5
         M9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=rHiy3/g92nvimJUuD/aTIwvqAiUSGUAvk9vZm2uQLfo=;
        b=F9PJm8nZm+3qtK5WvWjIGENXkVhzCOHj+X6YzogrmYfu2vf5rFN6wD43ZN84UJdpLW
         BZySmDB2YUKSwe+aHsUkUumt5LWci3Mqx4Z8r41MYHE0HpvwH+p/9bAxQec+F57wnDal
         CU29ZViLxWYP+AncTjp6NvR+54aOu3JvcQD+O/4buUww7dq1SrJh71KLafQ5muqZEMMK
         5qXnhc/7pK4jjVnC9jnbOydNkrI+XtoJxYOxktlZa03tDttpmh4BherUrLXMNbFQ9rg3
         SgJK2hJ2cN/UZ09BCsBsfbcYfCkenp0hU2TbiA7HYSmFmPKFBH6RbYMH915cn4ZAr04H
         nLew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.12 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.12 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <6d08752ff64f824b5967f34c120b948d>
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
Subject: [PATCH v4 0/3] gpio-keys: Add support for specifying wakeup event action
Date: Tue,  6 Mar 2018 15:44:15 +0800
Message-Id: <20180306074418.8879-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594173466215616151?=
X-GMAIL-MSGID: =?utf-8?q?1594173466215616151?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On chromebook kevin, we are using gpio-keys for pen insert event. But
we only want it to wakeup the system when ejecting the pen.

So we may need to change the interrupt trigger type during suspending.

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
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  3 +
 drivers/input/keyboard/gpio_keys.c                 | 67 +++++++++++++++++++++-
 include/dt-bindings/input/gpio-keys.h              | 13 +++++
 include/linux/gpio_keys.h                          |  2 +
 5 files changed, 90 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/input/gpio-keys.h

-- 
2.11.0
