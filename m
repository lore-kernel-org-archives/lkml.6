Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1750C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A313720851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="I7wcRKRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A313720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeLLWOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:14:44 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:38382 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLWOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:14:44 -0500
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2018 17:14:41 EST
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 25/26] MIPS: GCW0: defconfig: Enable OST, watchdog, PWM drivers
Date:   Wed, 12 Dec 2018 23:14:35 +0100
Message-Id: <20181212221436.19613-1-paul@crapouillou.net>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544652880; bh=F0LbjVzBTEYaaS03XKu2WMbo0Fth1wF9oOHlv1RuWS4=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I7wcRKRPclD3TRNJLDjbL+gWSdf0Uv+jv1nVr0cUxlgshyUwRqH//zVceC00mijvRwoioocu7aqpwBvONeeiz/7fcnwunlOqu1QkM3TeSmdK8P1FpPRXhnn0qh4QuGjUTBUL8MbC1flvUYy82DFcUYe9U+iztymKwhjMacEdH4k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OST driver provides a clocksource and sched_clock that are much more
accurate than the default ones.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v8: New patch

 arch/mips/configs/gcw0_defconfig | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/gcw0_defconfig b/arch/mips/configs/gcw0_defconfig
index 99ac1fa3b35f..7116400e8cbf 100644
--- a/arch/mips/configs/gcw0_defconfig
+++ b/arch/mips/configs/gcw0_defconfig
@@ -1,14 +1,14 @@
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_EMBEDDED=y
 CONFIG_MACH_INGENIC=y
 CONFIG_JZ4770_GCW0=y
 CONFIG_HIGHMEM=y
-# CONFIG_BOUNCE is not set
-CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_SECCOMP is not set
-CONFIG_NO_HZ_IDLE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_EMBEDDED=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_SUSPEND is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BOUNCE is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -20,8 +20,13 @@ CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_INGENIC=y
+CONFIG_WATCHDOG=y
+CONFIG_JZ4740_WDT=y
 CONFIG_USB=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_NOP_USB_XCEIV=y
+CONFIG_INGENIC_OST=y
+CONFIG_PWM=y
+CONFIG_PWM_JZ4740=y
 CONFIG_TMPFS=y
-- 
2.11.0

