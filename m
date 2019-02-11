Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A136AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709B12081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896304;
	bh=sQyA26nDB0R2IzjMTgXV5jlnL3DYu/gCAd2RUmlhDsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FkDwHYNDFIfVEGZsIFoHqhcEnqewuIN6zBEO2Qo4r46loKeLVmLWRjlOwJQgu1yYG
	 OTqKocbyH3ZS4Q8V8+saG5buW18GQdMa0kkIaItjpInlL8P3XKWI0GK6H8jfwY9DT/
	 VRk5q9JggfPsQhdluSDZqD7eQ/WfOEPP1uxlg2fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbfBKOpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbfBKOpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:45:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 848F820700;
        Mon, 11 Feb 2019 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896299;
        bh=sQyA26nDB0R2IzjMTgXV5jlnL3DYu/gCAd2RUmlhDsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGIEzUN8B4DikfPrXUnhuWo22PVRTGqbxuDMONtaLAj1dL4gyCjymsJa6Ez5MG7Ix
         /It7Q9SJK2fe5ZsRi4YKxCP4MUFJJZxohlj7tX3yw+0//ZutbeQi8kU2l14KZhAdxk
         Njaqds3EEy9+SMyBBweZvXVE6sAM8H836PMNa/aE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 139/313] ARM: pxa: avoid section mismatch warning
Date:   Mon, 11 Feb 2019 15:16:59 +0100
Message-Id: <20190211141902.953265668@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 88af3209aa0881aa5ffd99664b6080a4be5f24e5 ]

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
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-pxa/cm-x300.c   | 2 +-
 arch/arm/mach-pxa/littleton.c | 2 +-
 arch/arm/mach-pxa/zeus.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index c5c0ab8ac9f9..024c1fbcc55a 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -558,7 +558,7 @@ static struct pxa3xx_u2d_platform_data cm_x300_u2d_platform_data = {
 	.exit		= cm_x300_u2d_exit,
 };
 
-static void cm_x300_init_u2d(void)
+static void __init cm_x300_init_u2d(void)
 {
 	pxa3xx_set_u2d_info(&cm_x300_u2d_platform_data);
 }
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 9e132b3e48c6..9960ea158829 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -184,7 +184,7 @@ static struct pxafb_mach_info littleton_lcd_info = {
 	.lcd_conn		= LCD_COLOR_TFT_16BPP,
 };
 
-static void littleton_init_lcd(void)
+static void __init littleton_init_lcd(void)
 {
 	pxa_set_fb_info(NULL, &littleton_lcd_info);
 }
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index e3851795d6d7..68a536de542d 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -559,7 +559,7 @@ static struct pxaohci_platform_data zeus_ohci_platform_data = {
 	.flags		= ENABLE_PORT_ALL | POWER_SENSE_LOW,
 };
 
-static void zeus_register_ohci(void)
+static void __init zeus_register_ohci(void)
 {
 	/* Port 2 is shared between host and client interface. */
 	UP2OCR = UP2OCR_HXOE | UP2OCR_HXS | UP2OCR_DMPDE | UP2OCR_DPPDE;
-- 
2.19.1



