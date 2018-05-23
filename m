Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527095651; cv=none;
        d=google.com; s=arc-20160816;
        b=FWkNElUSC1xaFuGADzjq/2J3oBpIeXTs/Ew5pMHAQZ1Yx3Fi7ahdP6/Y7TIvZwxExF
         uKQuHynyOrLTOSuo886MxJo982t3WhpKaXcLW4rDP6vGmDS+P8He2mowa2FntmxbLewX
         gMBN0h62om5lW7FSpNgvy7+RHC6J2peNgp+fARKZIJ6JZdCYf02lqDbismkgL9jtUORy
         cKzBfkpwYJycUtH8w4s/rBzPIcH66TCcKj4kBxvSrf7OHj8Baa86i5jyhniGuE9hHvNU
         SLX5EwAYEw9W/M1hc2hJ8rAkqUWP6XQO18GB/ZopaXbnUBjLfdLVS83BD4Zf4UXg5Zgn
         +C3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Jc5ICXCG0sq4ebqr99PgbA0c2yw6j3epJGQUQjIuc40=;
        b=vWQigD5ufAegTLp0X9OJ242B42tYYqDfj37l1g19JL5G1aM9DOtJoWgYe7Brs6wLBs
         2DCpttxnrIDnEP9gC7gFg78H96xuhIAkDNiAgbQfR/hi+mHJ3F2UsO0rCRrEB2+a/dfl
         ejUEkrmxaON2pTbE9zahpeX+qKJa6WBvXSxt0lveuSbz1YCzLEUXSGcH9KXzAG1eGh3b
         h5oc5TC60rLKqlfza/0f5djrWYrD82EU66XQ+lUlzO7yzhXrilZlWZVhV+nsJc+vZYmQ
         sM1/aFeK3phNH6jc7ihiYNdutemEGS8BskNqkCLaJ0zVXDVazbNMYGukG08bINwwo03O
         DS8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pvwCJlp6;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pvwCJlp6;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZorUSONWZo32qfGcRK1YhrjwyNV60ZkDMdev/1XyUs8Ut+gZ/ytxQlS07eumHCbEeUQ3zMHfA==
From: Huaisheng Ye <yehs2007@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: mhocko@suse.com,
	willy@infradead.org,
	hch@lst.de,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	kstewart@linuxfoundation.org,
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
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v3 9/9] arch/x86/include/asm/page.h: update usage of movableflags
Date: Thu, 24 May 2018 01:13:41 +0800
Message-Id: <1527095621-5574-1-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601275849153186587?=
X-GMAIL-MSGID: =?utf-8?q?1601275849153186587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

GFP_HIGHUSER_MOVABLE doesn't equal to GFP_HIGHUSER | __GFP_MOVABLE,
modify it to adapt patch of getting rid of GFP_ZONE_TABLE/BAD.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org <x86@kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 arch/x86/include/asm/page.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 7555b48..a47f42d 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -35,7 +35,8 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 }
 
 #define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
-	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
+	alloc_page_vma((movableflags ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER) \
+	| __GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 #ifndef __pa
-- 
1.8.3.1
