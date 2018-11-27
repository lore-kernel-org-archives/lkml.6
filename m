Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D531C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEB120817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwUU3Biv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEB120817
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbeK1Dyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:54:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38822 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbeK1Dyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:54:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id k198so23064509wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xTUWDQtoCoS0aCkqKcHlSfKscpiq6EmalPX21Pfc5fY=;
        b=dwUU3BivFrGTU0l5vocuel01QRAE+v2OGhkebJVpy0mfJmO48WW8JjO/aQRDNIxlzp
         7Q7mQuPIYO6ENLlB1vL2wNEuEIHZp+ISZDSJKEFWk4t6VwdTO034MsDUqOMVSpnvYHaG
         EJcyDLbTK9jrS7IEcf09GuU+VgeRwknC0Tlm4O/P5QswfFrC1hiDKmoKuUuLwhOvaaB1
         eOqzl7HmKc1Hk+kdVzfJIn3rAmpOXnEkoLkjR1OyF9bg+r+lmbARfTC79ZfPy4UEbmPK
         TLasPIfGNrBaUGy9nXGM879QdxieJEgd31QTd/Q6LhFdvEscYdJa6SZolCyN4ZLBGe0E
         +eCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTUWDQtoCoS0aCkqKcHlSfKscpiq6EmalPX21Pfc5fY=;
        b=JYTw4Wn8P7IKQ4UiekS34Fxfh1kve/z9AeGxesVvjS7t7GScLV1rHRrGfIQFwTMvXk
         CLaogg4RbWZ9jM2TWab1Ec+uqdrT+UXf9BnnjGSujJ0ur+fYFHG43AUqrXH+4tx7wUuX
         4cK47N1NRBqpUxmDfGy+NBWOKJmAbcYlPK3Iw6IthjjwwXhehwYP9T8ku8ri/Ndig1x4
         tgArXECN2qTkkzsSBFafi5ytjI5NVN4IpSSaH4PnLY/1ygaKEDTA1oMqiJ9KvuoLNxCv
         mDgyoo9/5B+10PPSPvu4aivm2Syrjo9KJVhNFXuiKaURIcE85MDtLxwA3UjI2+qSYg+O
         4C2g==
X-Gm-Message-State: AA+aEWZTPoGEeRZsNlnMbYKX2aO/1rUATcgtw/AkTxtkYoeIMfSHeAkA
        a+l0WdQnwLgoS/FgBVqqFHEdTw==
X-Google-Smtp-Source: AFSGD/WWRQkAxqiKVcqGdnvTy6zSnKmrDpYhgJDtIRt2URzdNRxagoHNN/L5SvG9mNp5eIbIhcSMqw==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr12993788wmd.67.1543337759395;
        Tue, 27 Nov 2018 08:55:59 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id k73sm6383099wmd.36.2018.11.27.08.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:55:58 -0800 (PST)
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
Subject: [PATCH v12 06/25] kasan, arm64: adjust shadow size for tag-based mode
Date:   Tue, 27 Nov 2018 17:55:24 +0100
Message-Id: <95fa472a03a8ff268e24b8730ebd108922824e74.1543337629.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <cover.1543337629.git.andreyknvl@google.com>
References: <cover.1543337629.git.andreyknvl@google.com>
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
2.20.0.rc0.387.gc7a69e6b6c-goog

