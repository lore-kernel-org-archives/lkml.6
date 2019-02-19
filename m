Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B91C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3651321773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfBSOwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:52:30 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:56481 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBSOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:52:30 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1YlB-1gujBA2Yln-00357Z; Tue, 19 Feb 2019 15:52:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: remove CONFIG_SND_PXA2XX_AC97 in pxa_defconfig
Date:   Tue, 19 Feb 2019 15:51:57 +0100
Message-Id: <20190219145214.3811804-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x4bvBMHiHPbWMhKrQcdgWXDZO6WyzNAmLpDDxKm89QKrHAOI5eD
 IlnHRvII32Ujc91l5+oVC+f87fVpvY6PfU/FrdnPkFNaj2VBtJefuQq/Jhm4/Qq1plfJI0P
 ro+/3K6qwvauN2rnoYeeloPGB7ojJa7KZtFJVKOKepwTPDyaA2UFPuKeOYZauFC5z5w2iB0
 umju6PwWOxyPY7G8SEqxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:04mafl0Eoak=:Pte53+ULKDbyM2QN1JQz9R
 sXq/KKtbnycw22I6SEFgltIpvhCFinDD8KPflOMPg6jQHoEs9XYbaZo96ruA3lpwH8cvG2LB+
 ErB4Ic8/K1zGeNPXwdJ9Pman04YW0/U7Ym6Ap0DXrlLT+Ijbp/LM4LBo2HbZr44NRBK5WVFM7
 cWSPPDoVZuNCAbDV6ZblpzwIK6x2TfQ+NNpPfvIedLpNGq4loBVTozY4KSzchmniSZiiiwhiy
 8q53Kp8QQg9e+LYQwVTtzyikKq+ekSWZc3fo2eRXCAN+GMPVfO2r3sJYsxfSbKKBLjQ00dEoO
 fsR52mA7YFl3s2+NJvSptE52K+/PjyIpgV6FkP5WpW70cMEOn8l/Ib1z9zYokbl5OydPYlgYG
 aOwcuZ4Dd+P/S4aQsX0KMZU6oWKMyx6eFDvvgJFlo4LnHS0ZxYXmw9H+I+AoSmePqj7ryoD4S
 ffC87srX8dOb6BAEX5PkLntB51yIx6NHWKOyeGxgNDZhGUQtMEjGwKoEkn4uQBlai5cABLuCQ
 eMfRukPiOS8B/p1fDAi5KxhEa/+ggcSOUB1sQ/fkvdk3/OCjgx/hzWSXhzVwrX2M7p8mKFh0q
 VUx7VcwG0b2Xjz7j13648iuO4v5nYPJyTEqyOiZqjBwIzXMpXLDujbnW8lWTYCCRUtDidnza4
 az2QonX8mzNVQRXHaepeB0FgQu3WgvWE8W+JU5omiO4KMohEh+maZCo2kCSx0yzzxqGMR7mXG
 Xk04ORUgA8IdzFWGpgLluDBfpdzyNzntn41tAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_SND_PXA2XX_AC97 driver is for the old AC97 bus implementation,
and conflicts with all the new-style AC97 drivers after the conversion,
so the drivers we want all get turned off.

Not disabling the symbol however does the right thing, and we get
the drivers that are selectively enabled here.

Fixes: 25540f68c871 ("ASoC: pxa: change ac97 dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/pxa_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 6bb506edb1f5..7f0f1fda2584 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -482,7 +482,6 @@ CONFIG_SND_PCM_OSS=m
 CONFIG_SND_DYNAMIC_MINORS=y
 CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
-CONFIG_SND_PXA2XX_AC97=m
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_ATMEL_SOC=m
-- 
2.20.0

