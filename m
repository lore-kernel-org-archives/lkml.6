Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9301EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB7820883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1v9EDJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfAHQ4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:56:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33467 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfAHQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:56:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so3469265lfc.0;
        Tue, 08 Jan 2019 08:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6vP2tUy9VuXRg7vgiWwWPbY3vNG9OBcmWv1+qDoTUA=;
        b=k1v9EDJvIVSooF3J5/a4H8cAszEGWnJ71U5Qj2RxHPonru18IdlJiRN2+qQ9MyOj8o
         QVtA/dxlgmJewngXIOliZLQ7GUMWCJytYrz3CuaDFJKhXiKAED8BVkNK6cccibABU/pf
         MOwkkLfx9ziTAyEDDkSZQYpMIzFiHSUYnFXuUa2a4sVaev9GjJOm7dEacAdaw/Q0+o6f
         4y+SQdh9WGd5Po7mQDDg/FIW9VtkJmseHfbCVzfobqwIrsF9YUjHD+IFFtsv+DFG/YZs
         Iobn5fVXH4CAWpMI94Bh5RIA29S8N/A8TisARNw6xCHKgZlaDtWm6n8xQL71dJ4NF6Xr
         6vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6vP2tUy9VuXRg7vgiWwWPbY3vNG9OBcmWv1+qDoTUA=;
        b=r97/7g4bCMC2//2IinPi/HqbKfX4IRNe7GjqlReuUB3L0lB1KhT71FR+VdJDGn95ke
         cbcZ8bIAKb5K0FKn1cpVAzZNMJ0nh2puDXQLU4/FVCgmcIHFtQcv51VYrEoG0/DCdss+
         ttCvtDDd2eDl4e9B+OymDEfr1EBwdmEZupAtxUIobvDXwD2JUyP3JUlx2r4YGmdhEU5p
         nhnZvmxawIEugqk0CU6Uo/9ntCy++6wQ5Q7uUe2kamtcWud1OHVx1Vzu1Vv8GIteuf/B
         zsCIkRIDzySwd6ojX4kIQt0frL7w7wtIU5iYn7PGmNAQPwFSWzFvE3J+Qce+TTiN1AR/
         jYKg==
X-Gm-Message-State: AJcUukfI2zHBOXOY9L/0WXS/SvqVRDMHPFHmCqIFUOBvVxtM6P1/J26w
        hdN10w4NPgUa9JQ2E4reuWA=
X-Google-Smtp-Source: ALg8bN5JWkx9Iz6hBHw8buqUsoG7CsiONz/7/dji3w2ArYPNIW9f6S9k2uuUBpVYg3pHrzW4H7wWkg==
X-Received: by 2002:a19:200b:: with SMTP id g11mr1456972lfg.58.1546966571781;
        Tue, 08 Jan 2019 08:56:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.googlemail.com with ESMTPSA id f8sm14687989lfe.72.2019.01.08.08.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:56:11 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: defconfig: s5pv210: Run make savedefconfig
Date:   Tue,  8 Jan 2019 17:56:00 +0100
Message-Id: <20190108165601.25708-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is result of running savedefconfig. It's preparation for adding
support for more hw present on Samsung Aries based devices.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/configs/s5pv210_defconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index a077597369f1..0159636d4c0d 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -1,24 +1,24 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_CGROUPS=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
-CONFIG_PREEMPT=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
 CONFIG_VFP=y
 CONFIG_NEON=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -87,6 +87,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRC_CCITT=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
@@ -99,4 +100,3 @@ CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 CONFIG_DEBUG_S3C_UART1=y
 CONFIG_EARLY_PRINTK=y
-CONFIG_CRC_CCITT=y
-- 
2.17.1

