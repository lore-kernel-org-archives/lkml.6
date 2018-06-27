Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFBCC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BE025AA9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjGk/zbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BE025AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966086AbeF0RM7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:12:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40232 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964947AbeF0RMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:12:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id a6-v6so2233795ljj.7;
        Wed, 27 Jun 2018 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGBfIL7tRd3MXtN/EzT01VuA8qTevDiBI+4vF/JqW3c=;
        b=DjGk/zbFkBUYU2pkx4uHAbwInD+MlVgPHL0b/y7PepGsjdUTovi1fyBe5R+2zDd9fi
         CD5ztHAuIjl7ttWs8EXfEPlym7BiVXjgMmkGTfuJfEXTeygGfIK+cZS8Tsq8Nyn6vIT3
         NXv5/e2vzrZJyEdMbyGPfXa/tys1xzvJ1G7Iq5byHjFs/ucMzSE5FU8IUEDRaieVwfk3
         6y5jUg9tPEDTdYKqUsxzhPdC2J0ut5rGXWLlE5C5u20ioX5kYkMpjzt31tkPWIdMIhLF
         gcJohZnmGnbIP0Rq6smQccngf2GdZWJdMM7oSlj9Ze9x/mGqI+CLlI386Gh2cqzCsfmC
         ZoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGBfIL7tRd3MXtN/EzT01VuA8qTevDiBI+4vF/JqW3c=;
        b=DmZSSK37sizXgc+X2z3yc+jvOZ/ldb1EcqOd/lAVIV4GW+LAxJ8JEZH6jz8dNHrjnJ
         tUaKxaaEH7Q2Xd4ENvLil8ZHIy23k/v/hfnEaBHZdbp1kROUsS31m6gD5tOEMuEx+wai
         qNKBnvqcG8/GU6TxQaF9V3NImnvsSzV1cXXVajs/5HMkZHjawmRoWGazzxZQnrwSTFvt
         lTN2Xy3lhOQWgUNRXrUpIzkiZfjyXaZpvON01LaATAV1LtU4CIJ2LrR54D1dt0kaeVx3
         U0qWvU/zGm8eaIijHGfZqR2PZwyVs8FxPlluwjd6Gvl73RCzTsQxwNHavD34LxPETgB7
         UuvA==
X-Gm-Message-State: APt69E01L6sQUuoBG4gKjJlmySzSsiShTCwxze4yTNgbBj/yzK54yEtv
        /pzC5ygFB690Ebk5e+97yjc=
X-Google-Smtp-Source: AAOMgpdELhvRo3YFUe2udI8N2rBo/nRLEm0rAMt25odL8Q/G7JvnbD8PQvzzqZYk/L3gcspJvCg1xw==
X-Received: by 2002:a2e:5d88:: with SMTP id v8-v6mr402336lje.137.1530119571686;
        Wed, 27 Jun 2018 10:12:51 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm929344lfb.7.2018.06.27.10.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 10:12:51 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v2 10/10] ARM: s5pv210_defconfig: Enable options needed to boot typical Linux distro
Date:   Wed, 27 Jun 2018 19:12:24 +0200
Message-Id: <1530119544-30023-11-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

