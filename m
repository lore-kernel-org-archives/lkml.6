Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526916067; cv=none;
        d=google.com; s=arc-20160816;
        b=ZjTIVNmE+0/pn6PZ2OqGpqeDFnCuS2jfMWotCjrlEICKA/YLXAfq6/OePJ9cPgY4GI
         s4oeGctoJgpykIfH7u1b/9IDGP9ekHxGBv+v847qg9LqsoRmMXctZ8M0TyM/9vgfFJEM
         pHBBfs2icndiwKUK0atHcMfGNswvIo1s4gIc87r+4xOWJ4F4vJqe5SsX8sWRorv8N33R
         M+xvaKWMAwzFA6PRL0isLiyyjsB3F7bKtdT8o9YJNlFMm57SlxM38NoTUcRTcgA51rDs
         h2zE0MGBFYOD1dLbgCMcixA+U23CodqwL5Jzdu9JplwKjCNg28EXuUDX66GLR8+MtCnv
         XVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=SUiCWouVd2T3gM8xCB5UBKbjkUCyzntvXUY+hRFZOzw=;
        b=BHEzZTr03qaZvh1UpE6p6fFqeOu9cchKJCl3HtLsbiM2vPNXsvm033/mmDF24Vnjqs
         aYapV8XbiA3+n+3OaSpBBv8P16cfktH7CW6FiEwHTz0z/cLJOfSupYyi03eUSO6mIjNu
         tZp5vqKZvaP11UmMp7JDtlXV6upgW96iEaXohfDP6trTgKc51Y5e9HKgRvPsEEcIz9Wz
         +3nXe1iy5lsYPe+AQ7kyAY+sjMC3wqWTYuUhREeKRymSizCmZDb+yPoiLNtVPgnfKE0A
         PJNAanXO2ay4id3XyZ+RmXEUm/2xad7tawlJyGpBiRiTQ3BGUgIXmQvmgoIwCHXwMnC6
         wy3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qcd/9+PX;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qcd/9+PX;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZr0bb5Au61as90Ksqt6nlcN/jKlSrhahAU776NC8bZZK4XJ8qQOKGsXbGIUqWh6DmAr1YNTxg==
From: Huaisheng Ye <yehs2007@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: mhocko@suse.com,
	willy@infradead.org,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	kstewart@linuxfoundation.org,
	alexander.levin@verizon.com,
	gregkh@linuxfoundation.org,
	colyli@suse.de,
	chengnt@lenovo.com,
	hehy1@lenovo.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org,
	Huaisheng Ye <yehs1@lenovo.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RFC PATCH v2 05/12] include/linux/dma-mapping: update usage of address zone modifiers
Date: Mon, 21 May 2018 23:20:26 +0800
Message-Id: <1526916033-4877-6-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087542252628612?=
X-GMAIL-MSGID: =?utf-8?q?1601087542252628612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32).

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated with
each others by OR.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eb9eab4..3da0293 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -523,7 +523,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	 * decide on the way of zeroing the memory given that the memory
 	 * returned should always be zeroed.
 	 */
-	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);
+	flag &= ~(__GFP_ZONE_MASK | __GFP_ZERO);
 
 	if (!arch_dma_alloc_attrs(&dev, &flag))
 		return NULL;
-- 
1.8.3.1
