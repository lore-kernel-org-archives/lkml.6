Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108A0C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B213A21A82
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG7Dfor3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B213A21A82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933766AbeFUVIp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:08:45 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38102 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933364AbeFUVIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:08:41 -0400
Received: by mail-yw0-f195.google.com with SMTP id w13-v6so1672826ywa.5;
        Thu, 21 Jun 2018 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BtiNSIqI/RoeMxqgEMRsgrcPVJ6BM+TlUKL1e42nYek=;
        b=TG7Dfor3ioEr472TeOITMQJXfjlrDDhD7eF6OjPwSme8lxZy3dwC/PcOPFQYsrx9I1
         mn77US38clCJysWBkN8mjODLGvBHV7NMpgxHeckbJ/p7MiXmPYdgr2k0+eRslcMKRCvh
         opLCXA2YSEVeaWdoVycZEDQFzz7/ibbQaOALwc3o6nbZFpJr2rGBmeydUOimSXS1e1tj
         kLkxZ+huWI+GZbtNs8j4gLfbR4SWT6X9fUj2Y+RzTIe2bde8/mXE6gNvNHGDNIE50jsJ
         WWwHd8PhiRfU3xeTkccU13qVjys95i2gBifP/D1mFRcYT/yR5jx3jIWm8h9OCTacKIwA
         2wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BtiNSIqI/RoeMxqgEMRsgrcPVJ6BM+TlUKL1e42nYek=;
        b=UO0MyE13Bs96KmdbYhRIhSE3NEcS2MhfmsF6LHle5g7+MB+LclppCjcj82BemxsRA+
         OSuGPygqlQFz1GpzZiVjCMy3F/kQW7QFSm+kXbcFNhJc2sbvmSq7tm0JQRMDo46HDwPs
         usRUAh1MHm2RHmD9gDQ5XCMWOD2463+qUA3MMWKzjdzw44isZJXa2J1Q6IqQHSkquFkk
         puD8BTi8sbw57uuLDRsSxLzyWONkimU71DoUeDFTQ+a+mfaN/ZJMH6K3Ebg8yB8xwadL
         px6CmsJxZReIKNjsKY1JevE/mMqTAN+gZPb86Cvv/8zpXP2FIDX7qQXaZQgr1N2S9t1V
         9B4w==
X-Gm-Message-State: APt69E3VflH1xFpUNMMTvd2aVGPhj6RCHSWY95CYotYbOqLEHG0yKrj5
        bZ9BudHbGVV9VCGz4Ma0nN8=
X-Google-Smtp-Source: ADUXVKJE0BZty6+aFwh052FJSCJlWU6nRBH0JLxderYUjXVk7KzjsDW32MWDsD9CHdlMJDPq4HEWcA==
X-Received: by 2002:a0d:e742:: with SMTP id q63-v6mr13527819ywe.514.1529615321032;
        Thu, 21 Jun 2018 14:08:41 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id v127-v6sm2102526ywf.101.2018.06.21.14.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 14:08:40 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 07/10] dt-bindings: counter: Document stm32 quadrature encoder
Date:   Thu, 21 Jun 2018 17:08:34 -0400
Message-Id: <c1cc3d567d0a5799c3afe6e24ca9ec3b1547224e.1529607879.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Add bindings for STM32 Timer quadrature encoder.
It is a sub-node of STM32 Timer which implement the
quadratic encoder part of the hardware.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../bindings/counter/stm32-timer-cnt.txt      | 31 +++++++++++++++++++
 .../devicetree/bindings/mfd/stm32-timers.txt  |  7 +++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt

diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
new file mode 100644
index 000000000000..c52fcdd4bf6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
@@ -0,0 +1,31 @@
+STMicroelectronics STM32 Timer quadrature encoder
+
+STM32 Timer provides quadrature encoder to detect
+angular position and direction of rotary elements,
+from IN1 and IN2 input signals.
+
+Must be a sub-node of an STM32 Timer device tree node.
+See ../mfd/stm32-timers.txt for details about the parent node.
+
+Required properties:
+- compatible:		Must be "st,stm32-timer-counter".
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
+			to set CH1/CH2 pins in mode of operation for STM32
+			Timer input on external pin.
+
+Example:
+	timers@40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-timers";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "int";
+
+		counter {
+			compatible = "st,stm32-timer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tim1_in_pins>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
index 1db6e0057a63..ff9c14ada30b 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -23,6 +23,7 @@ Optional parameters:
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32.txt
 - timer:		See ../iio/timer/stm32-timer-trigger.txt
+- counter:		See ../counter/stm32-timer-cnt.txt
 
 Example:
 	timers@40010000 {
@@ -43,4 +44,10 @@ Example:
 			compatible = "st,stm32-timer-trigger";
 			reg = <0>;
 		};
+
+		counter {
+			compatible = "st,stm32-timer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tim1_in_pins>;
+		};
 	};
-- 
2.17.1

