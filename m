Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8E3C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC13520684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feB6vMOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC13520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeGSUpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:45:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33703 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeGSUpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:45:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so4702015pgv.0;
        Thu, 19 Jul 2018 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bUjuJGEt+be8EofDRAiXz08Yh0hW83UqekjgwLMVOQ4=;
        b=feB6vMOTxYQFpAQ4y5M7xaogDRgUR9/R5h6QdNMO7MIhP1l9QLd15wzVQE1n21lN4Y
         2LKcvuLp9M5ZVk6pN9plUFOUQDQ7fqBkGCFTVhK+8m2vQJb673YG1hVMDo81X19/J3zp
         hir/QlHNgTGBkOu1QJQ0tbSARHlCuIlhosjl3nDOFHA6Y4O2TxJxbP21Y0oxpbRDHXEA
         uMYwvmq6i7wiJsaqG5VPY+PZSq7oNl490UrdLA/k0yPL6fo5n7mfhbr/jbc94OoW3K4p
         S2bJ91KCXUdBa0OjgeT1LdGYprCYacQ+s7aeJq7ttt+pVXlBmsLWXpOBPSKZtrrilbmX
         QiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bUjuJGEt+be8EofDRAiXz08Yh0hW83UqekjgwLMVOQ4=;
        b=GClmlqOizXzsv9i4lSnJizQl9lZ6499GiejrG7qvj7xaLmfsU2s7Q0cuecmhHHTrol
         UEJItfaOqZErFJ/vrR4Yi0n7eGlkOsi3rdP9NSYMbZCciwu30mshi0212iaz0dKO/IH6
         kvShiqAY253fmv4m+HunDMyGd0ggZuEKdUpfwFCQRNtHhMiEsoSXKeDpxYwHDYJl4Tb4
         DVWfek3Pa2/IAmaBujoIDyfYAg4PzTnO1I44tieB9QoEl4b7rKDmr16VmNoe4ejmvq0p
         0ZjLNXZoNrUqSYeIFCnxkVxWzu7O/G6cVqOe7JcJKBtXOJRFa42Y+qdMUdAfUAnQKE6I
         tjaQ==
X-Gm-Message-State: AOUpUlGxf5qv6ygD7kNYou7USRwaJ9zqijwb4MI/1gVzPO7jXEDJ5rUT
        rFSZjKL8CboPg4N/toRWupcGlbw2
X-Google-Smtp-Source: AAOMgpcdhVEf70mzk/HeUD+nwgJfOVHploXG8T/syBDzk9cAxAIceNpipk0hNyZ/LtfKrdvQwttI+Q==
X-Received: by 2002:a63:9802:: with SMTP id q2-v6mr11253814pgd.70.1532030432506;
        Thu, 19 Jul 2018 13:00:32 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e2-v6sm3435pgo.92.2018.07.19.13.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 13:00:31 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-ssmb-spu3: Fix W=1 level warnings
Date:   Thu, 19 Jul 2018 13:00:02 -0700
Message-Id: <20180719200002.15857-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of things that were causing warning when building DTB
with W=1.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index b692117d7839..fe357668865b 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -23,7 +23,7 @@
 		stdout-path = &uart0;
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
@@ -128,8 +128,6 @@
 			compatible = "marvell,mv88e6190";
 			pinctrl-0 = <&pinctrl_gpio_switch0>;
 			pinctrl-names = "default";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0>;
 			eeprom-length = <65536>;
 			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
-- 
2.17.1

