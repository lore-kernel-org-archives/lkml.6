Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x224eP6SABb8x68/zFfRwHqQOMrrQjtrYFW+AlKPSMNNPvhu9NT6yTngvh7LNAXpdTdM3Wnd1
ARC-Seal: i=1; a=rsa-sha256; t=1518604488; cv=none;
        d=google.com; s=arc-20160816;
        b=fUpAafHxuf8oqi7w2PgoPxIZjwoWDvmjrXqB89ZpH5gZzMe7FSEikc7bgWqLKC7gYB
         Ta8xCfIzjLLi5wT0YqdUP/GL1V8oK5chthNUlt2OdpAzW44USdvI8eYJ0brhwXTzA3Gb
         IW/rqM9dpc1jL/K3IZ2/49cZ8+53O2d3/SM2NkvPA9751vLnUlG/fzjP8DSXBdOG/73p
         CTmDtfsZsTo6dPsWgT1+BNJ6vq2xE7bU1vul7kKBiHjO2VQ7Yy6rCoaUWn0RNIt+y1k3
         JqWA0bagezWOyrgAr+aKLATIlkywbyV8vAfqoT8FsyGMOLTeOm1TuVshit4c1D0E/g3k
         RyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=YNx6Byf2KH+r/waAN9iGc4paKPuecGNeASAv1LdJF4c=;
        b=K1tshmU8TE32kB7wUP/o17+I33KeRuyVbwOt1peXhsefCi9xoffkWCps7xLK/sqDJK
         hqoVObu3kGGUG0qy2NQBltKe6Wj1voXzih6s5pH9PvmfC170eKlVODxEBy4MuI4VN8zz
         ENJVN/n03CqVn6l1J8QdrrZhOtwK2RsBTWtdKz5T2fd30j59mqZ7lxYsGyHCZCtNlYOU
         xYIaNKQR1csNPlNO7B4EaKQpNauZKu9xS5b1b3aSn/EjiOm745cGKg81LkK9vBTUE0P0
         OfZN9WXKbRJ2XOtPFWw7FBecGwHGuG+/23ag9c+wa4kBxOtUp65bEA/ugJwJUrYQqoE1
         se4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=PLr6Jl0z;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=PLr6Jl0z;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Wed, 14 Feb 2018 11:34:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Yatsina, Marina" <marina.yatsina@intel.com>
Cc: Kees Cook <keescook@google.com>, David Woodhouse <dwmw2@infradead.org>,
	Chandler Carruth <chandlerc@google.com>,
	"Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>,
	"rnk@google.com" <rnk@google.com>,
	LLVM Developers <llvm-dev@lists.llvm.org>,
	"ehsan@mozilla.com" <ehsan@mozilla.com>,
	"Tayree, Coby" <coby.tayree@intel.com>,
	Matthias Braun <matze@braunis.de>,
	Dean Michael Berris <dean.berris@gmail.com>,
	James Y Knight <jyknight@google.com>,
	Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>,
	Paul Turner <pjt@google.com>, Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Message-ID: <20180214103434.GY25181@hirez.programming.kicks-ass.net>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
 <20180214090851.GU25181@hirez.programming.kicks-ass.net>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771900@hasmsx107.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3D6595E4CE1DA4A80538CC077C51A2B84771900@hasmsx107.ger.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592372219822561652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 09:52:59AM +0000, Yatsina, Marina wrote:
> Hi Peter,
> 
> When I started the original thread last year I was in favor of adding
> "asm goto" and didn't understand why it wasn't done by that time.  The
> feedback I got is that this feature (optimizing tracepoints) is very
> useful and that we do want it in llvm, but perhaps there's a cleaner
> way of implementing than "asm goto". An alternative suggestion arose
> as well. 

So it's far more than just tracepoints. We use it all over the kernel to
do runtime branch patching.

One example is avoiding the scheduler preemption callbacks if we know
there are no users. This shaves a few % off a context switch
micro-bench.

But it is really _all_ over the place.

> I'm sure you can provide a lot of background for the decisions of why
> "asm goto" was chosen and which other alternatives were considered, as
> you were the one to implement this.

I have very little memories from back then, but it was mostly us asking
for label addresses in asm and them giving us asm-goto.

Using asm we can build our own primitives, and I realize the llvm
community doesn't like asm much, but then again, we treat C like a
glorified assembler and don't like our compilers too smart :-)

> Anyway, I think we should consider the alternatives and not take "asm
> goto" as a given.

Far too late for that, 7+ years ago when we did this was the time to
talk about alternatives, now we have this code base.

So we have the two jump_label things:

static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
{
        asm_volatile_goto("1:"
                ".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
                ".pushsection __jump_table,  \"aw\" \n\t"
                _ASM_ALIGN "\n\t"
                _ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
                ".popsection \n\t"
                : :  "i" (key), "i" (branch) : : l_yes);

        return false;
l_yes:
        return true;
}

static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
{
        asm_volatile_goto("1:"
                ".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
                "2:\n\t"
                ".pushsection __jump_table,  \"aw\" \n\t"
                _ASM_ALIGN "\n\t"
                _ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
                ".popsection \n\t"
                : :  "i" (key), "i" (branch) : : l_yes);

        return false;
l_yes:
        return true;
}

Where we emit either a 5 byte jump or a 5 byte nop and write a special
section with meta-data for the branch point.

You could possibly capture all that with a built-in, but would have to
exactly match our meta-data section and then we'd still be up some creek
without no paddle when we need to change it.

But we also have:

static __always_inline __pure bool _static_cpu_has(u16 bit)
{
        asm_volatile_goto("1: jmp 6f\n"
                 "2:\n"
                 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
                         "((5f-4f) - (2b-1b)),0x90\n"
                 "3:\n"
                 ".section .altinstructions,\"a\"\n"
                 " .long 1b - .\n"              /* src offset */
                 " .long 4f - .\n"              /* repl offset */
                 " .word %P[always]\n"          /* always replace */
                 " .byte 3b - 1b\n"             /* src len */
                 " .byte 5f - 4f\n"             /* repl len */
                 " .byte 3b - 2b\n"             /* pad len */
                 ".previous\n"
                 ".section .altinstr_replacement,\"ax\"\n"
                 "4: jmp %l[t_no]\n"
                 "5:\n"
                 ".previous\n"
                 ".section .altinstructions,\"a\"\n"
                 " .long 1b - .\n"              /* src offset */
                 " .long 0\n"                   /* no replacement */
                 " .word %P[feature]\n"         /* feature bit */
                 " .byte 3b - 1b\n"             /* src len */
                 " .byte 0\n"                   /* repl len */
                 " .byte 0\n"                   /* pad len */
                 ".previous\n"
                 ".section .altinstr_aux,\"ax\"\n"
                 "6:\n"
                 " testb %[bitnum],%[cap_byte]\n"
                 " jnz %l[t_yes]\n"
                 " jmp %l[t_no]\n"
                 ".previous\n"
                 : : [feature]  "i" (bit),
                     [always]   "i" (X86_FEATURE_ALWAYS),
                     [bitnum]   "i" (1 << (bit & 7)),
                     [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
                 : : t_yes, t_no);
t_yes:
        return true;
t_no:
        return false;
}

Which does something similar, but with a completely different meta-data
section and a different pre-patch fallback path.

But we also do things like:

#define __GEN_RMWcc(fullop, var, cc, clobbers, ...)                     \
do {                                                                    \
        asm_volatile_goto (fullop "; j" #cc " %l[cc_label]"             \
                        : : [counter] "m" (var), ## __VA_ARGS__         \
                        : clobbers : cc_label);                         \
        return 0;                                                       \
cc_label:                                                               \
        return 1;                                                       \
} while (0)

#define GEN_UNARY_RMWcc(op, var, arg0, cc)				\
	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM)

static __always_inline bool atomic_dec_and_test(atomic_t *v)
{
	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", e);
}

In order to not generate crap asm with SETcc + TEST. Of course, the last
is superceded with asm-cc-output, which you _also_ don't support.

And I know you're going to tell me you guys would prefer it if we
switched to intrinsics for atomics, but then I'd have to tell you that
the C11 memory model doesn't match the Linux Kernel memory model [*],
another result of being late to the game. Also, we still support
compilers from before that.

So no, you're not going to give us something different.


[*]  http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/p0124r4.html

So ideally, the compilers would actually commit to also implementing the
linux-kernel memory model, otherwise we'll be fighting the compiler
(like we have been for a while now) for even longer.

Esp. with LTO we run a real risk of the compiler doing BAD things to our
code.
