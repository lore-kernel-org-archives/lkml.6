Return-Path: <thgarnie@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520974841; cv=none;
        d=google.com; s=arc-20160816;
        b=C/GY1aeY+lkbHFnkUvwHnYYzdtjMJSaY2DlfFbbB85MNjKrmavfTdyCQOeKSeVHjlY
         BJ//SOXM71SZxibDhZMom3ibEqUKgV8cJNaai4eThOcHO5Ifa2doTswcY2XgyOTkm5yU
         SJvxx5hYZF+P1U8hHWShqOvN2fzcW/w2VoIHevcAVCElFuYIyN6j4Hru5HV7qL5wLpOi
         6v6E4pXWFLePuSMUU6BECc7iWzgs2badUI/PqIJcxgo49Z5zg0WsNwQYjPNDJdIwSZr0
         6UwZo5+BEwnMWdlZv0R/+0sXwZ1h3WtWgT5jiJlBVp0fNrsbG0TtBXg1gp0UAVhr8lwF
         /7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=8Z0HoSlEr/r8ueDJF32+0PobUO6ef1mKRTWK6wqcoxI=;
        b=End0UGOPdXsLmu8wJj+Ts1uVXlwKYVewbySk9M22qWJEDC7WCqIPtwAmFvne52w6/9
         c9We1+VAr+DbpevWCeNjH/Z9krVCugYJiki6v7s58pq8IDYpFh6AnpB0MvHB99sDYKfS
         49XGWNsVbPDWnsHkWA76RcOD1u5KmzfKw6jp5jX77nz8jG5iTGBmkzVjjVRofNtOadjj
         oJWabzVHZwXdQ8P6EJrCi/ZnIK6Q9m6zQr7c8S393i3/SqPUWm5sr3q8iiwASoncxSpd
         TP7HShY3qLaWrZotLt91syd4hSCXGDskDGpZQo4noxDCH8GJT4bvSW4itU+9C64RLFZ3
         jeMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=hSXI/bun;
       spf=pass (google.com: domain of thgarnie@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thgarnie@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=hSXI/bun;
       spf=pass (google.com: domain of thgarnie@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thgarnie@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELv+64jFuN1zct6gdaeKaUsiiaPumXOOe0sZC84Ouz0jwCqAqJ8KYCtnnmRIi0TBaZBs505ZPA==
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
Subject: [PATCH v2 13/27] x86/boot/64: Build head64.c as mcmodel large when PIE is enabled
Date: Tue, 13 Mar 2018 13:59:31 -0700
Message-Id: <20180313205945.245105-14-thgarnie@google.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180313205945.245105-1-thgarnie@google.com>
References: <20180313205945.245105-1-thgarnie@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594857715399097934?=
X-GMAIL-MSGID: =?utf-8?q?1594857715399097934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The __startup_64 function assumes all symbols have relocated addresses
instead of the current boot virtual address. PIE generated code favor
relative addresses making all virtual and physical address math incorrect.
If PIE is enabled, build head64.c as mcmodel large instead to ensure absolute
references on all memory access. Add a global __force_order variable required
when using a large model with read_cr* functions.

To build head64.c as mcmodel=large, disable the retpoline gcc flags.
This code is used at early boot and removed later, it doesn't need
retpoline mitigation.

Position Independent Executable (PIE) support will allow to extended the
KASLR randomization range below the -2G memory limit.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/kernel/Makefile | 6 ++++++
 arch/x86/kernel/head64.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 29786c87e864..1ff6be34de66 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -22,6 +22,12 @@ CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 endif
 
+ifdef CONFIG_X86_PIE
+# Remove PIE and retpoline flags that are incompatible with mcmodel=large
+CFLAGS_REMOVE_head64.o += -fPIE -mindirect-branch=thunk-extern -mindirect-branch-register
+CFLAGS_head64.o = -mcmodel=large
+endif
+
 KASAN_SANITIZE_head$(BITS).o				:= n
 KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c855deee165..2fe60e661227 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -64,6 +64,9 @@ EXPORT_SYMBOL(vmemmap_base);
 
 #define __head	__section(.head.text)
 
+/* Required for read_cr3 when building as PIE */
+unsigned long __force_order;
+
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
-- 
2.16.2.660.g709887971b-goog
