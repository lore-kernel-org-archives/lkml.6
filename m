Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDE7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC9B21840
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="r91Ayg3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC9B21840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeHUUiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:38:22 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36442 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbeHUUiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:38:21 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 18/24] MIPS: Kconfig: Select TCU timer driver when MACH_INGENIC is set
Date:   Tue, 21 Aug 2018 19:16:29 +0200
Message-Id: <20180821171635.22740-19-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534871839; bh=mH6Ga8pJ369sJD9i63HQs4H1wCgEo3CLbvYB7ehcR6E=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=r91Ayg3hVWSgy5rtsR82vgl5HoTkHyN2AP1IhkUItHN8Z5BV1MFB1l1Ukd0c04QP8Vd81jtA+ayVs7HBBU/DiI0eh9IGIr/58TlfE3f90pBhU3C3wwQrNy6uOvyPXd1WDVXpltxUOm2X9zqNzqwUbgoB1vUv5QdSobAqOBop7hc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot boot to userspace (not even initramfs) if the timer driver is
not present; so it makes sense to enable it unconditionally when
MACH_INGENIC is set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v5: New patch
    
     v6: No change
    
     v7: No change

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

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

