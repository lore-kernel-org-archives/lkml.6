Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3530CECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE570205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdDBRm2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE570205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbeGVQpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:45:00 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41700 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbeGVQpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:45:00 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so7166837ply.8;
        Sun, 22 Jul 2018 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6o3rQsrfiZts5DqNsMEOKpNOtZIHyva1AoFsjFk52ws=;
        b=VdDBRm2DJnaVyHMq59+Zu6CXYdaxSm1vi92KxadngUZJ5dLtpLmY5oyyOi/2AVUeBU
         I8C+rGjCyxHoxX+We1UQARsDMv3dYfhzBOHcbmzWthgh7N5ED1efTQTV4+xRmhqHxMv1
         uKhvNXfqHgd4YkUzV9+0ezX6ebh3OWiUFinhBa2CVviM4N5Cm8NWvYti4smvbiitk8OM
         K96VqBr19Cm6IZu+Hyuz+71i+nmtbv7pe53y0jCnywTzSou4KI/tDzXHJ+aNhds3q9oe
         NblVU6r8tZTzqIMQlFDPd7DcRHRy5G6zajsvdfEqoUCBIqYBt8RJ3os4KzmcLMR2QSwA
         VYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6o3rQsrfiZts5DqNsMEOKpNOtZIHyva1AoFsjFk52ws=;
        b=C2RXKXvKT7asTMjWnxUj1PEyzvR3mzYV5/i2oSifR4jq1T93B/Rkk0xTaBS6LVVvbr
         1hiwDuYaJI7WhDU51SlI9jfmT/Q6aV1MWJIcj7aPpsnQ/7ICFdJ2TEFpWXGKRbI+MKzO
         TyMMaXE9MsShfWTc9Gm14nL+Ox4rVIN9T2uJCLKWRjdXsf/KxR6DYjvSlErtwrLHRvZS
         4TIZT/W09uLQcJTqtiS/Crjnl3ObfdTe8cUcw8YbmKBB8xCv58l76jHFASF2IIsXuvb1
         cYaL+fzp3UjThsCVLlwqpAGENxF0GUVqtRAaYcVepKBkS9y0Ce5NyI9oLXNt9gJP1Irk
         GKsw==
X-Gm-Message-State: AOUpUlFLzSNG4Ez6degpmRBiJ5wFXFZwMViEhsAt5B70Zmnj6rkTNZg5
        m4Qe9iKqbTSRiGLC+TefTDx12meCVbg=
X-Google-Smtp-Source: AAOMgpfWdcQ9jdYlP7ofkcgMpG1NOIukGj1kUNwSqnZC2I4sZFTkh1JwtHKuNv8CUtioHMgOoDGGeA==
X-Received: by 2002:a17:902:bcc5:: with SMTP id o5-v6mr9486459pls.336.1532274474829;
        Sun, 22 Jul 2018 08:47:54 -0700 (PDT)
Received: from localhost.localdomain ([43.239.70.127])
        by smtp.gmail.com with ESMTPSA id 16-v6sm13117344pfo.164.2018.07.22.08.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 08:47:53 -0700 (PDT)
From:   Akash Gajjar <gajjar04akash@gmail.com>
X-Google-Original-From: Akash Gajjar <Akash_Gajjar@mentor.com>
To:     icenowy@aosc.xyz
Cc:     Akash Gajjar <Akash_Gajjar@mentor.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: activate spi flash on pine64 LTS board
Date:   Sun, 22 Jul 2018 21:16:49 +0530
Message-Id: <1532274409-9921-1-git-send-email-Akash_Gajjar@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board has a 128M SPI flash. add spi flash support in device tree.

Tested on pine64 LTS.

Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
---
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index abe179d..d54637d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -134,6 +134,29 @@
 	regulator-name = "vcc-wifi";
 };
 
+&spi0  {
+	status = "okay";
+
+	m25p80@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "w25q128";
+		reg = <0x0>;
+		linux,modalias = "m25p80", "w25q128";
+		spi-max-frequency = <40000000>;
+
+		uboot@0 {
+			label = "uboot";
+			reg = <0x0 0x100000>;
+		};
+
+		rootfs@0 {
+			label = "rootfs";
+			reg = <0x100000 0x7F00000>;
+		};
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.7.4

