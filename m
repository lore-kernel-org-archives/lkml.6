Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CC2C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AB920854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdaNvdjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AB920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbeGVXt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:49:59 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44246 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbeGVXt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:49:59 -0400
Received: by mail-yw0-f194.google.com with SMTP id k18-v6so6214652ywm.11;
        Sun, 22 Jul 2018 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MaXwu3UiExrAZ5ralFaJKzkH6lxMbT4Gv5yXmL2FJ2o=;
        b=UdaNvdjApjw+V6ajjzIQVmCVphWhC/WfTPFm5IO0a0xXjz7QH5IHol7w+v18HREywy
         o7vKJe77ITvZB4WAJBfcyM2UzNI2Q32TJ8N7Oo9CwFyF9LiwG1S95v8wr3x2MuZ3mQ7R
         kQGRwncHV45lZEJAeXq6cHR6Fiy78OLMEqQ+Psdi9xW/f3z/cJax0hwINChN19p1+Ma4
         k3RnX2b/RBfCIjjYJyVA0QJSm5Kz+LsBkaQ4qoh3mLkEbo64Gkwj19rn68f3F/qvIzyM
         Lk3Wz8ufBQBTrK5/ag74sVv11l/Hb0uVL0wGPW0WYdq2nq9WsOi7PeFlhGLlFGwrmaVi
         cezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MaXwu3UiExrAZ5ralFaJKzkH6lxMbT4Gv5yXmL2FJ2o=;
        b=tjcuYhDkWZ6aTdU90M4ywpRTZus2VV+WTEv2ss80TQpe8d8VNeuwpXcBNx7AlYaAVU
         LIZzRb7Os0Fxj6j4Tse1GzGMbLB2sXrFlwkuZC7MzLX3waI0pfJcneC1w2j3kpZlcrGS
         MgDnomqxFiFoMuro7GUZ7oOxzKpVGvUBBwztW3oPRk8AHjDc5qHxNLXn2XhrmWbIWhas
         uUY+8OawKg45UpGAOEWBt2iV5FCWsFpOlJ4/DZTMNvic94Z3Yz3TBhM3/gHDQas8rw48
         39ii7rRYMyIJH7DdvdUT4f4tATVCIucok2ckW52UUQRfQSfkcPgEbTmH8a1EBpoLxYPa
         pjYA==
X-Gm-Message-State: AOUpUlFD2HtktRPaBVyk3kyFDZHatRcTBhmQzXdWFcxmJUkAcoarhkcv
        h5sLPFTiNUsS9ON1+q2jWb4=
X-Google-Smtp-Source: AAOMgpfW2IkSl5mpNUzYpnkxboHkbBViwTzulTocgbhi4h9GV+RoAb4wZRREP8I41hhIt+a0hdhshw==
X-Received: by 2002:a81:7050:: with SMTP id l77-v6mr5660933ywc.226.1532299900328;
        Sun, 22 Jul 2018 15:51:40 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id 139-v6sm933716ywk.41.2018.07.22.15.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:51:39 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 08/11] dt-bindings: counter: Document stm32 quadrature encoder
Date:   Sun, 22 Jul 2018 18:51:34 -0400
Message-Id: <7e5b0d84eb64a9f11770bb9734f8303ebf6f7178.1532298882.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532298882.git.vilhelm.gray@gmail.com>
References: <cover.1532298882.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Add bindings for STM32 Timer quadrature encoder.
It is a sub-node of STM32 Timer which implement the
quadratic encoder part of the hardware.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Rob Herring <robh@kernel.org>
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
index 0e900b52e895..15c3b87f51d9 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -28,6 +28,7 @@ Optional parameters:
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32.txt
 - timer:		See ../iio/timer/stm32-timer-trigger.txt
+- counter:		See ../counter/stm32-timer-cnt.txt
 
 Example:
 	timers@40010000 {
@@ -48,6 +49,12 @@ Example:
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
 
 Example with all dmas:
-- 
2.18.0

