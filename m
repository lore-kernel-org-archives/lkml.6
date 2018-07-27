Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEFDC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA039206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHFVNTpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA039206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeG0Ejh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:39:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39549 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeG0Ejh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:39:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so1240940pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to;
        bh=9Sr57swLBSLvmhuQRBpwtqfvQu7eG02RvZr11pmtwus=;
        b=rHFVNTpdl8xmUKCVIk9IrVW3SU42DCZ/BFYvnxHuRHTSleja2mvRgbha5H5FJRSwrU
         0dOaXiDwTES+5n4rLnUcbr1FkODtSqynLQASfSvpzNOMBRPCnfOWH7KNTEP/RxVO0X0P
         Of5oZZvvZmoaQVnrPkDnAZL04awwt0NmC1RoZovCVSD/wRI1NlL3swxUBQ9Qv0FFvmEK
         KDq2kRGFXIbbb8tiu2VTD9sdYygBm6w6x+hqueOeEBl9KPKAzTCHtAjcCgK9Ey80kGTx
         GWJ7ZR1soPVnBDrqEipYEEcYBaoaQS4I9JRZrwJ5shvYGCzwJ9yXzv8z+sBzbAEBJdOY
         SKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to;
        bh=9Sr57swLBSLvmhuQRBpwtqfvQu7eG02RvZr11pmtwus=;
        b=QsEAFBCvcsB4bSpll8ynVp/qSFiqNAquGlmplFk7mQN+sRz6bkv4SgzRS5uF9MZxH4
         xOShkDQ8WfhHLGC5qQ+sjVHTh+zE2Kme99bVYasUQYNHVIUlcYFtsJBdc63MEbCdxWO1
         w9J+/MbwuHwbmFtVioO93LF4lKjuOx2MEejyRvf450B3OfOg+ev/LzTfp8VUMi9TuxqR
         vXcSdple//dmNIU3C7gWTpIOzp77ydnMjl+tyxGS5H6ncj1i4NgHA3CGII9WUWOyKukF
         w56M7LrYSVruMB0h0le3fZ3KvYsw4tyA8bN4etMiBqMzK+k3HGNjKRhauXP2Uga8C3fY
         /kjw==
X-Gm-Message-State: AOUpUlEIyC1oCGjA7Pe9uTF4q3Wc6EPNjd25ZRAEXt6Rbk/5z2ODLNif
        JBixnwFIUf+cbcbE8ElV/s/P8z9i
X-Google-Smtp-Source: AAOMgpcZFvvSgeJuabGY+vm/EwVqNIBhV4n+NdZgbe9VOy8gC/Sesi4Pvie8wTLzFRRSoY0qjRa6qw==
X-Received: by 2002:a62:3b03:: with SMTP id i3-v6mr4753180pfa.197.1532661591544;
        Thu, 26 Jul 2018 20:19:51 -0700 (PDT)
Received: from localhost (static-50-53-52-16.bvtn.or.frontiernet.net. [50.53.52.16])
        by smtp.gmail.com with ESMTPSA id 64-v6sm4912973pfi.89.2018.07.26.20.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:19:50 -0700 (PDT)
Date:   Thu, 26 Jul 2018 20:16:35 -0700
From:   rd_dunlab <rd.dunlab@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Elad Kanfi <eladkan@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>
Subject: [PATCH 2/4 v2] arc: fix type warnings in arc/mm/cache.c
Message-ID: <1532661395238@infradead.org>
In-Reply-To: <15326613951079@infradead.org>
X-Mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix type warnings in arch/arc/mm/cache.c.

../arch/arc/mm/cache.c: In function 'flush_anon_page':
../arch/arc/mm/cache.c:1062:55: warning: passing argument 2 of '__flush_dcache_page' makes integer from pointer without a cast [-Wint-conversion]
  __flush_dcache_page((phys_addr_t)page_address(page), page_address(page));
                                                       ^~~~~~~~~~~~~~~~~~
../arch/arc/mm/cache.c:1013:59: note: expected 'long unsigned int' but argument is of type 'void *'
 void __flush_dcache_page(phys_addr_t paddr, unsigned long vaddr)
                                             ~~~~~~~~~~~~~~^~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Elad Kanfi <eladkan@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Ofer Levi <oferle@mellanox.com>
---
v2: drop some spurious (accidental) patch lines

 arch/arc/mm/cache.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-next-20180723.orig/arch/arc/mm/cache.c
+++ linux-next-20180723/arch/arc/mm/cache.c
@@ -1038,7 +1038,7 @@ void flush_cache_mm(struct mm_struct *mm
 void flush_cache_page(struct vm_area_struct *vma, unsigned long u_vaddr,
 		      unsigned long pfn)
 {
-	unsigned int paddr = pfn << PAGE_SHIFT;
+	phys_addr_t paddr = pfn << PAGE_SHIFT;
 
 	u_vaddr &= PAGE_MASK;
 
@@ -1058,8 +1058,9 @@ void flush_anon_page(struct vm_area_stru
 		     unsigned long u_vaddr)
 {
 	/* TBD: do we really need to clear the kernel mapping */
-	__flush_dcache_page(page_address(page), u_vaddr);
-	__flush_dcache_page(page_address(page), page_address(page));
+	__flush_dcache_page((phys_addr_t)page_address(page), u_vaddr);
+	__flush_dcache_page((phys_addr_t)page_address(page),
+			    (phys_addr_t)page_address(page));
 
 }
 


-- 

