Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D793C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FE121829
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnUSIqMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FE121829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbeHDQgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34284 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeHDQgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so7435737wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VzHZKtMRJUwwyqLx4t2w/ZzM4LJ+vhuneO/97iZ3BrU=;
        b=rnUSIqMMtc9FmwPfc6HcD50pATmaynlcpEcv2w1p13asl/GaVXGgcC6HHOhGVh532j
         pInHlJ/NB1xibAhcJtV7VzalcOTG68/aD1XNwkIL8W/4se9mHiuK25A0s7kVxINMvyLi
         wTefIpCjcbwaeQiE1QZ2SUP4SOy+pERqCrMYg//pbG5bqaFu+XWDbqpOU8ZCjhWi9dSY
         tNaL1v9A4ATxJJahZBq7V8lulhmNHwzjoF+oTB8/D6Zcjd2WLma8hd0vXeaMAXo6vCeo
         HqaNxqv3QZpdq2ucZ0xHXzrqkctcY9qz0Yrn4+yQKIsAbvflkm6AZvh1i2zPHLlABa+w
         /E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VzHZKtMRJUwwyqLx4t2w/ZzM4LJ+vhuneO/97iZ3BrU=;
        b=BJD8GOirME2SfaJoCRjxqWa4oKVf/7mF2Yf0y0OWN9eDEfemg2THHGLFz5pYQM4xl1
         hNDMDEF07mBa1rVrCApbphCxfEeERKE2NhUFdkZQfOVMPEDA17Hpbhls4S8g2vkdN7ec
         w3WRZYs+huIVGB9b7DcDh6SwgBae3czgmMVHauFbPzlEqLxqOUvXYhHenJmGx0GX21AH
         qXUEzvyY4hVKU0MUK5Bc0Bq1Dkn2jxjGwZzhwNJ26SvKOUIdFx+cJWVXNT092nVW9Rhw
         PGnFBrlN81TAJuNvspLewwHrQOys2ko//mR/S3p01bIKM6uGyV7Fd9j30aCaDqT8KuKX
         qB2Q==
X-Gm-Message-State: AOUpUlHvGAaAHo1ywD3j1wNx5XDm1eHdPMgoG9pptyMOKq/ozUPQCftg
        b6oAC9qfw8BmPLFItSjyMII=
X-Google-Smtp-Source: AAOMgpfu7ZsF3YEEPXImab/kFDrC7c8t6Iev53zNm+OfGpU1YbG/Uv0VeEtveITN2is/CR+FQQskrA==
X-Received: by 2002:a1c:357:: with SMTP id 84-v6mr7217848wmd.8.1533393357848;
        Sat, 04 Aug 2018 07:35:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id x14-v6sm5409149wrv.21.2018.08.04.07.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:57 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: remove unnecessary includes
Date:   Sat,  4 Aug 2018 16:35:43 +0200
Message-Id: <20180804143543.1500-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143543.1500-1-straube.linux@gmail.com>
References: <20180804143543.1500-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the header rtw_iol.h there is only one function declared.
Remove the include of rtw_iol.h from files that do not use
this function.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/mac_cfg.c        | 1 -
 drivers/staging/rtl8188eu/hal/phy.c            | 1 -
 drivers/staging/rtl8188eu/hal/usb_halinit.c    | 1 -
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/mac_cfg.c b/drivers/staging/rtl8188eu/hal/mac_cfg.c
index 8e849228f376..370aa5cc55a7 100644
--- a/drivers/staging/rtl8188eu/hal/mac_cfg.c
+++ b/drivers/staging/rtl8188eu/hal/mac_cfg.c
@@ -7,7 +7,6 @@
 
 #include "odm_precomp.h"
 #include "phy.h"
-#include <rtw_iol.h>
 
 /* MAC_REG.TXT */
 
diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 0fe2d53310f0..3c7cf8720df8 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -8,7 +8,6 @@
 
 #include <osdep_service.h>
 #include <drv_types.h>
-#include <rtw_iol.h>
 #include <rtl8188e_hal.h>
 #include <rf.h>
 #include <phy.h>
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 56fda8005d38..12864b648fa8 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -11,7 +11,6 @@
 #include <rtw_efuse.h>
 #include <fw.h>
 #include <rtl8188e_hal.h>
-#include <rtw_iol.h>
 #include <phy.h>
 
 #define		HAL_BB_ENABLE		1
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 19387d87185d..bee3c3a7a7a9 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -19,7 +19,6 @@
 #include <rtw_ioctl_set.h>
 #include <rtl8188e_hal.h>
 
-#include <rtw_iol.h>
 #include <linux/vmalloc.h>
 #include <linux/etherdevice.h>
 
-- 
2.18.0

