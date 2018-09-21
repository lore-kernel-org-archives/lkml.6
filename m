Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC06DC04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584F521568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZ3Qh9II"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584F521568
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391038AbeIUVD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:03:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41557 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391024AbeIUVD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:03:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id j15-v6so9141828wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myc+iFznG+xU2oejuTstHBw/z6FAJlgaorRzD++lkYI=;
        b=aZ3Qh9IIBfUdiC+v6Lry7v+8dlK7URGA46gmKYpAQlMNaT516kCSIAAKxRRuxuFboM
         BxdWeWXxImYKZp/HHAV9d008RCV7Jg2zj2BtpLhBe0iiiXa0YlCUq90LpHv8aACNq/un
         frrfI0QQp6y09aziMs+FxKP0lRGNo29fPuPtt/mc/1POP7H2q3pEqr3CbgOoCxE/kCxQ
         wU2fX7V9FnhyLDUM6s8vbA8x/5mrruy8spwUxgcn8eXyUnnmfaefsIR4XRNAnzQ7rENA
         HCi8QyxD0ZeHSQnkMKqQ+VuiHtNmOR7M5XN2SVHzrupCkbSurat1YkFKqVudo1DltvdP
         ayrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myc+iFznG+xU2oejuTstHBw/z6FAJlgaorRzD++lkYI=;
        b=spFG9dNyVVL9jKxLKd7g1bdxbapxGqKZ15ZlDp4GabvQ2gMlykkGLH2jPoMItPdu1q
         Kc7jQi2MbgR6EoQc2BNARpmrdqc/TDcPF6snx359DbWDn6kP4oESGgyGrBhZBbnkUaNq
         VQTSt5rLPnMckw+Ck9M1MMIt5z6s2+Wma7AtVnU4arndmwAfv/mqb1ZY4Ix90qqz1thg
         8IjxQNkBIU+qnMh7TWGvZJTYf67bQp8zdk35C+0Y5BEqMQsniprEw0sYazheZyflbi4g
         uR2kPxd94gzdfCmRw9TI8HqLxvVstFdJLOydk8AuA/bjf8D9YZ2Ibk6bfzEGfCzS9u5b
         zzGQ==
X-Gm-Message-State: APzg51A6miZjrzJLmM4MT6HFAW+GOd2fmOo8ECzyLQHEeRs9ls6n+gYL
        SVSA225SFn/t+J8+x/x7w+BQQA==
X-Google-Smtp-Source: ANB0Vdaj3+nA7j37D4DMyaMmDoORpJUgaJjp8Lwh8IUiqynn6q4s8aQcBqiGoF3Zsdq/S8hs9bKceg==
X-Received: by 2002:adf:a4dc:: with SMTP id h28-v6mr26625905wrb.167.1537542847324;
        Fri, 21 Sep 2018 08:14:07 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id e7-v6sm27990271wru.46.2018.09.21.08.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:14:06 -0700 (PDT)
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
Subject: [PATCH v9 12/20] kasan, arm64: enable top byte ignore for the kernel
Date:   Fri, 21 Sep 2018 17:13:34 +0200
Message-Id: <7edbd2d0b0c6f0b7a2b33e3d6da2f14b4b63b8ff.1537542735.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <cover.1537542735.git.andreyknvl@google.com>
References: <cover.1537542735.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag-based KASAN uses the Top Byte Ignore feature of arm64 CPUs to store a
pointer tag in the top byte of each pointer. This commit enables the
TCR_TBI1 bit, which enables Top Byte Ignore for the kernel, when tag-based
KASAN is used.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/mm/proc.S                   | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index fd208eac9f2a..483aceedad76 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -289,6 +289,7 @@
 #define TCR_A1			(UL(1) << 22)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
+#define TCR_TBI1		(UL(1) << 38)
 #define TCR_HA			(UL(1) << 39)
 #define TCR_HD			(UL(1) << 40)
 #define TCR_NFD1		(UL(1) << 54)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 03646e6a2ef4..b2b44dbdb063 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -47,6 +47,12 @@
 /* PTWs cacheable, inner/outer WBWA */
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define TCR_KASAN_FLAGS TCR_TBI1
+#else
+#define TCR_KASAN_FLAGS 0
+#endif
+
 #define MAIR(attr, mt)	((attr) << ((mt) * 8))
 
 /*
@@ -440,7 +446,7 @@ ENTRY(__cpu_setup)
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
-			TCR_TBI0 | TCR_A1
+			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
-- 
2.19.0.444.g18242da7ef-goog

