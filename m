Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FE0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02F920858
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTz2QY2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02F920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeH2PcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:32:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45382 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbeH2PcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:32:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so4474594wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OrkXoXQH/F+TSi0uzJOTsE67Q+iABNFRWIJoC0xEk4I=;
        b=WTz2QY2HKqYf+swr0X7Ae2YyC/6YPEZ7qJCGjn+gto47vutHzDmySwPeJpJN11E0ZE
         5/N+Lf5FI2i9lD6qnaIKa8vC/iEgp6tV3xlwZxOCsUOpRsPK5x8OxbGPeHqoaLRnz3tl
         9y2MSALdGNvdhBDLQvs0+f/FvlAZbS/GTFpeuBXd0Di7KJovjN8/Xes0AHrVObh18/kk
         l3VioLZaGqerA6Z1z05WFImABwS9LljXfzhrpinvyCSxMUXJUyb6Mgz0x0wZN2PV/gRR
         k8/pJKOTpSsY6SdKFgIhYeExLmV+9l/hayV09vG0Ai1tN5FuaJADVtrnzjbraHGluFQU
         kEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrkXoXQH/F+TSi0uzJOTsE67Q+iABNFRWIJoC0xEk4I=;
        b=oma8zG3zkGvUuHgLtyRNjA1exXNT0a3cqk7IQ3rzyYHSuCw06WMZnDP6vDJ6dNElHC
         rE8IirJCzBhcFqbPnIVWc+gOt9nwE8nxTF6OxR4S7AUmCrSTc9Ox/2W0p93ZNlEfVlKI
         PR8q1Z83bgMbBnQJ1CRlmeQf2DAVAENBFu/hu14hExn8ekYMSOtBsB/1dnz6TK/sqPid
         IRKB6MakRIQ5S1ohsLIfVrFQ1V9x7IEfPixRTkNQ7BW2XjXqEw6B/vRI1eRxf8TTycT+
         S8tgDqFqLdNPk1jfcRt8Fcg0qFmSDl61xfv0UlDZJWBqmX07JHLQXNoHXMccOPxpm6mD
         UBSA==
X-Gm-Message-State: APzg51DYdO9RlJcuHvqWXA49MegLS/PUQtPvAcNZvq4lrO1rLLNatmpu
        TyxJotXPao7iO9qzr73Dyr3K1g==
X-Google-Smtp-Source: ANB0Vdb/wq3vWEnItljvIkYES5qFH6+aaA3t/puEBlFbr7sKQYhGOPxWZqcCP6CtYnWV4cowVJ+NpA==
X-Received: by 2002:adf:a512:: with SMTP id i18-v6mr4050713wrb.220.1535542543576;
        Wed, 29 Aug 2018 04:35:43 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id s10-v6sm7800454wmd.22.2018.08.29.04.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 04:35:43 -0700 (PDT)
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
Subject: [PATCH v6 10/18] khwasan, arm64: enable top byte ignore for the kernel
Date:   Wed, 29 Aug 2018 13:35:14 +0200
Message-Id: <d34bd1004c8789729228d8bd38aaf08a65c94032.1535462971.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KHWASAN uses the Top Byte Ignore feature of arm64 CPUs to store a pointer
tag in the top byte of each pointer. This commit enables the TCR_TBI1 bit,
which enables Top Byte Ignore for the kernel, when KHWASAN is used.

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
index 03646e6a2ef4..c5175e098d02 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -47,6 +47,12 @@
 /* PTWs cacheable, inner/outer WBWA */
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
+#ifdef CONFIG_KASAN_HW
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
2.19.0.rc0.228.g281dcd1b4d0-goog

