Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64830C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5B320664
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDdBYCeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5B320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeKYSeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40860 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeKYSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so15789326wrt.7;
        Sat, 24 Nov 2018 23:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+W5Qljl8k9EH83ugcM500hEuxMmIHKFyX6qk7pxmzKI=;
        b=JDdBYCeCzf9l5KJrpamaZbippwi75I2Qhk9WvBIzjIHH8hLvWjnzxcjZM7ewkuCSls
         E0mQMgt/dRkBqVxA/KL92dQabj0MNqAyh/WeG3kZd/0qiRHuzT7yJgfYJG8p7+GQY5dZ
         XboCSoLi8SHsz/Q1QX90iIc2GJgegr5X6BSTQc9/5JVUvRIbeFLwGAPLskSsQbjBQ8xw
         NwQDWXWWuX+5W2P5HoYoyhKYnL/hGJi6maYk0rNXmknlm07P+ioZ+9josQShpWBtyNwc
         cy++OCr8iFY9khkXfPD/aMH0FU+jI2xOJWPBSeR6bQsImK9vNC3X33oIAmv9aQgP3Gr/
         vtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+W5Qljl8k9EH83ugcM500hEuxMmIHKFyX6qk7pxmzKI=;
        b=e13L3LvOZk3AAu1AiaRSBcVYxVmqym4jYrKV/naCsdM2PK3JBqq/8/qa2pZ4DvvmtW
         +cjcU6V72TZzIAnRdEQ35uMHc2+rNW9Ri1nagYynGuGT7Q1y3wJsKA1ExAb16+QUguLN
         759XyjPO86Y7BnebSWF55PNap5xKng0ZAelVCfefevlBFRB0fR26lyA/Dn2Qnf9hF9EE
         CQqsJw31CAXRDRV6MOBEEB6rF7VzmOIVR4aPRABIOLrX6wglFcPqn+FuUbqnscBtmiHi
         v9v0TqNAHeuyFNvWbavlDQNAXTd0rT8tdFgxOB/geZ7AhxuTkuiwT2q4vt1ZUG6QdEwi
         W6rw==
X-Gm-Message-State: AA+aEWYxJd032WTHBGlB30WwSWlxdyycgTBK5+Y+RRNgOuXfzn+nl3Pk
        2rpZ2oCYi3E5vl2U29KMQa9hDFU6qZA=
X-Google-Smtp-Source: AFSGD/XivJRedeyTpClT5XLrRb58RQocasRM5hPOuOid9zFqwuT4zrrbg4kU8zxSqWzJpqJdJKCJgw==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr19046291wrq.11.1543131825347;
        Sat, 24 Nov 2018 23:43:45 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:43:44 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [RFC PATCH v4 01/17] ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7 Allwinner SoCs
Date:   Sun, 25 Nov 2018 10:43:03 +0300
Message-Id: <e83e1b25069f3fa4925e5e5f6b9eca3190532b98.1543125196.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543125196.git.mesihkilinc@gmail.com>
References: <cover.1543125196.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner also has some ARMv5 SoCs.

In order to add support for them, check ARM_MULTI_V7 before enabling
ARMv7 SoC's.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d9c8ecf..185c573 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -9,9 +9,13 @@ menuconfig ARCH_SUNXI
 	select PM_OPP
 	select SUN4I_TIMER
 	select RESET_CONTROLLER
+	help
+	  Support for Allwinner ARM-based family of processors
 
 if ARCH_SUNXI
 
+if ARCH_MULTI_V7
+
 config MACH_SUN4I
 	bool "Allwinner A10 (sun4i) SoCs support"
 	default ARCH_SUNXI
@@ -56,3 +60,5 @@ config ARCH_SUNXI_MC_SMP
 	select ARM_CPU_SUSPEND
 
 endif
+
+endif
-- 
2.7.4

