Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F382C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679CC2147D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bxo3E4Rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679CC2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbeK1D4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:56:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42581 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731398AbeK1Dyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:54:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so23436625wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8jDgA1AyN3NE4eBg/lwMVayjAlQQavKYDtyjUMWkmY=;
        b=Bxo3E4Rb7z32spR+GjTU3/UkKTGzAZUE/6ScwrxnZHct9+8n6DhIPAlWfNPk4yvtAq
         PkF5qmbAKLUkwJhskz+edVmt8U0gNIS7JXhbzegEAAnxrdyJob+N+sL6TAIVBVcjvmD4
         PwOc2fCWgzsAQX/lmgBsIe2l2PS+aXGvAZR8ehnhsFLiJngL0VkrxwD6JHkJ2PO4YGx3
         XB9Nzoo5zvl1XhXpRJOFc0QeTA1hfU/SeQYwjx5psTSN9ZZuB3a0BO0gCZ+p/qF4b0oG
         tG+bFW16AGvNk5yTKTIM2JfWNcFnKaii4O5xUCK1MdbaQ2VOisQTBmWTaf8vD/SjaVeQ
         oypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8jDgA1AyN3NE4eBg/lwMVayjAlQQavKYDtyjUMWkmY=;
        b=JCUd7Q0ELkuFBxiUAc1Tva9Plm7GCPZ9kRyaxKKyu9dgq+etyY7P7uP3jbLn4cx1Ee
         WjWP2rxw7msaZn/AU/OA2ND+oaiT/KAan4kIcnrAnyKOEawILr5W7dqxIZNNv9wrvZHg
         3SmLzWywe22S7MCdauXau+Ho7/BG3Ex0nhx71S1SFszB4tKaKhl0OGEAX3QXxs3pQnut
         rH1hlnYB69JCiBSTTMLpNvi9GZ15SPXqUcKgp+OUOVxAtP76ePGyTI5kFSOUy3FZGlYw
         PW8HRAQnD1g9tJz3n6x9zd2WjJZIUydR/R5Mp8dVuRnYsQjuW7B7gZrJorPA5Qdfz6Bi
         1xCg==
X-Gm-Message-State: AA+aEWaLiCysLmo2U8uYRpw6304XeRrTpKUXH05gHODDu/hg9/r/BkmV
        TIpU94E9+Ie3yvFqN2X0yV177g==
X-Google-Smtp-Source: AFSGD/UriVYn0glnQslEJ+Tb2vBU5XdWPYCPaYmqBE94vU0Fqn7cyDlFXFag3HaZdSEdMQAwYsLMhw==
X-Received: by 2002:adf:c711:: with SMTP id k17mr15658629wrg.197.1543337768904;
        Tue, 27 Nov 2018 08:56:08 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id k73sm6383099wmd.36.2018.11.27.08.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:56:07 -0800 (PST)
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
Subject: [PATCH v12 11/25] kasan, arm64: untag address in _virt_addr_is_linear
Date:   Tue, 27 Nov 2018 17:55:29 +0100
Message-Id: <dd9cda296c70ca6b1839cf4de3ee3137cf5030e7.1543337629.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <cover.1543337629.git.andreyknvl@google.com>
References: <cover.1543337629.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virt_addr_is_linear (which is used by virt_addr_valid) assumes that the
top byte of the address is 0xff, which isn't always the case with
tag-based KASAN.

This patch resets the tag in this macro.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 83c1366a1233..5fe2353f111b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -322,9 +322,10 @@ static inline void *phys_to_virt(phys_addr_t x)
 #endif
 #endif
 
-#define _virt_addr_is_linear(kaddr)	(((u64)(kaddr)) >= PAGE_OFFSET)
-#define virt_addr_valid(kaddr)		(_virt_addr_is_linear(kaddr) && \
-					 _virt_addr_valid(kaddr))
+#define _virt_addr_is_linear(kaddr)	\
+	(__tag_reset((u64)(kaddr)) >= PAGE_OFFSET)
+#define virt_addr_valid(kaddr)		\
+	(_virt_addr_is_linear(kaddr) && _virt_addr_valid(kaddr))
 
 #include <asm-generic/memory_model.h>
 
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

