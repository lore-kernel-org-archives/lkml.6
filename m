Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuvRxC5i0MIMXW9UT2HjB3DRV/8kWcDSGAh+JVXE/Kl0aCFNqXD/PkpnLj77Au0bGNj1QN3
ARC-Seal: i=1; a=rsa-sha256; t=1521484150; cv=none;
        d=google.com; s=arc-20160816;
        b=qrWhOkb7B8Q/s2WnOqymzrMXDPJlZEqEJTrx+NhzfJ9Il70HR+ldLdFy/DFWheRUcw
         Cau2adZ+7KGadjvq9kYpzOzYHnNiqyRHsySRe7NcnYczBoKolNXNjl6J/TQtewGd6rrg
         8TfziRA6+bMCs1GpQtiNgPuqgUotAxabN04iahWZIFNbf0Di37JSxRkIx34Y+ny1wlqg
         JsK3zVLDIc3qbcXaelSdWuQNZl5HaR8XLmQaKJA12NFIcICmgb2qprroVh9PmLiaPzg4
         /HpQa0/wB+1X+oTTskR2H74pp4wnJFwRVvP7nAGHtRFA6LKAAyGwhnJF9Q6ILvTz75eV
         GA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e69HBkDdIt5p9yONILBB9oMUBP6hr0NTTij5dgTBkCY=;
        b=h641LCkzHDIY97HR587IcgMabNfFvD24q2ww/vUUVZGKS7eDjihIaIKBP91VlG9U8Z
         qo66oTlVUJ3ct3hZJmp7cTso/yF9z6B/Rkw+rOhz3ReleTtDfyZCzY2x8yWkU7KxmEyB
         aW8FvCmP03NaooYGekVnZfQ8IRbx/gmqXlgQcOkg04/pxVI/mIOGI5o8KmghrqFP241f
         KfdkIxHxbQwao089Gte6YpmvgnyAGHQWWuy/jEvKn7wk8dTc6Yzss6i7j783jkVcEROr
         c3gGvSy3oFoK/MOOw4NWw/WBE8L3DMdLfvUZuL2Skwe0mykPlE2aDeJ+BOk3nEqG9C0I
         5ZGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Kai Huang <kai.huang@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-mm@kvack.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 01/41] x86/cpufeatures: Add Intel Total Memory Encryption cpufeature
Date: Mon, 19 Mar 2018 19:08:01 +0100
Message-Id: <20180319180732.281721047@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391764772366077?=
X-GMAIL-MSGID: =?utf-8?q?1595391764772366077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit 1da961d72ab0cfbe8b7c26cba731dc2bb6b9494b upstream.

CPUID.0x7.0x0:ECX[13] indicates whether CPU supports Intel Total Memory
Encryption.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180305162610.37510-2-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/cpufeatures.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -314,6 +314,7 @@
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
 #define X86_FEATURE_AVX512_VNNI		(16*32+11) /* Vector Neural Network Instructions */
 #define X86_FEATURE_AVX512_BITALG	(16*32+12) /* Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions */
+#define X86_FEATURE_TME			(16*32+13) /* Intel Total Memory Encryption */
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
