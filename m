Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvgrAGiVKctnQM+HF6lA6K0T9IKbAJHDPCOJfuEK9xWkHv9LpxkMTJ0bI5S5BfSbA58mjIw
ARC-Seal: i=1; a=rsa-sha256; t=1520824069; cv=none;
        d=google.com; s=arc-20160816;
        b=q6ET69rZjnvcat0A6CwKRLW3qz50EwtBoxXwNz8qUW8aTveaH4ZYzuBoygO4H0EcIt
         B+l/xxMVU4QymcnFzjYajHrc+Lqb3PWTQpB55Vq2NeokluthNZTlSQlw0iCjaIKgAJnK
         DzOi9oLrHqdGWHNUAoxOPjx+KqnaegWXtc3wKI/WpNZdmTwsO11ELFNsI9Axv5oLFm0w
         6wt2dGr38ue/zJdUE7WOjkDAYhuxpSMKKr7rI2uCsMEzHg8yB44uc/gpJHiMLa83v5G7
         z0sJR2ATUZnFzJl/rvHwXCDyC0r6T690RXiOMZJL2j2GGBfRUu9kGT6e62Ofj8kuQJpo
         mB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=VPsnn1TMxQXxYoz0vinZKssvzhFi9OGV40hm/3Ee1t0=;
        b=sExuwGkQkyjFF28rrXUhH3QJ/KDz8Irg497rY4cKYXOYlUj38jFQfvzTQMySn9o2Yb
         ONa/NcN4aWh2Ld2I0g7ST/CbuHUZ6Chz4Aa48IihPAIKzdcHlayXEcAKZMeRjSKd4yTC
         eVFRnn3+MfROSgYKuWztUmzF0BhtYcDygXDTJiy7ItiGZd9Vkrd4gw0P3PVO67cVz7ae
         U+vG2vTbATXwCu+IL65xlZqs2u/u304BJ8/G0aLqEdC/B/PBDA1AAyYOMAtUZ/O1/xJ5
         4pM3+XDOsIjwzu1eAMHcy9qsBe2EIBwK8036Rfj9SRw75WMM9+6IIO+yTXt+mvA7Jd93
         QyoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Ananth N Mavinakayanahalli" <ananth@linux.vnet.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.190180288@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 069/104] retpoline: Introduce start/end markers of
 indirect thunk
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699620069808837?=
X-GMAIL-MSGID: =?utf-8?q?1594699620069808837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 736e80a4213e9bbce40a7c050337047128b472ac upstream.

Introduce start/end markers of __x86_indirect_thunk_* functions.
To make it easy, consolidate .text.__x86.indirect_thunk.* sections
to one .text.__x86.indirect_thunk section and put it in the
end of kernel text section and adds __indirect_thunk_start/end
so that other subsystem (e.g. kprobes) can identify it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Link: https://lkml.kernel.org/r/151629206178.10241.6828804696410044771.stgit@devbox
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 3 +++
 arch/x86/kernel/vmlinux.lds.S        | 6 ++++++
 arch/x86/lib/retpoline.S             | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -171,6 +171,9 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS,
 };
 
+extern char __indirect_thunk_start[];
+extern char __indirect_thunk_end[];
+
 /*
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
  * can be followed in the host, by overwriting the RSB completely. Both
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -108,6 +108,12 @@ SECTIONS
 		IRQENTRY_TEXT
 		*(.fixup)
 		*(.gnu.warning)
+#ifdef CONFIG_RETPOLINE
+		__indirect_thunk_start = .;
+		*(.text.__x86.indirect_thunk)
+		__indirect_thunk_end = .;
+#endif
+
 		/* End of text section */
 		_etext = .;
 	} :text = 0x9090
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -8,7 +8,7 @@
 #include <asm/nospec-branch.h>
 
 .macro THUNK reg
-	.section .text.__x86.indirect_thunk.\reg
+	.section .text.__x86.indirect_thunk
 
 ENTRY(__x86_indirect_thunk_\reg)
 	CFI_STARTPROC
