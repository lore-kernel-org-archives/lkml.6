Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522180915; cv=none;
        d=google.com; s=arc-20160816;
        b=b2roH56MbtDpi04P23lgpkFTTJmjyppAUo2BqxQkM98vtqu/Y+n5ndSitGMoMVt7ce
         Mmh2BQKrBQrYbo376aTS2UTBzaHK+GOUxA6IRRMjw/IYT4MmBtXKgecRCRLc2uoIjM2U
         6T61RRMRJvtLS2r+rubXmbcMoeCjHm1UxM/8vMVqb/kshMK9Hh4k1vRZq6FyU3zblOUx
         B23J/5e3h2bV/ierxlreA6WaBP42fjZtcRFchfRNhM6GBtHnt0IsTPEQJje754p5zjq8
         S1LXrdGFTI9OsYTfillDCXtGzNOAX49yVCLeripbJV7YXkncyuuY/prPcaDm2E18iLlT
         YbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=/LoTDexebbi6dH3gMc+gm/0313rhfVyxqs24BOlqumA=;
        b=lNjv657eDJcbLqNWfvLfnCIz33mioSFrniCocI9VeTm/u3skgyBn0JTBWPtiDhlw1B
         aTHM0GJZ9G01rDZmj9Z0aBEL3hA1ZkD4Rcc5ygrlU8gvWXCSkVG8XJmlHQ7j6xoxEb9l
         tDK5dD6R3xtsZvHjOy3tGmplI0UTCaGX0QAiefKXpyJGR/J4cNSzTMZ1ERrU5fnvvKAh
         xq84wslRVvHl6TBPhq4HdUL61DWjLKOtNebV9WyqPIjthx0jRXyIt5lE2aV5NmEhlRxi
         lB7/jaTP13TgnZIOsX4t+oJbTlGXNN0xSnokjAPuWD4ySrYZpBFJyUGm5KMl5IRvWMWL
         xFsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tqpm2/8o;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tqpm2/8o;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AIpwx4/9kY3JcIIVb7/WKuinBhXIWE6ysI/5CS6xzgm4YIsA6Ad7kKVqgmJUPVID1uskWgf8iRnJHA==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 27 Mar 2018 22:01:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Christopher Li <sparse@chrisli.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Michael Weiser <michael.weiser@gmx.de>,
	James Morse <james.morse@arm.com>,
	Julien Thierry <julien.thierry@arm.com>,
	Steve Capper <steve.capper@arm.com>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Lawrence <paullawrence@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	kasan-dev <kasan-dev@googlegroups.com>, linux-doc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	kvmarm@lists.cs.columbia.edu, linux-sparse@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Kees Cook <keescook@google.com>, Jann Horn <jannh@google.com>,
	Mark Brand <markbrand@google.com>
Subject: Re: [RFC PATCH v2 11/15] khwasan, mm: perform untagged pointers
 comparison in krealloc
Message-ID: <20180327200150.cadizr7wsfjnfta7@gmail.com>
References: <cover.1521828273.git.andreyknvl@google.com>
 <6eb08c160ae23eb890bd937ddf8346ba211df09f.1521828274.git.andreyknvl@google.com>
 <20180324082947.3isostkpsjraefqt@gmail.com>
 <CAAeHK+xUBOt0hh-r5JhjVFcjYDOOyjUKGeN8OxSfnMpOnaWvFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xUBOt0hh-r5JhjVFcjYDOOyjUKGeN8OxSfnMpOnaWvFQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752716297382191?=
X-GMAIL-MSGID: =?utf-8?q?1596122376031377916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Andrey Konovalov <andreyknvl@google.com> wrote:

> On Sat, Mar 24, 2018 at 9:29 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> >> The krealloc function checks where the same buffer was reused or a new one
> >> allocated by comparing kernel pointers. KHWASAN changes memory tag on the
> >> krealloc'ed chunk of memory and therefore also changes the pointer tag of
> >> the returned pointer. Therefore we need to perform comparison on untagged
> >> (with tags reset) pointers to check whether it's the same memory region or
> >> not.
> >>
> >> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >> ---
> >>  mm/slab_common.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index a33e61315ca6..5911f2194cf7 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -1494,7 +1494,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
> >>       }
> >>
> >>       ret = __do_krealloc(p, new_size, flags);
> >> -     if (ret && p != ret)
> >> +     if (ret && khwasan_reset_tag(p) != khwasan_reset_tag(ret))
> >>               kfree(p);
> >
> > Small nit:
> >
> > If 'reset' here means an all zeroes tag (upper byte) then khwasan_clear_tag()
> > might be a slightly easier to read primitive?
> 
> 'Reset' means to set the upper byte to the value that is native for
> kernel pointers, and that is 0xFF. So it sets the tag to all ones, not
> all zeroes. I can still rename it to khwasan_clear_tag(), if you think
> that makes sense in this case as well.

Ok, if it's not 0 then I agree that 'reset' is the better name. 'clear' would in 
fact be actively confusing.

Thanks,

	Ingo
