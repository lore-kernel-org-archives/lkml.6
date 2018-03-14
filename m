Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AG47ELuUqwWnmnRC5kjoNF5ZqgHCDBo1JQ+T61SKzqxUe0rC8tQWU8koRBRREYISorHPeHOfHniF
ARC-Seal: i=1; a=rsa-sha256; t=1521030537; cv=none;
        d=google.com; s=arc-20160816;
        b=KR2krWAw/qJGGUpD0wC75hYQfYZxE4YBFbaw/tsLSI3Q2Wy1fImZAfavetMUGxiCD2
         H3Fxu8GQOnTXUzhPSb+RO7ugHAbB2BLp11luujf+bwg8ncyIL2SwxR76U0D929j2jLzF
         0Qbo5my3STG1Et1IBLbkb+MOP5V7BKhWasLOGObrVyKmsZGxnAzHU9GL3tI1uZVlBGsc
         ewBkLNyoB3Su3ZZ7NWZSkNeP5CWIPvB4L7RtYEb7449FM/kC6f49DkynWE9VHNog8Z5V
         /uLmaX/sxzDC0Opmr6bGegjqJKE5EGWZeE7SkqwXCOW/IAEP9KcZKW9d8LI4ArgOfeeX
         tx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=fAdt+ThUDlVpQ+8DE2qX4IN8J8X48OsjpAISPGOV3mw=;
        b=t29Shx4Izbm7NtfbMeCxz/oN7OQFJ5tt6sl0xTRcDRhzAL87eRMoIHfm8NDnU2x2cQ
         euv/NS6XmRsQZmWY5cziykY2KORcZEBZZOwHb6koxBSg5FeNpQq23CAkC+/z8H1R1qxE
         GKJpoKkmewEFN4MMScWTuP/ATLxeCVyRlr2oUHjul2jIjXHfv8iLAMGFkE5/7HgykHNH
         7sJBmw6vggizDPxdFvCBG+DM3TUwC2xzS6Q2Wz4sLzSKaNNmYa7FrBWGcYv7DqBcpQUP
         etT/tdpfOF+lgnvh9WfLan5GaLs1Tn7e6WNj0cSuE8aiqbPGJ2n/A1bvubNCzBjR+nOw
         fkeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Wed, 14 Mar 2018 05:28:01 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Andy Whitcroft <tipbot@zytor.com>
Message-ID: <tip-a14bff131108faf50cc0cf864589fd71ee216c96@git.kernel.org>
Cc: hpa@zytor.com, dave.hansen@linux.intel.com, arjan@linux.intel.com,
        mingo@kernel.org, dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, apw@canonical.com, bp@alien8.de,
        luto@kernel.org, dan.j.williams@intel.com, jpoimboe@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com, tglx@linutronix.de,
        dan.j.williams@intel.com, bp@alien8.de, torvalds@linux-foundation.org,
        apw@canonical.com, luto@kernel.org, dwmw@amazon.co.uk,
        gregkh@linuxfoundation.org, mingo@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, arjan@linux.intel.com
In-Reply-To: <20180314112427.22351-1-apw@canonical.com>
References: <20180314112427.22351-1-apw@canonical.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation, objtool: Annotate indirect
 calls/jumps for objtool on 32-bit kernels
Git-Commit-ID: a14bff131108faf50cc0cf864589fd71ee216c96
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594916116672090070?=
X-GMAIL-MSGID: =?utf-8?q?1594916116672090070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  a14bff131108faf50cc0cf864589fd71ee216c96
Gitweb:     https://git.kernel.org/tip/a14bff131108faf50cc0cf864589fd71ee216c96
Author:     Andy Whitcroft <apw@canonical.com>
AuthorDate: Wed, 14 Mar 2018 11:24:27 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Mar 2018 13:24:31 +0100

x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32-bit kernels

In the following commit:

  9e0e3c5130e9 ("x86/speculation, objtool: Annotate indirect calls/jumps for objtool")

... we added annotations for CALL_NOSPEC/JMP_NOSPEC on 64-bit x86 kernels,
but we did not annotate the 32-bit path.

Annotate it similarly.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180314112427.22351-1-apw@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/nospec-branch.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index b7063cfa19f9..b3996d60f981 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -183,7 +183,10 @@
  * otherwise we'll run out of registers. We don't care about CET
  * here, anyway.
  */
-# define CALL_NOSPEC ALTERNATIVE("call *%[thunk_target]\n",	\
+# define CALL_NOSPEC						\
+	ALTERNATIVE(						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
 	"       jmp    904f;\n"					\
 	"       .align 16\n"					\
 	"901:	call   903f;\n"					\
