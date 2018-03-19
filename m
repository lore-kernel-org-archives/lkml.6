Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELslbYxZ+ankfzVgvCDSrw+s/AEnOZDjXTg4G4ImyaG4LZVoM9vFB2ovHnCpLgvmZnLHhFVh
ARC-Seal: i=1; a=rsa-sha256; t=1521483592; cv=none;
        d=google.com; s=arc-20160816;
        b=qXxEelWrD6szsDUPdglcIDlQ7VdajDgb6LsjzYYvO9MiSEYRZLyQvNU1a/CrB/kZWV
         7JdOFD5dDR2pLRISUGr7541hQoXB05Q2YJiBEgnlJyQM118wX0U1L5sxJ/DkZJ/zr1po
         Gdxn7G91gHsvwT9IVrtah70hVMB1nUhMaj05Vsfgiu6lETCRanjf95rDEa/lh+HaMlyl
         ALi53RIoyFw5zEnoeh4Gbu5JKXDStiS2K3HMPcw0ozJDD1rViJuaQWBHkOfo5jXzncAR
         lhgGUKnOnQbmxx5MPUSitICD6eSg0PlLQqAeS4uUVjbo6keaOaXUVBC6b2oxG8laPgl1
         daTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gkCJWN55E+IiYKprfB5HBKA+fhQFGQBnHVypWP/kLyE=;
        b=LvWrczGubd482x+IvwjPy2H4n71Q0g1MLQJLhaSV/IhTJBoxjmEFPAPsrIvh5wM4sQ
         7nUNztoywRJ0EG9/+P1UJwM29Xkhpdp317z+iOQeSVtYmGkYeX46T1PNAM57pUpnsv90
         iCWzSsrK+YNQRMRffRJRt9/37/C/0Ynnxnb7Z4cL1MOvZUOgJAH4/rLKzXkflBX4JWWp
         i7ZCmLBaBwkunropj/GdI65OX5xjCT9Zkjxb9KKBdWJNj8lF9Kvx+IRHTivBqnggIQ4V
         i3riPX55wSdb4bwZ2Q7L5z5MylMz249c502vmTNQC5D7LKcuC9u4kvWvh4Q2jmiT4jrJ
         FFAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jonas Jensen <jonas.jensen@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Olof Johansson <olof@lixom.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 045/241] ARM: dts: Adjust moxart IRQ controller and flags
Date: Mon, 19 Mar 2018 19:05:10 +0100
Message-Id: <20180319180753.060143251@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390501223106885?=
X-GMAIL-MSGID: =?utf-8?q?1595391179650567661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>


[ Upstream commit c2a736b698008d296c5010ec39077eeb5796109f ]

The moxart interrupt line flags were not respected in previous
driver: instead of assigning them per-consumer, a fixes mask
was set in the controller.

With the migration to a standard Faraday driver we need to
set up and handle the consumer flags correctly. Also remove
the Moxart-specific flags when switching to using real consumer
flags.

Extend the register window to 0x100 bytes as we may have a few
more registers in there and it doesn't hurt.

Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/moxart-uc7112lx.dts |    2 +-
 arch/arm/boot/dts/moxart.dtsi         |   17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

--- a/arch/arm/boot/dts/moxart-uc7112lx.dts
+++ b/arch/arm/boot/dts/moxart-uc7112lx.dts
@@ -6,7 +6,7 @@
  */
 
 /dts-v1/;
-/include/ "moxart.dtsi"
+#include "moxart.dtsi"
 
 / {
 	model = "MOXA UC-7112-LX";
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -6,6 +6,7 @@
  */
 
 /include/ "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	compatible = "moxa,moxart";
@@ -36,8 +37,8 @@
 		ranges;
 
 		intc: interrupt-controller@98800000 {
-			compatible = "moxa,moxart-ic";
-			reg = <0x98800000 0x38>;
+			compatible = "moxa,moxart-ic", "faraday,ftintc010";
+			reg = <0x98800000 0x100>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			interrupt-mask = <0x00080000>;
@@ -59,7 +60,7 @@
 		timer: timer@98400000 {
 			compatible = "moxa,moxart-timer";
 			reg = <0x98400000 0x42>;
-			interrupts = <19 1>;
+			interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
 			clocks = <&clk_apb>;
 		};
 
@@ -80,7 +81,7 @@
 		dma: dma@90500000 {
 			compatible = "moxa,moxart-dma";
 			reg = <0x90500080 0x40>;
-			interrupts = <24 0>;
+			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 		};
 
@@ -93,7 +94,7 @@
 		sdhci: sdhci@98e00000 {
 			compatible = "moxa,moxart-sdhci";
 			reg = <0x98e00000 0x5C>;
-			interrupts = <5 0>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_apb>;
 			dmas =  <&dma 5>,
 				<&dma 5>;
@@ -120,7 +121,7 @@
 		mac0: mac@90900000 {
 			compatible = "moxa,moxart-mac";
 			reg = <0x90900000 0x90>;
-			interrupts = <25 0>;
+			interrupts = <25 IRQ_TYPE_LEVEL_HIGH>;
 			phy-handle = <&ethphy0>;
 			phy-mode = "mii";
 			status = "disabled";
@@ -129,7 +130,7 @@
 		mac1: mac@92000000 {
 			compatible = "moxa,moxart-mac";
 			reg = <0x92000000 0x90>;
-			interrupts = <27 0>;
+			interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
 			phy-handle = <&ethphy1>;
 			phy-mode = "mii";
 			status = "disabled";
@@ -138,7 +139,7 @@
 		uart0: uart@98200000 {
 			compatible = "ns16550a";
 			reg = <0x98200000 0x20>;
-			interrupts = <31 8>;
+			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <14745600>;
