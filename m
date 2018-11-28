Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B70C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED8E2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK2kX4Co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED8E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeK2Jha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46690 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeK2Jh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so27905479wrt.13;
        Wed, 28 Nov 2018 14:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zZAcd5DCVFwIJh7pdMnlLFltxq06uySPlY2MVRx9NcI=;
        b=OK2kX4Cov+t8qGt5WqhcllKzXjFRPRKOleA+zAx35Jfa9A6Fsoa0wKXLiARzIpoQh1
         dXl3kxE/uSj4QOpjpS17FeHAGOYFnFrQXRvqgmHNTf0YxWLn9uHs4GppzW6Wo6NvbWuy
         BzTYo1lFSZ+K24qe4OiZ7XvIBqILSQxYV1XLVbg+KFg/fZ3lWcQoITgN2j2gqTAAP8aj
         a9/UEUQyjWyje5IHXw76P8b5S9QrKCBonYEluQ4rB6vGkzBCZ4PpnWwu1CbPQHFIGqTi
         zaanns8rmt9Su/JN0tEhBmXrhqfcY+IVFqJoIjchs5fhZrsdD1SvBj8yiJvQTnJpWTxl
         ATHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zZAcd5DCVFwIJh7pdMnlLFltxq06uySPlY2MVRx9NcI=;
        b=pmM0JwtmU+MPepKXv1tvZZyg62i1qSeMLWfnJTFwvd1HZC2aDpHoed64XTYEIDOo+N
         aHfSiVh6Nc0czKPALyuH1RxPGqrOMTtgv6wNNkjrtjH8sBAGB6OqrgXxHdopN6Ex/UUt
         8MIsTlBL+8vbEiJkQJ9Mr8k4NEiX3rS/ShJDJgjUYlZLROkgSlUwOXJPyrAAwLAi+Kfv
         HUWXzt02U07QCP/9FkJ086xe08L5eBZaMZ7YWduuST1tF1aLc6KhrT1XBUykhQR0nqKH
         QUW+NjqKnLCQFajOQxmJhBohwFGq9ic4vF2dFuI7EslLHAqtV+eCzuWnImVdc7IBK1jt
         5ClA==
X-Gm-Message-State: AA+aEWZdwgrAMJE9BHJHBSwCZkT9lEglIpy2xYHQXPdPpjsNe3OrNocw
        XAG+JzX/uWQS3kDc3Zthhb5wxwHC3Rk=
X-Google-Smtp-Source: AFSGD/VBum8b5mhsh0uW2/B16EAWpB1SETOR/HmbxHVVIhR4uV+sJel5+/SeRrIWhMX8THeLosot/A==
X-Received: by 2002:adf:9382:: with SMTP id 2mr17030823wrp.269.1543444456432;
        Wed, 28 Nov 2018 14:34:16 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:15 -0800 (PST)
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
Subject: [PATCH v5 03/17] ARM: sunxi: add Allwinner ARMv5 SoCs
Date:   Thu, 29 Nov 2018 01:33:13 +0300
Message-Id: <459a13de210c96de1a719552164fbc8aa3d0de4c.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
used for many new F-series products, including F1C100A, F1C100s, F1C200s,
F1C500, F1C600).

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/mach-sunxi/Kconfig | 13 ++++++++++++-
 arch/arm/mach-sunxi/sunxi.c | 10 ++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 185c573..7fa6a3d 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs"
-	depends on ARCH_MULTI_V7
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
@@ -61,4 +61,15 @@ config ARCH_SUNXI_MC_SMP
 
 endif
 
+if ARCH_MULTI_V5
+
+config MACH_SUNIV
+	bool "Allwinner ARMv5 F-series (suniv) SoCs support"
+	default ARCH_SUNXI
+	help
+	  Support for Allwinner suniv ARMv5 SoCs.
+	  (F1C100A, F1C100s, F1C200s, F1C500, F1C600)
+
+endif
+
 endif
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index de4b0e9..155cd9e 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -101,3 +101,13 @@ static const char * const sun9i_board_dt_compat[] = {
 DT_MACHINE_START(SUN9I_DT, "Allwinner sun9i Family")
 	.dt_compat	= sun9i_board_dt_compat,
 MACHINE_END
+
+static const char * const suniv_board_dt_compat[] = {
+	"allwinner,suniv-f1c100s",
+	NULL,
+};
+
+DT_MACHINE_START(SUNIV_DT, "Allwinner suniv Family")
+	.dt_compat	= suniv_board_dt_compat,
+MACHINE_END
+
-- 
2.7.4

