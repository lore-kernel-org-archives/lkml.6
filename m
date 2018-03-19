Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuRKnLtNYjm/csKmqIleHCZ+g67vYNxAoE/vXFLQuOUe8qQpQvOMbCrASIsrfpOO9lwqBzt
ARC-Seal: i=1; a=rsa-sha256; t=1521484297; cv=none;
        d=google.com; s=arc-20160816;
        b=GheM2KcYCTPYSIF4X4HH2Hl+9/3l21tltBicrhdh1wGhxfGEyyJGaNqWR55jPz9AUu
         vrB9Oemhl/9GatBjzqS5llhM620XAp0raMFl0BPpXp576tUYRSfOyIamPzMXNgz1LCjB
         p0Tlpnlz+XkXZesnI3G0ym6xjXthapxKubguRryKv8hdITgwlTbSSf35mO00xtcR/Qdj
         wvCJFbew1tzcejHFQtS8EHy/qnyad1R5eDV3eJKTCkFV3iWWH8eKwVayd9OhhMbXaar4
         MbS43ViU/D7RwTt4w7vtlBUS9o/VARQUOdaVdQOkrzKNZvpB/E4pRkqOnbQqiwWxcp1b
         dGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qda3JTrULF2h8PjS9xNiZwFaBCGFLIH2TG3h61Zm+j8=;
        b=SPmqnnqCotZ9BxYfAi1kHaEJ8nx0JbiaTQpvpByrYGao4MquXGeogypkml0syXfcfm
         JEfbp1mCaMIMgEZM0HzsJ/y7s1rOqdJc7OflvUdFMWWb5idbQiOHF+hoIgOhX0uHan+B
         0e7idySpyJT7DaARW7em46ZsxqV7GOGKQ849wTwxSuGkAs1E47vF44I2Hm7huimuKUVx
         f865OV6anXA2A5bdgVgSuhDp1vKzWcLwiuRQDedVf3LyA8gD8T33cJgirlwx4TWM49aJ
         9+IX9kH6RV7f4Erh2oq3izV8Y9HXUaFcrDNJkerXp5xWKXdPs/TvXUFuWIDTLGrdzaY2
         bnBQ==
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
Subject: [PATCH 4.15 02/52] x86/cpufeatures: Add Intel PCONFIG cpufeature
Date: Mon, 19 Mar 2018 19:08:00 +0100
Message-Id: <20180319180735.121159823@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391660122916954?=
X-GMAIL-MSGID: =?utf-8?q?1595391919393034862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
