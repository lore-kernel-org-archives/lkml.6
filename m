Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67978C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="XOGy/C/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE5C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbeGYA3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:29:25 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45524 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389178AbeGYA3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:29:25 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 15/21] MIPS: Kconfig: Select TCU timer driver when MACH_INGENIC is set
Date:   Wed, 25 Jul 2018 01:19:52 +0200
Message-Id: <20180724231958.20659-16-paul@crapouillou.net>
In-Reply-To: <20180724231958.20659-1-paul@crapouillou.net>
References: <20180724231958.20659-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532474436; bh=h967gpfixOFJqq7V79O1oI66BDb/fD2jCcCC6Sfba8o=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XOGy/C/INdyUPxzHJmGCYPsz/n/7OVo48NXhDqnv9WyuYZiFYIrzRR1IgdrcejkOQ4tsDhzkLcXEElP7fOy3vd9NHKA5ibnzU740wkmiiJ3qePy4URmNEVTDCB8ZhyhPn9mI6GDS8NpLmxYVJFhkba5DKVRbNb3KWIXDMPaltOo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot boot to userspace (not even initramfs) if the timer driver is
not present; so it makes sense to enable it unconditionally when
MACH_INGENIC is set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

 v5: New patch

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 08c10c518f83..254dbf69a4ad 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -384,6 +384,7 @@ config MACH_INGENIC
 	select BUILTIN_DTB
 	select USE_OF
 	select LIBFDT
+	select INGENIC_TIMER
 
 config LANTIQ
 	bool "Lantiq based platforms"
-- 
2.11.0

