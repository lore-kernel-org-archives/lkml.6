Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4DAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1AC20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7JVkYmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1AC20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeKFIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:31:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44279 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeKFIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:31:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id m18-v6so7428833lfl.11;
        Mon, 05 Nov 2018 15:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tJLRr6QbnqdTTEgIJ98Np6XMLsOvBj9N2cxclNb6K2c=;
        b=H7JVkYmZZwHQGgOOm3HYDLMMitw8SCx7TZep2F79ApE/7QcwbtIAcPEfuSEnVF+RaT
         cg8WSU8/SEG0EAypqdxEJ+a6SCbwMD5GoiRMsztMdEgCm7ZEq+oxIYOwpNP34fV2A1XA
         O//O4ouUDF6VAi2qjBJhBpQX0daGF3h97Ueh01ottJghcFHAEA+wAUvfWNewv0ox2Ogs
         CF6fww6ELD/Cq8CqerXq2A02ZIjNPXsB5vjqtZRNlOpzwnmx3tVjaoptkvU6o8T1ama6
         wEUsrtIGed/JpGCmTsdHGU+byWNDWQXWk4DPKXXkWAPcPgkWY9aDe34xojiMDm1Zs7fz
         qOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tJLRr6QbnqdTTEgIJ98Np6XMLsOvBj9N2cxclNb6K2c=;
        b=ZUEllhNMG9c6pDZYTHQ9ToFOBeyYPQZLDjTEtjv+JnapdMGVlYtVSiIB/eA6IQCXtE
         0IUlVI8kGtAp+M1OHK5xmzsgzDh3t6zr8pskGswl1gD1zbf5q91GIFoHTW4Cw2y0wmBa
         YJumZN5wOMPKYBRvv5DpQzuIcf+bJgJHHNCOIkrXV/xgvCOPMTSTYsex0KLsOUtWpjlA
         W5VtckAXnoF78ci2JITMLUjK12+oiW9cA/89AaqCKoZGwsdGNvuSZNXMUqDmNv/QEFvO
         EssyVnvkbzYADWuGE5Z4/YdESu+67EARA1NfJSIoNMZFYk8jkbdHLFCJEPbZj+ZyE5B6
         tfWw==
X-Gm-Message-State: AGRZ1gLC6CIq7vqf3eLgpX3Qc5bJurZHNoJifnkZJhW0cYHgG3OJBcsy
        b6KgoX7nKxXHoZ7TLEWm7vFdkxk82nk=
X-Google-Smtp-Source: AJdET5dnhXI/QIdh0ybsXT0jiIiZ5BWiBsqK3ncYm/fpUg1bXDH7qvzpWUM6/pJJ7DWSATQK5Lt/4Q==
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr2457029lfc.124.1541459385891;
        Mon, 05 Nov 2018 15:09:45 -0800 (PST)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id k68-v6sm99387ljb.35.2018.11.05.15.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 15:09:44 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: make board header file local to mach-omap1
Date:   Tue,  6 Nov 2018 00:11:26 +0100
Message-Id: <20181105231126.12674-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now as the board header file is no longer included by drivers, move it
to the root directory of mach-omap1.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v4:
- rebased on top of v4.20-rc1
- resubmitted as a standalone patch, other patches of the series it
  depended on have been already applied

v3:
- rebased on top of v4.19-rc1
- submitted as PATCH v3 3/3

v2:
- resent as PATCH v2 3/3

Initially submitted in series as PATCH 6/6


 arch/arm/mach-omap1/ams-delta-fiq-handler.S              | 2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                      | 3 +--
 arch/arm/mach-omap1/board-ams-delta.c                    | 2 +-
 arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h (97%)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index e3faa0274b56..7c9fb7fe0070 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -18,9 +18,9 @@
 #include <linux/platform_data/gpio-omap.h>
 
 #include <asm/assembler.h>
-#include <mach/board-ams-delta.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 #include "iomap.h"
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index b0dc7ddf5877..14c3d3f5255e 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -22,11 +22,10 @@
 #include <linux/platform_data/ams-delta-fiq.h>
 #include <linux/platform_device.h>
 
-#include <mach/board-ams-delta.h>
-
 #include <asm/fiq.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 
 static struct fiq_handler fh = {
 	.name	= "ams-delta-fiq"
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 3d191fd52910..b8acc9912a58 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -36,7 +36,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-ams-delta.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <mach/mux.h>
 
@@ -45,6 +44,7 @@
 #include <mach/usb.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 #include "iomap.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/include/mach/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
similarity index 97%
rename from arch/arm/mach-omap1/include/mach/board-ams-delta.h
rename to arch/arm/mach-omap1/board-ams-delta.h
index 3b2d8019238a..a74a306d7e77 100644
--- a/arch/arm/mach-omap1/include/mach/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/board-ams-delta.h
+ * arch/arm/mach-omap1/board-ams-delta.h
  *
  * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
  *
-- 
2.16.4

