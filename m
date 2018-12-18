Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E804C21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6CeLxm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbeLRNan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:30:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51308 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLRNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:30:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so2615519wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DLr9hZIqfTBfQ8vZM5TVqGu/0wSU0e2RGylEo0U1xk=;
        b=b6CeLxm48QORSNimPysCsqnEvAwvbwCEMK3zZ2IeU55RUe8jfEaoKD7B2W5pu4GMVM
         ZMfAqk8UVGyjCZdWBu94z+/d06Nqhr39DI+oBkGQF6PQNRAP48V2nHE1nMmWB13EyfCm
         NtxsSWQvTBxTL+Fd0/UOOq7DzicVsxlDHD16s9b1lX0C6x/VSR5lAuzePhQ9L1d5Oul8
         VXrACEN0B09HGP6S1WtlkS87efzvH+4OfJy778AP3n08axpCT24ejrd+gQ8n9Wv0ZFss
         zNcku1rhZAk/DpR9yt64U57aTzC8whKP5MKSsmn/EKNweqDVHhOPHIVAgeVnlG4EPeY4
         Oa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DLr9hZIqfTBfQ8vZM5TVqGu/0wSU0e2RGylEo0U1xk=;
        b=eNbHLpnwU56Nh2sLnWD48tvG/8x3ru/njNfzml8rr8oR0Cu1BK1ZGiFB/5EkmvgNMd
         RjkSnUjf1WfogrIHgfyUgUmVAMxhKTQ5wwyisAbum1pg4EYxC9gF+bpMItTNPTji+SwS
         JCQKPmuWkryP/+CwN8Ss8UPD1THn1u/dFnJgOVGAyCn4uf1j9yeZPJiBx7MusKuYwpNK
         +ARtfvJucieXUyAffvItqXf08XcPLCFOg/V8B9WlC3yjU37yFYvCmQPKUNgkw4GmOGZ5
         +t+FQriMQ2bczUcD+u7yDhenCtGb0qBV6WkWywFavTgcBOeGmXWJaySpej4XDQr6+OGc
         Dpog==
X-Gm-Message-State: AA+aEWZM3LPgji5bGWZNvPCKsYhQeFnl8HYFmxF17UiPtqE6iq+/YkUH
        978xYK2B9nEaW/oYBE2dUp6DeQ==
X-Google-Smtp-Source: AFSGD/Vk4dHI/WjETFO6q3mGOkSMUeOtBy8kBD/BEP66o/kq3hhOh6hYuClxgxsdrN7KcTWqc7mrIQ==
X-Received: by 2002:a1c:a104:: with SMTP id k4mr3226049wme.54.1545139839904;
        Tue, 18 Dec 2018 05:30:39 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id g188sm1995927wmf.32.2018.12.18.05.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 05:30:38 -0800 (PST)
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
Subject: [PATCH mm] kasan, arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
Date:   Tue, 18 Dec 2018 14:30:33 +0100
Message-Id: <706da77adfceb0c324e824d03b52d58a752577ea.1545139710.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.

Suggested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/kasan.h | 4 ++++
 mm/kasan/common.c              | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index b52aacd2c526..ba26150d578d 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -36,6 +36,10 @@
 #define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
 					(64 - KASAN_SHADOW_SCALE_SHIFT)))
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#endif
+
 void kasan_init(void);
 void kasan_copy_shadow(pgd_t *pgdir);
 asmlinkage void kasan_early_init(void);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 03d5d1374ca7..44390392d4c9 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -298,8 +298,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		return;
 	}
 
-	cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
-
 	*flags |= SLAB_KASAN;
 }
 
-- 
2.20.0.405.gbc1bbc6f85-goog

