Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526916103; cv=none;
        d=google.com; s=arc-20160816;
        b=TaKC9cxUACzYqFbzYgLDxBo+zC6kF06SreyGe4dCZtXLN9uFLvyIi1qje/oMYXtUvF
         egJtbSsHOuPIH8zNBMKE9haKB6xCp8/27zYhJO4RWpdlTK5RKV5FFSvSAEGqtmWwy1Mh
         JgXudfKjQO3FwVZCJ7kCPO2hK1M7dRZXRWcHM/bzmvQB0sCq+8LRrLFBulKbGlzJ2sHG
         p7045eHeBoit9hNuHZuxrOb6d9TKdNJemYqe3X0zE8dXqZUfxjhlzlvqV0yGJ++IRlkw
         QTFE/Za+za89fyzcAQrqrgwLS3EMzz74pBOn2oDDfWHz7e4lIWyN3uOV9x+nfUqoJ0+r
         UX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=MpNDRl4E1M/mrUg0hQuHl9LIBUSIgjRXePNbjqlDH7A=;
        b=n0tR4dL/X1kzpU+8uJiPuI+juQW7SyVtCxh69UCN8H2XsG5syDuv1h8XmDWJXDfOdl
         fssnhdPJNxqICJFlZWJ+p69S9jH4dYEPrFNvzm/LFPootaKW3MfJ+/qKDgCHsyDNa9MH
         HHtRKcYATjuRoP21cRK0sYZ8evaJHF/xgjJDGoCVAX9F0dY2S8zHCOqqxU2mL5gEYe/9
         1y3GR6uuhnRdgab9hmA94dLOKAhYyMNrSL2qRQJy210LBKIWK5oAyaqFmE+VMJe6pBvP
         +7euLhQVoaGflqYZLYhqt5FyzjLdp1S6ITX2WfaAKoOx6eCo4CQGVRLEb1XKnGYtCTYw
         CmPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NnAZW4eZ;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NnAZW4eZ;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqCK9UEPw6+CqPXvtA/McyYSGkuRyzwycl24jNkYHi1zj9XsFI3HBgHG/WrxTFDZ9BBt74Ceg==
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
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: [RFC PATCH v2 12/12] arch/x86/include/asm/page.h: update usage of movableflags
Date: Mon, 21 May 2018 23:20:33 +0800
Message-Id: <1526916033-4877-13-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087580156042073?=
X-GMAIL-MSGID: =?utf-8?q?1601087580156042073?=
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
