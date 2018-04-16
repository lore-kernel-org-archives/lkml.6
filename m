Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx48W/qYLfuy0EMaxTw0mevRbyNCSz+Etj96hYrpF82Haf7gQAK0Bn9oS+1lRHNJV44/46WTs
ARC-Seal: i=1; a=rsa-sha256; t=1523892348; cv=none;
        d=google.com; s=arc-20160816;
        b=jDl0kRojombL+tcOv3oAxmfz2aUuspj3LmX+VCpUhkcCQV/jwIxmayzpDiUrE1pYAk
         gRpDE18gusA14/2TQM4W9dhduuexWByVehEWeIGo7JP0gDlcBaBuq7Cbj+huWnWqS+NY
         yC1yJxwMohiHErTLyqRIHjVFxftVRWhuyTTXepgzSUi/cx+zxjxYetBisixRH5uPVz2y
         IKlwKC3gO4Q38ZDAvpHjOOqhVym6MUhrxyBt0ED6wdJqWxHFtA7C1mstAHs816kznRlY
         W3Ifx2mNkGdOQjkwXgxVgvetPcosGW2Zl+gv6oOJrPrV37veyJp0Zy5Yqm9ji0UjIQIt
         nQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=sBmnEAPtOXXVsp27L6zoCbiR5jvnoXrdbebyRH4BDuY=;
        b=lxjBmccCMWhJ6qPCTkhRVDgP3iqDV91T32rt2DENLPUFGnym77ZFB1Yp7Rn2CTcqqQ
         ZK+Ea/6TBJ5W4tQjGktOpwpGcnu/zcm2akpyJ31udeogG5U8ARWiRVgte0DQ7I7DkW82
         /sIsaKvDHcymSImqMICiT7OVACvDw/caVQMewktX25phBYnWs25spYl/f+/L40lB0stz
         VZ2zFZl2xL8HEYB96yYpD8uYOp5G37didRfNCAq4Nbzreg4F5arG6aOHpEo+uE1U5xJn
         A/0d4tkBe4SEI4hQc1KQO7VHQ5HBGgkqCsLOjPBA36nYvFyS7eojH4UbrR9pvr8Pbkiu
         CGtw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=GGgjqusw;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=GGgjqusw;
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
Subject: [PATCH 25/35] x86/mm/pti: Define X86_CR3_PTI_PCID_USER_BIT on x86_32
Date: Mon, 16 Apr 2018 17:25:13 +0200
Message-Id: <1523892323-14741-26-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916943163101962?=
X-GMAIL-MSGID: =?utf-8?q?1597916943163101962?=
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
