Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8FEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FA520883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ksJ0d3iE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FA520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeKQG4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:56:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53943 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeKQG4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:56:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id f10-v6so23232032wme.3;
        Fri, 16 Nov 2018 12:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ai/RSMltyx36GwmePMBYxsJgS0XIqXO//01v9qXa8/g=;
        b=ksJ0d3iE7L68tClLdPRFoJ2vvf7CtBbXhEUQt/r4BUSV3UpK1sotyEznR20vDuQS+R
         in3Rjlcdremsy/lfuaQH8pNt4fLh5Ug9d9vJGS9FmLhMnqfhxaEcIGzrNoyDBgECU6dx
         bk3gV2vcDJGHYDJK2jEh+Oii0CApDkb9t9OhezliKs9r0u/C5mlw75kf3wRHPrGKE/oi
         uBpzznqaU8n1nVCc/eLIAWP/IOKKWIUGr6v02xRyV2LishqDBYG2z/GO70xhz2ueFjv1
         r7evxNe9yKlTPdcdCrDJfM+b6EtK6LvXrl0soBwa8mha5FNdEOTOOzdUGLaQCXov+yET
         i9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ai/RSMltyx36GwmePMBYxsJgS0XIqXO//01v9qXa8/g=;
        b=nm6Io/Zmp/pN5zdandV3gamXOPLu5e47q9pd2zcoiahJwZHiOxcI9ZXmrOowSmkwKN
         +FiqEfPc8HnhnvTacY1zVft15DLJr+NfxFPC4GHqC52EjHId76r0og+/Tqmx9+07lNFw
         zfJBYtllGmX5tr0ca9dpOV9GM8NFQ1+z4NMDq0Lypt59QPEA+L47KKTOWM1pNjBY0qb6
         NjCSOrbocdrfA5hD+WBWd5DTMsXSRx+CNCaG3PnDAVJ/ipJuNiFPBQSg2TwFMhNaF0l6
         ScejR4kqpG3tjOEr5/fWzw0jhrSzXNo22DUiU+z/HNnh4E+altVVCoAL7gyEtVaCg946
         F+rQ==
X-Gm-Message-State: AGRZ1gL/evI0Gr7/dWznoLet8mxOxuAPP77FdVmoWyLVmiDVJU0l5gi9
        7DPcN2WwVQz7rBBtFSvI8TY=
X-Google-Smtp-Source: AJdET5dkG1uD6mpkxNZZQmZ6X0Dfch11XWq29CVOLJ3p+eB9T8/ydohsOOc86PzaIPye4DDcXPIZmQ==
X-Received: by 2002:a1c:880e:: with SMTP id k14-v6mr9967168wmd.88.1542400975598;
        Fri, 16 Nov 2018 12:42:55 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A1006D214A3B023844E6.dip0.t-ipconnect.de. [2003:dc:d717:a100:6d21:4a3b:238:44e6])
        by smtp.googlemail.com with ESMTPSA id y34sm6000758wrd.68.2018.11.16.12.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 12:42:54 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] ARM: dts: meson: add the clock inputs for the Meson timer
Date:   Fri, 16 Nov 2018 21:42:35 +0100
Message-Id: <20181116204235.3925-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
References: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson Timer IP block has two clock inputs:
- clk81 for using the system clock as timebase
- xtal for a timebase with 1us, 10us, 100us and 1ms resolution

The clocksource driver does not use these yet, but it's still a good
idea to add them as this describes how the hardware actually works
internally.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi   | 2 +-
 arch/arm/boot/dts/meson6.dtsi  | 5 +++++
 arch/arm/boot/dts/meson8.dtsi  | 5 +++++
 arch/arm/boot/dts/meson8b.dtsi | 5 +++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index f0255450bcb2..0839da07a75c 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -197,7 +197,7 @@
 				interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 			};
 
-			timer@9940 {
+			timer_abcde: timer@9940 {
 				compatible = "amlogic,meson6-timer";
 				reg = <0x9940 0x18>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_EDGE_RISING>,
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index 9b463211339f..ca978ab952cd 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -88,6 +88,11 @@
 	status = "disabled";
 };
 
+&timer_abcde {
+	clocks = <&xtal>, <&clk81>;
+	clock-names = "xtal", "pclk";
+};
+
 &uart_AO {
 	clocks = <&xtal>, <&clk81>, <&clk81>;
 	clock-names = "xtal", "pclk", "baud";
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 08c54cf5420a..3be5fbd07997 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -387,6 +387,11 @@
 	clocks = <&clkc CLKID_CLK81>;
 };
 
+&timer_abcde {
+	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk";
+};
+
 &uart_AO {
 	compatible = "amlogic,meson8-uart", "amlogic,meson-uart";
 	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 46b3564a6536..587a855f872b 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -370,6 +370,11 @@
 	clock-names = "core", "clkin";
 };
 
+&timer_abcde {
+	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk";
+};
+
 &uart_AO {
 	compatible = "amlogic,meson8b-uart", "amlogic,meson-uart";
 	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
-- 
2.19.1

