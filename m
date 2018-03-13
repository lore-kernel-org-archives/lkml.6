Return-Path: <kernel-hardening-return-12544-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtGGoz4VL261zIs8wupS1xU+y7PLZa6UbQ+HLFSzmcPUtDd/1OEBhUOEjAJwG8w6ACAKb7u
ARC-Seal: i=1; a=rsa-sha256; t=1520975172; cv=none;
        d=google.com; s=arc-20160816;
        b=NaWghWjfgMf+aX2whXloFWkBFmGcIwf9BKcqxLdgylhIiQwCOSTwtJ/XiYCCRi+g3S
         AIxIJxidXqUzjsbKl4o2A6q+B0kV2RigWwqvKnIi1Z3qYJr5W8UMYrWO/ywvHe5iLTOd
         B3dnflI00GqR2iR6nsBNni3puBtff37TSXOrMjjzpjlck+I/GKgkZ3bG+BfOBCv7ztwE
         0hDU0IGjwDyklvPSAiJ4oNuAKeeNDZLoauWYDI/WVOPF1mQrcNBZquHifVmHWtGnZWHh
         sTHh2tth95wZLw96tvH70Wpw5Tof/+gOSIu2C5q+KjGLfmUcGe1g2+F+1MiQ5KT7sRpO
         qjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=vO/yjXq+42QmCGcXYXbNUwLftfo2inVaVcUUtnJzwug=;
        b=d19KC1osB+IiZm+DDcv7rEh12o95EKV0B4hcke7zoFhOcgHSrxZFSN4fLW7s1D1xDV
         LJ7loqpb8GVf6QTesRnQaRn2fcqwaSa3ZZwqa1GLN2iL/HDI6nqY9qalDL79USTw2oXn
         zsXmeqCvEnnVu5ZVET09pn4pramNY0EqD8AZsXhIKj+pxhFJQvrgv2jSI6zMCcUvE/Yk
         mwDwu8HZ/8Ym1YuTy5jtWNaVx50SbA98eLJsRXajxIFLBcIsqMOHQlrbd5liJnNwK0v2
         n0aLKxEXK83ls0KeIxw+W5mLy4pOll1PkvMbaKETnR9vW99++0HlkiknyvN+rg95Dzor
         P0pw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=iEvcJA4y;
       spf=pass (google.com: domain of kernel-hardening-return-12544-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12544-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=iEvcJA4y;
       spf=pass (google.com: domain of kernel-hardening-return-12544-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12544-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Thomas Garnier <thgarnie@google.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Garnier <thgarnie@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Borislav Petkov <bp@alien8.de>,
	Borislav Petkov <bp@suse.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Juergen Gross <jgross@suse.com>,
	Alok Kataria <akataria@vmware.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Dennis Zhou <dennisszhou@gmail.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Christopher Li <sparse@chrisli.org>,
	Jason Baron <jbaron@akamai.com>,
	Ashish Kalra <ashish@bluestacks.com>,
	Kyle McMartin <kyle@redhat.com>,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Lukas Wunner <lukas@wunner.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Ingo Molnar <mingo@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Cao jin <caoj.fnst@cn.fujitsu.com>,
	"H . J . Lu" <hjl.tools@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rik van Riel <riel@redhat.com>,
	Jia Zhang <qianyue.zj@alibaba-inc.com>,
	Jiri Slaby <jslaby@suse.cz>,
	Kyle Huey <me@kylehuey.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Michal Hocko <mhocko@suse.com>,
	Rob Landley <rob@landley.net>,
	Baoquan He <bhe@redhat.com>,
	Daniel Micay <danielmicay@gmail.com>,
	=?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
Cc: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org,
	linux-arch@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH v2 21/27] x86/ftrace: Adapt function tracing for PIE support
Date: Tue, 13 Mar 2018 13:59:39 -0700
Message-Id: <20180313205945.245105-22-thgarnie@google.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180313205945.245105-1-thgarnie@google.com>
References: <20180313205945.245105-1-thgarnie@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594858062425792867?=
X-GMAIL-MSGID: =?utf-8?q?1594858062425792867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When using -fPIE/PIC with function tracing, the compiler generates a
call through the GOT (call *__fentry__@GOTPCREL). This instruction
takes 6 bytes instead of 5 on the usual relative call.

If PIE is enabled, replace the 6th byte of the GOT call by a 1-byte nop
so ftrace can handle the previous 5-bytes as before.

Position Independent Executable (PIE) support will allow to extended the
KASLR randomization range below the -2G memory limit.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/ftrace.h   |  6 +++--
 arch/x86/include/asm/sections.h |  4 ++++
 arch/x86/kernel/ftrace.c        | 42 +++++++++++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 09ad88572746..61fa02d81b95 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -25,9 +25,11 @@ extern void __fentry__(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/*
-	 * addr is the address of the mcount call instruction.
-	 * recordmcount does the necessary offset calculation.
+	 * addr is the address of the mcount call instruction. PIE has always a
+	 * byte added to the start of the function.
 	 */
+	if (IS_ENABLED(CONFIG_X86_PIE))
+		addr -= 1;
 	return addr;
 }
 
diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index d6baf23782bc..cad292f62eed 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -12,4 +12,8 @@ extern struct exception_table_entry __stop___ex_table[];
 extern char __end_rodata_hpage_align[];
 #endif
 
+#if defined(CONFIG_X86_PIE)
+extern char __start_got[], __end_got[];
+#endif
+
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 01ebcb6f263e..21bde498f1a9 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -102,7 +102,7 @@ static const unsigned char *ftrace_nop_replace(void)
 
 static int
 ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
-		   unsigned const char *new_code)
+			  unsigned const char *new_code)
 {
 	unsigned char replaced[MCOUNT_INSN_SIZE];
 
@@ -135,6 +135,44 @@ ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
 	return 0;
 }
 
+/* Bytes before call GOT offset */
+const unsigned char got_call_preinsn[] = { 0xff, 0x15 };
+
+static int
+ftrace_modify_initial_code(unsigned long ip, unsigned const char *old_code,
+			   unsigned const char *new_code)
+{
+	unsigned char replaced[MCOUNT_INSN_SIZE + 1];
+
+	ftrace_expected = old_code;
+
+	/*
+	 * If PIE is not enabled or no GOT call was found, default to the
+	 * original approach to code modification.
+	 */
+	if (!IS_ENABLED(CONFIG_X86_PIE)
+	    || probe_kernel_read(replaced, (void *)ip, sizeof(replaced))
+	    || memcmp(replaced, got_call_preinsn, sizeof(got_call_preinsn)))
+		return ftrace_modify_code_direct(ip, old_code, new_code);
+
+	/*
+	 * Build a nop slide with a 5-byte nop and 1-byte nop to keep the ftrace
+	 * hooking algorithm working with the expected 5 bytes instruction.
+	 */
+	memcpy(replaced, new_code, MCOUNT_INSN_SIZE);
+	replaced[MCOUNT_INSN_SIZE] = ideal_nops[1][0];
+
+	ip = text_ip_addr(ip);
+
+	if (probe_kernel_write((void *)ip, replaced, sizeof(replaced)))
+		return -EPERM;
+
+	sync_core();
+
+	return 0;
+
+}
+
 int ftrace_make_nop(struct module *mod,
 		    struct dyn_ftrace *rec, unsigned long addr)
 {
@@ -153,7 +191,7 @@ int ftrace_make_nop(struct module *mod,
 	 * just modify the code directly.
 	 */
 	if (addr == MCOUNT_ADDR)
-		return ftrace_modify_code_direct(rec->ip, old, new);
+		return ftrace_modify_initial_code(rec->ip, old, new);
 
 	ftrace_expected = NULL;
 
-- 
2.16.2.660.g709887971b-goog
