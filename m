Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvldD7uZ1EZWmGQeVVq9F9EKMNDtVS4248HPok90FLUVEorihNVnwvd0JnyabB+AYMQvape
ARC-Seal: i=1; a=rsa-sha256; t=1520824075; cv=none;
        d=google.com; s=arc-20160816;
        b=Z7S4YHLB7UZ0Z7anr4AWcU4l33GNY51CsPvD3n0Oz3YYwnpT8eEOtDqa+JEFSkX5SG
         wN5OexzRy4tHlPql0G+Y0tto66+A2HnlHVsARpUl75eAXCp/GWU+QOiKnJuru7n4yYlW
         rqPsjMzr5Rw3W9MKPgkdkaRl5IHf8QLs8mqGfIwDUvscuaapl2ciit6mObOFF8EX8vJc
         p/ryXLKLccSQyQB9voZlPL1DiAmAHalwi8jjtlTIv5I+u/SgjBR4p0orTgvq9EBCQ9p/
         /0JSwAHSB816KiLw/8ObQXZbB/cZgJ4m1k4Nk6uzMu6zivon0pKgs9hG1TFpEm29FYsD
         rBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=Nw2s2SrrTMPexs5+yPbdyZTNUkRjegG3y9x3t+ZBL6s=;
        b=aMYvxEtq9mTgLsMq8ZLYUFTNtVigsca5+MwcwG2pS/rrvtt2rqv8iQzbos3ug04iwH
         RlOVpUKfifAdslcm5rJlwA3mylDPoSnysLPEbKFb9nAEviA6neH6D2VghauvmB1R6xdl
         /PEVGpukgmWJq+9vepJWAUaqQUtD74ytKibeJUsmFspL3xKugysjMyYeHnJ7NRhIKBsh
         P1aSZY5C1axoYEkaGAwZX34vfinK885S3CjEZ27PQQgSWvpAYGGS9BzSJyD4Sh+Qz52B
         a4i6Ww7EmWKTPwkuqTNqh1U/LVewk+PYc9p6DChmHcweI681B9UGAVXDqqe6cQwehdWf
         R6Lg==
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
 "Peter Zijlstra" <peterz@infradead.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Ananth N Mavinakayanahalli" <ananth@linux.vnet.ibm.com>,
 "Andi Kleen" <ak@linux.intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.625190193@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 35/76] retpoline: Introduce start/end markers of
 indirect thunk
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699620069808837?=
X-GMAIL-MSGID: =?utf-8?q?1594699626534989273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust context]
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
@@ -104,6 +104,12 @@ SECTIONS
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
