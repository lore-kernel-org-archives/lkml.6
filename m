Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvAIjsNI+DMlvCyYXeN5sPJS8EL+PPx4Rzayoc9GkJLELJyx3lUIPrGS9JxVRo74xxUtcbo
ARC-Seal: i=1; a=rsa-sha256; t=1520245570; cv=none;
        d=google.com; s=arc-20160816;
        b=w0ZrEUKJxbF6nMa1dhnSTOd9KoKWYbbu5wcywzWS9AqXWZGaBAfVjpTNOqQpFz0CrC
         bTTnVHo6P2rUTsc+1ld4QT7qlDMeogFnpxrUXdRtXm2KhXh/SgJ1oJuIFu8QlzJ3Dpc1
         8rlHVem/fBPkCjc/ZeJIGTamESF+WJQlAhIkkF41RQYJOTxaIyCl3tR2RAz05ImSD3GC
         7huudbM27mKz57GKgCsCnO2FCxfJJFxK4+3eTQ/WmpPOdLlaYJhlD53bHp3B4YMmJMsz
         sAk27CjOAWtWa5fP2yND/Ud5ZuOhWUQhCwhVRxgGXRIo+zxTlo6fIbVo7+rZEHqMhGPI
         UQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=JA4ft/zbEQyrYYEDRQTfooNSsNBYYyu6NoZlpHRNmDU=;
        b=BW65p1KysY3KinMHiMeK4gUOgOaa9o21ubx9LtzAexuCyFCm2DEBg0YhDsYwxQ8aqN
         ye7kDfh1HxLZ+fZQIJKQKSYjiTgPSUJnleXCWnw8IJGVf/KRnr5jMkd+GD3NnOxX6Ih+
         gRdlv4Ef7llQ6YIbo8mixBUw4yS+dosagFoyyNQTCmOiP4stQur+IGVx09fp4exnoXAH
         HCYpNHmwi7PGyrCHk7B7wNrIjxzUocUcqeRs7g9WBNtjdkQEvfHwFb9/dKceSa+jgxJ/
         fpXSJcb7RyAzsFKOlIlInTdycn5fSaAHvx7s8IxhvXLOBYjnRWcoqdAcEdAuwlnIfmN/
         Sr6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=m+NZHETk;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=m+NZHETk;
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
Subject: [PATCH 01/34] x86/asm-offsets: Move TSS_sp0 and TSS_sp1 to asm-offsets.c
Date: Mon,  5 Mar 2018 11:25:30 +0100
Message-Id: <1520245563-8444-2-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093018082463612?=
X-GMAIL-MSGID: =?utf-8?q?1594093018082463612?=
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
