Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D985CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C14214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jbD8plmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C14214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeIZSHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:07:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbeIZSHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KA2dSx29O1++y9jSzA5WFLAkZsmP8i/iX3gCcgZBjng=; b=jbD8plmcHGE46ObbvYYsmPpiTB
        UC0Kyw06PgzPDYzi0+oBF+bFhAzFpTr07l6g8FuYwDuOtuEgNzaK6Zwh/HGeBajYXkgFTYq+WwEH8
        9aGMfmI+DpYw5Z5Hfdg9ykvhEn1fQNxKnU1YAQ0szSs/dHGT2MV1cKurOGHNVz9gjH18Lig2eSVI+
        3QWhc8Yj4eGPVTOkZdwQE6tJcMAQTG6icBLlij5y8+WnMiiKxp68tlYeWI+oRgbyPrmqk93fmNu2h
        kGh2U99J2CWuxvv4YBeAqNfQhZhEmHPsZ9Dhl/zqlRKqwKlz0/IZrbOClOeg4ZCzQZjpYr+z2yy+A
        AT26wr8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58Oy-0007Uo-2N; Wed, 26 Sep 2018 11:55:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B9A40206F1834; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114801.366086396@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH 16/18] asm-generic/tlb: Remove HAVE_GENERIC_MMU_GATHER
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all architectures are now using it, it is redundant.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |    1 -
 mm/mmu_gather.c           |    4 ----
 2 files changed, 5 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -139,7 +139,6 @@
  *  page-tables natively.
  *
  */
-#define HAVE_GENERIC_MMU_GATHER
 
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 /*
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -11,8 +11,6 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
-#ifdef HAVE_GENERIC_MMU_GATHER
-
 #ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
 
 static bool tlb_next_batch(struct mmu_gather *tlb)
@@ -109,8 +107,6 @@ void tlb_flush_mmu(struct mmu_gather *tl
 	tlb_flush_mmu_free(tlb);
 }
 
-#endif /* HAVE_GENERIC_MMU_GATHER */
-
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 
 /*


