Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522766730; cv=none;
        d=google.com; s=arc-20160816;
        b=Fp1f1jzagx9EPBYGr0JzMyrC9i/hAyaxQsbBgXPzgWWmGsGCcxUYwxl4GDoDJsonD0
         ImfySleXiI+9GiFs9FqGmkCZJv2+dsJuZAVLaAVdJswrwnjr36QLKuGwQt6ttY+k4/8H
         9e1K9nkVPP1+VPIKyBWlHyA0hWbyY8cUpBaik51bhKRmmx6y8T2zRjKfGPfrc0w3CIFP
         UlFnXvaxgYiGcsQAmz/Jyl3Ksq/vg+pwhY4i5GVOaqN/ZuRMMEwYUpXCbaTyEGPEfN5n
         V9k34MN5Q+QQAobTspWmzQSk5Gq8RamBPxA4CGjoGX5WEQCa/8DG0EDAzG/2bcLduM9l
         97fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1a5oEW7isbL9XxyI+mp4Xx36o7kfKeWwd9hU7nPOHUU=;
        b=MUm8a9I9kvbsm8OPOqGmvarckmwzEVqinNdfB7m1QvL0g2oiRADkAxw+sjgu47cxp5
         D8SLRaEvnLly0Rr0N8IwlWWN8wPfrVZRbXqRGBEnwv+Pxs3tJ9QsxuRg6q1socKSzGgH
         q2rYXb/9m4JIhDMbjR+5MRvJ/kDBRDhWxkIr+GiyE5dnNkbBeqhSlkBFtulVs2hD7hwT
         jkuJzvlX0oKBK+tc06ivC1s5a0ur2EfShFYyD39MuLhX9zoDl192LTnc6A870MGVgmYF
         7sQHIm7SOV9Lhl0KTnUfJxslhs74qLDVNf/3f8uwV95cHw4cJk8hmf6lvzl4gFLOIs5s
         kufQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=qUwoasuI;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=qUwoasuI;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48lwj2dfhG/pq/WQ7FjG8z4+mOcp7YpthP/LkiN15DAJG04UiHySYY963O6dVxKddJgVP/e0jmtk7oMiWEj2MA=
MIME-Version: 1.0
In-Reply-To: <a724eee6-7aff-df8b-de2b-8e9446e94623@virtuozzo.com>
References: <cover.1521828273.git.andreyknvl@google.com> <b79947167d09478d3f61d2ec8de37322c0e1fe92.1521828274.git.andreyknvl@google.com>
 <a724eee6-7aff-df8b-de2b-8e9446e94623@virtuozzo.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 3 Apr 2018 16:45:26 +0200
Message-ID: <CAAeHK+w9T8dTKP8tuw+B2MojvzRE6YQ1=O1FddZA62cYaeLV2g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/15] khwasan: add tag related helper functions
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Christopher Li <sparse@chrisli.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, Michael Weiser <michael.weiser@gmx.de>,
	James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry@arm.com>,
	Steve Capper <steve.capper@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw@amazon.co.uk>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>, Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	kasan-dev <kasan-dev@googlegroups.com>, linux-doc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, kvmarm@lists.cs.columbia.edu,
	linux-sparse@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook <keescook@google.com>,
	Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752710383893280?=
X-GMAIL-MSGID: =?utf-8?q?1596736647149717567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 6:13 PM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
>
>
> On 03/23/2018 09:05 PM, Andrey Konovalov wrote:
>
>> diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
>> index 24d75245e9d0..da4b17997c71 100644
>> --- a/mm/kasan/khwasan.c
>> +++ b/mm/kasan/khwasan.c
>> @@ -39,6 +39,57 @@
>>  #include "kasan.h"
>>  #include "../slab.h"
>>
>> +int khwasan_enabled;
>
> This is not unused (set, but never used).

It's used in the "khwasan: add hooks implementation" patch. I'll move
it's declaration there as well.

Thanks!

>
>> +
>> +static DEFINE_PER_CPU(u32, prng_state);
>> +
>> +void khwasan_init(void)
>> +{
>> +     int cpu;
>> +
>> +     for_each_possible_cpu(cpu) {
>> +             per_cpu(prng_state, cpu) = get_random_u32();
>> +     }
>> +     WRITE_ONCE(khwasan_enabled, 1);
>> +}
>> +
>
