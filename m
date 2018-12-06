Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E255C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BB020838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSllCbYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BB020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeLFMZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:25:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37635 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbeLFMZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:25:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so306030wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdXJRxv4fyHhhgwNYAW9KeDDpz520moerszNmxFBOyU=;
        b=tSllCbYhK8CTwm062EuJ9YxzX5azvNPGwSixQNdttv0wG7HbPvJ4HWqvcMlUyhbXFI
         qfiFNFadH9dyUfmPDcs07QkW+5tVlzIzfHGL34eDJb+aCwpLDI+2Jq5bSjS1DLLPtZSY
         QFM+Ke7eo58l5DlGpf90kwlk+F8UGcaPSuYzmSUtZxOfKt7BqigtuJmeH3dzl6XZlk3b
         783OT0Gs76sD8FegLNM/9btM6Wz3FXl34UjM6CMRJGkzceNPCf13AnIagkuNdqYjAyt7
         RRwXrFNgjBuXIhljtYHX/uaiR16N7FvbWMvVcpbfwmpfzQrZi0JChiYAum3bkh0bt5QX
         zWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdXJRxv4fyHhhgwNYAW9KeDDpz520moerszNmxFBOyU=;
        b=kSfEWKTKidSGxUo2FCFP2MKXs27ZlMO7dH3D7CVbziIcgL16XmIiqgGfdYwnhS+ZuM
         jQBUmOZ5154nsgN+1ngaGwihIuOlLQYE1d3vHn37jTUDV2JO+Kq2cWudRIKXmpUZA08E
         jReqk2/vhUuBho0ZcrIn4DJDoBX1o/Koy544k6n8gK7iq3EVrJDEKpPghFoznQS0l7uU
         Vue8B9Y757wRMuVAID14VQFDBdCAOUCYTKV4jXMv4mnUvzwoknfwPHm/ZZTVs3v+vCst
         ujSqV3Bewmm7j/qd/7DVF3koNehFdOl1b6o9u40uI/dxzavB9R15+WN28ARK4DXU8v9u
         AD1A==
X-Gm-Message-State: AA+aEWYoXZHgSwXj43Z3pEh/EUkc7jsu8c06OvhbB1B1uDsw6CAlXW7c
        MrjY7Ek1di7CVLdAx+0/8t5uzw==
X-Google-Smtp-Source: AFSGD/VDT3EJaRa30kcxnPk5C86z+Ev8IK3EjEUH0BceyiJnKYlqR1isJoV6wqdMtEO6xCDR+R+/9g==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr27012161wrw.50.1544099097573;
        Thu, 06 Dec 2018 04:24:57 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:24:56 -0800 (PST)
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
Subject: [PATCH v13 06/25] kasan, arm64: adjust shadow size for tag-based mode
Date:   Thu,  6 Dec 2018 13:24:24 +0100
Message-Id: <308b6bd49f756bb5e533be93c6f085ba99b30339.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag-based KASAN uses 1 shadow byte for 16 bytes of kernel memory, so it
requires 1/16th of the kernel virtual address space for the shadow memory.

This commit sets KASAN_SHADOW_SCALE_SHIFT to 4 when the tag-based KASAN
mode is enabled.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Makefile             | 11 ++++++++++-
 arch/arm64/include/asm/memory.h |  7 +++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6cb9fc7e9382..99e7d08c6083 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -91,10 +91,19 @@ else
 TEXT_OFFSET := 0x00080000
 endif
 
+ifeq ($(CONFIG_KASAN_SW_TAGS), y)
+KASAN_SHADOW_SCALE_SHIFT := 4
+else
+KASAN_SHADOW_SCALE_SHIFT := 3
+endif
+
+KBUILD_CFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
+KBUILD_CPPFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
+KBUILD_AFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
+
 # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
 # in 32-bit arithmetic
-KASAN_SHADOW_SCALE_SHIFT := 3
 KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
 	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
 	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..05fbc7ffcd31 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -74,12 +74,11 @@
 #define KERNEL_END        _end
 
 /*
- * KASAN requires 1/8th of the kernel virtual address space for the shadow
- * region. KASAN can bloat the stack significantly, so double the (minimum)
- * stack size when KASAN is in use.
+ * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
+ * address space for the shadow region respectively. They can bloat the stack
+ * significantly, so double the (minimum) stack size when they are in use.
  */
 #ifdef CONFIG_KASAN
-#define KASAN_SHADOW_SCALE_SHIFT 3
 #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #define KASAN_THREAD_SHIFT	1
 #else
-- 
2.20.0.rc1.387.gf8505762e3-goog

