Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtHi2Aa2CKd/WS3j+hzyw18sSsvcPKgKNqKQp/FhIFyT726m5TEl0wbOvEkHbilvx1M7sRQ
ARC-Seal: i=1; a=rsa-sha256; t=1520955124; cv=none;
        d=google.com; s=arc-20160816;
        b=c6oMCCK1fzMAFvatEhU7JCkm48QcGEw40MVskkl2Y+zyrZJzV0R0op+PZUMyuEFYVh
         zlMocNhqAqxXYLLM6n1b4Gk7+CcKLUawGxTE3fDzxNEfqHzO486Jmb7g/vpp56nvBMDy
         UqrOhL46nA3eyZ3JfsBoP0RhlFqdIXqPto0LnhTt5OGh15kstSZql82LYalpTadRA09W
         lHHmwlX5BsX+0oGKsomJqwle95kT0s9vXBX8oClRQDSjWI4xPPUgouC8V+f9cvSNg9o6
         28jE6LUknkQB7ZvBSduOvFNkXHocKFUoXExRuvm3XUzTFUYEaApr8zrWzdI3RynP8Ysm
         Dxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8mLntzz7VZ/zVygkr3/H+/IBvIrMP2cZPxkp328oEOM=;
        b=lCFMxeTvggBf414s09vWzuIBSHGWwB4yUJNoGAVaHJwynesMCpwpM3LoJUO1S8jiV2
         eUlDlV/EOhEu0amDZ+dxIbQA4+bC3yEQZ9X8bMOOvitjpcB9PS0O53P5+TETLiRvIcQ6
         A66A1N/1KVpMIqPMGj0raI+EXTtgCKc5Mb85WLjH+bBfhqurjYe3wzHQS0HgyUT0PkDj
         VzJ3TIMM7BGOBoAT8J7IfbSzQIKQOBtn+LTASNikE0B5ae/l8K7rdjObnt1xDjdSCP5E
         Bbo6tUll/1uP7bTYfuDBkbUF5vuQgIY3vZJmGf8/9Vc7C2t3NepyZyucjko5QEofB4H2
         MJCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Borislav Petkov <bp@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 096/146] x86/mm/sme, objtool: Annotate indirect call in sme_encrypt_execute()
Date: Tue, 13 Mar 2018 16:24:23 +0100
Message-Id: <20180313152328.018083861@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837040408534730?=
X-GMAIL-MSGID: =?utf-8?q?1594837040408534730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 531bb52a869a9c6e08c8d17ba955fcbfc18037ad upstream.

This is boot code and thus Spectre-safe: we run this _way_ before userspace
comes along to have a chance to poison our branch predictor.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/mem_encrypt_boot.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -15,6 +15,7 @@
 #include <asm/page.h>
 #include <asm/processor-flags.h>
 #include <asm/msr-index.h>
+#include <asm/nospec-branch.h>
 
 	.text
 	.code64
@@ -59,6 +60,7 @@ ENTRY(sme_encrypt_execute)
 	movq	%rax, %r8		/* Workarea encryption routine */
 	addq	$PAGE_SIZE, %r8		/* Workarea intermediate copy buffer */
 
+	ANNOTATE_RETPOLINE_SAFE
 	call	*%rax			/* Call the encryption routine */
 
 	pop	%r12
