Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsmyqPX/AWCI1dFnSpz/UGMJtZ+K3G8Q0uiMI+rcib1FAop46nRLXlEVOGD0K67TMAh8Co7
ARC-Seal: i=1; a=rsa-sha256; t=1521484181; cv=none;
        d=google.com; s=arc-20160816;
        b=BQ85BU1Rt9rjltsvpUQb7PtsGAwLoytiGlooYhsv9KagJoaVwwy019o+I5mYN/rR7E
         IHUF0CuI04bnF9Bxd46H86mayCi7YY4YC3mj36xOmb8U558rtf8zpHm+Pcv55ZjPa8h3
         03pnxijGKRmHNmvXFLb1ppU1mu3+1nua4TbNG+oYJl7oY7mi6J7L13I/on1XPYClhu8V
         NSL2hDPHDuZRXFysQSZRoTuSyAmb0qddQwG3yCnC84G4jdsUwKA80voWGjpcGSAMMcEz
         vbAzSH0lbSVtZibTSwCLVI3GUCxesh/oEXcQQhebw0Nk86HJ2Fs738PNk/Do8xWcBZ1k
         BPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ri1FNnjegUw/kqvv1niUMv7US/7CBKBMluv26u6/TGw=;
        b=DMutqc2rMKwGGzeIb8EJ2ci9PopPlA43m6qv7v03EwMsHQOvi3nhodM8O0SFK9xVA1
         G8BW89QmXuIuAX1zw6w/WkbS89f93ZDewfQGJiwnydbq8PfxBc6nRySla5adL25bNRP9
         AmLgLMywDUFufQg1A1atHBFOrH1/Tn7sErIsBbUFCJ3NcaUhAUKN6NlsnpUiMQdWtr1J
         tjPMzFER7XF9EALA1KFkTfLYqPfK469pf0G3mAATvrGUy3fsTaTkhYXIuQD8D95ocPtf
         rPS64R2O2bTpae1rZwWGASPH12I9riNlecmql5QRHAamekh5tkd0X9Cug3aoM98Wkf1b
         Mohg==
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
Subject: [PATCH 4.14 02/41] x86/cpufeatures: Add Intel PCONFIG cpufeature
Date: Mon, 19 Mar 2018 19:08:02 +0100
Message-Id: <20180319180732.348870979@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391660122916954?=
X-GMAIL-MSGID: =?utf-8?q?1595391797048456357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -327,6 +327,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
