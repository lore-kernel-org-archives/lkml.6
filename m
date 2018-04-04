Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522884673; cv=none;
        d=google.com; s=arc-20160816;
        b=TkYh7gErxzDv+kg/3rPlg8vBMzb4SinAn51/qk/rhnJOmMrWmzvu265kF8bZsTC52a
         VuLi6ulO2Ry1YNehjgBRpsIKpk4/jYC36u2nuu3CpRxQOE28lrOvoPCa27bNGclS6fzV
         ml6Zz05qkMVMW+N9iQrfyrUePeQWjOHKpa4jZl778WfRFrA4Y2Ukpstt02JB9xVBgVlM
         46O8QawFsZz61kmhXBhxPlcfDrNBWQXhOeJFB4LkQ2SvIrqqVITlafYgpkR45dbnXbvk
         wkaBAH9Qgd5Caq2tkCiPzHPO5YgFgs1cjc1huO4faCawFRsMdpen30TOpLFepm7vrEin
         zlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=xZYemq29u5B+gAFxsw3Ymxj7k59Ku5Ez8ervLqXRmgM=;
        b=0b3ELtyZJxhU1tACJDVGEJCK5q6kqBiXOCCZplI0/aqCmKEImgoQsl/2zHjcLH0CUS
         tcu+3O1SxQyfatRLgfzA3iVd0kpZG/0PFw5gf2hr0H8a1WYH9ab4YGHo1YBaUAyiiHD9
         CtVPeMhKxhvKIPkUOVQsf8VQwoiPs1EtvUFLLExnigruWM5BhVLkmKY7vwaGF7EkX4HH
         oO4JwZWIVllpmW7DS88r5sQywqnYsHaAcFD0Yfsm8lo+32KuZHjqgiqwio26KayAhvdI
         BtNinJzVPejheZDqcU1+Xpo5xYtBZ0aqm/UoytiM1WCZ1WYJUGuzLbe69prcCE9H9X56
         9Ywg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Z2heRo/+;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Z2heRo/+;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4/YbvkkkwS426oH8owlvpHek9gFI2wAKzHCRNPHS5MX8DpV0O0/oadBk877o339+fq/c8cpOg==
Date: Wed, 4 Apr 2018 16:31:11 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>,
	Guenter Roeck <groeck@chromium.org>,
	Greg Hackmann <ghackmann@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180404233111.GJ87376@google.com>
References: <20180403180658.GE87376@google.com>
 <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com>
 <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com>
 <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com>
 <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com>
 <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596860319255202445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Wed, Apr 04, 2018 at 03:39:24PM -0700 Linus Torvalds ha dit:

> On Wed, Apr 4, 2018 at 3:17 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Getting our compiler team high to look into this might affect a timely
> > (and correct ...) implementation of asm-goto and others important
> > features. Arnd, do you have another, preferably simple instance to
> > keep our compiler folks (halfway) sane?
> 
> I don't know if clang actually already gets this right or not, but as
> an example of a case where we have a semantic difference between "is
> this a constant or not", a much simpler case is in
> 
>  - arch/x86/include/asm/uaccess.h:
> 
>   /*
>    * Test whether a block of memory is a valid user space address.
>    * Returns 0 if the range is valid, nonzero otherwise.
>    */
>   static inline bool __chk_range_not_ok(unsigned long addr, unsigned
> long size, unsigned long limit)
>   {
>         /*
>          * If we have used "sizeof()" for the size,
>          * we know it won't overflow the limit (but
>          * it might overflow the 'addr', so it's
>          * important to subtract the size from the
>          * limit, not add it to the address).
>          */
>         if (__builtin_constant_p(size))
>                 return unlikely(addr > limit - size);
> 
>         /* Arbitrary sizes? Be careful about overflow */
>         addr += size;
>         if (unlikely(addr < size))
>                 return true;
>         return unlikely(addr > limit);
>   }
> 
> where the actual check itself is simplified for the constant size case
> (because we know that constant sizes are never going to have the
> overflow issue with the address size limit)
> 
> That inline function itself is then wrapped with a couple of macros,
> and the usual use-case is through "access_ok()", which then typically
> just gets either a sizeof(), or a non-constant length.
> 
> Of course, we've been walking away from having people do "access_ok()
> + __copy_from_user()" (the latter does some conceptually similar
> optimizations on constant sizes), so those probably simply don't
> matter much any more in practice.
> 
> But they are certainly a lot simpler to look at than the more exciting
> 32-bit asm-generic "do_div()" case is ;)

Thanks, that was useful!

>From some experiments it looks like clang, in difference to gcc, does
not treat constant values passed as parameters to inline function as
constants.

I'll ask our compiler folks to take a look, with lower priority than
other issues in this thread though.
