Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C67CECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E1320838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC3sxW+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E1320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeJYIsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:48:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44695 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:48:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2-v6so61582pfn.11;
        Wed, 24 Oct 2018 17:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1EIGYbmBEzSAvAC8bdZSJHv2E1NCYLeFw5YRiyglxcs=;
        b=UC3sxW+DDxcFyFp3fPgr/Z/Vzr7pxMXo0PrGgiSzdft8L/Ga8eScndfwGkzbv6fluU
         ddf1iFCtzlBmIVXPYQkUIwl40KP/9t//GORs4+MS/smAEM4A5J52FyBfv5bj348ykbu0
         BtLe4yyLj0EsFc7iAbyZ5MqZoU6Vat07BQmOvDCvGevh8Nl4omrM56+XkHRkcfIh9QxY
         8KlOFIVm1Z9Sc5MYLuPJXPatQ5csim9QkPHkjo02WTNW5QMEent/LSeQUULFvjI7iw/W
         HhkL8TFt909AZHt5OgenSRNvqZmfC2zVTiuXRgga3uWyrSQMM+A7ukVPBt1IYiQUgNR7
         YgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1EIGYbmBEzSAvAC8bdZSJHv2E1NCYLeFw5YRiyglxcs=;
        b=h9EvKwqoPaaik44bph9RrvxrdQ03fjig4aERLhZHipXn2E0qmZkUvUi2G3JT1JMCpA
         sQy1Ht83ynqLrRHTT87nUsf+CzYYp/HdDZoNMkz3yps/PtxbLeh1W9n5EBA5l0/B4xo6
         Yx9Xv4fQ5V4zbGl2tSItvtYs9vD/qznlCf2i2XW9U+18CdQXUo7olTh4+HKjfb9WH0Ma
         ZyTyJ8uROCKGlHJVrYGxhYK1n8sW5kgsdsEWmD+FPnfE5wWaXoJyODmXipV2XfxIQBGr
         i6fnXtC8tzUtTMjM/CyD7c/xX5rFqsOhq3tUdmvw5SKtAQd0Ljl0CC4Ry/V2f0VcNrkz
         eBug==
X-Gm-Message-State: AGRZ1gJ1aROGjSRWUlRSrx0m2yUfcZNWwmudZu3wcTZe6xFZaNSX5Nyu
        ngYv+vywVZjyO3gZzbWZUaXN6Cf8tkw=
X-Google-Smtp-Source: AJdET5dujOmGkNf8qBtC1QVDzzE4MU5LtYBBhcL5XSr9Muyj5ivF1zDWpBujzUI6cEoBe+vs/WJcvQ==
X-Received: by 2002:a63:cf4c:: with SMTP id b12-v6mr4451513pgj.418.1540426677533;
        Wed, 24 Oct 2018 17:17:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z87-v6sm11615707pfl.58.2018.10.24.17.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:17:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), arnd@arndb.de
Subject: [PATCH v3 3/3] of/fdt: Remove definition check for __early_init_dt_declare_initrd
Date:   Wed, 24 Oct 2018 17:17:42 -0700
Message-Id: <20181025001742.6510-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025001742.6510-1-f.fainelli@gmail.com>
References: <20181025001742.6510-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With ARM64 no longer providing a custom __early_init_dt_declare_initrd()
in its headers, and no other architecture doing something similar,
remove the check for __early_init_dt_declare_initrd being already
defined since we now have the one and only definition for it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/fdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7d316f008f22..2e962d75dbce 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -892,7 +892,6 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-#ifndef __early_init_dt_declare_initrd
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
@@ -905,7 +904,6 @@ static void __early_init_dt_declare_initrd(unsigned long start,
 	initrd_below_start_ok = 1;
 #endif
 }
-#endif
 
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
-- 
2.17.1

