Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AB0C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D96A20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3hWFQZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D96A20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeJ3ENj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:13:39 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33525 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeJ3ENi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:13:38 -0400
Received: by mail-yw1-f67.google.com with SMTP id x185-v6so3874581ywa.0;
        Mon, 29 Oct 2018 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YL0HdZkPCdw1CCL6gh+aOFZfOsDccPVqMbEblUSgKXk=;
        b=t3hWFQZXTa3gdT8u5roAeXBpOVMmucs7Sml7jofbKrNFaCyk3Wk07zYk2+RpOralEw
         YPeEPdMvHXTLGZkds4fJZgc8zKxDFkbHS06tZjP3oNOhRIHs1BEJOU0dHCAShOtsjjZo
         dAWaRZacS13+qj7UyhjfIaahpmiJ3RQKFLzhgcwBBmKIi4heAiPbT3Aknsw/G1ckMpLx
         jFVb4d3FL2ST4Pa/HUdQ6dFZ9M7Hbc0qW1oaD8WseJnD8N+X/XCoH8YxH7dv7HyvCN87
         BXaBVGZGr1QAs/MIOEDq4bj2lVuUQDW0aHT/XcShKyxFjRF9gyU3VP156CU1elPTbhW9
         DFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YL0HdZkPCdw1CCL6gh+aOFZfOsDccPVqMbEblUSgKXk=;
        b=Ea7LioIhiigID6jxW8cGnHjSGJk5dKqS8GdJwjB/UQl7nbjoi5PsiLXekMqAwtOOHB
         yyKLUYNba+9gsNGRICbBwPdlpk8w6PiYRuCVKxtX6j5WSvJ9WOB8nP89eigumFozYbaU
         8kCAoaq29mWa1BUT8CztrREO0a14f+j1/qqWNvmFIcE4Ca22qErhVkH1Lk055OSPfkzf
         XW8IWN1TXE6J2d10a9KNqJ+SN3q9IOsm3oPMkpdO9P84dWv4+xG1Z2TNK86gkoMr5pXC
         snh3oX6PZqF21sJpclJykQIJcqml30MzRQYETqgQHoTUZwGx6zWylGaHid3o8skJ6Mud
         tJLw==
X-Gm-Message-State: AGRZ1gJJKXV/iUmEMGBdJhcqu9NgUq7LkR7lIr3PeklnD7K5yhQAcosq
        OIZ0M5Aw0BENkyVc4u2Kg11Dqd4q
X-Google-Smtp-Source: AJdET5cgRCqX84F0H+HUxaYu2M5Bp0gYI/v2sSKNjUsmqEqtruOiIQpOjlJ+xeWQt7SpUYFNQVYPWw==
X-Received: by 2002:a0d:d205:: with SMTP id u5-v6mr15271650ywd.427.1540841015022;
        Mon, 29 Oct 2018 12:23:35 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k85-v6sm5410014ywa.76.2018.10.29.12.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:23:33 -0700 (PDT)
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
Subject: [PATCH 2/2 v5] of/fdt: Remove definition check for __early_init_dt_declare_initrd()
Date:   Mon, 29 Oct 2018 12:00:14 -0700
Message-Id: <20181029190014.6455-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029190014.6455-1-f.fainelli@gmail.com>
References: <20181029190014.6455-1-f.fainelli@gmail.com>
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
index 76c83c1ffeda..0f6430265e4d 100644
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

