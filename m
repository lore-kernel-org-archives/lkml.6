Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523554649; cv=none;
        d=google.com; s=arc-20160816;
        b=ULRiz664peExAVm7nGIBWPDJajuOHPBdbC6WjDbDKseV+CaM525soGopt5a1zgRg6m
         XOm1hOUqrloo2PQ52aPo0lFK+dYYTtygzWvW1anM28khS+6ZgjuvwOwErp8fKzEtYWF/
         BCYpK2+n3bqO8anEdDZJj82cbT911U+nPXQCnGL5ksruTx++8dg6wYckdRXil/zLjRk2
         4liCCCaTfU5yrATkMIw4sSQ9qjhagUj8n2YublIA4QpYG/A3s4TvyMfKvvSc+oMkWmFC
         WSC2Jl2oDPAZqh9vCrBqZfp1+EioyehYQtKzCjgh9/rl5l1IoUARpzoigqCqxuSp7b7+
         /Vog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=aRGQiPOQ2Ax/mA+iYWZKVjMuBtc+gZ+7DZAIk3VKTnY=;
        b=o9tb+AkdRDhk/5u6NZ4qu5FO0XGoi18aUaEbOZj89l8DKjVrwesW/R8gZ94vSrKeti
         YgLJHD/YhhdgdIYo5zDonjsu+n28+SZ8UV/4/BqoO8vZb7id3fTY2ozR+yddP3W5JnP3
         KzfH6Wcujg3r9fumPngbc6kjK3FW8wmrvUaNqGFY/0UfJFQqBukeIc0AwmUNjvUxNUTh
         YcJKUOWPXTB2Fiem/Uv3MwDFEEZpTViVxPtDS9+ahsXfSzkFT8Pz4yAn4bLb1jjmeHbv
         vcPfCwIJE4aAoTAjcKH/md6QXNr1G82DcgThoWmgkuU0BRB/T56GrowhietFSVQ8IV5H
         WBeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=K2UGWBaI;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=K2UGWBaI;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48wKoUx1qfFqkZlw/IoUgdbuMp9D+PRPlSB2wIYarrDreVm9Go0bVYO86/x4Qrp1fWrHfobk9dLyyLC0cf9I3U=
MIME-Version: 1.0
In-Reply-To: <a29d22c7-bcae-ec8d-1810-95eef013e699@virtuozzo.com>
References: <cover.1521828273.git.andreyknvl@google.com> <ba4a74ba1bc48dd66a3831143c3119d13c291fe3.1521828274.git.andreyknvl@google.com>
 <805d1e85-2d3c-2327-6e6c-f14a56dc0b67@virtuozzo.com> <CAAeHK+yg5ODeDy7k9fako5mcCLLnBrO729Zp_-UtDuzh3hZgZA@mail.gmail.com>
 <0c4397da-e231-0044-986f-b8468314be76@virtuozzo.com> <CAAeHK+xmCLe85_QNDam_BVTp9wVzjxgvko2+0JapJCzmciGa5g@mail.gmail.com>
 <0857f052-a27a-501e-8923-c6f31510e4fe@virtuozzo.com> <CAAeHK+xnHeznZwofNQVDcBCCMnaEQ6fcRxOcrFM-qQFUsZ51Rg@mail.gmail.com>
 <0f448799-3a06-a25d-d604-21db3e8577fc@virtuozzo.com> <CAAeHK+wWN=phNZgC_g5SMf61sCAVM7SGX9GdF1X4v+P3mK=uZA@mail.gmail.com>
 <bfc3da50-66df-c6ed-ad6a-a285efe617ec@virtuozzo.com> <CAAeHK+wzwXnJh1bbhUN6bm788q52BA2EfC+Q3dMS=peP7Px4Rg@mail.gmail.com>
 <a29d22c7-bcae-ec8d-1810-95eef013e699@virtuozzo.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 12 Apr 2018 19:37:27 +0200
Message-ID: <CAAeHK+w1f4QSuan4onv-2ZxxSsi-ZYsdPOSuJ4=2ygJ2=q=VmA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/15] khwasan: add hooks implementation
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
X-GMAIL-THRID: =?utf-8?q?1595752721075121286?=
X-GMAIL-MSGID: =?utf-8?q?1597562840542616775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 7:20 PM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
>> 1. Tag memory with a random tag in kasan_alloc_pages() and returned a
>> tagged pointer from pagealloc.
>
> Tag memory with a random tag in kasan_alloc_pages() and store that tag in page struct (that part is also in kasan_alloc_pages()).
> page_address(page) will retrieve that tag from struct page to return tagged address.
>
> I've no idea what do you mean by "returning a tagged pointer from pagealloc".
> Once again, the page allocator (__alloc_pages_nodemask()) returns pointer to *struct page*,
> not the address in the linear mapping where is that page mapped (or not mapped at all if this is highmem).
> One have to call page_address()/kmap() to use that page.

Ah, that's what I've been missing.

OK, I'll do that.

Thanks!

>
>
>> 2. Restore the tag for the pointers returned from page_address for
>> !PageSlab() pages.
>>
>
> Right.
>
>> 3. Set the tag to 0xff for the pointers returned from page_address for
>> PageSlab() pages.
>>
>
> Right.
>
>> Is this correct?
>>
>> In 2 instead of storing the tag in page_struct, we can just recover it
>> from the shadow memory that corresponds to that page. What do you
>> think about this?
>
> Sounds ok. Don't see any problem with that.
>
>
