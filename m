Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A83C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3E72075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj6dYugE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3E72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeIFO5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:57:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36624 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIFO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:57:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so5065564pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVdxn+3vt6uBmQntezzi5p84CFfWT4Wz9Qc3XWM/P2I=;
        b=Uj6dYugECbTFq5bCh3KlVp6wUAaK9VN33+FUNZKjKrLFk0NpeMV5Lcu75PkkmH1jO5
         nLHUDZx/staukoocEtTAJUjcckmJeRl4CvPLs4oXCp6/FUGn7OH1wYR4+uzp6o9AjyCR
         FctxgoOrh4o2G8xQZHhJ40VMP95rpyBzgQ0Ae4qjUKqxjCg37nsI06S8+rEgajqxDPzC
         Vtgaz/aeD6xe8R2SnByWGBcHZpOOedfc3191FEkP2g3hov+z5gcj+U1udj5J/kkuZKzz
         QfsXN2Y9816Tw2c1hioE2jqPEcNzXWIMXCxfIbNHtCcInRbnqXaRat0sFNo0P5o266uy
         bHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pVdxn+3vt6uBmQntezzi5p84CFfWT4Wz9Qc3XWM/P2I=;
        b=S/oiJH9S0BUNRIWBYVZBg+vBiZACdGzzzKOt04ztH3euzPwUEfWPUum/AsxW1GIK+n
         u7hAAw+gM9ZrHSxzAB+6njqW9216+V7FUnioj4p+9J1pBg7DaWJs7eI5NReKVI5m4BZc
         bz4/2FKbwsbSlTmc8JJSGtrbYwBZ7hPh6d3HMM4tMyDz0i+ZORyjg7RsoKqkUy+pqxLo
         mWKYTHPm+mw1ryfsxAr3Bt/u/dv4/5lKKZqaFrxTqJ4Iz4bWg3QS/ZHz21G80tmfGUoW
         IIn8cX6Ir1KjiIOUtRKXdZqwNzyn5kGHo/oywuF2AQr415BXfwnT5XMwBTlymWxmkhFE
         eixA==
X-Gm-Message-State: APzg51D082VeJrUrQIUxJ2G5MUMJ7e1gfSqEw/dR5faNFEYlMo4c0dl0
        6NNLfAtCxgWrlckwRyFcfho=
X-Google-Smtp-Source: ANB0VdZWf0siBKdhWrhJ6Bz9HLbQzzJb49Z79wPC47qfzbXzfKczofzbxQDk7scN0TgV6IMQAAPShQ==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr2097691pgc.48.1536229352570;
        Thu, 06 Sep 2018 03:22:32 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id h82-v6sm7909555pfa.173.2018.09.06.03.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 03:22:31 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk
Cc:     steve.capper@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        android-treble-mediatek-ext@partner.android.com,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC 1/3] arm: mm: reordering memory type table
Date:   Thu,  6 Sep 2018 19:22:10 +0900
Message-Id: <20180906102212.218294-2-minchan@kernel.org>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
In-Reply-To: <20180906102212.218294-1-minchan@kernel.org>
References: <20180906102212.218294-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use bit 5th in page table, we need a room for that and it seems
we don't need 4 bits for the memory type with ARMv6+.
If so, let's reorder bits to make bit 5 free.

We will use the bit for L_PTE_SPECIAL in next patch.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/arm/include/asm/pgtable-2level.h | 13 +++++++++++--
 arch/arm/mm/proc-macros.S             | 16 ++++++++--------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 92fd2c8a9af0..91b99fadcba1 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -164,14 +164,23 @@
 #define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
 #define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
 #define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
+#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
 #define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
 #define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
-#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
-#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
+#if defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7M) || \
+	defined (CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
+#define L_PTE_MT_DEV_WC		L_PTE_MT_BUFFERABLE
+#define L_PTE_MT_DEV_CACHED	L_PTE_MT_WRITEBACK
+#define L_PTE_MT_DEV_NONSHARED	L_PTE_MT_MINICACHE
+#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x05) << 2)	/* 0101 */
+#define L_PTE_MT_MASK		(_AT(pteval_t, 0x07) << 2)
+#else
 #define L_PTE_MT_DEV_WC		(_AT(pteval_t, 0x09) << 2)	/* 1001 */
 #define L_PTE_MT_DEV_CACHED	(_AT(pteval_t, 0x0b) << 2)	/* 1011 */
+#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
 #define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x0f) << 2)	/* 1111 */
 #define L_PTE_MT_MASK		(_AT(pteval_t, 0x0f) << 2)
+#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 81d0efb055c6..f896a30653fa 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -134,21 +134,21 @@
 	.macro	armv6_mt_table pfx
 \pfx\()_mt_table:
 	.long	0x00						@ L_PTE_MT_UNCACHED
-	.long	PTE_EXT_TEX(1)					@ L_PTE_MT_BUFFERABLE
+	.long	PTE_EXT_TEX(1)					@ L_PTE_MT_BUFFERABLE(L_PTE_MT_DEV_WC)
 	.long	PTE_CACHEABLE					@ L_PTE_MT_WRITETHROUGH
-	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK
+	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK(L_PTE_MT_DEV_CACHED)
 	.long	PTE_BUFFERABLE					@ L_PTE_MT_DEV_SHARED
-	.long	0x00						@ unused
-	.long	0x00						@ L_PTE_MT_MINICACHE (not present)
+	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
+	.long	PTE_EXT_TEX(2)					@ L_PTE_MT_DEV_NONSHARED
 	.long	PTE_EXT_TEX(1) | PTE_CACHEABLE | PTE_BUFFERABLE	@ L_PTE_MT_WRITEALLOC
 	.long	0x00						@ unused
-	.long	PTE_EXT_TEX(1)					@ L_PTE_MT_DEV_WC
 	.long	0x00						@ unused
-	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_DEV_CACHED
-	.long	PTE_EXT_TEX(2)					@ L_PTE_MT_DEV_NONSHARED
 	.long	0x00						@ unused
 	.long	0x00						@ unused
-	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
+	.long	0x00						@ unused
+	.long	0x00						@ unused
+	.long	0x00						@ unused
+	.long	0x00						@ unused
 	.endm
 
 	.macro	armv6_set_pte_ext pfx
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

