Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523016844; cv=none;
        d=google.com; s=arc-20160816;
        b=0bt/2z3cc4bW5UZFv9eK4YOvk+MUMbxlMq3bc+Me5lEJMxG7euFEtckWHxYm9CZarr
         OpZIe9Nv78D2o0iGCYzxyttldM4cxBMgDFiEZFhAMfIs9eamhdotsq3JMQuCrfoFJYOe
         ExTbCXzrqlSrOy+2FkafXCW00y7lvdgWUi0B8MwMjTyr27YsI/ib7mgw/2ySo6EKeAwD
         49UqHK8SnT6P21IAtSGyBeJVVwGzx+6Hs9pBmKXuqAcXRQlwyDHpWUkfLGcxCrSGpxMJ
         5wLVMVaM1KsWKyeyDkcujBaemXQS9tE0nOrwvBpZcCneOGoTz80zlswYknEXtpuSXrSV
         RdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=JZvJp7WX90aOohXd2BywJ3RCKsz94zlrlmgflbXFn2M=;
        b=nsNdqJaXZj9anPnHSKQ8r5dEG4KEYet7kCtTAF8seFp9hs8xN+INLF1CgQW2zmEzty
         66T/Ms1kdBoTsHD0/SRsyVmwR9KdwjvCXPCXvRCunGrGBXHWS/+YsAEhLkeHvYj3JrSX
         etqdDeXJ29m3z0fQ53zJmmOzNGhDm2lqd7+9PG3LkV8D/Gg4g6DHODxK7eT6mE0a1k+B
         TJ+5epFye3ToJanmjHbZtgcgWLb7wZ3VjLiNXUbr8ReItSVYyEF2QsMmtLvOGRrpIJ/o
         fXzrwy7lFFeXq2PYgsKfbcIN9BAgZqlEc6CLvGDU1FPMN7VTBVC+hF7hv9ag40qJ3Hr6
         pvjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rFnjhO5f;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rFnjhO5f;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx492DmrLuKQ/phnW5yXAPKFSZ3J3tvh3BEsltH6wklXgf/lsGhIh/UWL9Mc85hEvre4lYYRmNRyUxpfF9LvvGTg=
MIME-Version: 1.0
In-Reply-To: <0857f052-a27a-501e-8923-c6f31510e4fe@virtuozzo.com>
References: <cover.1521828273.git.andreyknvl@google.com> <ba4a74ba1bc48dd66a3831143c3119d13c291fe3.1521828274.git.andreyknvl@google.com>
 <805d1e85-2d3c-2327-6e6c-f14a56dc0b67@virtuozzo.com> <CAAeHK+yg5ODeDy7k9fako5mcCLLnBrO729Zp_-UtDuzh3hZgZA@mail.gmail.com>
 <0c4397da-e231-0044-986f-b8468314be76@virtuozzo.com> <CAAeHK+xmCLe85_QNDam_BVTp9wVzjxgvko2+0JapJCzmciGa5g@mail.gmail.com>
 <0857f052-a27a-501e-8923-c6f31510e4fe@virtuozzo.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 6 Apr 2018 14:14:03 +0200
Message-ID: <CAAeHK+xnHeznZwofNQVDcBCCMnaEQ6fcRxOcrFM-qQFUsZ51Rg@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1596998911006264811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 3:02 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> On 04/04/2018 08:00 PM, Andrey Konovalov wrote:
>> On Wed, Apr 4, 2018 at 2:39 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>>>>
>>>>> You can save tag somewhere in page struct and make page_address() return tagged address.
>>>>>
>>>>> I'm not sure it might be even possible to squeeze the tag into page->flags on some configurations,
>>>>> see include/linux/page-flags-layout.h
>>>>
>>>> One page can contain multiple objects with different tags, so we would
>>>> need to save the tag for each of them.
>>>
>>> What do you mean? Slab page? The per-page tag is needed only for !PageSlab pages.
>>> For slab pages we have kmalloc/kmem_cache_alloc() which already return properly tagged address.
>>>
>>> But the page allocator returns a pointer to struct page. One has to call page_address(page)
>>> to use that page. Returning 'ignore-me'-tagged address from page_address() makes the whole
>>> class of bugs invisible to KHWASAN. This is a serious downside comparing to classic KASAN which can
>>> detect missuses of page allocator API.
>>
>> Yes, slab page. Here's an example:
>>
>> 1. do_get_write_access() allocates frozen_buffer with jbd2_alloc,
>> which calls kmem_cache_alloc, and then saves the result to
>> jh->b_frozen_data.
>>
>> 2. jbd2_journal_write_metadata_buffer() takes the value of
>> jh_in->b_frozen_data and calls virt_to_page() (and offset_in_page())
>> on it.
>>
>> 3. jbd2_journal_write_metadata_buffer() then calls kmap_atomic(),
>> which calls page_address(), on the resulting page address.
>>
>> The tag gets erased. The page belongs to slab and can contain multiple
>> objects with different tags.
>>
>
> I see. Ideally that kind of problem should be fixed by reworking/redesigning such code,
> however jbd2_journal_write_metadata_buffer() is far from the only place which
> does that trick. Fixing all of them would be a huge task probably, so ignoring such
> accesses seems to be the only choice we have.
>
> Nevertheless, this doesn't mean that we should ignore *all* accesses to !slab memory.

So you mean we need to find a way to ignore accesses via pointers
returned by page_address(), but still check accesses through all other
pointers tagged with 0xFF? I don't see an obvious way to do this. I'm
open to suggestions though.
