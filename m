Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526036971; cv=none;
        d=google.com; s=arc-20160816;
        b=ebzPgfxO84aeeHkCqrztqjoC0nOU4xTpQVVsBa8fJIAWjpYYMjomeQaRbUI4LJAmWX
         nPRUK29RLAMBcrXADOkeyEr6EQ1eVz6Y+iie+jj/fWi0e55ilEUqxU3GUQzaNgJkrNYh
         mriITiJj0rpx7kBmqFd9H1ZgxwUdF+uR90dfVdj/8LXX4J6aWcyn7vpYhsyuurRNaLW5
         NW72PyDDHzKU+CP6IvEIxVwBJc9aruNSWUT0rgvjIqJIROg+cvDy6RP8iAuoy6nXq/GT
         k8FyvYLQv+sn3n32DyDIeX1ph1mdGSxq//0SCE0us3X59B3J94ttGrX3ic6PvJz/Vi5d
         XDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=e5VkeKyjspWx0gNrw1JAcgyTe6NRKcWiRvuIotTcpwU=;
        b=yO5S5xFr1Yx8fkOQx9fCN9yEvHIaN4Fjo0riE7tMHJDnk6ZyehwzwXnrvBTmsFfxOS
         bQhaeKj48oqXTbplmPSVrgaYcP6nQfNogNhT/cDeaZFBeYw3U+3Iuww/Pi/myyQq+Aaa
         jDNf2mmMW5oV1nNa44dtRLVNHeP8BhIRSCuWL3HsJuJWPfb7vG339Y/I6NblEd4ygK3u
         wxRNeiOl7eMqIaJ6F4DZwnjN2osFx8DDTlE5sb6FielDrjoQLPP8uCnrT1ZwcqYG6wPu
         p+fdNZ0A0te+IZBS+EFYl7FaRp8I1AkF8DxxN3BWL4dK5RUn+HinHVF4MDgxQ+NVjz6O
         8MmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YBPWXBdd;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YBPWXBdd;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZopum+6EOSsnQbD5qbgpI1tjeYLHLk5SIOEntk4xcG13pR5no01aTR7zoOKrCATtX4FOMsN/g==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Chris Healy <cphealy@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Aleksander Morgado <aleksander@aleksander.es>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 2/8] dt-bindings: nvmem: Add binding for RAVE SP EEPROM driver
Date: Fri, 11 May 2018 12:06:57 +0100
Message-Id: <20180511110703.4924-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
References: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600165743775017377?=
X-GMAIL-MSGID: =?utf-8?q?1600165743775017377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Add Device Tree bindings for RAVE SP EEPROM driver - an MFD cell of
parent RAVE SP driver (documented in
Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Aleksander Morgado <aleksander@aleksander.es>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/zii,rave-sp-eeprom.txt          | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt

diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
new file mode 100644
index 000000000000..d5e22fc67d66
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
@@ -0,0 +1,40 @@
+Zodiac Inflight Innovations RAVE EEPROM Bindings
+
+RAVE SP EEPROM device is a "MFD cell" device exposing physical EEPROM
+attached to RAVE Supervisory Processor. It is expected that its Device
+Tree node is specified as a child of the node corresponding to the
+parent RAVE SP device (as documented in
+Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
+
+Required properties:
+
+- compatible: Should be "zii,rave-sp-eeprom"
+
+Optional properties:
+
+- zii,eeprom-name: Unique EEPROM identifier describing its function in the
+  system. Will be used as created NVMEM deivce's name.
+
+Data cells:
+
+Data cells are child nodes of eerpom node, bindings for which are
+documented in Documentation/bindings/nvmem/nvmem.txt
+
+Example:
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu1";
+		current-speed = <38400>;
+
+		eeprom@a4 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa4 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			zii,eeprom-name = "main-eeprom";
+
+			wdt_timeout: wdt-timeout@81 {
+				reg = <0x81 2>;
+			};
+		};
+	}
-- 
2.16.2
