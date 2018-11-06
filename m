Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05643C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94DF2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGq5Em+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94DF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389773AbeKGC5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:57:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36148 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389742AbeKGC5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:57:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id z13-v6so12090894wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAdA2FIVXKrjFBT52+TbmLiPLvAT0qhuSkNJfNCOc2A=;
        b=PGq5Em+hIMGRrbgQhOj9WL7gicpV1a3cL1rwh4lemyPxMvFq4cG0mLriMBcSZkZUkh
         y+3GtrAF+dUXGDq1ZluSY4Ae+lNWq96tu7xFx8+3iUW74K5mMz0bNUjL+NF6zctA+4QS
         qnxDtpPcAEaC7j/9Pr+9+iCcTjIRBCQDBlqgv7jG812R/tkMjbJxP0Ho79hqKU+e0BK/
         1V3aOBfi8vX1vQdtwGNFcAWiS0iJHMNQQEwB2emM9/9GBvWQmJ/6N9TDkBQji3hVOuxH
         OvBCjaHDQv/WAwDgrbXwVByowANBHjdFk09bux4a/YZWYWedpIt49wvjAZbdfS4GERDS
         Djtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAdA2FIVXKrjFBT52+TbmLiPLvAT0qhuSkNJfNCOc2A=;
        b=AEpG4m+KlM6cpvuTsVzco1oNyixgIUnReSEUsy1/VTYu2rEkoGOBBjnouOE+RPtkrq
         7dUbMNHLMfaBnTA8r0ozyxEkv/veuDX59oxcTk7SypbJYtpde2zc6F64YsQqNDws/moQ
         iBk8pUgEDREZRjg+mnYGXPcsOm1yuH2aDbjN9LJ5m7uLN11+l7/yvR0K3bmfo/EgGGiE
         vem2gFDElllOJYHmu5QeOABjgzrqzCEqZIHRi/cnIvxITEhY3yEcdtrczf3NL8xeGQRR
         EL24za34TX2DqZspPqkKsQNupfJjcC9MH7uaR09UA32uwnlmStMvZ2xSpcdo7Ip2hEfl
         LfPg==
X-Gm-Message-State: AGRZ1gKRbhfcxjUXwcFSx7iKcHt7CneSY18mNuhfVMXeG0EV/WVGc1eh
        4G8yoDsnaqdAJOQuO3pVbM8A9Q==
X-Google-Smtp-Source: AJdET5f8uBubLHMHT+u4DepXXo41R1BmOHzAcM6VRyMsXW0CF05mu1xpsp3a9dayz1rV+f4WhA8xlg==
X-Received: by 2002:adf:8989:: with SMTP id x9-v6mr22834650wrx.184.1541525454442;
        Tue, 06 Nov 2018 09:30:54 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z17-v6sm16328416wrm.65.2018.11.06.09.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 09:30:53 -0800 (PST)
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
Subject: [PATCH v10 08/22] kasan, arm64: untag address in __kimg_to_phys and _virt_addr_is_linear
Date:   Tue,  6 Nov 2018 18:30:23 +0100
Message-Id: <b2aa056b65b8f1a410379bf2f6ef439d5d99e8eb.1541525354.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541525354.git.andreyknvl@google.com>
References: <cover.1541525354.git.andreyknvl@google.com>
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

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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
2.19.1.930.g4563a0d9d0-goog

