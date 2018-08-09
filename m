Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A9C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5759921EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D73aW0s5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5759921EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeHIVtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:49:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36512 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeHIVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:47:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so1385924wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8+p7PdvKfl3q/+F/IGkt+C18+eHZ9wVnzYkW+BehT8=;
        b=D73aW0s551OGsYp9bn6Vo8ec1xt2vcZEVojeeg/hcq+xlUvedvfiPvD/l23Qztvnw+
         wSLucQGfP6ySKLhpmhcRTW8CbF74oP4WdINOeTcHbe8nwxxrmgezabuzCNMGmUKm6fUK
         SRj9TMDDJRTKOFBl1AmQZS70YMKa8CzKaO5su8SVksnZW2NJ35YRrsXLjntvy6CpThYw
         jhc++KV7XImPnbR+UvilReSMks8aI8LJhZ/Q5JCfe3j8kwpu5Qt/uNXsGox6/MqM9h8v
         iW/pdTxfHLAju6h9IZcYcNKAUs7ZpyPeqQ/LQ2kxHatkzBl2m2u48Bp8zbJoniIuPUlQ
         Hegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8+p7PdvKfl3q/+F/IGkt+C18+eHZ9wVnzYkW+BehT8=;
        b=IivbyvO/vl4rGDUmov3+P0fK4TeXmO18Bvq03QpkLmPSI7UiV7smdv2i0l1+oSMtR3
         ER67hJdyCAh6jGG4nUjGgOM0AOZyNLKte28FWF0mDhxsGnbk1mXlzdjMEgwgQ/3piaLB
         dg5FwFL8VeHJqgjJfezzN0ZNfYGWxu4myKhe5MoKOSzCNtwMZTU3Suvw2JxsNYJ0cErr
         hTUzFXMG+cCOMaoMT4oqp8cyE37nJZkaMZ3Vw45wKi/LfeKHmQVChiY2em35fUtelCfw
         UqNJqMim7Z6LWxo3wvmwTiJF/iyPMKwQXPngJssiFg+5EHxS1wi2yxc9RhZlwuETUfPR
         CAgw==
X-Gm-Message-State: AOUpUlHz7oTRUhbR2iKc04BWjn4IO5EWU9NowW+eDAHdoJ52Kk2h8t4+
        rVnZMqmvRCw/zr7NnZFnmlMtqg==
X-Google-Smtp-Source: AA+uWPw3BJp/Y8iB0ddeTjQn74oZlVoIzUW/ZVOeQxFtaBKLU75DdXP/0uzrW82eVwx7QU/jEbWVJw==
X-Received: by 2002:a1c:1252:: with SMTP id 79-v6mr2356794wms.70.1533842481486;
        Thu, 09 Aug 2018 12:21:21 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id o14-v6sm14738797wmd.35.2018.08.09.12.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:21:20 -0700 (PDT)
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
Subject: [PATCH v5 04/18] khwasan, arm64: adjust shadow size for CONFIG_KASAN_HW
Date:   Thu,  9 Aug 2018 21:20:56 +0200
Message-Id: <ae060172d137e1f5b836c88b3c54f424ec90a78b.1533842385.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KWHASAN uses 1 shadow byte for 16 bytes of kernel memory, so it requires
1/16th of the kernel virtual address space for the shadow memory.

This commit sets KASAN_SHADOW_SCALE_SHIFT to 4 when KHWASAN is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Makefile             |  2 +-
 arch/arm64/include/asm/memory.h | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index e7101b19d590..7c92dcbaf1a6 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -93,7 +93,7 @@ endif
 # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
 # in 32-bit arithmetic
-KASAN_SHADOW_SCALE_SHIFT := 3
+KASAN_SHADOW_SCALE_SHIFT := $(if $(CONFIG_KASAN_HW), 4, 3)
 KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
 	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
 	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 49d99214f43c..6d084431b7f7 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -74,12 +74,17 @@
 #define KERNEL_END        _end
 
 /*
- * KASAN requires 1/8th of the kernel virtual address space for the shadow
- * region. KASAN can bloat the stack significantly, so double the (minimum)
- * stack size when KASAN is in use.
+ * KASAN and KHWASAN require 1/8th and 1/16th of the kernel virtual address
+ * space for the shadow region respectively. They can bloat the stack
+ * significantly, so double the (minimum) stack size when they are in use.
  */
-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_GENERIC
 #define KASAN_SHADOW_SCALE_SHIFT 3
+#endif
+#ifdef CONFIG_KASAN_HW
+#define KASAN_SHADOW_SCALE_SHIFT 4
+#endif
+#ifdef CONFIG_KASAN
 #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #define KASAN_THREAD_SHIFT	1
 #else
-- 
2.18.0.597.ga71716f1ad-goog

