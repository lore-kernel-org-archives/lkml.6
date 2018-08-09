Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E5DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AAA21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nos1UDYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AAA21EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeHIVrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:47:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45701 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeHIVrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:47:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id f12-v6so6052358wrv.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFiGSfRezZmnQnY92qgEO5G22hCK6sbxZ9zHPdYvrq4=;
        b=Nos1UDYofE5iwALIoGSkS0Q+oJZ6uWFtPCiNTKNWA9uq8ORDDXJvnDw5AyUJEdsjel
         dQOGsHXIkwOloSfAXwZjqYrk8IgXuz81I1YuA0MsaDYiQffMvtVseiOIFglGjFxRkHYa
         Yw/RfC4EQ6qPnIFsWJ8rOrCIV/S0JcmOve0hgF8hmGdu8H9iQMHV3wTsSvAggJuHXhQZ
         uVbjF50RnjwGVm5u+W7uX2UN1mNoHUpAT4UXxtWh+aMPeILzRP20CNrrvsA9ZLJmj1y1
         PmTVJ5ZQjTK/8qyt99la6l0kSmKDHJ2qgqYwtC5HSfCAD9ksGSESs+Nq25oG6F8sMMFp
         CgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFiGSfRezZmnQnY92qgEO5G22hCK6sbxZ9zHPdYvrq4=;
        b=KUL83zP27MkP8kCOwwdXL+sqleDqXkGd8+UFhPbGEJkm1qkC4WxI8Fnx8AokOlWcur
         +cQ9xTm7pWT4pZLPAwCqo9P2IRyHFM5MGMwpcnTt+/6BRp3fs3voBriXbAq2WF6n2lwj
         GqamsRAVWjodfe+9Ue9B19AO6jTQBPThhdTaA/DQAgBpIGrUMwoaZOVK7mvM6o5pnQKs
         /j4wE4LhHmNp6h2W+oJHfdAlMPTKOjYk/bwlncgn0KwXqmA+vH1DH+mhEoF5tjolfLH5
         hzBUPZ1NL7zLs04YncgtVd4K3myjAt0voUczUgzuu0V59UQmQhLtqsEwSlMFgv9IqgQ9
         8hNQ==
X-Gm-Message-State: AOUpUlFOnu9lbc7MbaiNi+EJF5wVZZoHdns4QTYZGNMAIE8lpXJG4W89
        TbmgPHfkmH7yhq82PUodoO1B5A==
X-Google-Smtp-Source: AA+uWPzI7yJOFtEcYKJKQsLAaH/2GfV75jLtgqXee01D7GLmz1Df6TG6DdqoLCgZWUJM/bkd4L7VLQ==
X-Received: by 2002:a5d:4007:: with SMTP id n7-v6mr2347871wrp.258.1533842484618;
        Thu, 09 Aug 2018 12:21:24 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id o14-v6sm14738797wmd.35.2018.08.09.12.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:21:23 -0700 (PDT)
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
Subject: [PATCH v5 06/18] khwasan, arm64: untag virt address in __kimg_to_phys and _virt_addr_is_linear
Date:   Thu,  9 Aug 2018 21:20:58 +0200
Message-Id: <3e8180bbbc82be79412be86316c5b7ea6470b7dc.1533842385.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__kimg_to_phys (which is used by virt_to_phys) and _virt_addr_is_linear
(which is used by virt_addr_valid) assume that the top byte of the address
is 0xff, which isn't always the case with KHWASAN enabled.

The solution is to reset the tag in those macros.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 6d084431b7f7..e9e054dfb1fc 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -92,6 +92,13 @@
 #define KASAN_THREAD_SHIFT	0
 #endif
 
+#ifdef CONFIG_KASAN_HW
+#define KASAN_TAG_SHIFTED(tag)		((unsigned long)(tag) << 56)
+#define KASAN_SET_TAG(addr, tag)	(((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
+						KASAN_TAG_SHIFTED(tag))
+#define KASAN_RESET_TAG(addr)		KASAN_SET_TAG(addr, 0xff)
+#endif
+
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
 
 /*
@@ -225,7 +232,12 @@ static inline unsigned long kaslr_offset(void)
 #define __is_lm_address(addr)	(!!((addr) & BIT(VA_BITS - 1)))
 
 #define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
+
+#ifdef CONFIG_KASAN_HW
+#define __kimg_to_phys(addr)	(KASAN_RESET_TAG(addr) - kimage_voffset)
+#else
 #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
+#endif
 
 #define __virt_to_phys_nodebug(x) ({					\
 	phys_addr_t __x = (phys_addr_t)(x);				\
@@ -301,7 +313,13 @@ static inline void *phys_to_virt(phys_addr_t x)
 #endif
 #endif
 
+#ifdef CONFIG_KASAN_HW
+#define _virt_addr_is_linear(kaddr)	(KASAN_RESET_TAG((u64)(kaddr)) >= \
+						PAGE_OFFSET)
+#else
 #define _virt_addr_is_linear(kaddr)	(((u64)(kaddr)) >= PAGE_OFFSET)
+#endif
+
 #define virt_addr_valid(kaddr)		(_virt_addr_is_linear(kaddr) && \
 					 _virt_addr_valid(kaddr))
 
-- 
2.18.0.597.ga71716f1ad-goog

