Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvP4PKdTqSP2fdle6/jYM5q05K55GHpekwFxHYSDXANKe52KqOxzPr5dSD9S5uzZqkYHlju
ARC-Seal: i=1; a=rsa-sha256; t=1521483161; cv=none;
        d=google.com; s=arc-20160816;
        b=bINmCunmaFo4oHU4uZe7NaNuBV81o2T2yJvk/QAPaBwAkASHIrFgU0/g3ohiSAyeEO
         Vovl9oONeQIstKhYtuzvI0JnNnQw6DuZb/Os0nm5S2awM4keYNx129KcClC/+cNH/Y7o
         NovMfMokKWf8TOHExNjrok68M9GtW4aBBlgF3c4H7ACBBSrSeFtGLzps57r61P9Mfzhn
         uMtliHW7jlTXA91qfBXcDJZ5/587YENQvxBA+JlT2Id7Axh4/AgzjIPnEs09aKVV3Fxp
         RRZ8Yfe96oAFuN4/8prkpor84fe4mrCIUKIaAnfEnKNmJIOyAOZ2f3y4gieDBY+kym4j
         jRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y5vrBmqBkfYzAzZwnOOpl/KFiMS9w1oxpj2aA5p1DfI=;
        b=PG60zaL15nVbWmQRv0M+4JHuhhMVanz0JeLnWxSZurxnzi+f/kbvv/pvA0KxuB69oq
         uO/dlccvEGgv4q4d+bfsPvDhi/qYja3heH0i90w3+2gdvP5hNerXFMMTOWAN0m+BUjgB
         RmWQCoNHW+Fgmy38YsvilmpGLLaCbbIicwulM40RMXHM+lCA5Re9jS2LQX2a2YRbsDET
         MZKeycHu/AfK/b+gEylrtzp3RpX1ypHi5c1oodbwKL7IapQDliCTDbWwbcABLhV4pZOU
         WznTKExGA94+DVMT+R6tkvlnFovIX91YXJ48ms/1XpFCoUsydgHLcMA5r5b9irnqv9E0
         OBSw==
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
Subject: [PATCH 4.4 021/134] ARM: dts: Adjust moxart IRQ controller and flags
Date: Mon, 19 Mar 2018 19:05:04 +0100
Message-Id: <20180319171852.237598214@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390501223106885?=
X-GMAIL-MSGID: =?utf-8?q?1595390727357962606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
