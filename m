Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E7C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A090620838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2VohwGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A090620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbeLFMZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:25:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56193 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbeLFMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:25:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so774959wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqMDiL5pFL/+tkei1G/AIx7zwZMP99eD4KugQS7K55g=;
        b=Y2VohwGtLIqo6t/3aMQeakdW1sJ7UgqyXRDUNidOjVdD5M1bxlNFiaWPSn1bXLUyyF
         mCCWKClMkXpRl/CkEYHFhkecgRkp6UBK6sfIgjgkARPZuNzpSqHnINsuMeuueMsTmNvD
         Mb970K6ZZtXOqMs4Gaek4O18mqjDkafHoZWEvQa4fKAWweR9DbpR2Q7eZR4APBPmIkFH
         N3qGtFuiC24t7PZgMXta7ZPzCIcCq8Yl7LCg8wCFP5JpIj2RfyVIiKy7tRwzK6WESWKq
         SjD/5xD4Wzs6YWFY2xHp4H4kAcqBkIOdh05TJR5kuzLQ14sH63IMtTkNdNhpUY1CH8hi
         OqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqMDiL5pFL/+tkei1G/AIx7zwZMP99eD4KugQS7K55g=;
        b=WpI3XvWxwC2tNSO6mL5MtMbP3AGr0a9FDcsPVXmMKhokV630NyrJRmK+rlxbEw83i/
         7IkE5adzOF1UQILiNrULxdHXs4z/pZ+BczukhpuNbGHltWnUI50qB8QpQHAZDukd3Ckr
         s7LcKQnofBPLeHbJ+DR0xPN7Wy1lLYZuG33pQZEKWOKigNsTgVwsLra58APN4o8HxVZ2
         dl/SsRESdOj10wBPhzZnHYGVNOs26P3glKRu9lCwR2xE/13Cb3zEd21XCs4nbXuJdtvX
         MsrFyR5yrDfnjCYaoBB5gpkWJQYEcHm1kSDrge7otnSPOiXkF4MRCpMMjMlUwXomaDHj
         CMSA==
X-Gm-Message-State: AA+aEWbOSB91MsnLmL3A099QGRQ71xJDtyCPemtoTC7y5OkRErvrvmwB
        MVMbODxXDwzkPGjVnw5T3zNUrQ==
X-Google-Smtp-Source: AFSGD/UGniPFpytnR5EvX1mvUQCqi8xKkHyAIiafnkUS1yg6vUphxPqdq7r3o6WSEF+mrgSfvm3zrg==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr18924469wmg.79.1544099106379;
        Thu, 06 Dec 2018 04:25:06 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:25:05 -0800 (PST)
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
Subject: [PATCH v13 11/25] kasan, arm64: untag address in _virt_addr_is_linear
Date:   Thu,  6 Dec 2018 13:24:29 +0100
Message-Id: <df73a37dd5ed37f4deaf77bc718e9f2e590e69b1.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
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
2.20.0.rc1.387.gf8505762e3-goog

