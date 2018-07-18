Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5CDECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE71C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGq+kwnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE71C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeGRKzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:55:17 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42216 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbeGRKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:55:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id l9-v6so1983586pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eRDwASIsY8b+RX050eLm0VBB26pLnnPViHoepUqi2Po=;
        b=ZGq+kwnN0E9i9dy3JvIzgqeCn45XvfDGq/IB4MUI8GiIwX1hAgQx2uAemjCOPGwrTY
         gwPR4KnTXmBL4BmC8ez/yT+Zp9wfF6Xl8mdE9kLnQ4oGillqRiQ8P2YcHWwK+/N7OH7C
         tYTdwin4v657p0SDtnVMAzizOTOxPrFNdME4O1GSIGhP6T3dDypSyY6HqQDSZv3grxto
         rm4K/puEKpdA8Lq49kE1sMlyH/Yh2okr70ll2G05Z4Meye7kIC0igNKVbWFShm+B8WnK
         didWlKywzkfqGuunRfXPPGgazIdqz0RKoGK1ai10Z319G1Cl+adg/uCGC97PB30HenX1
         IIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eRDwASIsY8b+RX050eLm0VBB26pLnnPViHoepUqi2Po=;
        b=Ixecnn5KigWQuiSvvewQvdntBRD1UDUqGw+k8OF9jVNo1mreiDimlvx2FKchwYEA+4
         QFuqMgz42tmAjCi9kiR9Lh+ISzaf1HdTkzZAkwVFtvCbIR1i4U1/LoAVpTRIsCtq2H89
         Oaqe6l6meiwtJQnq8f94qrRCfO/tay9EEM+/UZwji/wxnPtC5CazHBxF91qwZXdlIiw2
         r1xEdxN/RjjbccxXBy5T/jqBJqVaREoxoyt/pQQDQFQ0X5Y/ZnEG0e586FrRwvQIoZk2
         UW3gkl7irqu9kxC0XTa950UuAxIYrQa9xR64WlzUX2br6WAaNfAoGr4D7aB0cvhn4UDs
         fhfw==
X-Gm-Message-State: AOUpUlFx91wbn3gyR42Ho8PnMUZphAVqcJ8DNP/wSJ7n7IODJ/nMYgbm
        n2rKfBx46bdLlGwx4TTqgjs=
X-Google-Smtp-Source: AAOMgpfeiz3tXLB5ESsZXCWZlRF3NLqq6tikDmEZ/vaCylCaT9KQ6FfLldeRHr2VGJcawFqIrjydZg==
X-Received: by 2002:a63:5106:: with SMTP id f6-v6mr5078111pgb.95.1531909085434;
        Wed, 18 Jul 2018 03:18:05 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id x2-v6sm6899518pgq.33.2018.07.18.03.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:18:05 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 4/6] arm64/mm: Make swapper_pg_dir smaller
Date:   Wed, 18 Jul 2018 18:17:25 +0800
Message-Id: <20180718101727.10787-5-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718101727.10787-1-yaojun8558363@gmail.com>
References: <20180718101727.10787-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We setup final page tables in swapper_pg_dir, which just contains
PGD. And the PUD/PMD are allocated dynamically. So we can make it
smaller.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 arch/arm64/mm/mmu.c             | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 61d7cee3eaa6..2446911f4262 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -237,7 +237,7 @@ SECTIONS
 	. += RESERVED_TTBR0_SIZE;
 #endif
 	swapper_pg_dir = .;
-	. += SWAPPER_DIR_SIZE;
+	. += PAGE_SIZE;
 	swapper_pg_end = .;
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 088a591e4ea4..1d16104aa0b9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -633,14 +633,6 @@ void __init paging_init(void)
 	map_mem(swapper_pg_dir);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 	init_mm.pgd = swapper_pg_dir;
-
-	/*
-	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
-	 * allocated with it.
-	 */
-	memblock_free(__pa_symbol(swapper_pg_dir) + PAGE_SIZE,
-		      __pa_symbol(swapper_pg_end) - __pa_symbol(swapper_pg_dir)
-		      - PAGE_SIZE);
 }
 
 void __init set_init_mm_pgd(pgd_t *pgd)
-- 
2.17.1

