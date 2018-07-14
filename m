Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D75ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40922089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KypnvKEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40922089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbeGNNMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:12:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37226 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeGNNMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:12:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id v22-v6so26585120edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 05:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IS1GJUM9S7B8HIwdEFcOjjBErjjOL6EBH9mRjTk9F5k=;
        b=KypnvKEL9kRda36ELjL9+865wVGyKfk7JJHDnEcBN4EsiFADNDx7NLECN6QsVh8g78
         X5uGogLcEfuZ4T2kQNlPHw8ZxMSp4jjEGSpOa5Uvk8AiEYk7ZJ6Jk/M3cYiUMu0DQCSN
         g800aSLMTgtBxNACOcPgiOImpRUS763Fl3VUtq0FaKO1m+17yNZffsGzM1ZfWube7jc6
         XGpRx2XlVSyUyzA/aNMTJB/qyLmSLarl5+t0hvb1UdOQpCQEVbAqxKNKodp75eexrj86
         yWLcKi3dgwzV1DX0idY2FrfpucnvmaeGjvO7Gk6aY7VCfIGqU9mROHaYZGSJkY1B3eW0
         Lamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IS1GJUM9S7B8HIwdEFcOjjBErjjOL6EBH9mRjTk9F5k=;
        b=tmNtwPA98wiL+ZiOIl1TactkxhlJfO/uVde/7+odL0HRiXgxPN4fEbW8H+7JmuudNp
         TkwTbzPzhktNPnS7B3lA6B9auNIaSk+CLpq6NAZfQRwXs+ChT4ZBtNejel181EACGM8K
         hy5uV6NJWFz1Q2hSfCUcRSpYJmYAbDiQCNs4Kd91GDdjwmDA4dmr43tBQPZsw7hk2I6+
         HTEwpDDLKSxO5BUPFBhZn5IRSHbSawRHYxXhpO+7GoU1zYXPr+f/sORBETj5ka5nQLGT
         wzbl/V501SUAljyg2cLEE29NFwxXaXjupXgSzUZbQu+hDzTitYBPYVMl5Io7YymLY8eC
         NaBA==
X-Gm-Message-State: AOUpUlEfuSRdCv/mkAe6zRftR6G67E1GBRUGQlI/d6ZhByKwd6P0O3zv
        8Gy5tNKi7FC69a147ulyLOs=
X-Google-Smtp-Source: AAOMgpdiI+aFTpN4o/PNsn2RcnmgzH5+vZlcpS5n/J0oUxEeeVrpUgGlDcCmdiJgRt/BOWEn4AJI0g==
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr10648390eda.154.1531572793867;
        Sat, 14 Jul 2018 05:53:13 -0700 (PDT)
Received: from arch.localdomain (x4db2bd54.dyn.telefonica.de. [77.178.189.84])
        by smtp.gmail.com with ESMTPSA id n10-v6sm16577396edr.59.2018.07.14.05.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 05:53:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: rtl8188eu: remove redundant header file
Date:   Sat, 14 Jul 2018 14:52:41 +0200
Message-Id: <20180714125241.15509-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180714125241.15509-1-straube.linux@gmail.com>
References: <20180714125241.15509-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both functions declared in rtl8188e_led.h are also declared in
rtw_led.h which is included from drv_types.h. Remove rtl8188e_led.h
and it's includes.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c |  1 -
 drivers/staging/rtl8188eu/hal/usb_halinit.c   |  1 -
 .../staging/rtl8188eu/include/rtl8188e_led.h  | 20 -------------------
 3 files changed, 22 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/include/rtl8188e_led.h

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
index ca0b0f1c2a7f..412b76271a3d 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
@@ -8,7 +8,6 @@
 #include <osdep_service.h>
 #include <drv_types.h>
 #include <rtl8188e_hal.h>
-#include <rtl8188e_led.h>
 #include <usb_ops_linux.h>
 
 /*  LED object. */
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 4b3ece90bb34..d551d0cca90b 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -11,7 +11,6 @@
 #include <rtw_efuse.h>
 #include <fw.h>
 #include <rtl8188e_hal.h>
-#include <rtl8188e_led.h>
 #include <rtw_iol.h>
 #include <phy.h>
 
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_led.h b/drivers/staging/rtl8188eu/include/rtl8188e_led.h
deleted file mode 100644
index 74f2554e41d3..000000000000
--- a/drivers/staging/rtl8188eu/include/rtl8188e_led.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef __RTL8188E_LED_H__
-#define __RTL8188E_LED_H__
-
-#include <osdep_service.h>
-#include <drv_types.h>
-
-
-/*  */
-/*  Interface to manipulate LED objects. */
-/*  */
-void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
-void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
-
-#endif
-- 
2.18.0

