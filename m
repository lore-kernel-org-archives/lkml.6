Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu+60j0goMVu43Jv1dZb4F41bG2L/f+4KwQ/wjieKXla6eSutWyt0Nv+aFZOvqNAfjEyC9k
ARC-Seal: i=1; a=rsa-sha256; t=1521484268; cv=none;
        d=google.com; s=arc-20160816;
        b=D+GSUEqIN22RO6qmxnC6ulN87zy8oXW+LrE+3ba5G4WeuK8TC8YyfmmljeEZ49QDEh
         ghnfE0MPbcUbIIIJ61YDfaQxj6t4Ke5Csf1MkXMogVvfzAQCGvnyVDUvORhFRqr2mT64
         NUw8FXn1HNzuDoXc06V+N0X7gjUdGbQNnE8KIHGAQauoCI8jTjWVbi5sGDutcg5uWlP1
         HEH8CgRrBpGYj+iqWn2mInRb1ObVO2nBdQaeSnvaKpMsdLLiJjIUcrnEk2/59BasX0Hz
         7REMoEfqi1cvVEwF7KOTw90MpXmKVFQHCpHxvKOCXvFxUTaiyP8ECb0180gS/40kQ5Df
         Hbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uL5XD2/Q42wfYqUV0pcHZBZegMEbauJj4fqHaC+RKeY=;
        b=z8ohW6yhPjzWeqFpPamLTF6myUWa/Tq5k7V+cVd1H+4bK6yZfmdd2/YHcxSneM/tyu
         eL64qtwOIroBVG4IPeAT8G7Ui7OuBAxKrLUBfx0bYOW3wfSdwfo1D60fgIkbuTPFrU0X
         v6VYM5BkiltgT39NKHk6ZcL3ajlS+X2mq9emfUY/zvRKtdJNBByFyEymYiRRhod5vXFj
         ugwS+RE+i+Z+PMRmZM00i0mxrglNKd1b++Gai9HF9/n5bChp+HTurdwZzoF5UYtteqwz
         Yt3NyOnTl/F9WiTzGvN2xc6JG8Dp1uefSjmgjFG7ook9u+SuoSGTyjCqBTIQLpKF+dhl
         5TNw==
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
Subject: [PATCH 4.15 01/52] x86/cpufeatures: Add Intel Total Memory Encryption cpufeature
Date: Mon, 19 Mar 2018 19:07:59 +0100
Message-Id: <20180319180735.065262366@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391764772366077?=
X-GMAIL-MSGID: =?utf-8?q?1595391888080581786?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
