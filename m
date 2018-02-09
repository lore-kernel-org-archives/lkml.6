Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x225krW7F3jxD1B9qVYySS8jSbFuPeQBwXemJ4YdMaG2nKrCIhWsEeD1DZ7b/XatWa+1JpYRI
ARC-Seal: i=1; a=rsa-sha256; t=1518168367; cv=none;
        d=google.com; s=arc-20160816;
        b=aVVBO0bjLWL5Voi3tsI5LNIFpOkoG2OCNqPBCuu1LXQGxNRZj4l8POCl1Fe6K39y+t
         EwjHG+B7CZA267rHSbCIMe0r5JpIKTyFqCzxAAxCGWlWPjwgLy3JerPD2YG0+SK2mfuU
         8mNDhVTguq7l/DIW/KiPrvUl0Jeg6ryny4y5M8D2bxiPOIUjZlBoqid86hRf2pHcrgv9
         U69hO9tHXUzhY7k/8h1b5tximpz81erw9AXQQnSVdf1NWHbjRrNJImFTTFC4l8o7T7l0
         PBl19agccS1+vG7/PKRra8HHj12uiFgEw/nLa01C7YmnAdOFNmxUn/GVLcx4inACBZ7q
         RJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RGA25vQ8gBPaSKGy/lT4lV6mDQVKRyvseZa9z9ApG6o=;
        b=EslSzuRDAoSOLkJPPEOOQFmiXtXnOEgVq9uLBcugs2+DO81gDk/klutGvF3fL5myjT
         kOhlrl9Jnj6gsBIGtKecXNuxn6BiDtZjT26ZlHZotA/N75h/xOROCtN0lUk9JPz7XZuA
         dZsujmZpdW5M0A+f9mQUfuhfihIwRR6SPviANbOFn2HC8ja14kBQZHtjIL52NW62ZFQ9
         1a4E4TICu5uOaYaOIpRtlC5S75ECNJvKiDOS9uTHVglmXuXv4cAiw/yujPROnb5z6F7e
         uVBR9NkxR4c3R8bcvcKJ3ib9170YH5EUgtI1u3ncRxCzrJDbwptrpJ4ip129c1JfDtqA
         yCrw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=qw0MjPHr;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=qw0MjPHr;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 28/31] x86/ldt: Define LDT_END_ADDR
Date: Fri,  9 Feb 2018 10:25:37 +0100
Message-Id: <1518168340-9392-29-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914914585532932?=
X-GMAIL-MSGID: =?utf-8?q?1591914914585532932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

It marks the end of the address-space range reserved for the
LDT. The LDT-code will use it when unmapping the LDT for
user-space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_32_types.h | 2 ++
 arch/x86/include/asm/pgtable_64_types.h | 2 ++
 arch/x86/kernel/ldt.c                   | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index eb2e97a..02bd445 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -51,6 +51,8 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
 #define LDT_BASE_ADDR		\
 	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
 
+#define LDT_END_ADDR		(LDT_BASE_ADDR + PMD_SIZE)
+
 #define PKMAP_BASE		\
 	((LDT_BASE_ADDR - PAGE_SIZE) & PMD_MASK)
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index e57003a..15188baa 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -90,12 +90,14 @@ typedef struct { pteval_t pte; } pte_t;
 # define __VMEMMAP_BASE		_AC(0xffd4000000000000, UL)
 # define LDT_PGD_ENTRY		_AC(-112, UL)
 # define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
+#define  LDT_END_ADDR		(LDT_BASE_ADDR + PGDIR_SIZE)
 #else
 # define VMALLOC_SIZE_TB	_AC(32, UL)
 # define __VMALLOC_BASE		_AC(0xffffc90000000000, UL)
 # define __VMEMMAP_BASE		_AC(0xffffea0000000000, UL)
 # define LDT_PGD_ENTRY		_AC(-3, UL)
 # define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
+#define  LDT_END_ADDR		(LDT_BASE_ADDR + PGDIR_SIZE)
 #endif
 
 #ifdef CONFIG_RANDOMIZE_MEMORY
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 26d713e..f3c2fbf 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -202,7 +202,7 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	struct mmu_gather tlb;
 	unsigned long start = LDT_BASE_ADDR;
-	unsigned long end = start + (1UL << PGDIR_SHIFT);
+	unsigned long end = LDT_END_ADDR;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
-- 
2.7.4
