Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D4FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C526208B6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tO+bBWwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C526208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934650AbeGFSdz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:33:55 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36500 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934335AbeGFSdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:33:37 -0400
Received: by mail-lf0-f68.google.com with SMTP id n24-v6so10529779lfh.3;
        Fri, 06 Jul 2018 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGBfIL7tRd3MXtN/EzT01VuA8qTevDiBI+4vF/JqW3c=;
        b=tO+bBWwQ84kLt5sVNNkeCuccgYho6IY14XpzzyO15Qal2ueW1aHDsPPB375kzdnjJe
         m4U0MnC6AwDlxXSvR/FS2pxsySd8jETFYl4abm+BeB+2yM7zD8uBb49iBwTxeRL30jn+
         zrRStDNtj+I5X55+fGxs3WQH6WgfxFimEyJGJrWY8CT2ByeROO9ji7MY79wZe+ZiGaxS
         7w+zJHtIZw/eo57A6zJ9LJAoz4wCqPkSsxkE8UM07NIRt/hz/I+voZPYdu1OfLbxKQQB
         wWXRmB4rq0qW7/6oSK8VLRiTA6Dl7RxDZPUcYfSWixbKCaDaQn4XyfclemmRbpDpNVyQ
         eJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGBfIL7tRd3MXtN/EzT01VuA8qTevDiBI+4vF/JqW3c=;
        b=dY0uBC0r091w2hqUEswInuLofkHJEhZ+apbM0YsKFeC9lKoK2hAFITkRaZdvaKw8aF
         QtcF6LDQblsNTArifmw9u06NgI/DEPG0Mgh5roThwxDaA0+fR8O03H1qVqA8T5qky2uO
         ejWHlj9nEw4ih1XE2SQCXwBIv4vw85QIEetoOgHHOEY15sV0Qw/kr2zg3gJIFgY11+7N
         pz1a6LIrJqZZTuplfz9BTf3I8XQTzGDsVEmOm0lcVG0cuK4tsvV1XOU2IMS9RL33DuQ5
         xChq9eI+vA6FeGJwOl1okUnzVyr2LdBDcLyRTqBXMKWMJiuo5jSghUA5FUqIMQylZEYJ
         oU0g==
X-Gm-Message-State: APt69E3qFQuC6Jg+gl2DwJyK/NNcQv7bn8EVdsox3MqkKSabQ7OCOjRy
        EH3StkE9RWxciy6U1C8o6s4=
X-Google-Smtp-Source: AAOMgpefs9f03/bmFYESyk1grM8R5EnQl1JF8wix3SrCrKnn7mC0G+poDO9SikzCk8Gdk3CLP/KMQg==
X-Received: by 2002:a19:1366:: with SMTP id j99-v6mr8184466lfi.21.1530902015336;
        Fri, 06 Jul 2018 11:33:35 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id l82-v6sm2314697lfb.8.2018.07.06.11.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 11:33:34 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v3 9/9] ARM: s5pv210_defconfig: Enable options needed to boot typical Linux distro
Date:   Fri,  6 Jul 2018 20:32:50 +0200
Message-Id: <1530901970-14972-10-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables few options which are required to boot
typical Linux distro. It was tested by booting ArchLinux ARM
from sdcard.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/configs/s5pv210_defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index f719e7f9a655..a077597369f1 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -1,5 +1,7 @@
+CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CGROUPS=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
@@ -18,8 +20,18 @@ CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttyS
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
 CONFIG_CFG80211=m
+CONFIG_MAC80211=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
@@ -63,6 +75,8 @@ CONFIG_RTC_DRV_MAX8998=m
 CONFIG_PHY_SAMSUNG_USB2=m
 CONFIG_PHY_S5PV210_USB2=y
 CONFIG_EXT2_FS=y
+CONFIG_EXT4_FS=y
+CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
@@ -72,6 +86,7 @@ CONFIG_ROMFS_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-- 
2.7.4

