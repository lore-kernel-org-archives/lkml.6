Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9189AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A8920C01
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3lKnIQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A8920C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404628AbeKTDv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:51:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53652 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404285AbeKTDv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:51:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id g131so5751168wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dR8lcfOg/asfdxo/WfCVQzFad9LYpScILBiq6D3Qbc8=;
        b=b3lKnIQw33I69347c6fVByjZWZr7rDfZ6pO/Th+7IH/z4NfXLoPk6gkZ6U+EuX8ViZ
         YvJr7csFPYS3irKKPwFBlIUVwi664iOL1+0Zl2X2madbWgValetXf8gjws1+oU9Tu1ye
         OEwGw5UlVlxIv/bPEHYGYnySoUH32sHcN6B14z0CVpKxTCSstFOwYILAL0z/aC1+bVaI
         7qjaP5iEylpKToNC3dh4SGcPFIAaCiniXcIq9QFyoplJCiGTFhrdjEKkYbqYwX2beBSj
         Q+4Eaq6aFNUnLw4H9+FNi6Msuzomb85hS5dxEpUktBeo4ZKCl8DjGrDQOJc1a87JAIXi
         16vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dR8lcfOg/asfdxo/WfCVQzFad9LYpScILBiq6D3Qbc8=;
        b=UhAr5PKl1/Nfk/1pALNOG1P9byGDWods4szEMOwtKzhmhVYIjMlq675gq9IwagWdBx
         q3DGJ4jYxU4FzbeWenQ373aQmMeI3DIx6/rHlZniYNWvzfgw4X0z4kfBz7CQI4sYhIR1
         ZnU8yE/a+QK10Xs7++qo1ZOrbTGafBfJAieDeq5LaBjRoOV5zNFWRWZ0A2WKoT6YKXmK
         iaw2Q9bnUUPnPwYW2xJSOYbTlB48zwvF/RTkcl2+v5DeH+r2SkmglEs0MCYEQpdqbWy5
         0CZRxV6V4OJZqSHNc6v2y1FwvMedbie+dXgeFuiwV6o2by6wS3KFZaTkYuEkPG9MEiQY
         R4Fw==
X-Gm-Message-State: AGRZ1gLq9/ZEy2TuhjaTwBfeSVZ9ODHgFTfLPadRrRXIhqGY7kJEox92
        +DCUc7KSNbMNAv4bRsS9kfXLog==
X-Google-Smtp-Source: AFSGD/WNR8o/WnEF0/GAJSPJLxjNxD3wmkq6whPNnsgmqmNKBmrpQx9bRReY6c/V+wChGBijG3HyMw==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr5632080wmh.87.1542648421670;
        Mon, 19 Nov 2018 09:27:01 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l143-v6sm23685190wmb.23.2018.11.19.09.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:27:00 -0800 (PST)
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
Subject: [PATCH v11 06/24] kasan, arm64: adjust shadow size for tag-based mode
Date:   Mon, 19 Nov 2018 18:26:22 +0100
Message-Id: <8122d5bedc46bb3655d576c922db3d722a231bf0.1542648335.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
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
2.19.1.1215.g8438c0b245-goog

