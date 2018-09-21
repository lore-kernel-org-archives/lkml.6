Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44243ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF01120858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFk3Aix9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF01120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390904AbeIUVDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:03:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37311 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390607AbeIUVDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:03:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id n11-v6so3676332wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTTlDohLEJvb592OsyAPVR+u8uN9dIVJB3pJotLdeOk=;
        b=eFk3Aix99RmJaNZRwCRLFH/tDZNfk5/3JawlFf1a11HhqIDObEJMuPJ1S6LXnwafvv
         pDK0c73bjQBny01Z5FXE7/lMchlf2fzVj1CjiwcqDMTTgDOHopWD0Xsao4jr2F76rO9H
         sRTSfbicV3YQxXFxMGGkfCFrC7QW3EgUZvmN7yEkxsHMVhG9mzLQ22hOZVMlzaYFyiKq
         qqZ5w92kv5wzvOtcuL2bcpcyqlfncMFkBZuzP+z6GYR/0+6/C+PCRE7WLSWVJJymgBgc
         k5+LdjtnDdLQpZ9Mwb+AJaf3zvy/dB3bLa2M/Ru3XY8Je/6e0XKLgvNRH54XQJN7XAsO
         jXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTTlDohLEJvb592OsyAPVR+u8uN9dIVJB3pJotLdeOk=;
        b=ci640DxSdnVKCeGAFVTuVpQGsDeITrYT9EbChmMWHNSvYuVcAD6kLUhXqMH43uNg/m
         s2I93mGn3y1DjdmyVCJaGjgq5k7YhSWVg/SiABqLx0ClDvgUvu659BVusD55Rnz5EHiI
         91E2C+zTvYOlnN5JHB5t5L2TC8X+2c5PTY4jPZ/BxNzf16I9amYtazmvvSrv+YoPhfOz
         fWf5S5pzhFu33tvbOJXrlFiS52eETeXudfoGAwh1uBh/N8p6+1Xraxlh8WHFDTrIFkIX
         YUEti8OD0N9SN+Dge/spahE/t97mBCFSCRzMBX/ZkgkhKSjdyDJfaI4HcrPt9acWq8qJ
         vGmA==
X-Gm-Message-State: APzg51AEnplqBmIryj4Y3dEUaN79l4uHEhiYZWdXfGtqeZOQ+hC/UW2q
        yK4Q3BgBUF4fSBQG3LG9Jbvd1w==
X-Google-Smtp-Source: ANB0VdYlfbjDbYUvenzNc17f98hLcknJNfP2DahKpQTTsCR+woEiIv9h2+SgVGtbCbMPsqia5n0+RA==
X-Received: by 2002:a1c:1eca:: with SMTP id e193-v6mr7134810wme.99.1537542835102;
        Fri, 21 Sep 2018 08:13:55 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id e7-v6sm27990271wru.46.2018.09.21.08.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:13:54 -0700 (PDT)
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
Subject: [PATCH v9 05/20] kasan, arm64: adjust shadow size for tag-based mode
Date:   Fri, 21 Sep 2018 17:13:27 +0200
Message-Id: <10cf432f0ffdb67fbd495acc61bdd9517af5b7b7.1537542735.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <cover.1537542735.git.andreyknvl@google.com>
References: <cover.1537542735.git.andreyknvl@google.com>
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Makefile             |  2 +-
 arch/arm64/include/asm/memory.h | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 106039d25e2f..11f4750d8d41 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -94,7 +94,7 @@ endif
 # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
 # in 32-bit arithmetic
-KASAN_SHADOW_SCALE_SHIFT := 3
+KASAN_SHADOW_SCALE_SHIFT := $(if $(CONFIG_KASAN_SW_TAGS), 4, 3)
 KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
 	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
 	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..0f1e024a951f 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -74,12 +74,17 @@
 #define KERNEL_END        _end
 
 /*
- * KASAN requires 1/8th of the kernel virtual address space for the shadow
- * region. KASAN can bloat the stack significantly, so double the (minimum)
- * stack size when KASAN is in use.
+ * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
+ * address space for the shadow region respectively. They can bloat the stack
+ * significantly, so double the (minimum) stack size when they are in use.
  */
-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_GENERIC
 #define KASAN_SHADOW_SCALE_SHIFT 3
+#endif
+#ifdef CONFIG_KASAN_SW_TAGS
+#define KASAN_SHADOW_SCALE_SHIFT 4
+#endif
+#ifdef CONFIG_KASAN
 #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #define KASAN_THREAD_SHIFT	1
 #else
-- 
2.19.0.444.g18242da7ef-goog

