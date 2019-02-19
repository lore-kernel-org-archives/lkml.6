Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD97C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2612146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGxa/fcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfBSKdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:33:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55612 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfBSKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xzoq3822VPftHOSX/XRMpwACoEFrdDki2itBY3y0uPM=; b=rGxa/fcUPtcZpXT5CV7qV8y0/4
        M/Fj8EB0WmOLN0suzx92w6QVbQn4Wkx4dbJUZdJLuz3GpgbNguH9ijZ6m5p97OIOA3FVErUQ64h3I
        R76XxI/m15st9xBUJqAvMoXQDJ/Eb2so7FbudtAIogDG48JEWxB6lYHPFgR4xj1bEfJdow8fcIZZR
        UwXo0Tkr9omxjLd1HoVT/OFxOd2Til3bkNtbnw63ae6nzQqBp42O8MYSSDyOx9VoYxmq2DYw2oIpN
        rAFeiMneF2AxjVtYwN6R+/aHONB3UdZAXoswzn2foFmmUWJkJqdOPvFQRl3YiBepiDCvEYDekTVM9
        op1RG5Rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw2hn-0000dj-UE; Tue, 19 Feb 2019 10:32:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 59AEA285202C8; Tue, 19 Feb 2019 11:32:48 +0100 (CET)
Message-Id: <20190219103233.207580251@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 19 Feb 2019 11:31:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH v6 06/18] asm-generic/tlb: Conditionally provide tlb_migrate_finish()
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needed for ia64 -- alternatively we drop the entire hook.

Cc: Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -539,6 +539,8 @@ static inline void tlb_end_vma(struct mm
 
 #endif /* CONFIG_MMU */
 
+#ifndef tlb_migrate_finish
 #define tlb_migrate_finish(mm) do {} while (0)
+#endif
 
 #endif /* _ASM_GENERIC__TLB_H */


