Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+dRuirQDMe55FtZ+71P4ArYt6dA/0MSXMyRi9J2asGh6pP0A2912Dxbdl8xAE5QhlNQdD2
ARC-Seal: i=1; a=rsa-sha256; t=1524498480; cv=none;
        d=google.com; s=arc-20160816;
        b=zZN694kdUPuXj+OTuI7IWH4DeYsbt5CtPEfuzGPIeIKnkeowL806wrdLxLnqiuXcUg
         JZt7bGJQ/HpM6auEFgbH0oGUkmt36zQVhspwr69nvhu7vtG84LQyH0ZqileNH0jdP1nf
         9WSXG2/d1tLq9DptBjiWJQdHERoK3EGriuvHtXUUguPesNonpKPgyAg19S78G6/bJysq
         Y4HiL/MFPk3yD0dTeClITRor5B4sFWKll3CE5ntspKGvvFpuO3/4xzPS8cHuzPXE0n7U
         FMKMeLqVBfH/CzT5YhwWxmUj7IW9+dcZ2nxZHhCWnscKXkYmJoTEHfLKcX629XqqvGGq
         1ozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=sXfYIJU/ruaJY13W/nJrbm70x64qAsmvxR7tt1NAr70=;
        b=z1u9h8y224BzTkp/poyLUlfWVYAD0Dkhx2vgnkzj9C7Ttl8uaxU1UP368QJDwv4E74
         AxZqOSziHw5iX0H+78JZc7bTBu1dFY5G/JtmfMtcfEdpMtCPr/DyTuE/a3eicm7jQEoV
         YT0HUx92um2lJIVxsB0Uz1eTRWjsSuSj9ylCILqJC8fBZo07lAiaFaHfTDFgHFlztQhy
         ple7/jJkx6sn7bZouD1fmHunwdCl/pHMGpGlDTMt6SkT3O4Uv6oysMhqDEF4UIRrooLV
         yx4ckLMNuJh7BtZXWHM0orz6f1wOk1TqhCea0Cd+Y3timGUiMTukitojV2Ov4gPKYf0F
         dInw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=XDwGuoFA;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=XDwGuoFA;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 32/37] x86/ldt: Define LDT_END_ADDR
Date: Mon, 23 Apr 2018 17:47:35 +0200
Message-Id: <1524498460-25530-33-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552518374636074?=
X-GMAIL-MSGID: =?utf-8?q?1598552518374636074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

It marks the end of the address-space range reserved for the
LDT. The LDT-code will use it when unmapping the LDT for
user-space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_32_types.h | 2 ++
 arch/x86/include/asm/pgtable_64_types.h | 1 +
 arch/x86/kernel/ldt.c                   | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index 1fa76c9..6d5f795 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -53,6 +53,8 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
 #define LDT_BASE_ADDR		\
 	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
 
+#define LDT_END_ADDR		(LDT_BASE_ADDR + PMD_SIZE)
+
 #define PKMAP_BASE		\
 	((LDT_BASE_ADDR - PAGE_SIZE) & PMD_MASK)
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 355b488..f78ded7 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -104,6 +104,7 @@ extern unsigned int ptrs_per_p4d;
 #define LDT_PGD_ENTRY_L5	-112UL
 #define LDT_PGD_ENTRY		(pgtable_l5_enabled ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
+#define LDT_END_ADDR		(LDT_BASE_ADDR + PGDIR_SIZE)
 
 #define __VMALLOC_BASE_L4	0xffffc90000000000
 #define __VMALLOC_BASE_L5 	0xffa0000000000000
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index c9b1402..e921b3d 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -206,7 +206,7 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	struct mmu_gather tlb;
 	unsigned long start = LDT_BASE_ADDR;
-	unsigned long end = start + (1UL << PGDIR_SHIFT);
+	unsigned long end = LDT_END_ADDR;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
-- 
2.7.4
