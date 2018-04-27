Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933051AbeD0XAd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 19:00:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44952 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbeD0XA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 19:00:28 -0400
X-Google-Smtp-Source: AB8JxZoIbxtLXKpYK8DXKLzUtUR1E35berOvXOi/G/3BPWS/rkFQFCU/vLz2YKsPpnhXmHyzpJL4Tw==
From: "Wesley W. Terpstra" <wesley@sifive.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH 1/3] dt-bindings: added new pwm-sifive driver documentation
Date: Fri, 27 Apr 2018 15:59:56 -0700
Message-Id: <1524869998-2805-2-git-send-email-wesley@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524869998-2805-1-git-send-email-wesley@sifive.com>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new PWM device tree bindings for SiFive SoCs.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
new file mode 100644
index 0000000..7cea20d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -0,0 +1,28 @@
+SiFive PWM controller
+
+Unlike most other PWM controllers, the SiFive PWM controller currently only
+supports one period for all channels in the PWM. This is set globally in DTS.
+The period also has significant restrictions on the values it can achieve,
+which the driver rounds to the nearest achievable frequency.
+
+Required properties:
+- compatible: should be "sifive,pwm0"
+- reg: physical base address and length of the controller's registers
+- clocks: The frequency the controller runs at
+- #pwm-cells: Should be 2.
+  The first cell is the PWM channel number
+  The second cell is the PWM polarity
+- sifive,approx-period: the driver will get as close to this period as it can
+- interrupts: one interrupt per PWM channel (currently unused in the driver)
+
+Examples:
+
+pwm:  pwm@10020000 {
+	compatible = "sifive,pwm0";
+	reg = <0x0 0x10020000 0x0 0x1000>;
+	clocks = <&tlclk>;
+	interrupt-parent = <&plic>;
+	interrupts = <42 43 44 45>;
+	#pwm-cells = <2>;
+	sifive,approx-period = <1000000>;
+};
-- 
2.7.4
