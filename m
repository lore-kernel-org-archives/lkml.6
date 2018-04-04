Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522878400; cv=none;
        d=google.com; s=arc-20160816;
        b=DsWUjzT7DLFAr1nA7lrOJ408sOOy7tyUtHXLEtIFJ3ZPk1PdTqZp6YGwh2btBj5xdt
         aczMwd8zQm6IpLKf9clCub5X9JgzapvespTVS26QONoSqtwgUZ3jXJcXAsp9sxoI0xdZ
         4gscRn5MLAbwTsPzLSRF8WBTI/5t9K5XN/AAgii31XpuXEGzMJeNTaJ9keWYmb0hPSwA
         rn95zn9LvqJs4E0RB7f9+czFm228Tq0rKPYHBFoZQZ4yKhT1ipQQ0eK/ncqtOPNqYfcg
         LubBOTREYG7GkWS9o96DRdj8adlZcPDXFNmiKvYy7vdJHQDELPH4m8p2zvl6NaWWRw+/
         0K8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=1EaGTkdUmFCVcy8uZwcgcgIvfropc2FOCPsVeUJOhGU=;
        b=JDo377Qo8eyVAOoKSAMUeUq26dikWTyWH6hITmbXFqe+fs0a3DKa07/gwOgv/Y+KK2
         Qv4dVvrfo9J7u6jNI/Z4xYpzWMg5irDvS9P0sSpoGJkQiMX6x8HconZs0Rq9m9scEVK1
         6U8Vi585L1wN8bjIN9fyzipE4e+1TYMIifP2XMOOQoGFLZ7I1pbd1607u25IawJwzzNg
         5z6smtj3h6ajk15BKp0NukzkBFLt/OTmRBhvWOkfQ9gh6M2NSG8/CjSzJmFQOzFKI0JV
         CPD8YC+dOIq0WNEKAiXKEce0gfj8O4lMwtTaFcmZjslTu3bPSy2oruxGqsyNlPUkcYv9
         78pg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=n5q/A297;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=n5q/A297;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx48aiDHYo9HUDZN9JAGmbfknLi+DMPAZboRwvO5vlSG6CwsKlyKSmOSoVk+akkN+pH7Gum+HJw==
Date: Wed, 4 Apr 2018 14:46:39 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20180404214639.GH87376@google.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
 <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com>
 <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com>
 <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596853742068422702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Wed, Apr 04, 2018 at 11:11:36PM +0200 Arnd Bergmann ha dit:

> On Wed, Apr 4, 2018 at 10:58 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > El Wed, Apr 04, 2018 at 10:33:19PM +0200 Arnd Bergmann ha dit:
> >>
> >> In most cases, this is used to implement a fast-path for a helper
> >> function, so not doing it the same way as gcc just results in
> >> slower execution, but I assume we also have code that behaves
> >> differently on clang compared to gcc because of this.
> >
> > I think I didn't come (knowingly) across that one yet. Could you point
> > me to an instance that could be used as an example in a bug report?
> 
> This code
> 
> #include <linux/math64.h>
> int f(u64 u)
> {
>         return div_u64(u, 100000);
> }
> 
> results in a call to __do_div64() on 32-bit arm using clang, but
> gets optimized into a set of multiply+shift on gcc.

I understand this is annoying, but it seems I'm missing something:

static inline u64 div_u64(u64 dividend, u32 divisor)
{
        u32 remainder;
        return div_u64_rem(dividend, divisor, &remainder);
}

static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
{
        *remainder = do_div(dividend, divisor);
        return dividend;
}

#define do_div(n, base) __div64_32(&(n), base)

static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
{
        register unsigned int __base      asm("r4") = base;
        register unsigned long long __n   asm("r0") = *n;
        register unsigned long long __res asm("r2");
        register unsigned int __rem       asm(__xh);
        asm(    __asmeq("%0", __xh)
                __asmeq("%1", "r2")
                __asmeq("%2", "r0")
                __asmeq("%3", "r4")
                "bl     __do_div64"
                : "=r" (__rem), "=r" (__res)
                : "r" (__n), "r" (__base)
                : "ip", "lr", "cc");
        *n = __res;
        return __rem;
}

There is no reference to __builtin_constant_p(), could you elaborate?

Also you mentioned there are plenty of cases, maybe there is a more
straightforward one?

In any case it seems this derails a bit from the original topic of the
thread. Shall we take this offline?
