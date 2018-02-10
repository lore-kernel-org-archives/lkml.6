Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBJLLU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 06:11:20 -0500
Received: from regular1.263xmail.com ([211.150.99.138]:57861 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeBJLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 06:11:18 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <7c08eb103ec574ce43e27d867235501b>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com, dtor@google.com, dianders@google.com,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Emil Renner Berthing <kernel@esmil.dk>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Avoid wakeup when inserting the pen
Date: Sat, 10 Feb 2018 19:09:07 +0800
Message-Id: <20180210110907.5504-4-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wakeup event action for Pen Insert gpio key, to avoid wakeup when
inserting the pen.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 191a6bcb1704..ef2de0057c5c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -134,6 +134,8 @@
 		gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 		linux,code = <SW_PEN_INSERTED>;
 		linux,input-type = <EV_SW>;
+		/* Wakeup only when ejecting */
+		wakeup-event-action = <EV_ACT_DEASSERTED>;
 		wakeup-source;
 	};
 };
-- 
2.11.0
