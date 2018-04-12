Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523551537; cv=none;
        d=google.com; s=arc-20160816;
        b=IiyBWRyCg34UcZ2aCawyh2MdWPLUxBcMERSg2YafUth6yl/tolFUNRzxaZNEyR1xmS
         10Z7llGyZTc1B1zbkfjO+HeORYw3qQ8ZDywf7OguG4z9fmP/8Myu8l1Ycj8lBEVM5czO
         hfnU2x5I9PazF5WqQaGJH/fABs7qu0QOnAbm+OQlzr6hwgtHfZcVNu9zXJBbymKe++IG
         rnlPNPfsTwtq9wndoSN2XLs04YmT2Q0a3lR+/6mu9obZXSYwe/jLSe2R+Tym3ErfHA+G
         3EdfYNMlF+q8pqKwp/fLmLXJavB+UtrDSd3SOrvStzLGiC2voiDmWP0sYOTgJZifXJHp
         5Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=BWuFFzW/AWNYXx/wYN3ISaVq1gGToskm7usSBtUlJiQ=;
        b=A09Cgmwe9wwC88sgZCNAI84VWSD5VFqxKZxELpJHwSPNbE2xzoDReqW8tY/m/nhRNA
         +Dbg36AwxTW1zPIxIvI4CbkjPkvnBjk0y2vAV+nDHzL3zLWL7REqFkoNjiWkTkDrVeIe
         JjMVX8qp51t2SaP0VAS061L9ICa/Vuj0XoPiIYAEX+2OEqDQwhNFr8w2tcigWhejDWQs
         KQQaJNgFfC7srWbK3d1e2wv60wIVUqxMZn4/6f+82HWcUvzHLPeTlK1S5uFvwoxs0SSB
         haY4HyUUJp8pyr23dUxbQDTjPsQTfhZKEq5ZPmJDZUwvSe0xMxln8a4JNAWO2to1mpo3
         DZwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=lofft9Dm;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=lofft9Dm;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49w/bOQtJ0qaWDSRp1soJRLPSJuEJ5JGzwNwmg+Ni0jmzq+ID2ravZ3ZmvcKaGIw8PtITOvfNHO/AVDwbytSaw=
MIME-Version: 1.0
In-Reply-To: <bfc3da50-66df-c6ed-ad6a-a285efe617ec@virtuozzo.com>
References: <cover.1521828273.git.andreyknvl@google.com> <ba4a74ba1bc48dd66a3831143c3119d13c291fe3.1521828274.git.andreyknvl@google.com>
 <805d1e85-2d3c-2327-6e6c-f14a56dc0b67@virtuozzo.com> <CAAeHK+yg5ODeDy7k9fako5mcCLLnBrO729Zp_-UtDuzh3hZgZA@mail.gmail.com>
 <0c4397da-e231-0044-986f-b8468314be76@virtuozzo.com> <CAAeHK+xmCLe85_QNDam_BVTp9wVzjxgvko2+0JapJCzmciGa5g@mail.gmail.com>
 <0857f052-a27a-501e-8923-c6f31510e4fe@virtuozzo.com> <CAAeHK+xnHeznZwofNQVDcBCCMnaEQ6fcRxOcrFM-qQFUsZ51Rg@mail.gmail.com>
 <0f448799-3a06-a25d-d604-21db3e8577fc@virtuozzo.com> <CAAeHK+wWN=phNZgC_g5SMf61sCAVM7SGX9GdF1X4v+P3mK=uZA@mail.gmail.com>
 <bfc3da50-66df-c6ed-ad6a-a285efe617ec@virtuozzo.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 12 Apr 2018 18:45:35 +0200
Message-ID: <CAAeHK+wzwXnJh1bbhUN6bm788q52BA2EfC+Q3dMS=peP7Px4Rg@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1597559576890004262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 6:31 PM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
>
>
> On 04/10/2018 07:07 PM, Andrey Konovalov wrote:
>> On Fri, Apr 6, 2018 at 2:27 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>> On 04/06/2018 03:14 PM, Andrey Konovalov wrote:
>>>> On Thu, Apr 5, 2018 at 3:02 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>>>> Nevertheless, this doesn't mean that we should ignore *all* accesses to !slab memory.
>>>>
>>>> So you mean we need to find a way to ignore accesses via pointers
>>>> returned by page_address(), but still check accesses through all other
>>>> pointers tagged with 0xFF? I don't see an obvious way to do this. I'm
>>>> open to suggestions though.
>>>>
>>>
>>> I'm saying that we need to ignore accesses to slab objects if pointer
>>> to slab object obtained via page_address() + offset_in_page() trick, but don't ignore
>>> anything else.
>>>
>>> So, save tag somewhere in page struct and poison shadow with that tag. Make page_address() to
>>> return tagged address for all !PageSlab() pages. For PageSlab() pages page_address() should return
>>> 0xff tagged address, so we could ignore such accesses.
>>
>> Which pages do you mean by !PageSlab()?
>
> Literally the "PageSlab(page) == false" pages.
>
>> The ones that are allocated and freed by pagealloc, but mot managed by the slab allocator?
>
> Yes.
>
>> Perhaps we should then add tagging to the pagealloc hook instead?
>>
>
> Of course the tagging would be in kasan_alloc_pages(), where else that could be? And instead of what?

I think I misunderstood your suggestion twice already :)

To make it clear, you're suggesting:

1. Tag memory with a random tag in kasan_alloc_pages() and returned a
tagged pointer from pagealloc.

2. Restore the tag for the pointers returned from page_address for
!PageSlab() pages.

3. Set the tag to 0xff for the pointers returned from page_address for
PageSlab() pages.

Is this correct?

In 2 instead of storing the tag in page_struct, we can just recover it
from the shadow memory that corresponds to that page. What do you
think about this?
