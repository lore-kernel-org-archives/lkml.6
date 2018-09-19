Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A65ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99882208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99882208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeISJWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 05:22:19 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53955 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeISJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 05:22:18 -0400
X-Originating-IP: 36.71.235.160
Received: from ubuntuVM.lan (unknown [36.71.235.160])
        (Authenticated sender: aditya@kobol.io)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D718160007;
        Wed, 19 Sep 2018 03:46:18 +0000 (UTC)
From:   Aditya Prayoga <aditya@kobol.io>
To:     linux-ide@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Daniel Golle <daniel@makrotopia.org>,
        Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH 2/2] ARM: mvebu: Enable ARCH_WANT_LIBATA_LEDS in Armada 38x
Date:   Wed, 19 Sep 2018 11:45:30 +0800
Message-Id: <1537328730-9156-3-git-send-email-aditya@kobol.io>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537328730-9156-1-git-send-email-aditya@kobol.io>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable hidden symbol ARCH_WANT_LIBATA_LEDS so CONFIG_ATA_LEDS can be
used in kernel configuration.

URL: https://lists.openwrt.org/pipermail/openwrt-
devel/2017-March/006582.html

Signed-off-by: Aditya Prayoga <aditya@kobol.io>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 2c20599..51f3256 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -68,6 +68,7 @@ config MACH_ARMADA_38X
 	select HAVE_SMP
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_38X
+	select ARCH_WANT_LIBATA_LEDS
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 380/385 SoC with device tree.
-- 
2.7.4

