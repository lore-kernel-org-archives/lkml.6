Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FBFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6EE214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kx6bZkMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfAJOjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:39:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46992 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfAJOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:39:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so9880449ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GSxT6oKgkAEU+p14SpUooJ78BS9FtYp2WPB+Mr2PVJc=;
        b=Kx6bZkMIVoD/s02spJOxDJBY+TzF7TsXf9SMm1Oxe/ZLUQE8JAAaq4RrtO58IuFrgr
         Nf66k8NpFeVlIGIsM8mms3aD5ORQn82fTGBxke0Dl7pmfvPf0bKfO8oYIj8AOZ48tYps
         EtmSM6KNbLVXue8Dco+vdOAjOBt2D163CA0w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GSxT6oKgkAEU+p14SpUooJ78BS9FtYp2WPB+Mr2PVJc=;
        b=N3rmMvuqF+77f4Kkc1SLBTDLIzmnu7zInj4c7nsHetRQZQyISpW3ESRf09mMW+jUJK
         jiQIKPDkpD+9E2pHlk9G6E6uIkDAYgJXKTe+FgR9FtxlkLnKlKIyT3drwDWkJ49dD/4Z
         WQshvG1hNxaiww4AQneLPhwpFBLaa2cjwIxLJJUTDbZfeOSGtHTbn7Z4q2ncOW4omEgK
         qBZMaNOfZQGOKa2lVRHWGwvxlhDrfK5z4eXQWFcIqlaqPX+Kz330I9OFSBEG5zDXuFOI
         mDIh/yDVfEu0CWTMAYLUu59T6BTysUaOlQ/aAsgVWlDNfxA7Q/7KSn4teuCVrXNBYxRr
         2tAA==
X-Gm-Message-State: AJcUukeG0WEreJz7OFZH7W3VI/x+4ffx9dMQpmeU8g+akeaY4k171awb
        o6eHiN1MAkHz5y+GBpGxfaj5l8wo+NA=
X-Google-Smtp-Source: ALg8bN6igLYNPV3LIDXp0TJ7oMS5gamorK41qY9ntWrvLaJMLLsvVSCKTmCyBTi/EHcI7PNers4YwQ==
X-Received: by 2002:a2e:80d3:: with SMTP id r19-v6mr6030375ljg.151.1547131165830;
        Thu, 10 Jan 2019 06:39:25 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v5-v6sm15457931lje.78.2019.01.10.06.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 06:39:24 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.linux@gmail.com>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] ARM: config: spear3xx: Activate PL111 DRM driver
Date:   Thu, 10 Jan 2019 15:39:17 +0100
Message-Id: <20190110143917.9054-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190110143917.9054-1-linus.walleij@linaro.org>
References: <20190110143917.9054-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This disables the old FBDEV driver and enables the PL111
DRM driver on the SPEAr3xx.

There are some device trees in the kernel that switches
the DT node for the PL110 to "okay" but none of these
have any display defined, so we can safely switch to this
driver before we get any users starting to define
displays. Let them do it on top of the new driver
infrastructure instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/spear3xx_defconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 6753b373bee8..c42e3204e2fa 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -50,8 +50,10 @@ CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
+CONFIG_DRM=y
+CONFIG_DRM_PL111=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.19.2

