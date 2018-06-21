Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79210C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF84219C6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="SoRzxnSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF84219C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeFUSIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:08:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54382 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeFUSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:08:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id o13-v6so6524970wmf.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4OVkQMfco+pkdlJQkKbGNSMsCdGKfZMm7e+f5NN65HY=;
        b=SoRzxnSbMmojBuafxcam+Uka+I1wI/kLPzYYeawXQtWAgr3jaqqvJ6XfypPtbD5s70
         BnNapPWstOAv79Xtlss8/jlMsetRQ/5qyA8bmxzdUGTHLv+8+hPJsHhl8+9riP/oay9Q
         HQTRqfeME1ry6O1g8Co+Uk5riV+r0j0cJgIJQveq8eU9bCfw1FrglUxfySjVx/SZ+vIJ
         pn7Xfap4s+OA7UgcPh4flSgoVdgq5S4QZ5WC2hHIA/Qy6gfbVlTiogR0qaEEx3Sxo70x
         0A30SG/xdqbSwOAFpU5bVxZBTmaYNZkiOAXeyTwihwg3y9ZMJRDsKkqsG+zYj0cbYF8g
         NA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4OVkQMfco+pkdlJQkKbGNSMsCdGKfZMm7e+f5NN65HY=;
        b=jGiZkqsnznJ+BLtgPIkuW6u2Oqw6nBVNrIVOYB4aaojCXON1FQWNLn2cHrU33pLwcg
         8Fm8SB+1ND78HktVK8PmNaJUAToBT+IhM9IFP9U4L4D9R8v94RLOGEcgYudJ4VR8AIAI
         2cmw/JiymHQ2O0f+cwsJtIzpgnhvYlQmgcq7Y2+Bb7zW9vsE1FimnqkMR++SJj0Csf7y
         oAM6YloyjRFrHlmw4n6xVJXadeV+4MWjOX7UjaidoJ+f+UJ5fXMV2KUMsHAMmFUb2eV8
         1bzy1x+r6xiCGsZi4uBBDKuTp2wYsvaDLh7OQg+ij21WnY8h5mi+0mGyE7e0rXnEfn6D
         qOXQ==
X-Gm-Message-State: APt69E0vpS0Kna8W0uXPaUJ/gCQei8Kv8uES/SUOgcoqsU2ba2R7NaE0
        5VYI2pb0Jgil0xyjklOCxdcCov00ME0=
X-Google-Smtp-Source: ADUXVKLbHFmxVsGRLU5an2bChGUkbvuFukMO9YsUhjuvCTp2ogN16NCQSLyyqNiuPH/R9c4TgG39Lw==
X-Received: by 2002:a1c:9bd0:: with SMTP id d199-v6mr6068851wme.16.1529604505823;
        Thu, 21 Jun 2018 11:08:25 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 127-v6sm9165927wmk.45.2018.06.21.11.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 11:08:25 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [RFC 1/3] iommu/iova: Find and split iova under rbtree's lock
Date:   Thu, 21 Jun 2018 19:08:21 +0100
Message-Id: <20180621180823.805-2-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180621180823.805-1-dima@arista.com>
References: <20180621180823.805-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_iova() holds iova_rbtree_lock only during the traversing rbtree.
After the lock is released, returned iova may be freed (e.g., during
module's release).
Hold the spinlock during search and removal of iova from the rbtree,
eleminating possible use-after-free or/and double-free of iova.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/intel-iommu.c | 14 +++-----------
 drivers/iommu/iova.c        | 19 ++++++++++++-------
 include/linux/iova.h        | 10 ++++------
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 14e4b3722428..494394ef0f92 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4530,19 +4530,11 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 			struct intel_iommu *iommu;
 			struct page *freelist;
 
-			iova = find_iova(&si_domain->iovad, start_vpfn);
+			iova = iova_split_and_pop(&si_domain->iovad, start_vpfn, last_vpfn);
 			if (iova == NULL) {
-				pr_debug("Failed get IOVA for PFN %lx\n",
-					 start_vpfn);
-				break;
-			}
-
-			iova = split_and_remove_iova(&si_domain->iovad, iova,
-						     start_vpfn, last_vpfn);
-			if (iova == NULL) {
-				pr_warn("Failed to split IOVA PFN [%lx-%lx]\n",
+				pr_warn("Failed to split & pop IOVA PFN [%lx-%lx]\n",
 					start_vpfn, last_vpfn);
-				return NOTIFY_BAD;
+				break;
 			}
 
 			freelist = domain_unmap(si_domain, iova->pfn_lo,
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 83fe2621effe..4b38eb507670 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -715,23 +715,27 @@ copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
 }
 EXPORT_SYMBOL_GPL(copy_reserved_iova);
 
-struct iova *
-split_and_remove_iova(struct iova_domain *iovad, struct iova *iova,
+struct iova *iova_split_and_pop(struct iova_domain *iovad,
 		      unsigned long pfn_lo, unsigned long pfn_hi)
 {
-	unsigned long flags;
 	struct iova *prev = NULL, *next = NULL;
+	unsigned long flags;
+	struct iova *iova;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn_lo);
+	if (iova == NULL)
+		goto err_unlock;
+
 	if (iova->pfn_lo < pfn_lo) {
 		prev = alloc_and_init_iova(iova->pfn_lo, pfn_lo - 1);
 		if (prev == NULL)
-			goto error;
+			goto err_unlock;
 	}
 	if (iova->pfn_hi > pfn_hi) {
 		next = alloc_and_init_iova(pfn_hi + 1, iova->pfn_hi);
 		if (next == NULL)
-			goto error;
+			goto err_free;
 	}
 
 	__cached_rbnode_delete_update(iovad, iova);
@@ -749,10 +753,11 @@ split_and_remove_iova(struct iova_domain *iovad, struct iova *iova,
 
 	return iova;
 
-error:
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+err_free:
 	if (prev)
 		free_iova_mem(prev);
+err_unlock:
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return NULL;
 }
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 928442dda565..803472b77919 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -160,8 +160,8 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
-struct iova *split_and_remove_iova(struct iova_domain *iovad,
-	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
+struct iova *iova_split_and_pop(struct iova_domain *iovad,
+		unsigned long pfn_lo, unsigned long pfn_hi);
 void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 #else
 static inline int iova_cache_get(void)
@@ -253,10 +253,8 @@ static inline void put_iova_domain(struct iova_domain *iovad)
 {
 }
 
-static inline struct iova *split_and_remove_iova(struct iova_domain *iovad,
-						 struct iova *iova,
-						 unsigned long pfn_lo,
-						 unsigned long pfn_hi)
+static inline struct iova *iova_split_and_pop(struct iova_domain *iovad,
+		unsigned long pfn_lo, unsigned long pfn_hi)
 {
 	return NULL;
 }
-- 
2.13.6

