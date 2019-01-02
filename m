Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E2C218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAlrMqV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfABRgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:36:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53568 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfABRgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:36:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so27257961wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 09:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsJFoVJf3IIY1mc4G8PoWo9I+7LoITd3hZ2Vo5zkWAc=;
        b=lAlrMqV+AGSkWFg5yrz2JZbPk6RoKIqYdaAHGwn+o5V/PT3wER7ZaMKwkE5hdb8SuZ
         LPObNhnGQkXOjiShOE7KLEe+L83ocrpqNvR5qQwkMP5Jd9WvyCHU1XtGvb8QckxB9cCo
         gFwgxa8I2Z6nAI/XlNVC2sTC4UcKZCyjZClhL4LmKKz7nwSQmrvkj3eDWI5v8Qyf3dVU
         KN+qP7/l7ObKbX4pR3rxTA8VymtrWoOGIyD2lKYFGn5sBzxkrkvUhOi4CFKYCGGGVkVv
         6IVZkI9DYKZ4d6sI3dIg+OQntY2oMujijkTJspbpA7hPOjSgmSOqiAXGwZvhxQwTzZsC
         vurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsJFoVJf3IIY1mc4G8PoWo9I+7LoITd3hZ2Vo5zkWAc=;
        b=DicF6SF/ZOCoW7jpiaH/iLQpw3+aqDlpV7pjRMINXUKc9T1Bp1gqT6nW9e9vYychSC
         2gehE8PrkNSymk/jlQ+wgU0lVTvcAX7/co8OLdVXU03JGM5WRd5PeNBg5bO0s2e9AJ8l
         EQFoYF/eB0fRCMetYq86UP9bP3texfvh7VrLUHitprgHsLKHe1IeWrtf30V2XnGqUM57
         jIc470k25wM517nh5J1KhgHAFYzPej7v4lvlQbBZsb/5J8syblgdjjSZBuOXVgWK2IHV
         V69Cf4fsjPHxeIyraypx7bq9zgg/cHfiPjs2nBf0pLaO/rYIODCL9Q5TXe4znnjXSaS2
         z0PA==
X-Gm-Message-State: AA+aEWY2/rqgxoa4qKrptkObjHK4erZIgdbCSA3Jymyn/iJRpyUBIM6L
        UXPS70LfzBZBzUb37HqdB400Kw==
X-Google-Smtp-Source: AFSGD/VaDhJ7tSu1Glf9joOK/KwNwzfxgXuAYl8ckeRSP/aFiyqPuu4bYT2MGG+9MfJfx5N6OAZhBA==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr35511822wmc.42.1546450574842;
        Wed, 02 Jan 2019 09:36:14 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id t4sm45987076wrm.6.2019.01.02.09.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 09:36:13 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 1/3] kasan, arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
Date:   Wed,  2 Jan 2019 18:36:06 +0100
Message-Id: <b16c90197bb2c06c780e6e981c40345e03fda465.1546450432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <cover.1546450432.git.andreyknvl@google.com>
References: <cover.1546450432.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.

Suggested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/kasan.h | 4 ++++
 include/linux/slab.h           | 1 +
 mm/kasan/common.c              | 2 --
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index b52aacd2c526..ba26150d578d 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -36,6 +36,10 @@
 #define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
 					(64 - KASAN_SHADOW_SCALE_SHIFT)))
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#endif
+
 void kasan_init(void);
 void kasan_copy_shadow(pgd_t *pgdir);
 asmlinkage void kasan_early_init(void);
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 11b45f7ae405..d87f913ab4e8 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -16,6 +16,7 @@
 #include <linux/overflow.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/kasan.h>
 
 
 /*
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 03d5d1374ca7..44390392d4c9 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -298,8 +298,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		return;
 	}
 
-	cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
-
 	*flags |= SLAB_KASAN;
 }
 
-- 
2.20.1.415.g653613c723-goog

