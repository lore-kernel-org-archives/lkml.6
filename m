Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6446BECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089A12089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2nNEXdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089A12089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeGOVLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 17:11:13 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39016 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeGOVLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 17:11:13 -0400
Received: by mail-yb0-f196.google.com with SMTP id k127-v6so14704029ybk.6;
        Sun, 15 Jul 2018 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MaXwu3UiExrAZ5ralFaJKzkH6lxMbT4Gv5yXmL2FJ2o=;
        b=P2nNEXdKoVV7P9uzH3VIEpU81V23RKwzqTF5Js6JpIBE04udwC2r8auDzI+E5M3RdJ
         LkUse9vXxQTXtFYmO/em0eOWtcUCITyKBZFmlfdMc7XwYIdaP2Ahhu5TZHZSfwvOfL1M
         ZwgIo3HdfNGkB3Rmz7ar5jfKCv8c8xBwa+Z9GiRgse51Qfe8Ar5FTwNmohnI4/S0rvAa
         kK2CChqAuK2jxPig2sTiysY9kxwaGlexOB7HdV9i8SQTmDnmZmDdMNNP/NwTUvufkY8L
         5HZAoA1LKN9O2ZeEwQj970WYcLzHbBnmlzUS0PYGW7GCgj+MedCpURJjmmB3o/foGLSj
         KUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MaXwu3UiExrAZ5ralFaJKzkH6lxMbT4Gv5yXmL2FJ2o=;
        b=LZTCZLkBV9yyxggUVDZruTp3rPVLgJSfT5YCx1Li2+c2wvDeXj+mSAahZWeunI6OXu
         ONED9BlJL8kA/Dkz7MVI3AD0LNN4fwpWqrnnWBfJlHWRBHFpS7xCk11gyLd0DzHMFzJ5
         guOFXR9WFa8TFSCw1Xc8nyi2s8DdbqV5YT5vW+0NtDETEj5b54g/vWQ3vafZ3WuiVKXT
         7u3+QIz+jT+eUrdU5IAjDsQVKOUayFMhsjqHtFBoZkSBnTrfVjqugU/DwzrKYf0S5SYj
         v9MVk4/g6AG7oadhfJ4Qja6O9ggygktYSeyE/sASzXPATB+yrOMf1b2cCVVmZ71VF/vA
         Wmmg==
X-Gm-Message-State: AOUpUlHfQYk6zSnL57FoglBgANXkkhPhoXCDLXci46JF0H1kqu5D9YqM
        gvwWJuFxRtqO/eZThI7/zVI=
X-Google-Smtp-Source: AAOMgpcgZtv05p7yfduIaVQsGzwO+4jId7kMrlUsUNaccxC0xjPMx5Py/nsIRpYV2j+uMiP8ETWhUQ==
X-Received: by 2002:a25:a383:: with SMTP id e3-v6mr7309724ybi.325.1531687623010;
        Sun, 15 Jul 2018 13:47:03 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id h126-v6sm14265450ywf.73.2018.07.15.13.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:47:02 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org, jic23@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        Mark Rutland <mark.rutland@arm.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 08/11] dt-bindings: counter: Document stm32 quadrature encoder
Date:   Sun, 15 Jul 2018 16:46:43 -0400
Message-Id: <9724df348c488ed5c1b92738c3ef2ee12665bd05.1531685025.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531685024.git.vilhelm.gray@gmail.com>
References: <cover.1531685024.git.vilhelm.gray@gmail.com>
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

