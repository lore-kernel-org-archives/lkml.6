Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+Q2BCh+I+ThH9YdwwG8EQCRptpSZzFJuQXBkY90+mt7BaH7NKtYmY961UrS0eShvQ4N5BP
ARC-Seal: i=1; a=rsa-sha256; t=1524498468; cv=none;
        d=google.com; s=arc-20160816;
        b=SWyN2bmNQVmVM7Oa+uTobVHcjYN7TcPT9P4aRoIS79D5IpilOoi9iwscWLKp203rqP
         YxNBoYidwCA8MHzKCoMI+K1fZ7f1C07Tf+WEvwfNJlzNO9HCZmy0o30U6hvfOisVmBqE
         jTKcc0mxwJUzhhfBc02ZAlKAgjTFdzYNTdTGnyTosZtWX53Mq1vPnRsfGOzhqgjdmV8I
         5By78pJ34J3WIqzxZOj7q0Rq+OB1KdjOprMUDyclZmNL5MgrT89lhBhQKh65ag2IbBVF
         iLo9yRYnePLC24sG/7y3KOX1tYLU48BMseTFQyyyM4/PNrEA429kaq6R/GqsboWAQ861
         eP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=JA4ft/zbEQyrYYEDRQTfooNSsNBYYyu6NoZlpHRNmDU=;
        b=fNC9Zm5ZHUQrl7rIArCFBpZSf/RlOBi+TrxlRh49X5d5ilR/xQgHB0+5bSdCSJn6Rh
         Ne77EAM5w2/h7pZYqFZupeWqFb10Djd5D8YsKWGbbdN6dUWncMOJHDD40IlPPKDouHk8
         kTlwiBZQVo1tU3v+/TCITsdz6JE05tnjU0X3LCj9GQuJB2QG2pzJDME9i4oFECrSLzk8
         t7l36KqisUwze3PcCvO8A06dSB1CdM+GMNbQIB99In3++Fw1ey9eSWOTXLI9SKCzu2Z5
         hqLyi3U527T6waLgUeGFxU1tKdCVxR13hjvJXqdci9Bb8J2m6bRT1ByQxrlGKOG6oZtl
         0GxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=SaUL/HJ8;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=SaUL/HJ8;
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
Subject: [PATCH 01/37] x86/asm-offsets: Move TSS_sp0 and TSS_sp1 to asm-offsets.c
Date: Mon, 23 Apr 2018 17:47:04 +0200
Message-Id: <1524498460-25530-2-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552504733324374?=
X-GMAIL-MSGID: =?utf-8?q?1598552504733324374?=
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
