Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtrEUZc1UkWDcpRn7vYtLVPdmiRqKzlY/PYQdFFXM8FtOYIb8Q+d8iv5ARQ8egQYrS9v7EV
ARC-Seal: i=1; a=rsa-sha256; t=1521228600; cv=none;
        d=google.com; s=arc-20160816;
        b=Sfd0e/xewuDjjTIbq44El+rd9Zyrw/ME70KcvZ01Kq0XIfVCBzoc2BWvaHd/V7jaZA
         omL+asjgSGMlp592EaqQdrpqP29NISEZBIGz75vzNNjjCxYIK5klu/zBSRkmIKWu74I9
         6xWN/6nKi8zulX89FDVoIMth47iVT6nqLMiEccUiSJ3xPQaZlj2VpHhCj2LAo0OOWJ85
         wG3ZaaF+BJCs+GjEMKHpwB0lxzXrkp7yoSq5oIJo710w0yDrrN1ER6TRlqFQDBxBn8RC
         a9IszobeWuvcrpGPJdTzuBuAUP7YihHVav2aN6ccVoMPbljQ5cgxT/RDeeHqVU65qbjx
         5Adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=JA4ft/zbEQyrYYEDRQTfooNSsNBYYyu6NoZlpHRNmDU=;
        b=OdgXBSCEniExaYHDRz7p9SlVulXsQSaSRDde0eQ5NCGP12jEMl92zjWQDIXm+hhzwK
         daK5j6OznnZmb0Wkxy+0eEsdSgoVNe+IF4i9xDHeFZtMREgjgY2u+Hn6eBswhahGCpn3
         i1icsxr0ONTZTXdpB/ZyRo2i1yVPfhscLRXJSWewkUO1ED/WfSWdWv0y/JDKyAc/4xpw
         3C23+YCM6d0owkfLPM5ikRRW7+3yaZciUfRyyiueNFHF32THRBGKLc5bOPQJD+SGODKM
         EDRggSGWIe00gW/orUAPnJFcgRFGjEJRDWbisVOdBWXjhbkBvXDbkG2I8lQyRHIeSpig
         g99Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=LStBwtbE;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=LStBwtbE;
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
Subject: [PATCH 01/35] x86/asm-offsets: Move TSS_sp0 and TSS_sp1 to asm-offsets.c
Date: Fri, 16 Mar 2018 20:29:19 +0100
Message-Id: <1521228593-3820-2-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123800301687917?=
X-GMAIL-MSGID: =?utf-8?q?1595123800301687917?=
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
