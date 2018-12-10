Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56C4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BD22084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BD22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbeLJWBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:01:15 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:41611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeLJWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:01:15 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MDQRy-1gdb7r20LW-00AYJq; Mon, 10 Dec 2018 23:00:05 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: pxa: avoid section mismatch warning
Date:   Mon, 10 Dec 2018 22:58:39 +0100
Message-Id: <20181210215856.2238253-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
References: <20181210215856.2238253-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:op5fpHUg413BwkzBl40iq+Gi+V2I2A80rX9YvUBiIA3ewZpCu3+
 4BfpTBlnuSadxNlcNhoiRjVsPjHgrkdfa+hn29jiLca60B614GT8lwcVG2V6XNH3nQAfEJB
 C14/CzU1Ml/twPNzD8LGMwGGiAojrq3F5ZVSgzEEPkR0alfPoMYNrPOnNytDWbd7DTQ3iiY
 5zca4d+M+TCFXh6CVVTiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hrlG9Un2ALQ=:DCcryrPNDhf7kmYDcs4RXw
 TeC+J75xO8JdCPVmpVbrcVz/8vQ9KSkkMusgjGJAS1m8B6gjibqYNVoJhOXn+fV2/Q1cRvVYS
 pSlctY+MP/zF6zpTOaFRJckAc9wGAGq8rQE2l8lWYaWD1Xr7yoEUm+tx0BwBnWfwbg4MQFZT/
 oaa1VTtjv1pOIVdNgvBY0qOgvzv82Qwm+mAsj/HgpmsqtfaIr/7Ogw1M+lbD4sAgtkxG4IM6/
 P/yRMpMIF9NswmJ3C04NpEYnvatKb4v4m50TdVfnO38AoRuLd2u64n/DnD8NhPUVYuggu7+Sx
 Li43CdWd5AWRDEEewi0IYlJfRD3zBWFurRWtEA+9p5mTCiLPzAGWBPm4+wcCgyE/vVUs7nMG+
 WkE8pgVrevAYOHfLYFHp4vZN10fB3N50VuBCYnZN3qDyY1IeAKzITmY+WyLAjcTwHQZFu/Hpz
 18i8PD4BrJlYSsHif/fiWfGOzeBdCOSrnVJ/1XeU3cgSL4ZITceEtcy0DWUi4Ta9OIC3nBTve
 rtOUmQ3hGxvXzjjOSEYXWAi6/OQGsXuVehbHsEA34xHlshqiV0o91jG76dBCeTz89KoK1Ba/f
 oCXij6SUi8Wf7y2jYRLokrOb7qSNfUpAofEHV+QBz9enpYLuABWePi2X+okJzBDMYgQjyNANz
 cXH7b9EJCd5HRoLNgqjPRlyH744WtUauUO7lkZebDMAwJmGeXwEFXp4B/Aqqt68dMX2p/6xiA
 VLjLwlVhHIGYXWI8AaHeO4KTH0By0iVAMrEP+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: vmlinux.o(.text+0x19f90): Section mismatch in reference from the function littleton_init_lcd() to the function .init.text:pxa_set_fb_info()
The function littleton_init_lcd() references
the function __init pxa_set_fb_info().
This is often because littleton_init_lcd lacks a __init
annotation or the annotation of pxa_set_fb_info is wrong.

WARNING: vmlinux.o(.text+0xf824): Section mismatch in reference from the function zeus_register_ohci() to the function .init.text:pxa_set_ohci_info()
The function zeus_register_ohci() references
the function __init pxa_set_ohci_info().
This is often because zeus_register_ohci lacks a __init
annotation or the annotation of pxa_set_ohci_info is wrong.

WARNING: vmlinux.o(.text+0xf95c): Section mismatch in reference from the function cm_x300_init_u2d() to the function .init.text:pxa3xx_set_u2d_info()
The function cm_x300_init_u2d() references
the function __init pxa3xx_set_u2d_info().
This is often because cm_x300_init_u2d lacks a __init
annotation or the annotation of pxa3xx_set_u2d_info is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/cm-x300.c   | 2 +-
 arch/arm/mach-pxa/littleton.c | 2 +-
 arch/arm/mach-pxa/zeus.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 109fab292f94..b76b566280fa 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -564,7 +564,7 @@ static struct pxa3xx_u2d_platform_data cm_x300_u2d_platform_data = {
 	.exit		= cm_x300_u2d_exit,
 };
 
-static void cm_x300_init_u2d(void)
+static void __init cm_x300_init_u2d(void)
 {
 	pxa3xx_set_u2d_info(&cm_x300_u2d_platform_data);
 }
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 8e0b60a33026..39db4898dc4a 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -182,7 +182,7 @@ static struct pxafb_mach_info littleton_lcd_info = {
 	.lcd_conn		= LCD_COLOR_TFT_16BPP,
 };
 
-static void littleton_init_lcd(void)
+static void __init littleton_init_lcd(void)
 {
 	pxa_set_fb_info(NULL, &littleton_lcd_info);
 }
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 897ef59fbe0c..c411f79d4cb5 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -576,7 +576,7 @@ static struct pxaohci_platform_data zeus_ohci_platform_data = {
 	.flags		= ENABLE_PORT_ALL | POWER_SENSE_LOW,
 };
 
-static void zeus_register_ohci(void)
+static void __init zeus_register_ohci(void)
 {
 	/* Port 2 is shared between host and client interface. */
 	UP2OCR = UP2OCR_HXOE | UP2OCR_HXS | UP2OCR_DMPDE | UP2OCR_DPPDE;
-- 
2.20.0

