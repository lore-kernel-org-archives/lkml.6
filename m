Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELswQtGYLmcQBRLjFOBuqbTettHk2Qc21nGAkS23RB9uOxu6sayuaV0yWFhkQkJjqroIPdC8
ARC-Seal: i=1; a=rsa-sha256; t=1521228610; cv=none;
        d=google.com; s=arc-20160816;
        b=Js4H3TQJZnIZDo3lgpoBSDddlY1qHvamuWSbCDbKPwOaH0x0LROZqp2T/9izM4JZqi
         0nwpbEba6CEJcBWJGz+00yf8yWvx23VQ6+CGrUINZ6rRjHGni3tGS7drXuAXA4JA9Pyk
         kJuBJb8z7RlksLT0S/JFUVEBf2pvr9CayvD9bUBcs43M1wkgRmEnzwWHD0EfV6E7FPYV
         1oJK4Wnm4+d1DMXQmn3OA8EYv1wTaBtfGWll/IOKtfyXgcleNtR+gmsoiu/bzmVKxNgP
         VRIaLgw6xNyAerZAGpxFfzSp1fQMyztq1rrMvJ57LzI9NirHddMa+S87wtD8spGUpBBR
         p6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=sBmnEAPtOXXVsp27L6zoCbiR5jvnoXrdbebyRH4BDuY=;
        b=ZMtP05KP/d0EOvxXMG79lJ6VbZB/uXiwPV6KPDcObZUDiP9T2TFNAIt8NVLyXb3guS
         imSWqKPrZxb+iD1r4Uvge1d1WC2r+bslzEvVzpjPqptNLOJL+E3WHfsFpVQrtB/ypDry
         nWFht3nHrA7cMQ+YwrRCEt+5boMZUzoUddjcuqlPyrhkOmAQNLvbPoHe2CqEn2htSCvr
         4IMZvfgnPGEUc/A5BnP2oK82u4DqD50y5nxk0bdgOBio5CTCtJU5acD8AEej8lC1jLu4
         6IegkswPrKgWd2Ynz4D4+Ibj64HqvJ08DXLf2tjJIaF7S6dJSSW4XCoCFPHJ1Q1poRoS
         P64Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=ZRLxPqiy;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=ZRLxPqiy;
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
Subject: [PATCH 25/35] x86/mm/pti: Define X86_CR3_PTI_PCID_USER_BIT on x86_32
Date: Fri, 16 Mar 2018 20:29:43 +0100
Message-Id: <1521228593-3820-26-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123811965834549?=
X-GMAIL-MSGID: =?utf-8?q?1595123811965834549?=
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
