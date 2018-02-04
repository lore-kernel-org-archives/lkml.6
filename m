Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AH8x225odfMS3IsKGRX543rCD2qyeRqMJ4Rf3aNmYLo0AHoynuunx8Cjf9N+gpTpPVJjXpCfR0o6
ARC-Seal: i=1; a=rsa-sha256; t=1517769838; cv=none;
        d=google.com; s=arc-20160816;
        b=lq+5Vtv3nT7zqe7A+9ZJG/dHohjWC3QMpIHybpJA96mywxEdJpQJlTtEqKEGOFG0T3
         qoYZlXPG/aQAYh+z+A2HKgBkpbWRa/UhuDqcuIoazvCtAdyVXcsbGJEfIaXJx+JkYiKu
         6a0I+xbW9fSOBsqNza/mr/UDkNDPxciFW85Runt/oXV4NMpMHa9f2+kgSX963vs9IztH
         3afZ2faNxLteotS2yTZX5vUg3Te/97OXCehpjRoEOzvnCw1m3HPu4twX4rGckXTmeYq3
         7bcagZ2suNIBKrw96jOPLpB+h8bg9fZ1wO0WezciGm4y92rUZ+EBvNy90bdQa8GF9b3j
         1mAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=PgLn4TQz3l0wgVd4WgcJEwlYcjfVjaSKtIknUyn11Zw=;
        b=IlgSCEbxr8lxyxqANDoauXohauK/g6N4eL5sYcGxaUNs0PJWsR/4KzuwQY/uw0aytB
         h5mfFoVj4vkkZnWPomZUiUMSSJK1Mkx7HVIG4bHJzG3gPHVu9Yu/G/1YSPt5yQXTNAQI
         +EkYGQMLlYsemC4CVzcAD5OnpwD02IHx6HI4Fu7PyYvQbLiiwCzdQEW6DJXFYNJcPXVu
         v49a4ngNpxF7xPtUXS0gDJJGfFZhRXV/ycrESqOZ1Dzpl8CDf/KO7O0Wri9nm21I6Bvg
         cL+huD67+gKvP2LN/CLMbTKWen4pCExRklLEV8n/iDPr3pVWspu+P5bGtGUzkKncpzyu
         IYsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Sun, 4 Feb 2018 19:43:50 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
cc: David Woodhouse <dwmw2@infradead.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    KarimAllah Ahmed <karahmed@amazon.de>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>,
    Andy Lutomirski <luto@kernel.org>,
    Arjan van de Ven <arjan@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>,
    Asit Mallick <asit.k.mallick@intel.com>, Borislav Petkov <bp@suse.de>,
    Dan Williams <dan.j.williams@intel.com>,
    Dave Hansen <dave.hansen@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
    Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
    Joerg Roedel <joro@8bytes.org>, Jun Nakajima <jun.nakajima@intel.com>,
    Laura Abbott <labbott@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
    Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
    =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
    Tim Chen <tim.c.chen@linux.intel.com>,
    Tom Lendacky <thomas.lendacky@amd.com>, KVM list <kvm@vger.kernel.org>,
    the arch/x86 maintainers <x86@kernel.org>,
    Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [RFC 09/10] x86/enter: Create macros to restrict/unrestrict
 Indirect Branch Speculation
In-Reply-To: <20180123102318.airsvcl5uckguo2z@gmail.com>
Message-ID: <alpine.DEB.2.21.1802041801280.1035@nanos.tec.linutronix.de>
References: <1516476182-5153-10-git-send-email-karahmed@amazon.de> <CA+55aFxUEPHc7JRQG3zmxEsfmfJOiJa1QqFBKCBNb5Tt5vfiSg@mail.gmail.com> <1516566497.9814.78.camel@infradead.org> <CA+55aFwOkH8RH12Dzs=hT3e7eS3Ckz9Ed6x_-9a0zs1cw9zbKA@mail.gmail.com>
 <1516572013.9814.109.camel@infradead.org> <CA+55aFwoxXmY0u84iPT-RP8DoG+Qb8t-mh2r8RLhKVAH3jm6qg@mail.gmail.com> <1516638426.9521.20.camel@infradead.org> <20180123072930.soz25cyky3u4hpgv@gmail.com> <20180123075358.nztpyxympwfkyi2a@gmail.com>
 <1516699832.9521.123.camel@infradead.org> <20180123102318.airsvcl5uckguo2z@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1739222675-1517769830=:1035"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590140582166248265?=
X-GMAIL-MSGID: =?utf-8?q?1591497026325627994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1739222675-1517769830=:1035
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 23 Jan 2018, Ingo Molnar wrote:
> * David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > > On SkyLake this would add an overhead of maybe 2-3 cycles per function call and 
> > > obviously all this code and data would be very cache hot. Given that the average 
> > > number of function calls per system call is around a dozen, this would be _much_ 
> > > faster than any microcode/MSR based approach.
> > 
> > That's kind of neat, except you don't want it at the top of the
> > function; you want it at the bottom.
> > 
> > If you could hijack the *return* site, then you could check for
> > underflow and stuff the RSB right there. But in __fentry__ there's not
> > a lot you can do other than complain that something bad is going to
> > happen in the future. You know that a string of 16+ rets is going to
> > happen, but you've got no gadget in *there* to deal with it when it
> > does.
> 
> No, it can be done with the existing CALL instrumentation callback that 
> CONFIG_DYNAMIC_FTRACE=y provides, by pushing a RET trampoline on the stack from 
> the CALL trampoline - see my previous email.
> 
> > HJ did have patches to turn 'ret' into a form of retpoline, which I
> > don't think ever even got performance-tested.
> 
> Return instrumentation is possible as well, but there are two major drawbacks:
> 
>  - GCC support for it is not as widely available and return instrumentation is 
>    less tested in Linux kernel contexts
> 
>  - a major point of my suggestion is that CONFIG_DYNAMIC_FTRACE=y is already 
>    enabled in distros here and today, so the runtime overhead to non-SkyLake CPUs 
>    would be literally zero, while still allowing to fix the RSB vulnerability on 
>    SkyLake.

I played around with that a bit during the week and it turns out to be less
simple than you thought.

1) Injecting a trampoline return only works for functions which have all
   arguments in registers. For functions with arguments on stack like all
   varg functions this breaks because the function wont find its arguments
   anymore.

   I have not yet found a way to figure out reliably which functions have
   arguments on stack. That might be an option to simply ignore them.

   The workaround is to replace the original return on stack with the
   trampoline and store the original return in a per thread stack, which I
   implemented. But this sucks performance wise badly.

2) Doing the whole dance on function entry has a real down side because you
   refill RSB on every 15th return no matter whether its required or
   not. That really gives a very prominent performance hit.

An alternative idea is to do the following (not yet implemented):

__fentry__:
	incl	PER_CPU_VAR(call_depth)
	retq

and use -mfunction-return=thunk-extern which is available on retpoline
enabled compilers. That's a reasonable requirement because w/o retpoline
the whole SKL magic is pointless anyway.

-mfunction-return=thunk-extern issues

	jump	__x86_return_thunk

instead of ret. In the thunk we can do the whole shebang of mitigation.
That jump can be identified at build time and it can be patched into a ret
for unaffected CPUs. Ideally we do the patching at build time and only
patch the jump in when SKL is detected or paranoia requests it.

We could actually look into that for tracing as well. The only reason why
we don't do that is to select the ideal nop for the CPU the kernel runs on,
which obviously cannot be known at build time.

__x86_return_thunk would look like this:

__x86_return_thunk:
	testl	$0xf, PER_CPU_VAR(call_depth)
	jnz	1f	
	stuff_rsb
   1:
	decl	PER_CPU_VAR(call_depth)
   	ret

The call_depth variable would be reset on context switch.

Though that has another problem: tail calls. Tail calls will invoke the
__fentry__ call of the tail called function, which makes the call_depth
counter unbalanced. Tail calls can be prevented by using
-fno-optimize-sibling-calls, but that probably sucks as well.

Yet another possibility is to avoid the function entry and accouting magic
and use the generic gcc return thunk:

__x86_return_thunk:
	call L2
L1:
	pause
	lfence
	jmp L1
L2:
	lea 8(%rsp), %rsp|lea 4(%esp), %esp
	ret

which basically refills the RSB on every return. That can be inline or
extern, but in both cases we should be able to patch it out.

I have no idea how that affects performance, but it might be worthwhile to
experiment with that.

If nobody beats me to it, I'll play around with that some more after
vacation.

Thanks,

	tglx
--8323329-1739222675-1517769830=:1035--
