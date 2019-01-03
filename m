Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF626C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC5B217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzRV4OzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfACSpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:45:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35286 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfACSp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:45:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so34538228wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 10:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcZuxDuPGnY34gBBOzPjzW9RC6MdmGqedzN7uzgRX8A=;
        b=JzRV4OzU47GC2npsOEq89Allc1qgPv+Y5jsoLkXuyflZ9xTmZcqNEWdvopVB2mLN9u
         8dO+4sD19DkkXcPnobH6i4C8sPCDcTKX0Zb5bMIzj7AAWZze9z4tJvCau1rxfVHhRRRb
         jSjusOJhz6SUeB4bWg1pRK3Ec1iK+PCIbicMVihCOHNB3eu8wG57R5YW7mn3YHEbjXfG
         GoNIzVch9Hl/MBebbU2cyVjj/+ZtkiaLrajzmanxTB4cyMH9xs/7d39MOEsVTcaLg585
         xYTZJkUhlbbMrBQ3Hrw6gURwz+PJUt3SD5vFdNZwyzVNZuM8xmb9QtROaHCZOT2IPHuL
         VF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcZuxDuPGnY34gBBOzPjzW9RC6MdmGqedzN7uzgRX8A=;
        b=iOsin4/SbM911Jnh+wo6SFttzaYxmJ9wzti3QwDikAffFikWSDKe+YCXlP3BWBpLa8
         pz+I7mTSuxl7fX4a3zZ0ZDhji01q3fXrQH3uxJeFe41HHI5XfHZGaWdel47arIvzesZd
         57WrEbZmqAs1OXOdONNKiPM0jAdo20CfDEM1p+wPLX7Ch9NztVh46xFy3ha0afsqm3RU
         6j1gSpiK/F9G0bIw2UaKY184NYdmOQkzD88xkAGWlTalgTdvTzYxsOXTdMEG5Ltb1xh6
         yasxMzRgxzYhcse28J8JL036azybFJfZue6CFg2lkaB5fe9d2FWYyoe6t9IU1rWvVvuj
         QcZQ==
X-Gm-Message-State: AJcUukdLm1fZYmIjLHoITIcl4iHs9IgIS5A5hvYhDEUFKbapBV7JlxKr
        cmlL+16Vd7M/IpQFMSzbu4NFhg==
X-Google-Smtp-Source: ALg8bN5f1SEsd4ITLAOkW46zsAXPnkQ0Kw16Q2Kzdp8Q2K31EY+gUdUwN0+RWy+mZNfdm32Jcr+xpQ==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr29524927wrr.155.1546541126907;
        Thu, 03 Jan 2019 10:45:26 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id t12sm52236944wrr.65.2019.01.03.10.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 10:45:25 -0800 (PST)
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
Subject: [PATCH v3 1/3] kasan, arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
Date:   Thu,  3 Jan 2019 19:45:19 +0100
Message-Id: <52ddd881916bcc153a9924c154daacde78522227.1546540962.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <cover.1546540962.git.andreyknvl@google.com>
References: <cover.1546540962.git.andreyknvl@google.com>
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
 arch/arm64/include/asm/cache.h | 6 ++++++
 mm/kasan/common.c              | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 13dd42c3ad4e..eb43e09c1980 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -58,6 +58,12 @@
  */
 #define ARCH_DMA_MINALIGN	(128)
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#define ARCH_SLAB_MINALIGN	__alignof__(unsigned long long)
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
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

