Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELv9A6Ca7E7ohv/zTHG34539eDkuOnZhm1jluOl3LNu/69uGhE9zto8wjkd0PQfntGT1I5AZ
ARC-Seal: i=1; a=rsa-sha256; t=1520245579; cv=none;
        d=google.com; s=arc-20160816;
        b=noOBVMluvxTbEGrb9us4dfcNWXOcd1u5/vPRY412AiBZ19T3hy8EC1fesGakdThib5
         3UHXTdGOUXHlopsCXFJ2aOsb0VmUmnt8Dsl4w/E+4eUctuzAYBkJ+PIIdCRM4mOSJoVK
         6IAr6qcFxfceP+6LPcj+pVy9DZ5Bqs8RWtyTaOIxxrtd8eJemR3YofPY2BM3GKd1SUU9
         wuIv6xhMDsEHw6xRISVG/9GEoOXN9mAP8QAkH6QtiSVwcKLD9I1RlzjQq3rbSRXI1x4M
         cgJbk1bLR5AzBQvMEKWraoRCSpr0kixF0QPjs+Xwh1j4Xtaq9sP1jNhU5XhZXLYY2226
         sPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=sBmnEAPtOXXVsp27L6zoCbiR5jvnoXrdbebyRH4BDuY=;
        b=NSrohI9dG/9zfSgj2cdrIG3Hn4QehKbqVNjEQk6oPaE401xicyWl3ifBufR0webSPp
         4cNtMJr8KsYmnwrWe47uX60eP322Hv6YpDtIBghh/lzt5bA66pF+Q/YbW8KI8/pO8al6
         uAn/bbp0O6wuN4zeDl6sRS/MudN3JTTbgIsbnaI+YeP2EVzuSMQYUDuhKy5y+aS9z9iL
         DAPajGbH8hFvp+iRP6lDToV6OdIFtUUNbZH5kG1yUbYJLNpkg83xkSMpkjuNLfFhBQac
         etdSkXsfzOipnW8m15SCk85sbxi99arGFO2tfzk6boX7GUXZ0jZGVQK8RB9fldI0IP75
         ARSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=EWx0NU/3;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=EWx0NU/3;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 25/34] x86/mm/pti: Define X86_CR3_PTI_PCID_USER_BIT on x86_32
Date: Mon,  5 Mar 2018 11:25:54 +0100
Message-Id: <1520245563-8444-26-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093028891542358?=
X-GMAIL-MSGID: =?utf-8?q?1594093028891542358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Move it out of the X86_64 specific processor defines so
that its visible for 32bit too.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/processor-flags.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index 625a52a..02c2cbd 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -39,10 +39,6 @@
 #define CR3_PCID_MASK	0xFFFull
 #define CR3_NOFLUSH	BIT_ULL(63)
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-# define X86_CR3_PTI_PCID_USER_BIT	11
-#endif
-
 #else
 /*
  * CR3_ADDR_MASK needs at least bits 31:5 set on PAE systems, and we save
@@ -53,4 +49,8 @@
 #define CR3_NOFLUSH	0
 #endif
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+# define X86_CR3_PTI_PCID_USER_BIT	11
+#endif
+
 #endif /* _ASM_X86_PROCESSOR_FLAGS_H */
-- 
2.7.4
