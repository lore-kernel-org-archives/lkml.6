Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227mF7i9+6Ef0EB7MFpmlH5JEggedKvfuIPpBfNEUXQJdmUAhr3fbQD2Qkc8FEV+0H2qmmHJ
ARC-Seal: i=1; a=rsa-sha256; t=1519218077; cv=none;
        d=google.com; s=arc-20160816;
        b=SEpbqH+N867Kr4qgPc0hYgUa/oVJOYghG9Q6EBUhJRtdfY5a3cHM+SYt3TWIh1QzSs
         la9gDHq6esXJMh6PHHiRHScwkn7gKTfaqGV9LAWlR6s0oJ8O3TIr+qDeLMBWQInuG7b7
         waawN0DoGBJh64Ue9kvahwHNZuGuvbDmcDqafvYCsUTmKKSp8abGmSzYR+MvuSkQg015
         UIo8LenD7fUlhqBklRRltV0J2h+Tx8dOwxkrabFgFzxfDSMdid1JSxbfY1FRE1DTaXqh
         K2PdNj1qCtXZlBLhEJKk3zrU8KRJNa+pFVhSSM8r5rnWpmdbp1eKc+/3mWANB8HELGyp
         ADqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JKGzs3AXzeuDt3vI+H+xcP2JxgRLdJ0Z9No4j8AF+5w=;
        b=LBFXLxtkIeEP/ballT9aOpiFC5WeDqVo6/0ne8O8pRC76tiLUOEEYwJ9y2dyhYG8bP
         V8KEpei1RMcxp5lpF+zU7wPf5AA2fiYQz2CEwGhYa/UcOYoZzAXuqj+MnniaLfuQ6Z2A
         R6yIFSWiAYP0Ep0m2no8HtrBmFcF3jRDYpPosjaxVder7KHJzQ+UXb8IAzQb/wd73fwd
         W3V+2nw4coxe1r1ZAsNo1PMkm9Mq+3Ibr0BrzJDEtS7kLbSLkLmsNwG7bA6C64+TZt+T
         YyTh6yWyb9uxoBykKOAPEqHjzl4cHH3cl1zHpKqzAtJQbTnmHnUMVeqhwcTjYhq3vBCJ
         RkJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joe Konno <joe.konno@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	arjan@linux.intel.com,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	dwmw2@infradead.org,
	dwmw@amazon.co.uk,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	linux-tip-commits@vger.kernel.org,
	luto@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 078/167] x86/speculation: Add <asm/msr-index.h> dependency
Date: Wed, 21 Feb 2018 13:48:09 +0100
Message-Id: <20180221124528.723749680@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015329486886101?=
X-GMAIL-MSGID: =?utf-8?q?1593015615035485037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit ea00f301285ea2f07393678cd2b6057878320c9d upstream.

Joe Konno reported a compile failure resulting from using an MSR
without inclusion of <asm/msr-index.h>, and while the current code builds
fine (by accident) this needs fixing for future patches.

Reported-by: Joe Konno <joe.konno@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan@linux.intel.com
Cc: bp@alien8.de
Cc: dan.j.williams@intel.com
Cc: dave.hansen@linux.intel.com
Cc: dwmw2@infradead.org
Cc: dwmw@amazon.co.uk
Cc: gregkh@linuxfoundation.org
Cc: hpa@zytor.com
Cc: jpoimboe@redhat.com
Cc: linux-tip-commits@vger.kernel.org
Cc: luto@kernel.org
Fixes: 20ffa1caecca ("x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support")
Link: http://lkml.kernel.org/r/20180213132819.GJ25201@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/nospec-branch.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -6,6 +6,7 @@
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 
 #ifdef __ASSEMBLY__
 
