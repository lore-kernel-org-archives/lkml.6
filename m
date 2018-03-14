Return-Path: <thgarnie@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521047390; cv=none;
        d=google.com; s=arc-20160816;
        b=LyCzfMGt4lLfL2v2AbD3xmVZKa9SsVo2szoCKGfLoxmg5myEMwwc7haown0MgM/X8l
         sX/3HhjNTCN9J6LTPScL+ecGmrewDcAi+IBFIkKvAtRhTdSAGPFfAMbD0n69gAt+mhJA
         fvnkotx7j5nJDD2to5nrcnKddtWjAXaPPuZG3Lc9MwWqg2+745XlgbKDV7x/ZkgvKlek
         qKrFA5E2gXODQaNuQdcv/DAg60N0Do4KyS1NuP5X3+UAJO9yLzVvBe8/o6mssJ+Mbzr6
         iq1N8OeWPWckvMBLa6J+SfnzgXK+PHwjtOeLSUNIwUFEfXhAFKFNUfqswkPYarbeYMal
         PFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ML4zYfUdscaecjzRnFI3Xbmp1Bh5ZDK2+GXVNLbFDmY=;
        b=zmS0YiSpfKkj3D5J7iTvFIfCS7xiSX2shds7nbnR6nXIt4YxzHFrKWsg8VN0uRoSe9
         xC2H1gWxPeARYdeFeJA0dTM/yB5z5zDtmYI7zTDmmD2Al7yOtIL+wkPUR9H3TmD/JIjE
         YrevNuiQ1uDtcz8mbp98wNvg0dbMy2Oo0NVTWZdUHqB6ZtJbRh1vKgoTcvTkJ+//4SQp
         uA9nlyKMogS3fmvfO68FkJ3cl3kAO7dSUSgxH0B/iRKmMtc7BNy1W53ZMf++Pj+ApFwy
         Ovmwv4rAFT+soNxn0ui6mea38Obe6n94tWrUTQjn8UMqQGpltymqG/hCp+yP4VaHGmHc
         Xy8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=fV5SPfFY;
       spf=pass (google.com: domain of thgarnie@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thgarnie@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=fV5SPfFY;
       spf=pass (google.com: domain of thgarnie@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thgarnie@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELviZGZDZaNV357LLY2JOyJN0hTji+QaSs7eTbrrGhdoNHwBkZ2mvXieb6/WBcxkNvCVIyz3owGsuTq0yNnuBFI=
MIME-Version: 1.0
References: <20180313205945.245105-1-thgarnie@google.com> <20180313205945.245105-7-thgarnie@google.com>
 <20180314102951.GQ4043@hirez.programming.kicks-ass.net> <alpine.DEB.2.20.1803141051210.14471@nuc-kabylake>
In-Reply-To: <alpine.DEB.2.20.1803141051210.14471@nuc-kabylake>
From: Thomas Garnier <thgarnie@google.com>
Date: Wed, 14 Mar 2018 17:09:37 +0000
Message-ID: <CAJcbSZHz9c-W4ZEVFVn3Fepj9Tau6YzDdcvxAQdK5Aw-8S6Jzg@mail.gmail.com>
Subject: Re: [PATCH v2 06/27] x86/entry/64: Adapt assembly for PIE support
To: Christoph Lameter <cl@linux.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Philippe Ombredanne <pombredanne@nexb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Matthias Kaehlcke <mka@chromium.org>, Kees Cook <keescook@chromium.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Juergen Gross <jgross@suse.com>, Alok Kataria <akataria@vmware.com>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, Dennis Zhou <dennisszhou@gmail.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>, "Luis R . Rodriguez" <mcgrof@kernel.org>,
	Christopher Li <sparse@chrisli.org>, Jason Baron <jbaron@akamai.com>,
	Ashish Kalra <ashish@bluestacks.com>, Kyle McMartin <kyle@redhat.com>,
	Dou Liyang <douly.fnst@cn.fujitsu.com>, Lukas Wunner <lukas@wunner.de>,
	Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Ingo Molnar <mingo@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, Cao jin <caoj.fnst@cn.fujitsu.com>,
	"H . J . Lu" <hjl.tools@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Rik van Riel <riel@redhat.com>, Jia Zhang <qianyue.zj@alibaba-inc.com>,
	Jiri Slaby <jslaby@suse.cz>, Kyle Huey <me@kylehuey.com>, Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <mawilcox@microsoft.com>, Michal Hocko <mhocko@suse.com>, Rob Landley <rob@landley.net>,
	Baoquan He <bhe@redhat.com>, Daniel Micay <danielmicay@gmail.com>,
	=?UTF-8?B?SmFuIEggLiBTY2jDtm5oZXJy?= <jschoenh@amazon.de>,
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>,
	virtualization@lists.linux-foundation.org,
	xen-devel <xen-devel@lists.xenproject.org>, linux-arch <linux-arch@vger.kernel.org>,
	Sparse Mailing-list <linux-sparse@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594857697760354422?=
X-GMAIL-MSGID: =?utf-8?q?1594933788489455883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 8:55 AM Christopher Lameter <cl@linux.com> wrote:



> On Wed, 14 Mar 2018, Peter Zijlstra wrote:

> > On Tue, Mar 13, 2018 at 01:59:24PM -0700, Thomas Garnier wrote:
> > > @@ -1576,7 +1578,9 @@ first_nmi:
> > >     addq    $8, (%rsp)      /* Fix up RSP */
> > >     pushfq                  /* RFLAGS */
> > >     pushq   $__KERNEL_CS    /* CS */
> > > -   pushq   $1f             /* RIP */
> > > +   pushq   %rax            /* Support Position Independent Code */
> > > +   leaq    1f(%rip), %rax  /* RIP */
> > > +   xchgq   %rax, (%rsp)    /* Restore RAX, put 1f */
> > >     iretq                   /* continues at repeat_nmi below */
> > >     UNWIND_HINT_IRET_REGS
> > >  1:
> >
> > Urgh, xchg with a memop has an implicit LOCK prefix.

> this_cpu_xchg uses no lock cmpxchg as a replacement to reduce latency.

Great, I will update my implementation.

Thanks Peter and Christoph.


>  From linux/arch/x86/include/asm/percpu.h

> /*
>   * xchg is implemented using cmpxchg without a lock prefix. xchg is
>   * expensive due to the implied lock prefix.  The processor cannot
prefetch
>   * cachelines if xchg is used.
>   */
> #define percpu_xchg_op(var, nval)                                       \
> ({                                                                      \
>          typeof(var) pxo_ret__;                                          \
>          typeof(var) pxo_new__ = (nval);                                 \
>          switch (sizeof(var)) {                                          \
>          case 1:                                                         \
>                  asm("\n\tmov "__percpu_arg(1)",%%al"                    \
>                      "\n1:\tcmpxchgb %2, "__percpu_arg(1)                \
>                      "\n\tjnz 1b"                                        \
>                              : "=&a" (pxo_ret__), "+m" (var)             \
>                              : "q" (pxo_new__)                           \
>                              : "memory");                                \
>                  break;                                                  \
>          case 2:                                                         \
>                  asm("\n\tmov "__percpu_arg(1)",%%ax"                    \
>                      "\n1:\tcmpxchgw %2, "__percpu_arg(1)                \
>                      "\n\tjnz 1b"                                        \
>                              : "=&a" (pxo_ret__), "+m" (var)             \
>                              : "r" (pxo_new__)                           \
>                              : "memory");                                \
>                  break;                                                  \
>          case 4:                                                         \
>                  asm("\n\tmov "__percpu_arg(1)",%%eax"                   \
>                      "\n1:\tcmpxchgl %2, "__percpu_arg(1)                \
>                      "\n\tjnz 1b"                                        \
>                              : "=&a" (pxo_ret__), "+m" (var)             \
>                              : "r" (pxo_new__)                           \
>                              : "memory");                                \
>                  break;                                                  \
>          case 8:                                                         \
>                  asm("\n\tmov "__percpu_arg(1)",%%rax"                   \
>                      "\n1:\tcmpxchgq %2, "__percpu_arg(1)                \
>                      "\n\tjnz 1b"                                        \
>                              : "=&a" (pxo_ret__), "+m" (var)             \
>                              : "r" (pxo_new__)                           \
>                              : "memory");                                \
>                  break;                                                  \
>          default: __bad_percpu_size();                                   \
>          }                                                               \
>          pxo_ret__;                                                      \




-- 
Thomas
