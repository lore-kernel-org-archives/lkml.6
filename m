Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeBTFZL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 00:25:11 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44460 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeBTFZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 00:25:08 -0500
X-Google-Smtp-Source: AH8x224d8SI56mIwsL2DYZY1mqNFNsrSiHJcY14CpbuxF/pUXKZ6EM+EHIqE0M50TS9lngPyj1aUcg==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] platform/x86: fujitsu-laptop: Do not include linux/slab.h
Date: Tue, 20 Feb 2018 06:24:52 +0100
Message-Id: <20180220052454.11134-6-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220052454.11134-1-kernel@kempniu.pl>
References: <20180220052454.11134-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not include linux/slab.h as all module code now uses managed memory
allocations and thus neither k*alloc() nor kfree() is used.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 7888b779d6c5..17779b8b7f30 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -61,7 +61,6 @@
 #include <linux/kfifo.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 #include <acpi/video.h>
 
 #define FUJITSU_DRIVER_VERSION "0.6.0"
-- 
2.16.1
