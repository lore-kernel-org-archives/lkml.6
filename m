Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AH8x224kuwkFeFXSVI5MHX7yZSv1m2S63kOj2iDo07r3R1jHB0SnQsEkG3lTskZ17w0xKMSmQEew
ARC-Seal: i=1; a=rsa-sha256; t=1518260993; cv=none;
        d=google.com; s=arc-20160816;
        b=aZWUcu1KjmKsAg3TrRbfIfZqK8APUeR680ge1+UfLLlpRgq+4Suid9grqWyOfE8gqk
         OrE8GeRAO2kfrtriAuA5I79NuzHqPtrt5/aQGiQbQwWeZaZpEx0Uh3kbMfxRaoPsXdji
         /v93aU36FtpfXFhE40A++5MoL+wGAYOcTHltsqIGcbcXsBiZn1K4QExDTF/eB3lkMx2f
         uBccFcowWBpNm/Nn2FFreiDagpArF0aijQsADbUnolgukAMiX3LJOyew2XAzj2ZbHN+N
         GbcfcNHbN5Hx9S5fqwQJhgHQZd21kt3I+1lJC3kuP72GEASEA/kHP56SNJQWtCAdO/Za
         Q2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=o1+F/Wqs9uV+f23DvmEe91ZFq1mK/3juLpkB1n8sPyQ=;
        b=hApu5H2vQ4C7ubje93MckExBWf+63jPGPwo/+VreY6X6eKjnscyYg619XGVtDH0A3i
         oVdSz57n94dIWb/sWYM3dlKOeayLNJYlB0bkM0cLCntvtgpws4w0024zpnGPA9zAoHDt
         3Fw/aBOQkfGyT79ZffI+viw5MMGyhSASy54LXQOMfDAd65BtRqp/Cj0leAhAfk5FBvtF
         Gg38NxHI7mq5vmtWT3SP8+WhFh38OzCJA9h+v2/h7ZTkfmrohMUiKkBrOGEShNq+1Swh
         VX5sWUN6/6SaZxiSaniLajg4TSgfTd/nEeb1f+Z6GCeBZPBjOl8p9mfcXQE/FAJH4HqD
         Pemg==
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
X-UNIQUE-TAG: <9781965f6bd348c5e5765e562243b24f>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com,
	dtor@google.com,
	dianders@google.com,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Joseph Lo <josephl@nvidia.com>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
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
Subject: [PATCH v2 0/3] gpio-keys: Add support for specifying wakeup event action
Date: Sat, 10 Feb 2018 19:09:04 +0800
Message-Id: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012039137400382?=
X-GMAIL-MSGID: =?utf-8?q?1592012039137400382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On chromebook kevin, we are using gpio-keys for pen insert event. But
we only want it to wakeup the system when ejecting the pen.

So we may need to change the interrupt trigger type during suspending.

Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.

Jeffy Chen (3):
  Input: gpio-keys - add support for wakeup event action
  Input: gpio-keys - allow setting wakeup event action in DT
  arm64: dts: rockchip: Avoid wakeup when inserting the pen

 .../devicetree/bindings/input/gpio-keys.txt        |  8 +++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  2 ++
 drivers/input/keyboard/gpio_keys.c                 | 27 ++++++++++++++++++++++
 include/linux/gpio_keys.h                          |  2 ++
 include/uapi/linux/input-event-codes.h             |  9 ++++++++
 5 files changed, 48 insertions(+)

-- 
2.11.0
