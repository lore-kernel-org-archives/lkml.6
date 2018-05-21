Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526916058; cv=none;
        d=google.com; s=arc-20160816;
        b=ZHq+BmMYHP1VuhXOawDH+6el6ejc/RurqtDE3EiHt3VcEOCSs9xtAfWCZqExcWzF10
         /oe/vWUE/l9yXfJgoqNUalrgNun5qSeIdhBL3ORZi2knrLQmu7L/Incrgr1/fuKvtwoX
         p2vI3TRIWFprsJ1/D3iBlotuJJYVF6twLVgmzqH2xreG0I5WY/Kq+z55XB0c6FZCexpD
         rbRoKoCC5QLcogGjWKiQkpr/V+qOzvK2UNo5368EF+Day1dhagfw9P5PzuRHGVNpk1nQ
         sljmvBJIWozrIMFiyqV4AIy9vo+Y6j2pgHcvJCfAFMoWPZII1iJESKEtPL0Tc7IIUamp
         mz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=+qXoWc9m1t3VT6I86x0msVkk0a5EDzoYUDMpAQp8jw4=;
        b=vXUax++mMm0KMe6jrWpKUxy/B3EcHLwJruBie3ZVPN9mvTdn0K109KSXcNSoLX0kQA
         5JryTpxxeSmrmdEX3+ZCKK+6emmWnx9s4pXbRAUd7lSgemzo7kp9fZgvVZod36j3Ak7W
         q6KUk3WuMy9oiK8C63LZNLQg4jENVyoMjMg01sFZwNmFZwKZNIsej5HRD8UVRGCi9IPK
         l4/DkocK9tcrWQklvkAzcs16CO/cj2SDG9tlQzIITl5JnjqIV1JK7RaFJvXKZvenVrFK
         5es2nkp/Mk0L+8R8ZEJzkXXXW+QfUbSZL6GFu0l1dne4Qh+vvRfOpYZyxcuDoqXYjUiW
         KA9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OoNijXYv;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OoNijXYv;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqewaMO6N2bHpyXYSuDYmPj77UwH9wj1+0OYgDu4Sv0hKoq/yJBAz59W+ZZM7RsR0slj5L6UQ==
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
	Muli Ben-Yehuda <mulix@mulix.org>,
	Jon Mason <jdmason@kudzu.us>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH v2 03/12] arch/x86/kernel/pci-calgary_64: update usage of address zone modifiers
Date: Mon, 21 May 2018 23:20:24 +0800
Message-Id: <1526916033-4877-4-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087532360168136?=
X-GMAIL-MSGID: =?utf-8?q?1601087532360168136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32).

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated by OR.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/pci-calgary_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 35c461f..c89717d 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -445,7 +445,7 @@ static void* calgary_alloc_coherent(struct device *dev, size_t size,
 	npages = size >> PAGE_SHIFT;
 	order = get_order(size);
 
-	flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
+	flag &= ~__GFP_ZONE_MASK;
 
 	/* alloc enough pages (and possibly more) */
 	ret = (void *)__get_free_pages(flag, order);
-- 
1.8.3.1
