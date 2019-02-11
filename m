Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF9BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B2920863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkX4vG0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfBKJWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:22:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54200 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfBKJV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:21:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so16213795wmb.3;
        Mon, 11 Feb 2019 01:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lIYeZisgInqCOZpWT0d/hZqmxdLdiRL0RmR52VTtRjA=;
        b=CkX4vG0Cf9MIFPB0r0biBCJp7uoat+QwA097brWM6ScCKl4BT3GVi8GEuUEaW19elo
         ndLUpJZ+7IZDWLr1mx4AmIU1LzoEcxn/+b+NUs2tydpQoOc4MTLFyqWJ9QdUn9MVdCgk
         RXUeW5B3O7Um5IrnlJt9so2xIFHljU72hhUvrW2r5WseWu5+wIDqNsT0nFUv+CkJrqU4
         jHnq7gugqCTYnyBIdrOwZvYApZsUWqDKaCuuq2huAXgVS3yGuP3r20yAINq4+8B2WZEX
         K3FFAjYEub/jDQo7UEZ2c1iKdET8pDPxGfw6ZpJKRCTk09Wh8kPHsLSR2q0rBqM6IH7G
         Vf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lIYeZisgInqCOZpWT0d/hZqmxdLdiRL0RmR52VTtRjA=;
        b=amxmhEnKGu9s52nxROrOqOkSbIzjx1DlXqLo6Fk3+uwnnSJ1XAFfk3CEruqz5kFVCU
         W0DGIH4KstyN+8zwlFiWkGsOQtkiLCXspTt465b6S+HIojb9cSQAiCa0AdHNeMv9Stmn
         RrgHwE/H9Iw/Fqv2zf1VoS0QD5Ud98IAiHGtX6UT1HSIYSfBhUNLyr3Udt/u/EkHXmmF
         tbwUy1mqToYeNd51iBBhs9jMjCqMqjt511pyhRvFuMjz+2VMeSr0ODuSHnr/ESOPafBa
         mA/dGV+9aEbJ3JzZ65F/BbXtAunQ18Gx13pVNqz6AE0Ikq+6/QKtCWyz1q9ePy2N5Stg
         RyxQ==
X-Gm-Message-State: AHQUAuYukkFyTX8lXWAMXvRjZdr3kidKL9kxMz4uoC4ZH12xVCtZvD0n
        uVk/o7Xg/qkcB7KJb8dkSQkj4iuLEcE=
X-Google-Smtp-Source: AHgI3IZ3YDqNq/2AQaMYe1kJv8UXjv+MSl9KMteeI+5/4URxr44WhcfQlK15lXqYlYzWYBQFLK1FQQ==
X-Received: by 2002:adf:de83:: with SMTP id w3mr5951635wrl.56.1549876916755;
        Mon, 11 Feb 2019 01:21:56 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
        by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 01:21:56 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 7/7] ARM: dts: f1c100s: Activate SPI flash on Lichee Pi Nano
Date:   Mon, 11 Feb 2019 12:21:13 +0300
Message-Id: <02be41b6187d4d1fe09bff24cb93c2400a166803.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lichee Pi Nano board has a Winbond W25Q128FVSIQ 128Mbit SPI NOR flash
connected to the SPI0 controller of F1C100s SoC, via the pinmux group at
PC bank; so it's bootable.

Enable this SPI flash.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
index a1154e6..52a29be 100644
--- a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
@@ -24,3 +24,16 @@
 	pinctrl-0 = <&uart0_pe_pins>;
 	status = "okay";
 };
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pc_pins>;
+	status = "okay";
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+	};
+};
-- 
2.7.4

