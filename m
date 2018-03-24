Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521880192; cv=none;
        d=google.com; s=arc-20160816;
        b=utKqtsk5gCfTyqdzuZX1xxqH0c5exTOf0SHmeZ/K4KO5nh4F6qYAi311mXmDocFSFx
         ups4ibO3AYqDIP4fvQszG6Rqspj9ugrpqoHRQnclAV5z9t/Nd3eq80snqgKcT9UauJcw
         5aOZYdEJKPOAotvwoaZzC28Sn09GCnts5kDbiekvPImXAx2JaTpL9NbfKu6XzW46v2dm
         pJd3YoXWLUpPxB0SKzPsebvXmk1mAUk1qHa+DNJIXj48AIZJe42npB81e0id+cODS1ss
         u79c/v4Syxuinsi9bD+TTwZdy/vfCVKVgQFszkQErqSnONx7cbQTshxH/ep7INsFIuC5
         Is0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=7YUIQS8P3QkIZOHVpNJUPvT8NJaHk45qOwaIUm6aNe4=;
        b=sTPr3sbSO4YEmt62DmiM0kXOrPwJNbNdXgkZtGRx5SbhQIEsliwtZGEiw89a/qfHwc
         g0BaHVik3ZXupOeLF5Z0qlAb0KCQW7vjXhhdlhNvMGpqnHXBCClmTOcb80eAeWgbVzTB
         aaL1kWuPXx3HEMwsF3iwexRevT2bQZ9Ajxoe6/rw7iGY4WhNrSM3RmQ1KW1Dn88DPWjN
         Uy1NkF0yoIWULN4bAOCnG3oBiOeHjXsNlH7ZzLMwqSUrqFK0nFUVwuZCJTF7UWFae3yr
         FuOxnG5s5YvhtzmhEpgAnO4CGMgqeiSvpB2McK6L0rji2jKfJj2BmcQOI3yWW3mPXkIO
         IhgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BOKmvSRe;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BOKmvSRe;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AG47ELtwqN6c3uVuKoE6BC56mRd9oawNBWOTko1tV5SXdzq/6ycvLSyvkyUX8v9OB9SoDIUuyPI+SQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 24 Mar 2018 09:29:47 +0100
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
Subject: Re: [RFC PATCH v2 11/15] khwasan, mm: perform untagged pointers
 comparison in krealloc
Message-ID: <20180324082947.3isostkpsjraefqt@gmail.com>
References: <cover.1521828273.git.andreyknvl@google.com>
 <6eb08c160ae23eb890bd937ddf8346ba211df09f.1521828274.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb08c160ae23eb890bd937ddf8346ba211df09f.1521828274.git.andreyknvl@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752716297382191?=
X-GMAIL-MSGID: =?utf-8?q?1595807044663980395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Andrey Konovalov <andreyknvl@google.com> wrote:

> The krealloc function checks where the same buffer was reused or a new one
> allocated by comparing kernel pointers. KHWASAN changes memory tag on the
> krealloc'ed chunk of memory and therefore also changes the pointer tag of
> the returned pointer. Therefore we need to perform comparison on untagged
> (with tags reset) pointers to check whether it's the same memory region or
> not.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/slab_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a33e61315ca6..5911f2194cf7 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1494,7 +1494,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
>  	}
>  
>  	ret = __do_krealloc(p, new_size, flags);
> -	if (ret && p != ret)
> +	if (ret && khwasan_reset_tag(p) != khwasan_reset_tag(ret))
>  		kfree(p);

Small nit:

If 'reset' here means an all zeroes tag (upper byte) then khwasan_clear_tag() 
might be a slightly easier to read primitive?

Thanks,

	Ingo
