Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60A5ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9514F214ED
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEelfSNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9514F214ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeJ0HTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:19:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44971 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJ0HTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:19:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so1153874pgs.11;
        Fri, 26 Oct 2018 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s9oKvIT0NBM4/QkLDCZzAlsB4eCuoBdrv+ulGIgxa6g=;
        b=ZEelfSNMbOLzf7iIe/u36NptjUa3Rs/vDqHNXDTR/SPFGcJqqhS1aWSQKJxY2Y7R47
         POYNNV2SDUYAeOwPV4NXGJwuPn82yxbWk/6gzhEKP4mgxNmeIqhXRoxI6iGvyVAxyjgd
         B+LXcZoBWTSQG7dZzF6HQ+0/U3TwR8HuOcjlzCTFKYPwxuvlmgyH+yRmhPVIJ1QrTcFI
         CRVISLp6s97luxj7QXuI+p2DnxjXhrP4CRkXH/w3kTA1+xd16tw9Q9twQGqGwZl18rg4
         ibXDTclGyo98JTbo77b5c9VaCdO39WxWnkfP9HL/+Q6qlriNGENeahsVStLaUJ35c2YY
         NADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s9oKvIT0NBM4/QkLDCZzAlsB4eCuoBdrv+ulGIgxa6g=;
        b=SPc9XKjUhRbJbdyQ6L46d2xbVHDWTB7ETwgqnR/q5015o5gjgwDIB/5tEP89b2Wbbg
         Lu0gimNRdPPWJlw7/+cu+nZgmjswxMjr9ybQK56OYxDUSPfYWnuKQ5Ty2EPnFPy93tnS
         0A/BwM1+q06nj8U1HknkN0mxdv8C8NitZtp0SV/nB6vVdKTh9oVhYjRlqcvhFNQpi3Mg
         Cl89HiAdBEgmGfwVXCRoH7OwOqceAl4/ihNplwSTD2NkZ3LLc5EYMBQtoElAo0rmu/gr
         O+N6Z/lHMh1M2t9u+RUs3ICHLwAqzqQLkTkvRougY5IZpmZShzH2+6KG4L7+VhhC3VsZ
         ACaQ==
X-Gm-Message-State: AGRZ1gKfdq5EUvBp3Jwnqz1O2etz8/qrubYA50jDOKRH+JqhvWrQ27nv
        lytwYp7sC/gikuYGBP05ggT1PS0c
X-Google-Smtp-Source: AJdET5fyHjPokgv+7kYchOd03fhrhfg0lLcM5fb5tLBIlzi/WVx1W55PqjbJOx4D22iJv3uwzQo8VA==
X-Received: by 2002:a63:ce14:: with SMTP id y20-v6mr5342817pgf.248.1540593620029;
        Fri, 26 Oct 2018 15:40:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id t9-v6sm3665536pgl.37.2018.10.26.15.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 15:40:18 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk
Subject: [PATCH v4 2/2] of/fdt: Remove definition check for __early_init_dt_declare_initrd()
Date:   Fri, 26 Oct 2018 15:39:51 -0700
Message-Id: <20181026223951.30936-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181026223951.30936-1-f.fainelli@gmail.com>
References: <20181026223951.30936-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the one and only architecture (ARM64) no longer defining a custom
__early_init_dt_declare_initrd() function, just get rid of the check for
that function being already defined.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/fdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..797c9e2d6d57 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -892,7 +892,6 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-#ifndef __early_init_dt_declare_initrd
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
@@ -900,7 +899,6 @@ static void __early_init_dt_declare_initrd(unsigned long start,
 	initrd_end = (unsigned long)__va(end);
 	initrd_below_start_ok = 1;
 }
-#endif
 
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
-- 
2.17.1

