Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523376461; cv=none;
        d=google.com; s=arc-20160816;
        b=ijymV0Ch+mepJ/Wpcdc0hSWV43ddCI7VO3MGDhIEt3KbNOTp9sPQ8PQrB/l+sQXFQ4
         6r1j/D31hRrQrib/MiKm7/BrsW+XkpUnqKJx/N2nB9Fezpu2H2CNDPRIuGFod6yTiGPM
         EFIvrcLfS+chA/BrLrutBGALcRId7AZka9IQm7I3K+oeVjHtopOptPm9jjggXfw7HQfu
         uwdyzuBYlt30x/hMSX2N3cIt40pDtW03i+HDkEG9aaKLI14mAH/aOfOTUGa8IDv+6TJM
         hGyYZ6YH52oa2YLOe7StQKY59oUwWEQ9Q8WIT0Ib8KvL8fmZmalByO7YLTCepNwP780+
         1obA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yC8KBxVM+HMrnayel8NIMWofWn4JG57aZ9j7A87WzMk=;
        b=XqAFVKINPS+GY6HQiRPkfwQ57hfmG6spKJ8EcW7/Q7OnKBrRDyJ/zter6ngpmt8n/N
         rmcK303xbbFheZ3QLdyyAVxgHFx1puC10usbom0kSkQu0UL5Ns/BAFTyC6Fhn/Khichp
         xxrh0nZpjp9+ZUvQa+nyLVc7aZjT/BzL4pWVAE9cFxL6EeEk5qLW6zTyoU1fg2Kf/5Te
         cQAhstOGzkBAErRRwXiVW7r4S2o+5zphksWMdVbvPK/m9hPbfuWl35FRok+y1gPcXqhU
         uKK+ZFLzHdYeGQdJzB2Wv9lFRBXMVcmKMYLbI6VZDs2KKt7XH3U2T+CcBUZ3T/K2SkIF
         1EFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=anK8Lkc+;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=anK8Lkc+;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48yfYgoeB8mf3Smh7K3Xkdevn4FCgwg2OOlGRvAuNIDA1g4xmoOFAwkm3aPBDRhEyOIT4DD1XMDnPKg2dLXm6Q=
MIME-Version: 1.0
In-Reply-To: <0f448799-3a06-a25d-d604-21db3e8577fc@virtuozzo.com>
References: <cover.1521828273.git.andreyknvl@google.com> <ba4a74ba1bc48dd66a3831143c3119d13c291fe3.1521828274.git.andreyknvl@google.com>
 <805d1e85-2d3c-2327-6e6c-f14a56dc0b67@virtuozzo.com> <CAAeHK+yg5ODeDy7k9fako5mcCLLnBrO729Zp_-UtDuzh3hZgZA@mail.gmail.com>
 <0c4397da-e231-0044-986f-b8468314be76@virtuozzo.com> <CAAeHK+xmCLe85_QNDam_BVTp9wVzjxgvko2+0JapJCzmciGa5g@mail.gmail.com>
 <0857f052-a27a-501e-8923-c6f31510e4fe@virtuozzo.com> <CAAeHK+xnHeznZwofNQVDcBCCMnaEQ6fcRxOcrFM-qQFUsZ51Rg@mail.gmail.com>
 <0f448799-3a06-a25d-d604-21db3e8577fc@virtuozzo.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 10 Apr 2018 18:07:39 +0200
Message-ID: <CAAeHK+wWN=phNZgC_g5SMf61sCAVM7SGX9GdF1X4v+P3mK=uZA@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1597375995779829896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 6, 2018 at 2:27 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> On 04/06/2018 03:14 PM, Andrey Konovalov wrote:
>> On Thu, Apr 5, 2018 at 3:02 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>> Nevertheless, this doesn't mean that we should ignore *all* accesses to !slab memory.
>>
>> So you mean we need to find a way to ignore accesses via pointers
>> returned by page_address(), but still check accesses through all other
>> pointers tagged with 0xFF? I don't see an obvious way to do this. I'm
>> open to suggestions though.
>>
>
> I'm saying that we need to ignore accesses to slab objects if pointer
> to slab object obtained via page_address() + offset_in_page() trick, but don't ignore
> anything else.
>
> So, save tag somewhere in page struct and poison shadow with that tag. Make page_address() to
> return tagged address for all !PageSlab() pages. For PageSlab() pages page_address() should return
> 0xff tagged address, so we could ignore such accesses.

Which pages do you mean by !PageSlab()? The ones that are allocated
and freed by pagealloc, but mot managed by the slab allocator? Perhaps
we should then add tagging to the pagealloc hook instead?
