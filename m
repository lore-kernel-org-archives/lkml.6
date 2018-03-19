Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuv8AX4Iwsbsr00KhrQmus3ITLJ8zOTo3grykCJ7bBwEb1dcBxvQ3hO5+vp2kUf/cUwK6LJ
ARC-Seal: i=1; a=rsa-sha256; t=1521484050; cv=none;
        d=google.com; s=arc-20160816;
        b=K/5CSi3BptC0CdxghxWAyqVQ7+5Y8SPHTOa19rrbJwTWp4rAE0brkYEhiiIM8DdRoZ
         WD61HFNjbobbT1GgOr+JJLvP2puJKqEDdCeJczdQquLKCwfHdgKiaD1aCA+VC+3RD76M
         122gRLu6d4qFnqa3Rrwj0njsBRCNcpKYHQRLx8cxZf/sQqfOynVPMNeaO/haFZv46Zlw
         6xb+fUS8azDx8r/UlN0FBTVt6MArLVmUxFZvcFVg1iu3HHRd98zaC1dWRFm1RB/rXFQm
         V5W57Uv5TNxte8fs4APaTm8BCG7NMg2NepFIZkwH/T478CxVkpAp6QXx2lfdthLtSsGz
         Ylbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RHPQQ8CSkCsFXCA/PkNlk/gmvikZKEAVYMM1p0oualM=;
        b=UlyTTD5mAULu36GB7q1tVkgsAyNKPONrx1xQRnNwSfGjuryCunmCKrII5rI8hcwvZS
         /1ROBTQW+ejl9Adb8XcXNKUCjqBJm+bs+DBASrrvhS7xYU02SGZIIhWuNL+4Y6VQRsIS
         PhfTW2nh4SFx88JY1wcjd731p0HtXLRuixuX8eghBPg3ODjGZaLQQFpWjtkP4NIialvc
         WrJgT2r4mQOEiOd6eT3jqjzc1fk9+pzI3BPG/Y0orxO7OKeH5NnG1JXfAAFBYmEa0Tqq
         ZWK4SqUXNo/wk3/khQvOIbYcrALY73QrfpQ5qbFaePDTi2R57uXskIpw50a+iRPuwzTz
         R0kw==
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
Subject: [PATCH 4.9 212/241] x86/cpufeatures: Add Intel PCONFIG cpufeature
Date: Mon, 19 Mar 2018 19:07:57 +0100
Message-Id: <20180319180759.948937973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391660122916954?=
X-GMAIL-MSGID: =?utf-8?q?1595391660122916954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit 7958b2246fadf54b7ff820a2a5a2c5ca1554716f upstream.

CPUID.0x7.0x0:EDX[18] indicates whether Intel CPU support PCONFIG instruction.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180305162610.37510-4-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/cpufeatures.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -302,6 +302,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
