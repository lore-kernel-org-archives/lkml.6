Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89CC67790
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA60620852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1pH7mxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA60620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbeGXVys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:54:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42142 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbeGXVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:54:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so3688672pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fZdUYn2ZVBIMk2fhKZQTtHGLabYHRqk234ZLxnVRc+w=;
        b=J1pH7mxbP0OilhfRPe6GYP527hAhlpaDnqHLeXFnq6tDBqt3VNGoY1rDZICyJJng8a
         xU7sOxOydtgTBTEw6uSWe8g6R7SDxYEcmat2WOndV/Kk+jDBb10OFMbjF9PXRSu7dgd9
         ef100bsJ5ZVuxtIYi7JFd4qNNqW6kx/r3ecV/2DJhNUprgUM93FY8t5zRUjYSSk5mp60
         ZLGdOr+PytuA5Drwh33zpUd69zd5VVWFVG4Bd1vOT3Rw6ciIqVyMN72ZjxS+QqQ8D2Mi
         aLZk3yPLgd2UlGEhSZrLNKbFl280ouGUgObZa5zBSEXe6nXV9XS+U5nY3GhuGTS5nW7F
         FvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fZdUYn2ZVBIMk2fhKZQTtHGLabYHRqk234ZLxnVRc+w=;
        b=uGh1ftn9/5kY215XPOz4ntJIp0T75j45nKd17lHTLjwKWOnGngN/AybjywkTyQli+F
         6UAcqyOjNLWv2mWyH2oAZQlQhNqUyNE+IM8Yp+mRzpF+n4GqMKmG3OdxLK77VM6c5aFr
         Jt1t7BpngjHzFq27OSzw7rdh/RrdD2C7oIQAOS0KCB7sX13tnBuG+On31XP9fJjDbEEe
         X7CbPK9tyOSxd96REsYMBi4hdgtYguqIMEKYfufz+JQR9px9yZ1KWIgAwU5z4dqZKWBP
         Eqx9rkeyR0+k0OzGNq1LXt6mglgZ+EX9egQT5Ggh+Bb97mIjOW0WvegRvlLl9XBScF1e
         jgVQ==
X-Gm-Message-State: AOUpUlGEzHFQTHSIA7JX0mWHzw3zHM4AnBQe0Bm1uavyZ460PHI8/Whi
        m115gxjh/kcEcmSxe6GDH2QXM2g0
X-Google-Smtp-Source: AAOMgpenYFNN0Pnx8P1jGp2lgBlX9wp46VT9vPEsAXiU+2qzjdylCIiefrTVwlgTxVDUC5JUm1xVog==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr17863487pgt.164.1532465193483;
        Tue, 24 Jul 2018 13:46:33 -0700 (PDT)
Received: from midway.home (static-50-53-52-16.bvtn.or.frontiernet.net. [50.53.52.16])
        by smtp.gmail.com with ESMTPSA id t21-v6sm21536110pfi.73.2018.07.24.13.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jul 2018 13:46:32 -0700 (PDT)
From:   Randy Dunlap <rd.dunlab@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Ofer Levi <oferle@mellanox.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH 2/4] arc: fix type warnings in arc/mm/cache.c
Date:   Tue, 24 Jul 2018 13:46:20 -0700
Message-Id: <20180724204622.2366-3-rd.dunlab@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180724204622.2366-1-rd.dunlab@gmail.com>
References: <20180724204622.2366-1-rd.dunlab@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

../arch/arc/mm/cache.c: In function 'flush_anon_page':
../arch/arc/mm/cache.c:1062:55: warning: passing argument 2 of '__flush_dcache_page' makes integer from pointer without a cast [-Wint-conversion]
  __flush_dcache_page((phys_addr_t)page_address(page), page_address(page));
                                                       ^~~~~~~~~~~~~~~~~~
../arch/arc/mm/cache.c:1013:59: note: expected 'long unsigned int' but argument is of type 'void *'
 void __flush_dcache_page(phys_addr_t paddr, unsigned long vaddr)
                                             ~~~~~~~~~~~~~~^~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Ofer Levi <oferle@mellanox.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/mm/cache.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

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
 
@@ -1084,7 +1085,7 @@ void copy_user_highpage(struct page *to,
 	 * addr_not_cache_congruent() is 0
 	 */
 	if (page_mapcount(from) && addr_not_cache_congruent(kfrom, u_vaddr)) {
-		__flush_dcache_page((unsigned long)kfrom, u_vaddr);
+		__flush_dcache_page((phys_addr_t)kfrom, u_vaddr);
 		clean_src_k_mappings = 1;
 	}
 
@@ -1105,7 +1106,7 @@ void copy_user_highpage(struct page *to,
 	 * sync the kernel mapping back to physical page
 	 */
 	if (clean_src_k_mappings) {
-		__flush_dcache_page((unsigned long)kfrom, (unsigned long)kfrom);
+		__flush_dcache_page((phys_addr_t)kfrom, (unsigned long)kfrom);
 		set_bit(PG_dc_clean, &from->flags);
 	} else {
 		clear_bit(PG_dc_clean, &from->flags);
