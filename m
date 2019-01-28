Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886F5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4F32147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690719;
	bh=e9/c6A7PIyvAymmZxpbMq3tCY1Ai/E2lqcATqD7TE6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0UtU9rb2mRhsV5jBJJCdBDDVq9DTOa2OwBZm8alAzbBknqr1xQhDrJMO0RvoTm/iQ
	 LMS5KzWovTSQyZrZ2rq76yXgsPWxgTrVoXqyyZK6/zMbGS3of6V1/LBYnVp69ziMi1
	 dDGFKdb7Uo9z4AywveIZONXVudqkGTEZ21Iq/uVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfA1Pv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbfA1Pvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:51:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE72821741;
        Mon, 28 Jan 2019 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690712;
        bh=e9/c6A7PIyvAymmZxpbMq3tCY1Ai/E2lqcATqD7TE6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2IQ0FSR+suErfynj9wi9g441DaRRF7QegjSo1nw2UVnomuSoYkyalVaHeJAloOM1S
         ObW2TgN/PdwDX5vkZtyrTGsF8omRnyaChSS6OV7HOmNAGYV1xkIBjJOh0FvxCIhVAe
         3VLizuhGFahqejGTcT8FRKoNcv3PUB6ulX7beJFg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 173/304] ARM: pxa: avoid section mismatch warning
Date:   Mon, 28 Jan 2019 10:41:30 -0500
Message-Id: <20190128154341.47195-173-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

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
index d53ea12fc766..54a32f0433a2 100644
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
2.19.1

