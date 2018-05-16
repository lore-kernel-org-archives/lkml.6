Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526488136; cv=none;
        d=google.com; s=arc-20160816;
        b=fmupRJAiZNSpKHzcRfv87mOWUJk75fzVopeJX7+NVOetn1YpxMlU3EUxEAebVpXOux
         Nw/g55tMelim9h+MFAGKiLi7ULoC4yo3Q910M4NpTIQqo3W1kRAdYpE5sRJBgQXTZ5Ve
         r0qMCHk8UAsE/ugUiDd0pfvX9WW1Ecv0m3IaJmpOAf9g4ny7AvMMdChFUilGPrB7GgoM
         XC3cnGcB6k+wgkal7rcoXBPdYlvA0UO/w6tSt7uPpe2NGC5nJHtOjPy9volrwoqu+YNT
         /mswoarCAf/uOq6qy8DZg0REFvxU0wVEIIC9EJvRXaPzlQyKpzWGxLEdx2lX3bRJSehc
         wGmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=yG8WI64gesDH1VxIEInLOPqtrbP0jMf2nhukF0giWlE=;
        b=sOKWG2iGJbLQ8CmsseqIPXKtv3/zPHEP2m7RcZ/cDvID+I1SPXIJuiDEjlN+MvRRyg
         2rOI5P1tO9M1Yq8UMGzbSyQHnxRuI4pXsjM3gusYtYvkG0W0eTpKHvGV8NYhU2iPMfqu
         QtJanq/v8FWORXfT0+iYejnu8yNvEx9CV+pqQD68aJlwkLVlpLDAglv1L6aqbiMQ02Y7
         OkyaxS/ujkwMEtN+8s86SzSG7ubd0wJuzkdo5PO8peGgeuSQAp4BhzQf2bVerzF3rYVC
         ou7EPUitsjD1G2Ahm8T8qK0adm7Co5O9rp0Jyck3bz7v/gLhL2Cfq+GBCruv+lO4TKyu
         v6UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AB8JxZryjR/lAeKrUdUABVWtT0CkCNboMmDctEJAOtt/LClKnsiq5uKm9CvFffYNao9GCdhqTWb23w==
From: Alexander Popov <alex.popov@linux.com>
To: kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>,
	Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Weimer <fweimer@redhat.com>,
	Boris Lukashev <blukashev@sempervictus.com>,
	Andrey Konovalov <andreyknvl@google.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	alex.popov@linux.com
Subject: [PATCH v12 6/6] doc: self-protection: Add information about STACKLEAK feature
Date: Wed, 16 May 2018 19:28:17 +0300
Message-Id: <1526488097-20611-7-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526488097-20611-1-git-send-email-alex.popov@linux.com>
References: <1526488097-20611-1-git-send-email-alex.popov@linux.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600638824413823271?=
X-GMAIL-MSGID: =?utf-8?q?1600638824413823271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add information about STACKLEAK feature to "Stack depth overflow" and
"Memory poisoning" sections of self-protection.rst.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 Documentation/security/self-protection.rst | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/security/self-protection.rst b/Documentation/security/self-protection.rst
index 0f53826..b685f18 100644
--- a/Documentation/security/self-protection.rst
+++ b/Documentation/security/self-protection.rst
@@ -165,10 +165,15 @@ Stack depth overflow
 A less well understood attack is using a bug that triggers the
 kernel to consume stack memory with deep function calls or large stack
 allocations. With this attack it is possible to write beyond the end of
-the kernel's preallocated stack space and into sensitive structures. Two
-important changes need to be made for better protections: moving the
-sensitive thread_info structure elsewhere, and adding a faulting memory
-hole at the bottom of the stack to catch these overflows.
+the kernel's preallocated stack space and into sensitive structures.
+The combination of the following measures gives better protection:
+
+* moving the sensitive thread_info structure off the stack
+  (``CONFIG_THREAD_INFO_IN_TASK``);
+* adding a faulting memory hole at the bottom of the stack to catch
+  these overflows (``CONFIG_VMAP_STACK``);
+* runtime checking that alloca() calls don't overstep the stack boundary
+  (``CONFIG_GCC_PLUGIN_STACKLEAK``).
 
 Heap memory integrity
 ---------------------
@@ -302,11 +307,11 @@ sure structure holes are cleared.
 Memory poisoning
 ----------------
 
-When releasing memory, it is best to poison the contents (clear stack on
-syscall return, wipe heap memory on a free), to avoid reuse attacks that
-rely on the old contents of memory. This frustrates many uninitialized
-variable attacks, stack content exposures, heap content exposures, and
-use-after-free attacks.
+When releasing memory, it is best to poison the contents, to avoid reuse
+attacks that rely on the old contents of memory. E.g., clear stack on a
+syscall return (``CONFIG_GCC_PLUGIN_STACKLEAK``), wipe heap memory on a
+free. This frustrates many uninitialized variable attacks, stack content
+exposures, heap content exposures, and use-after-free attacks.
 
 Destination tracking
 --------------------
-- 
2.7.4
