Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtknUEoEG9reqlq1eFRL2I9jXZqtdZUGh1Zk/K81Y2MjDdWyhKtP7qXV/QO6S2E5DKczR5W
ARC-Seal: i=1; a=rsa-sha256; t=1520955692; cv=none;
        d=google.com; s=arc-20160816;
        b=yYqrcY1QnPOT0ymWW/NNzY5AiDdXcgaAO/GnwO7HhfLmvsHPoW+ISCbD/8baYPizXT
         IDsVXM5hNCBHDuACw8t7+tSRbe9XK9kQC4yayMKFvB3XANYXiDLtR6O5A4qRv2aAgTAc
         ERZ51SMlyjb1YhmvNeSA/i7c3HL7DWETqhCeBXayi2aG+CMyDTu2KazNMoWdaTHkiwge
         avU2bjMsUpZEdufkct6sTzKf0mB/p5f8R4qKCNiDnxuzoJ0fIAWt3zUQb1zRgTT3gwCB
         ZTpBKk8FfLbjgjOorxL29y9ISyXPsb4EC0YjvwGcX0n1cVxl/pfKpkIuz+zFK5rLWhAl
         zG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rPm8jip4gnQ0eUUcHEEo3/f2ZZmtMnRFBBQg3QSuaQ8=;
        b=wuuWxptu1yPFnhXpMIFnBi3RzYNSTcXXqkSGlB6mB+gWRxfDi8Dr1xAS76JuYWFpD1
         qTLlZkCHRkOEXBM3GfMuoV7OiLWombHZ0iZNdIWm1ywkxkk8hxGV6w/whPfBFX4RvhGV
         9M5i6QE2bS6xeCElaEPKs+jiogCi+wvVrEiZePYNvw3Loh2uTXITxYHIZEsK4KQMt11C
         05aLl6uejH1r/oISdw6cefmBAF901TwoEYXiIBTi0g58N+t/v/fbBziBSt3Y/Xg0UW0J
         ye4pFAaayxwfIZmv2WcFsKbgramRoMu/P1Ye9WNWZwptlcRlZ68/TmUPjcg+8ffS8+uW
         Xw3Q==
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
Subject: [PATCH 4.14 130/140] x86/mm/sme, objtool: Annotate indirect call in sme_encrypt_execute()
Date: Tue, 13 Mar 2018 16:25:33 +0100
Message-Id: <20180313152506.922403153@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837040408534730?=
X-GMAIL-MSGID: =?utf-8?q?1594837635918587919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
