Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033267AbeCAQ4b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:56:31 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43216 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033036AbeCAQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:56:16 -0500
X-Google-Smtp-Source: AG47ELv6H5OYEZRV0TA8uhikQzaSyELEPbfp5C7ayFkYHfmyzED8jcitShqX1rbzZiswkmmZE9AFDw==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH v2 2/2] dt-bindings: input: Add binding for RAVE SP input driver
Date: Thu,  1 Mar 2018 08:55:27 -0800
Message-Id: <20180301165527.22274-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180301165527.22274-1-andrew.smirnov@gmail.com>
References: <20180301165527.22274-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Tree bindings for RAVE SP input drvier - an MFD cell of
parent RAVE SP driver (documented in
Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../bindings/input/zii,rave-sp-pwrbutton.txt       | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt

diff --git a/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt b/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
new file mode 100644
index 000000000000..e14e12d27772
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
@@ -0,0 +1,24 @@
+Zodiac Inflight Innovations RAVE Supervisory Processor Power Button Bindings
+
+RAVE SP input device is a "MFD cell" device corresponding to power
+button functionality of RAVE Supervisory Processor. It is expected
+that its Device Tree node is specified as a child of the node
+corresponding to the parent RAVE SP device (as documented in
+Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
+
+Required properties:
+
+- compatible: Should be "zii,rave-sp-pwrbutton"
+
+Example:
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu1";
+		current-speed = <38400>;
+
+		pwrbutton {
+			compatible = "zii,rave-sp-pwrbutton";
+			status = "okay";
+		};
+	}
+
-- 
2.14.3
