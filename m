Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E29C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D6320858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXnNKEPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D6320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390556AbeIUVEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:04:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46147 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390964AbeIUVDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:03:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id z3-v6so1388485wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m233AnC4qvrdV4eo3QzdNfMFrtQI7a9l1G83xPQzcRQ=;
        b=eXnNKEPHitQJezi0vHtHIhgtf1+Nu76xnakGrrSIlmxQYrEomHDWnSPKQZv2RBaMyg
         DfOVVg7EW8nVvRheW/vPQsiupWVv3evsdHoJRSqZc5ljRyWpJPE9tFdyKd5RY7/gEjsf
         Bo9WOBw2fmhd1oljcXXeQgEpPVkER26e6mZUo021V6Dlc4TrtV542wIpdX1hwq2n1yWg
         A1wHs5iM0blg0U9U5JZfWUVL3DgRODcMiXnIJK/FzsWXwjYpVDteD/5/1twuScg+5ilL
         qdeYlxvgCjApJidVANb5pXkm6j00YzJAnSB/ACTkn+5l0LVYlZeh0KIpEQ5r1osMg3rK
         6eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m233AnC4qvrdV4eo3QzdNfMFrtQI7a9l1G83xPQzcRQ=;
        b=q5moj15yvc+rYFx5K2/NPD6CG7bsYLgna0tHDGbDYQ6tUDGUJDKod4vhWquEmiMTf2
         JZJXmow4o1sVVCxnDuxalhLricFegU7lENehcGemVY1R+aevIhwpTL8x3lZQj1ObL7wG
         eDDj1Uy/Vzlbo0VLnfAGfXeP8C97gE1662qfP5tXyUJp48SeTJWa/k7i8m6hjt6M7gTT
         fX1PzHA3+jozY1j516uCZ0yG3OJydDSoDEZUs5prHU9m2qse5ekFAtzNNEPVXX2GMSPM
         OHeFI7M2zTKZha/4ClZxjYq/l15cv+VxSUxinrcx+QboDW9XVtwOCDfNhAkHzQ2CdgOv
         1saQ==
X-Gm-Message-State: APzg51AUbIscSWdZn/OS5QBi+AeezefpaYX8BBc5yCNqPTZJ0hg2rnAE
        7Dael1QCAUkX3XLymxuRwKRLhQ==
X-Google-Smtp-Source: ANB0VdZ/7B03zuJhdFK5x1o9/rEePSk4KohCAM1ihTBVIsTurv5K1v1r00w6vlR1FCprWMkvVK1lhQ==
X-Received: by 2002:adf:9244:: with SMTP id 62-v6mr35901684wrj.62.1537542838400;
        Fri, 21 Sep 2018 08:13:58 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id e7-v6sm27990271wru.46.2018.09.21.08.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:13:57 -0700 (PDT)
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
Subject: [PATCH v9 07/20] kasan, arm64: untag address in __kimg_to_phys and _virt_addr_is_linear
Date:   Fri, 21 Sep 2018 17:13:29 +0200
Message-Id: <1324a622035ee2a6fecd1e729a62af22542d9f3e.1537542735.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <cover.1537542735.git.andreyknvl@google.com>
References: <cover.1537542735.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__kimg_to_phys (which is used by virt_to_phys) and _virt_addr_is_linear
(which is used by virt_addr_valid) assume that the top byte of the address
is 0xff, which isn't always the case with tag-based KASAN.

This patch resets the tag in those macros.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0f1e024a951f..3226a0218b0b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -92,6 +92,15 @@
 #define KASAN_THREAD_SHIFT	0
 #endif
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define KASAN_TAG_SHIFTED(tag)		((unsigned long)(tag) << 56)
+#define KASAN_SET_TAG(addr, tag)	(((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
+						KASAN_TAG_SHIFTED(tag))
+#define KASAN_RESET_TAG(addr)		KASAN_SET_TAG(addr, 0xff)
+#else
+#define KASAN_RESET_TAG(addr)		addr
+#endif
+
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
 
 /*
@@ -232,7 +241,7 @@ static inline unsigned long kaslr_offset(void)
 #define __is_lm_address(addr)	(!!((addr) & BIT(VA_BITS - 1)))
 
 #define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
-#define __kimg_to_phys(addr)	((addr) - kimage_voffset)
+#define __kimg_to_phys(addr)	(KASAN_RESET_TAG(addr) - kimage_voffset)
 
 #define __virt_to_phys_nodebug(x) ({					\
 	phys_addr_t __x = (phys_addr_t)(x);				\
@@ -308,7 +317,8 @@ static inline void *phys_to_virt(phys_addr_t x)
 #endif
 #endif
 
-#define _virt_addr_is_linear(kaddr)	(((u64)(kaddr)) >= PAGE_OFFSET)
+#define _virt_addr_is_linear(kaddr)	(KASAN_RESET_TAG((u64)(kaddr)) >= \
+						PAGE_OFFSET)
 #define virt_addr_valid(kaddr)		(_virt_addr_is_linear(kaddr) && \
 					 _virt_addr_valid(kaddr))
 
-- 
2.19.0.444.g18242da7ef-goog

