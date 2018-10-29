Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F1C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7732084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGDIKmT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7732084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeJ3Inv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:43:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34178 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3Inu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:43:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id f78-v6so4838953pfe.1;
        Mon, 29 Oct 2018 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UCzz1toXQe6bQDYNTpARd+cAILXLMTsKuFpS/Hs6ZpA=;
        b=hGDIKmT8JC7ldxnYEi2TgGW3IK81ZJRtagn6wQGiIyQ5dvfVWuQNuNviAJ69A7YPbf
         2CtGs23/wkWaJTlEsYvj1Q0LsJ1R3TqDsBt4PgkChy7wjMoIEiD9ggIH90rEbEURFFGx
         3AQ9Ej2tM5ASJ3OoKYiYdt6+ZtkIMt12oFKc4GorkmUt/3VRfzqRKM26/+i8kUF1jM5j
         oOY0bfuw3OsCdbrqvgyxVLCZFVAN8ZCTnJE9Qc+qqskxNPJeRXukaRVk5/pOCCiLXiwV
         6UfaddskARqZz0FR51m9H/4hgWcWPNDQIgkFfgEUt3WOCLMwx7s8cSsneAG67ld1/84G
         xG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UCzz1toXQe6bQDYNTpARd+cAILXLMTsKuFpS/Hs6ZpA=;
        b=Ee2LWXX1UZx/uNafnFZ3GbTLWcQkcuBtEhHna+buWRyYjzxRKeW+EItxVoFvyOPQOW
         cdNAVygSGvCyAcb4P/4ODTYLb2ltEoUjnKA0lkTF6/GjIN4QzHaRL65LdUP2M8YXpnR4
         xavnMg8Ecl0m32xR567kpO0xgKSJ0L5ItgMA8dZzvZLbPOjgTfkQ6LL1lg/tnSdpUCfu
         UsWDYmcJw+n9mPI9Jw0TKZjaCV/hBS7h53L1HVe/zMctp1nGx+OHSfml+yyhWUbfDZkb
         JXyLSISmwpSKwergYayRF9UHfc3eNZ7IsaWhyXxkASlHlTI75DFod5yxLYDz/1U4PDtG
         eEXQ==
X-Gm-Message-State: AGRZ1gJODl4gktjQRqcWJo5gxLZJAlvvJVZjd6jVksnvU3BWPBxhV+DA
        v3JImvA98puOfSFWXm6LcKWL/VuE
X-Google-Smtp-Source: AJdET5eHYVb/NuHFBjEhkC8HoR0aFVfakxqd+ruG1hahbvjrnV9ih3tJJ5QxKfR5ltvetBxWyTVzjQ==
X-Received: by 2002:a63:fb41:: with SMTP id w1-v6mr15900303pgj.321.1540857166303;
        Mon, 29 Oct 2018 16:52:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k13-v6sm22537981pff.30.2018.10.29.16.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 16:52:45 -0700 (PDT)
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
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org
Subject: [PATCH 6/6] of/fdt: Remove definition check for __early_init_dt_declare_initrd()
Date:   Mon, 29 Oct 2018 16:52:06 -0700
Message-Id: <20181029235206.30060-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029235206.30060-1-f.fainelli@gmail.com>
References: <20181029235206.30060-1-f.fainelli@gmail.com>
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
index 313cd4f24258..3d84fe79eeb4 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -892,7 +892,6 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-#ifndef __early_init_dt_declare_initrd
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
@@ -904,7 +903,6 @@ static void __early_init_dt_declare_initrd(unsigned long start,
 	phys_initrd_size = end - start;
 #endif
 }
-#endif
 
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
-- 
2.17.1

