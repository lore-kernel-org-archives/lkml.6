Return-Path: <thgarnie@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520974861; cv=none;
        d=google.com; s=arc-20160816;
        b=TCUGf80B9HGvq/PMmQn1b/HfuUVi/k70vEaHupo4CCoAVbB02qwQc2bXGkEabBgipD
         GDe9rfxqz8w+9WsYDdxXXwuA8XDi/GEZraYOpSQFtiV59qkLTdKVq3UCTPtLVknQFLnr
         NpOb0jmO934Tltkc6NfwL6VbKXWulebyPWwI5B4WI2zKiIf72KSZOWFJjLgNmcVym1Ul
         wBtdxVGYekQ6RiKMTYCZc8eLOv2AGVyVfyofJF3r0wzBzkowO0fJ5H0gHfiiIaGCjNsF
         AyNDOSqcqiUgVg0APHp5KyoC6YMDOlo5aAVXFsMIqIAYugpQwrNYdHjvBwmWEKKzEDc/
         g7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=rlr53OdH0sphfmSd4xJhwh6ORHhK9BkcznUgDBjICCk=;
        b=QKHcSyqniTs/iHHwnsfowiDVMnsS3CrY0IJ620hPV8vqRVIUZOSokjpeRa4hpBhWMz
         onfbPr13HWK3K2cNEFijJkDSHbWezlPXMxENlIGiU0cUNklaFLMgjnt16rgrotlimwuK
         yLqG4o0G3Yg6oVu4Fk2PqxjtBOHOlXOkyC2J9cJ+yfFKAZAPGYbUnzXigknHkoK/ffe4
         fHIpWF0cve8BCGOee/PrhshFerJB89JPe92mnRAvkXPiwIoHZTQKtFtrCyJGwgqKyrEV
         CgOBE7ZcDd3mks5vSeEi8FWoxLlx8ubfvPAmON12DpV0SL/l5gMAVJQ635kyJpgsbC9D
         EZwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cVZz71r/;
       spf=pass (google.com: domain of thgarnie@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thgarnie@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cVZz71r/;
       spf=pass (google.com: domain of thgarnie@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thgarnie@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELuhDzyO9bqrIHiqE+LHydaRGZVJ+4CYwmUb49ZV057TmuBiOvxyX+PD7/Jx5J4plgYUpUHAyg==
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
Subject: [PATCH v2 19/27] kvm: Adapt assembly for PIE support
Date: Tue, 13 Mar 2018 13:59:37 -0700
Message-Id: <20180313205945.245105-20-thgarnie@google.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180313205945.245105-1-thgarnie@google.com>
References: <20180313205945.245105-1-thgarnie@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594857736565238273?=
X-GMAIL-MSGID: =?utf-8?q?1594857736565238273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible. The new __ASM_MOVABS macro is used to
get the address of a symbol on both 32 and 64-bit with PIE support.

Position Independent Executable (PIE) support will allow to extended the
KASLR randomization range below the -2G memory limit.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/kvm_host.h | 6 ++++--
 arch/x86/kernel/kvm.c           | 6 ++++--
 arch/x86/kvm/svm.c              | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b605a5b6a30c..7bd6ba79e778 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1380,9 +1380,11 @@ asmlinkage void kvm_spurious_fault(void);
 	".pushsection .fixup, \"ax\" \n" \
 	"667: \n\t" \
 	cleanup_insn "\n\t"		      \
-	"cmpb $0, kvm_rebooting \n\t"	      \
+	"cmpb $0, kvm_rebooting" __ASM_SEL(,(%%rip)) " \n\t" \
 	"jne 668b \n\t"      		      \
-	__ASM_SIZE(push) " $666b \n\t"	      \
+	__ASM_SIZE(push) "%%" _ASM_AX " \n\t"		\
+	_ASM_MOVABS " $666b, %%" _ASM_AX "\n\t"	\
+	"xchg %%" _ASM_AX ", (%%" _ASM_SP ") \n\t"	\
 	"call kvm_spurious_fault \n\t"	      \
 	".popsection \n\t" \
 	_ASM_EXTABLE(666b, 667b)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index bc1a27280c4b..5e4dd958ea95 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -711,8 +711,10 @@ asm(
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
 "__raw_callee_save___kvm_vcpu_is_preempted:"
-"movq	__per_cpu_offset(,%rdi,8), %rax;"
-"cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
+"leaq	__per_cpu_offset(%rip), %rax;"
+"movq	(%rax,%rdi,8), %rax;"
+"addq	" __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rip), %rax;"
+"cmpb	$0, (%rax);"
 "setne	%al;"
 "ret;"
 ".popsection");
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index be9c839e2c89..6835a2ce02e5 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -626,12 +626,12 @@ static u32 svm_msrpm_offset(u32 msr)
 
 static inline void clgi(void)
 {
-	asm volatile (__ex(SVM_CLGI));
+	asm volatile (__ex(SVM_CLGI) : :);
 }
 
 static inline void stgi(void)
 {
-	asm volatile (__ex(SVM_STGI));
+	asm volatile (__ex(SVM_STGI) : :);
 }
 
 static inline void invlpga(unsigned long addr, u32 asid)
-- 
2.16.2.660.g709887971b-goog
