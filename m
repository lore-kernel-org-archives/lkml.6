Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4/g+XF10odBGSmFx/kZAK87Csho1vHqh9yB+x978GEgtz+0fVcTCyfIKyGDaqWHH/PLbrMH
ARC-Seal: i=1; a=rsa-sha256; t=1523892338; cv=none;
        d=google.com; s=arc-20160816;
        b=b3MOqgdA5bOCO0C87fA3Lz/zG7wywLkrxozUuwVqTsvmBnzku1Q+vHf0ufJ8Eoez+u
         yGnrP3d2ShcYvK4yKGhPzQURW/wy7kAVByztTFJm1PZxAT5/MK4aASry8nvXKMaqmBr3
         uykBPjfspcSRqyrrmqdnWozaNfNTpuI6FidejImE7+6tQZIZxXtkWn2IN449bw5IDYSq
         8sHamCLRu/7UbqaZMGJc/g/TntvLW5ziDw8/RqaLr4WIJQ9J/vzv4K2/owJQ0ZDrKMTG
         qezaoGbwesOJmR7fX33R3dh/mNFaVrOJDnsI2KkFPDH5GUbuN4WJAxzUOZueffRG0Nqd
         M5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=JA4ft/zbEQyrYYEDRQTfooNSsNBYYyu6NoZlpHRNmDU=;
        b=UYyJ8LIh91eHA5Q/et2fHPD1VVUs0gIYRVFe4ymkBTq0iZt/1ix7+mrvFLG3k6lPnV
         VF1cFh+bvO5CY3+AGSWkPsvN23xIei5eetbe6NMMc911MpTxxT2VM5NIi8hyd+Ni13Kr
         B5K4Hv95SMVvRT2/SogSMvyBtVCVYQbz7+6ZioltQRr/KyOnJXlX2mBM4QBkRWMGJ6Kc
         B3Q16XLy2X2ICatoEGjF5Ha4xUUjGBaNVJMwvGK1jrk0uOQkopBChIH5LpxcKy0KyhnY
         uOjI/Ry+SQbjHHa2hYSDT7so+yZrfalWyjua/Pfe1pCTyEWYib7zpjABueoRhNiAIZkz
         dd6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=hLYH2ZSb;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=hLYH2ZSb;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
Subject: [PATCH 01/35] x86/asm-offsets: Move TSS_sp0 and TSS_sp1 to asm-offsets.c
Date: Mon, 16 Apr 2018 17:24:49 +0200
Message-Id: <1523892323-14741-2-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916932798973912?=
X-GMAIL-MSGID: =?utf-8?q?1597916932798973912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

These offsets will be used in 32 bit assembly code as well,
so make them available for all of x86 code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/asm-offsets.c    | 4 ++++
 arch/x86/kernel/asm-offsets_64.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 76417a9..232152c 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -103,4 +103,8 @@ void common(void) {
 	OFFSET(CPU_ENTRY_AREA_entry_trampoline, cpu_entry_area, entry_trampoline);
 	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
 	DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
+
+	/* Offset for sp0 and sp1 into the tss_struct */
+	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
+	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 }
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index bf51e51..d2eba73 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -65,8 +65,6 @@ int main(void)
 #undef ENTRY
 
 	OFFSET(TSS_ist, tss_struct, x86_tss.ist);
-	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
-	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	BLANK();
 
 #ifdef CONFIG_CC_STACKPROTECTOR
-- 
2.7.4
