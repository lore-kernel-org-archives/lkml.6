Return-Path: <cl@linux.com>
X-Google-Smtp-Source: AG47ELt3TwkKHzmBQ7VChlWI01NX5L29TVDWM9rAP2ZPMc4yyFz9FjgEV4fjL1wMU8V6pk8gY8CX
ARC-Seal: i=1; a=rsa-sha256; t=1521042904; cv=none;
        d=google.com; s=arc-20160816;
        b=SfSdX/EAOz6GxH5io1IDWpSUIKtCIgLpfKuB8oljW3eWRbIFsijKmR4F1Ex3MBG20W
         pCxuhzjyhmnFipoVi+RGtpJp/XRL9osI6zGr/lEb4Mqmto75r94/5rYQOxPj7WwbKi3P
         eMle5f/Xnd4tV+CLNtddzj8tp4uPIVu2hUkFiYwEcAWDQ7iChTzzZaup94YVMPm19D3x
         UTLEtYeAyXpohiaFYXAxy3V75NXCvm08N2x6fhy54FYHwnz3Z+v2YGkpxn2y/sIHgoV8
         PC9isUT2NKTxZ+JzvZk3qLljnytM34L4eKoekr4sTTTjoqD3Lr0sahgRiSYjlXE/ojzi
         7fQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=aPYpGhd0csEkWAUCsnRmpCzl3TfpkkplfOAxFpvOZ2w=;
        b=FDUOb4UWM5Xf4ktF1YWoZ1NQBEe974cHJa9j3iihzwlrZc+JpuKR9LVdQwXLWItIx9
         iM6ML2wmexRSpeQGvIk2b/UUI14CB/LDvjyY3JjSKcdLqnIrrW7ihc/udD4Bx+4Hmya5
         J4UE18o32H7IA3U9PCIYnmO2TvK1DMT79zjZaR2uTLhd3PqAW+LoK+vBaO9xZIyTX0DY
         /k5s5X6xh6sRBmmkJumg9z/ID1tmVEXTZLohs0VIIuRYds3FNd2zpoYmwwQnc9n0NeRv
         6wwiyfci4kWaXm9olYL6at7ZMu6A5iT46g2AhkvhfQZO43Vv5PnYnIpvEI1SCLpbTToc
         C5Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of cl@linux.com designates 2001:558:fe21:29:69:252:207:35 as permitted sender) smtp.mailfrom=cl@linux.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of cl@linux.com designates 2001:558:fe21:29:69:252:207:35 as permitted sender) smtp.mailfrom=cl@linux.com
Date: Wed, 14 Mar 2018 10:54:58 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Peter Zijlstra <peterz@infradead.org>
cc: Thomas Garnier <thgarnie@google.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S . Miller" <davem@davemloft.net>,
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
    "H . Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Kate Stewart <kstewart@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
    Philippe Ombredanne <pombredanne@nexb.com>,
    Arnaldo Carvalho de Melo <acme@redhat.com>,
    Andrey Ryabinin <aryabinin@virtuozzo.com>,
    Matthias Kaehlcke <mka@chromium.org>, Kees Cook <keescook@chromium.org>,
    Tom Lendacky <thomas.lendacky@amd.com>,
    "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
    Andy Lutomirski <luto@kernel.org>,
    Dominik Brodowski <linux@dominikbrodowski.net>,
    Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
    "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>,
    Pavel Machek <pavel@ucw.cz>, Juergen Gross <jgross@suse.com>,
    Alok Kataria <akataria@vmware.com>, Steven Rostedt <rostedt@goodmis.org>,
    Tejun Heo <tj@kernel.org>, Dennis Zhou <dennisszhou@gmail.com>,
    Boris Ostrovsky <boris.ostrovsky@oracle.com>,
    David Woodhouse <dwmw@amazon.co.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
    "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
    Andrew Morton <akpm@linux-foundation.org>,
    Nicolas Pitre <nicolas.pitre@linaro.org>,
    Randy Dunlap <rdunlap@infradead.org>,
    "Luis R . Rodriguez" <mcgrof@kernel.org>,
    Christopher Li <sparse@chrisli.org>, Jason Baron <jbaron@akamai.com>,
    Ashish Kalra <ashish@bluestacks.com>, Kyle McMartin <kyle@redhat.com>,
    Dou Liyang <douly.fnst@cn.fujitsu.com>, Lukas Wunner <lukas@wunner.de>,
    Petr Mladek <pmladek@suse.com>,
    Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
    Masahiro Yamada <yamada.masahiro@socionext.com>,
    Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
    Cao jin <caoj.fnst@cn.fujitsu.com>, "H . J . Lu" <hjl.tools@gmail.com>,
    Paolo Bonzini <pbonzini@redhat.com>,
    =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
    Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>,
    Rik van Riel <riel@redhat.com>, Jia Zhang <qianyue.zj@alibaba-inc.com>,
    Jiri Slaby <jslaby@suse.cz>, Kyle Huey <me@kylehuey.com>,
    Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <mawilcox@microsoft.com>,
    Michal Hocko <mhocko@suse.com>, Rob Landley <rob@landley.net>,
    Baoquan He <bhe@redhat.com>, Daniel Micay <danielmicay@gmail.com>,
    =?ISO-8859-15?Q?Jan_H_=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
    x86@kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-pm@vger.kernel.org, virtualization@lists.linux-foundation.org,
    xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
    linux-sparse@vger.kernel.org, kvm@vger.kernel.org,
    linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 06/27] x86/entry/64: Adapt assembly for PIE support
In-Reply-To: <20180314102951.GQ4043@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.20.1803141051210.14471@nuc-kabylake>
References: <20180313205945.245105-1-thgarnie@google.com> <20180313205945.245105-7-thgarnie@google.com> <20180314102951.GQ4043@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfHvWKpO9WvTrkJyAniC8bHkqwiEbP+9RYKslR6MzA+dwdd69a8L2k/E/Bttqkw5UtWxn/OFGk5ZYdPE47PeDewxM+SyZGvqgznnvgaiAR+OyKfJ5CYlW
 TYWTK06P1eKA+txLwEBDyWUjCFth7SpP5lj/gDctepHZ2NwUtPMb0blGqwnD7GtEIoWlSinCbQgVJnzONF3rOSr7iLCg2WSwVEeDeMnsxxlcmou6mH3SS6NF
 iFEgYEcQ26CwIyM5TWKLG8WFKghAsa88wuQPyWspsGexS+NK93xd2BPDlYJzQH6vkAKshsWYqE61byDbMnkd+VfvZHszlXJyjsmfPP55ouvTKBaVO48UihmM
 VZ07T94xOvlpr2aIWQgPWOONE6rPJVq1/XDStvMGjb8Fmo/ZvWdQh20fcj2SvxBMHpw/hXl30oUvpwGtuiqb5jozNUfRjwzM47B6o4GICvvhHVJySZpEfe5T
 WG85pL0mF9FCnPGwZIHbA71m9bEFGHyy7A+TY/Wo3rhnyDubqRTgyXIdFc9BwAECFQEwlGvsqjN3V64lp4O/1LfukrqwJGF8IZquoAcypWt/aXpvLVeUjBHB
 AFfyWpZx4pawXfDZ90/GZCbsw6cFmQvjuddGB7PTha380fDxluZLwGcnVyRzfwnU+I/wq7FC5WUVL0DvSdVI8S9y4sR2BZgPFqeZRlLT8o8EWrWNvlTObd2W
 YtWrGwMqN/yfK1heqZSyum7mc6NPIBH6DqMCrg7r4P6z5rkc1kBqAuJQ1lEIHV5sHj0PLpwuSHk9Tq8JntvuBX8nSNurOGwiB/O558Woe6NtP964QBfM12V4
 pRmO5BphLNiwgg4tfGnUMFVoExdMgoFwofv5Ld3uDUZEu7GzxAJa+mhjTH3tYj5DcAPLbyW7PBFKMZogbc8gfH8qC2vHNSozUO2bO4c554ogxI6rbdrMQvrG
 cxtJtsG64qDbEQDWGwoR5v4uZIMsqHx2kuOArVY7R1KG9cn8iR9PQtkpklYsQQWlHmrcrwszz4xgbDrua6DxifYU54DTe4MOUK+KErGOT4Q4cvZu5dIEl91o
 baoBXqLFQBuPJigd1iNnCgUz9yrTEoWsDU8L2afmpemnYo6SmI5Mq8KsgqgPhVx15kPqxfhAezf9ckNUyVEmn/Cxxz5mctK9hQua1pHc2s9Urp3kYjVY3VAX
 5QWBtJWhXB1xilyKM4tp5vnbArVD+Ck8SeA9gMNgU4FfLrWUiGRz52Xc/kljfbqSFZUUXj3stk/ojnipwkAOtiFHlguWemhEMUrHb6koCGS6sVl8RAXLk5P/
 oQnIjT24/ilHS2iuzhfraVy56kw1pSEyB6CkMbd2/tDSfZFB7kaoj9Vk4p02KhQNh4GyeyCZHbiknraFIgvM0veQiwB19IU/usoWMnqSeP6gClyOC3A6RqsX
 +VOo/VTNYUj0hwUP3jZlt89JjWtuXqUJkAwPI17dNv5IBnkQkgUE6OJBacDAS92IFC5XwalTXdx8rpje9apIKdbin5eKuUruq0D03XoTJKeP+/EhkslUAE+3
 snVUKmM38vB3gojIUFGioqdqOEp0ne/QiGyhT1RM2G1ecgfG/mPxsZJbG7YDkrE71017f83GUE4yqmLQ487dN6A5SXrqy6ZVNzbGwL4NsEOBGNFheBJtu9mE
 x3XIjX6Qo676YTLl6qezt3RlaTtFv1nPNYtoBYOwJoX4qt9WJHpTQ2icH9ylnJckAVAqDA0pJg/PdbTuT8Mt+OJfgsf1nF+c067Zp67KrbHp/ITK4hqKunkG
 8v7OO5UZp+K4GMAD7nQ=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594857697760354422?=
X-GMAIL-MSGID: =?utf-8?q?1594929084493804709?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Wed, 14 Mar 2018, Peter Zijlstra wrote:

> On Tue, Mar 13, 2018 at 01:59:24PM -0700, Thomas Garnier wrote:
> > @@ -1576,7 +1578,9 @@ first_nmi:
> >  	addq	$8, (%rsp)	/* Fix up RSP */
> >  	pushfq			/* RFLAGS */
> >  	pushq	$__KERNEL_CS	/* CS */
> > -	pushq	$1f		/* RIP */
> > +	pushq	%rax		/* Support Position Independent Code */
> > +	leaq	1f(%rip), %rax	/* RIP */
> > +	xchgq	%rax, (%rsp)	/* Restore RAX, put 1f */
> >  	iretq			/* continues at repeat_nmi below */
> >  	UNWIND_HINT_IRET_REGS
> >  1:
>
> Urgh, xchg with a memop has an implicit LOCK prefix.

this_cpu_xchg uses no lock cmpxchg as a replacement to reduce latency.

>From linux/arch/x86/include/asm/percpu.h

/*
 * xchg is implemented using cmpxchg without a lock prefix. xchg is
 * expensive due to the implied lock prefix.  The processor cannot prefetch
 * cachelines if xchg is used.
 */
#define percpu_xchg_op(var, nval)                                       \
({                                                                      \
        typeof(var) pxo_ret__;                                          \
        typeof(var) pxo_new__ = (nval);                                 \
        switch (sizeof(var)) {                                          \
        case 1:                                                         \
                asm("\n\tmov "__percpu_arg(1)",%%al"                    \
                    "\n1:\tcmpxchgb %2, "__percpu_arg(1)                \
                    "\n\tjnz 1b"                                        \
                            : "=&a" (pxo_ret__), "+m" (var)             \
                            : "q" (pxo_new__)                           \
                            : "memory");                                \
                break;                                                  \
        case 2:                                                         \
                asm("\n\tmov "__percpu_arg(1)",%%ax"                    \
                    "\n1:\tcmpxchgw %2, "__percpu_arg(1)                \
                    "\n\tjnz 1b"                                        \
                            : "=&a" (pxo_ret__), "+m" (var)             \
                            : "r" (pxo_new__)                           \
                            : "memory");                                \
                break;                                                  \
        case 4:                                                         \
                asm("\n\tmov "__percpu_arg(1)",%%eax"                   \
                    "\n1:\tcmpxchgl %2, "__percpu_arg(1)                \
                    "\n\tjnz 1b"                                        \
                            : "=&a" (pxo_ret__), "+m" (var)             \
                            : "r" (pxo_new__)                           \
                            : "memory");                                \
                break;                                                  \
        case 8:                                                         \
                asm("\n\tmov "__percpu_arg(1)",%%rax"                   \
                    "\n1:\tcmpxchgq %2, "__percpu_arg(1)                \
                    "\n\tjnz 1b"                                        \
                            : "=&a" (pxo_ret__), "+m" (var)             \
                            : "r" (pxo_new__)                           \
                            : "memory");                                \
                break;                                                  \
        default: __bad_percpu_size();                                   \
        }                                                               \
        pxo_ret__;                                                      \
