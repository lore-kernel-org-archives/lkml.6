Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526916098; cv=none;
        d=google.com; s=arc-20160816;
        b=ihlfBtp8M2HsIi5RzDkWADER2U9wSF4HOAQiAyCZ7LlxvSvE502TGKdAhebOejVPRK
         TMA50EXunsutzkacMS9ggP7eCZJx3lw4OQIgResZ4wGFVYivAHfR91WMc0he7wobPRDh
         KRLGoPJV1AznOXgHlpjoqKpo+5L5Esi/IARtUALbwHV5yjYqudORykmqdHbxrFRgY3s+
         pr0icLoQDbXRwlal4xTfY8PRi1PhE5ca+fXt2aS2RkKyiwC+0/CUC6xpdLXpvBTddtB4
         y46zy9NkByZY9sDXb1wGnSKG4DTDflRE/vp96W/bd3JVOA0nDQKE0Wo4M16PAkTpx+v0
         L2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=mIbmZ20teXfAmOTtwA1kFrQ87eKmr8IakHelnh9jX5M=;
        b=AHgBYTLjOmPFAf/XyCHw5+Ea7AaQ6KIpSiqCWG/YoaHyR7akgNJTFqWkWdqEZX7zhn
         09MoY1gNyo39r6MRNCuQ7wd1RS0B4CWX6X8HiUmsAcGTpzy1yYqrgQZuzlFU7zQN08dN
         eXYwvDE9BNcxNFAzxvN0QkTXbgj7P16Pr3Laj1rG0qt3PWTy+/pkUKmb231oM4pwjGh3
         6tNhVYIWZvsZdN1uUArTPApwBriCovhoVxXg8W/ULscrrP2vfAbLu8bD6ap1I+aKMmVQ
         Qs9A1IdNU78JamO5z9ajiczF+3gxqyFo2VEKja0fzDlExTPzs2Ne7mX6SvJ5NXrd8J9+
         /9DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GbmDhgVt;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GbmDhgVt;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZr+oLHMSLuqYb/ZI2mVYYGNkmtN1FuZjw3vt+shfVrfBheiJb1XBhgdmJ0TQsYqtOhkJprquQ==
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
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: [RFC PATCH v2 11/12] include/linux/highmem: update usage of movableflags
Date: Mon, 21 May 2018 23:20:32 +0800
Message-Id: <1526916033-4877-12-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087574960962515?=
X-GMAIL-MSGID: =?utf-8?q?1601087574960962515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

GFP_HIGHUSER_MOVABLE doesn't equal to GFP_HIGHUSER | __GFP_MOVABLE,
modify it to adapt patch of getting rid of GFP_ZONE_TABLE/BAD.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
---
 include/linux/highmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 776f90f..da34260 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -159,8 +159,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 			struct vm_area_struct *vma,
 			unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER | movableflags,
-			vma, vaddr);
+	struct page *page = alloc_page_vma(movableflags ?
+		GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER, vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
-- 
1.8.3.1
