Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9239C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7B8217CD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FjVLWXl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7B8217CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754299AbeFUSIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:08:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52495 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754134AbeFUSI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:08:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so6594131wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jlif8cZDXUisRged7DKaVTS4g+nHLP46lSFjlmxfdVc=;
        b=FjVLWXl11rqTzo3UWh3kpyho0pepDJSBfD2Zmk9ghnGbQpUnkftq/X4zbOCyRq5Vsy
         pyXlQx6UYQPi3ZASl1y1bhdX1XwVruRruPae4lpoPQ5wqyiKn/bTrJ/8OhOYPp/yow+k
         iMpUFwJXw7SdxleJg9Gcxg/wI3ksM3uWIkoLRG7fasWNL+GCMeEHmVzA0DIJutLYIPp7
         gZbibyROiw9yftXdyvj/ErXHWupxOsTFAgV9DE7+GvC2HdwaalU6//O/FbyAsPr5QdW5
         30MbkBI+2YqOEBwnXwsKgN4kOvbGg8ozUi8RFcvXy28yuPz0lB0o0EI3cEDFZPiSi5/J
         pujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jlif8cZDXUisRged7DKaVTS4g+nHLP46lSFjlmxfdVc=;
        b=adYglX+eSDbp7FzRxUk6GNhSmNXEes/QrQDCp+cbC/hz0jPHAmUC+GjfCnv9f80X5M
         KzA/JpcSN5Qjge8+YH9+yP8kMFTFNNrcUsmeBr3m+VzCCFkT3HQGuHAPfZmuaio+fGiU
         u0TkE5qrPegI/dLEhrHnxf9RDqMDXKQzuRHtlTrUacG+k1i6khz1kok088QyNs3ozn0E
         9Eh2jXoskcxwpCLuDNO809yIwKx8MmiMCOOPK7HZLYw77EC8vz0ulGlKv5Hy3C2rTu/m
         1pYEfq+Ekk/cyLIS3w1QRbykdPTFtbr0ZRbtqqfV8S712/2CTfg1pUVz5bzxbHfYR+1s
         tVEw==
X-Gm-Message-State: APt69E1Dz6joVh37hBLZCAIwn/0dOCJNynRTrUytLZapNWyzC4sd7BLb
        eoxc2YV4fhFb05gblJIzBJbIVkNJKoU=
X-Google-Smtp-Source: ADUXVKKAfo2dCUloj/EjPMyabTPFGVlyP/aHqV7O5grXcD7Y0/fx8GAX40dlIneWv4nXnATHeliRYg==
X-Received: by 2002:a1c:6d85:: with SMTP id b5-v6mr5660795wmi.135.1529604507848;
        Thu, 21 Jun 2018 11:08:27 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 127-v6sm9165927wmk.45.2018.06.21.11.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 11:08:27 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [RFC 3/3] iommu/iova: Remove find_iova()
Date:   Thu, 21 Jun 2018 19:08:23 +0100
Message-Id: <20180621180823.805-4-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180621180823.805-1-dima@arista.com>
References: <20180621180823.805-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is potentially dangerous: nothing protects returned iova.
As there is no user in tree anymore, delete it.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/iova.c | 20 --------------------
 include/linux/iova.h |  7 -------
 2 files changed, 27 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4c63d92afaf7..4a568e28a633 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -336,26 +336,6 @@ static void private_free_iova(struct iova_domain *iovad, struct iova *iova)
 }
 
 /**
- * find_iova - finds an iova for a given pfn
- * @iovad: - iova domain in question.
- * @pfn: - page frame number
- * This function finds and returns an iova belonging to the
- * given doamin which matches the given pfn.
- */
-struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
-{
-	unsigned long flags;
-	struct iova *iova;
-
-	/* Take the lock so that no other thread is manipulating the rbtree */
-	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	iova = private_find_iova(iovad, pfn);
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-	return iova;
-}
-EXPORT_SYMBOL_GPL(find_iova);
-
-/**
  * __free_iova - frees the given iova
  * @iovad: iova domain in question.
  * @iova: iova in question.
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 803472b77919..006911306a84 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -158,7 +158,6 @@ void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
 int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
-struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 struct iova *iova_split_and_pop(struct iova_domain *iovad,
 		unsigned long pfn_lo, unsigned long pfn_hi);
@@ -243,12 +242,6 @@ static inline int init_iova_flush_queue(struct iova_domain *iovad,
 	return -ENODEV;
 }
 
-static inline struct iova *find_iova(struct iova_domain *iovad,
-				     unsigned long pfn)
-{
-	return NULL;
-}
-
 static inline void put_iova_domain(struct iova_domain *iovad)
 {
 }
-- 
2.13.6

