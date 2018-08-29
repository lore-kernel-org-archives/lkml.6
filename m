Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E617C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD7620862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SaDmWZ9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD7620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeH2Pds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:33:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53123 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbeH2PcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:32:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id y139-v6so4892351wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oho6JdHma26yH9i0K5sb+l4Yb9Bpt1LjR+gOl5dkBUo=;
        b=SaDmWZ9fK2PewT8oJonwMmFfr8WhrgkwKC1k18mnNmJmAsCXOB3epwtFKQCa9bJOAi
         mEj8+WOJp2nZjwSiGScw6Xf5tBPmT1MpzndcX+Y+Ct0cNtljF9Ux6NW+JhEZSOSdgrxU
         yvYeNx0zRXThLLrsda7sUxBeiipmmCaRpWw3EfQPRM0nzAAWxcYpVEaZsynW76N+kdWG
         uuyyKkgeP3GLgqci7gdynMTo3MsxqG1n2vZYlR2lP32Vi0+iyNDuLjgbLH4od9gAkPMz
         p3j/Y1rMM2RUu+jDYRBgy/F6h8F3cZXPVHFrtsUqaArAhctqLIcRmQaMiHZ5DTmF+235
         K9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oho6JdHma26yH9i0K5sb+l4Yb9Bpt1LjR+gOl5dkBUo=;
        b=BzUmbrgfvQGlN+J5MnCVPKjROtpz2siILqA7LRaLefAtaN6TOkNBL7qo1XwfG1QIBb
         tMIaTujel6Gp0Nk5JiqiYXTo9i+NveXtQuBDQ6gTehdcLRyxW9YFdjyiM/+65A6zjOYp
         aB5vNiGdVThCQlguK1jMYbtKmW/eM7c/9pmPtDbMgf4Eo/R/RbGjwnPbob6e/+1XzQ2n
         uCtBwak7RvxxPm7VxkHHe26Ut4QEixJiSZONU+s88UHe8k8F2JqADLcttWZ1spdtPHYU
         0S7Px7/W73YrLfk9iSmhUoezCBA1/5VVMsDZKwmi/sjISJDx2hQ0gEdu8sgf7fR7earR
         LMXA==
X-Gm-Message-State: APzg51BYtsIkA9HiknwOLmyQiEbDuhxGdGku0LawftTgMtEopdbWQdXB
        ZYfSquBooqV4nkzRSmNgPKBF+A==
X-Google-Smtp-Source: ANB0Vda/VxaGGcnpqyl9kXA7HPIGNrg+oVCYhSMZPHQ7NBy/4oLuVzESIGyzYz5syIS6IPDHguMu6g==
X-Received: by 2002:a1c:7fc6:: with SMTP id a189-v6mr4102021wmd.42.1535542534055;
        Wed, 29 Aug 2018 04:35:34 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id s10-v6sm7800454wmd.22.2018.08.29.04.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 04:35:33 -0700 (PDT)
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
Subject: [PATCH v6 04/18] khwasan, arm64: adjust shadow size for CONFIG_KASAN_HW
Date:   Wed, 29 Aug 2018 13:35:08 +0200
Message-Id: <b4ba65afa55f2fdfd2856fb03c5aba99c7a8bdd7.1535462971.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
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
index 106039d25e2f..17047b8ab984 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -94,7 +94,7 @@ endif
 # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
 # in 32-bit arithmetic
-KASAN_SHADOW_SCALE_SHIFT := 3
+KASAN_SHADOW_SCALE_SHIFT := $(if $(CONFIG_KASAN_HW), 4, 3)
 KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
 	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
 	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..f5e262ee76c1 100644
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
2.19.0.rc0.228.g281dcd1b4d0-goog

