Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521881017; cv=none;
        d=google.com; s=arc-20160816;
        b=zMaJNUOB8TkmhsEp15uUyIfORemBm+hjGKB3q0mbLRCX8CblnATpa5aLgxInxxSscR
         1dg28t7lo2Krt55GXW+57EHbFfPiRwiwXcs4HdOjDOphddf82v+3XdtP8OQ5Mfa9FGHV
         uHGbNGvNcGz9yRl05b6xTogXMAWfK8PhRyTrTPb8BhK7yhlKZMt9TYww2+vbaEiGggoF
         1ITWCCPjQtyEsRL+GPOW+8vRu8hkm6j5cHtbbD5kwtKF8zQlRl10R21jIuHeTWoPZOS8
         TF4j9koQ90IQ0vaQBQ65eOQQvERfI7wng6NodRr503vd0vwZ7Itk/gTLV5Mjh6gSSr6p
         SwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=XHNqgIDW4VvH9alZZa9LCvq2uQWSEjdxQflfUZUorTs=;
        b=SQsOl6C1zDzcnkp7i+YDTBuyOlip5AzPVi6Hn0X0Kz3EDmWKZDPewTND2UQm32lHa5
         PVQgicLsuxBt8W2U/Y74xB+nw/leDXV8+QlUjH0Ctle/6RKiIbafkG6xYYX9Lm5K53Pv
         2FQ0lAzTRW2DtXVds8q8LXAOJzsezjEiXieP7vEwfF9j+yNxjzp1gu5pXT/2Tv3KJhB2
         N8ZC6UmaDH3siQMY7vFjIFEhNZy6ue6Rw4YIulunae+pTwffGJ977PqqK+cMhlR6EE7Z
         EGZSgVrEWZZt8DduBVniHWQgZG2QUhcfOtpVI2yEbRlCG8LQ3H01EFoormD656mbCqhf
         ps7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JXzsxAqU;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JXzsxAqU;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AG47ELsSur18aIC56JpQC55s7Coif38EDBdBSyRwp9VujCGZaa3Y5hQ4ZcAVSKKo876IHe+cUfgXOQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 24 Mar 2018 09:43:32 +0100
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
	Stephen Boyd <stephen.boyd@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Lawrence <paullawrence@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu, linux-sparse@vger.kernel.org,
	linux-mm@kvack.org, linux-kbuild@vger.kernel.org,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Kees Cook <keescook@google.com>, Jann Horn <jannh@google.com>,
	Mark Brand <markbrand@google.com>
Subject: Re: [RFC PATCH v2 03/15] khwasan: add CONFIG_KASAN_CLASSIC and
 CONFIG_KASAN_TAGS
Message-ID: <20180324084332.u6qik7lkdbenqbb2@gmail.com>
References: <cover.1521828273.git.andreyknvl@google.com>
 <1fb0a050a84d49f5c3b2210337339412475d1688.1521828273.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fb0a050a84d49f5c3b2210337339412475d1688.1521828273.git.andreyknvl@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752701351251910?=
X-GMAIL-MSGID: =?utf-8?q?1595807910041919510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Andrey Konovalov <andreyknvl@google.com> wrote:

> This commit splits the current CONFIG_KASAN config option into two:
> 1. CONFIG_KASAN_CLASSIC, that enables the classic KASAN version (the one
>    that exists now);
> 2. CONFIG_KASAN_TAGS, that enables KHWASAN.

Sorry, but this is pretty obscure naming scheme that doesn't explain the primary 
difference between these KASAN models to users: that the first one is a pure 
software implementation and the other is hardware-assisted.

Reminds me of the transparency of galactic buerocracy in "The Hitchhiker's Guide 
to the Galaxy":

  “But look, you found the notice, didn’t you?”
  “Yes,” said Arthur, “yes I did. It was on display in the bottom of a locked filing 
   cabinet stuck in a disused lavatory with a sign on the door saying ‘Beware of the 
   Leopard.” 

I'd suggest something more expressive, such as:

	CONFIG_KASAN
	  CONFIG_KASAN_GENERIC
	  CONFIG_KASAN_HW_ASSIST

or so?

The 'generic' variant will basically run on any CPU. The 'hardware assisted' one 
needs support from the CPU.

The following ones might also work:

   CONFIG_KASAN_HWASSIST
   CONFIG_KASAN_HW_TAGS
   CONFIG_KASAN_HWTAGS

... or simply CONFIG_KASAN_SW/CONFIG_KASAN_HW.

If other types of KASAN hardware acceleration are implemented in the future then 
the CONFIG_KASAN_HW namespace can be extended:

	CONFIG_KASAN_HW_TAGS
	CONFIG_KASAN_HW_KEYS
	etc.

> Both CONFIG_KASAN_CLASSIC and CONFIG_KASAN_CLASSIC support both
> CONFIG_KASAN_INLINE and CONFIG_KASAN_OUTLINE instrumentation modes.

It would be very surprising if that wasn't so!

Or did you mean 'Both CONFIG_KASAN_CLASSIC and CONFIG_KASAN_TAGS'! ;-)

Thanks,

	Ingo
