Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x224aLZPmHOm7mOHEV9trPVJcjwUsy/M0KKPwCOtCUihSLFKbSxuj4LQoP1x+Srqs3cfl6l8g
ARC-Seal: i=1; a=rsa-sha256; t=1518168362; cv=none;
        d=google.com; s=arc-20160816;
        b=pg2G67kw2sWNGNN0qHn28NIHI7HNPLoCPRgwMCeMlEpYbetcv36fPupZ8mA/b8InWI
         gxgWYZNHK+SPXvtebYzIsynvnnv1FztTWJPP1/dZYohcZZ/tD2T+Ug6AGNtPP+AXkb9e
         PwmMjJyhQE1tmOdXmiXEsC8Y/C8enJ5fKsg6FItH9/mjR2pQWvJXTSSjqpvDN6jfHY3/
         GRnT/TRMLlalfkZFga+Om2UpYYCocO87drqdBZ8L5LbhmgR82JIBCb1wBvi2C6YDSvrL
         /rGyIoscNvsGj5Pe21bhAafxBx2fxUtnK31LJiuCFWOYmWYQrBR/UZrTSeGUmykYmoBw
         ZqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=1NttUfG1dbBu4q1Ghm8E6zuzd47Oa/dg7nGYF58eE7I=;
        b=jS5MVkzxyseAd4VtxB4ZDvi2KTjb91Zs/maSqP0tiXx9MKhIpkyaE+wLeocyRbp1fr
         iIyDnbckMsi1H7rRXx7LaKTXcx9HQwU3Lo042grk1A5p/p7/j4MFOpm5Bc0Ohjl77jxE
         +DarEUjhf2J86SywU10wk+wTJmZlsKE4TiHHC8S9GLnk9FmTtpncB8wduUnbRpeRd4ko
         4DmuJ9Y1sqrTsDUmASRvyMaScofhOf95tXk5ERAAtQvqgA4dCKoEab/HRGYGXFzjeysp
         TNBqCJ4T8DRSK54vpSceX92bRjnJXQr+tlIGXW2L7kQ4RIsNs2oaxlm7t3/gZ0nrUwQw
         Y/UA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=hbQ6+qgh;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=hbQ6+qgh;
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
Subject: [PATCH 23/31] x86/mm/pti: Define X86_CR3_PTI_PCID_USER_BIT on x86_32
Date: Fri,  9 Feb 2018 10:25:32 +0100
Message-Id: <1518168340-9392-24-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914909315393823?=
X-GMAIL-MSGID: =?utf-8?q?1591914909315393823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Move it out of the X86_64 specific processor defines so
that its visible for 32bit too.

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
