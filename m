Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521449049; cv=none;
        d=google.com; s=arc-20160816;
        b=UqVmQ6rTEvBzJV2Sed5DfkfINH++ND0EjgJB0zl+2OBPDNqz2fylvQqbSxvUBYIAaf
         +1cFMiRi8LeJ0GsYTClUy7B6g5EHj3t23tOqfSVCHmRUyhch0eb9s32tY64zFPATANeG
         T5fNrTyCbKmceRjPKeZCR/vmvUFSO/HnKVAsCOiUFvMaa3yehnXiCZSZ0o55iZI57zkF
         +enQ8XiXEPjYsW/eaJd99JJGUyTwC+aUYE7wi1os0XPtzPk2373Kn0kI1tldo9lCL+qs
         itYOUl+CaOPykJTFjjkHHEIuIJsNltmKwoaiLrydg5i/PXhBFx0UduhMfI0RAc3xq1D2
         zI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ncdqQWzLPvuKVyXjgJeeqCXTdHfM6CE0gfYP62NNm8o=;
        b=KT4DThzjG6mwQdkbC+W9+kvBfWXO8WOB7juf3YrcISE0Oq5LLNY+25sVqGQ/0Ec9NT
         4KpCjn2FheBvGIxpeqWT7HGVCRTrH+WXrgz6jUz7FlMlMHt6y8bKEjTrrLDbNVjjsdJg
         QvPX+o+9VjsDStPWVc6BjOt/dKCltKWzBU27w22j/WjBYZYH8A/szj3dHYDMX7ZHtMXM
         QUobDRpgP4uITRKlFCmy+rgKZg5wGu+7jKF+sT1jRBOClGdtVdGwBCys/RIcBW4srqI0
         16dX0vWV8Kj9pf+rK5ead1+HrfctwZ32xrGWWUR2PrG6/PcIcE4agmM2cGni/tItaKts
         Yixg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=S4cw2pXE;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=S4cw2pXE;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELsY+BP61VKoAqB/ja4LAQ5796efFMfcKZ3xr60cNRQWA7UpLkcoZR8KmVYDuOnKwE7bEdt+Bnph0KsDkwiNZ9s=
MIME-Version: 1.0
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C0076FFD@dggemm510-mbs.china.huawei.com>
References: <B8AC3E80E903784988AB3003E3E97330C0076FFD@dggemm510-mbs.china.huawei.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 19 Mar 2018 09:43:48 +0100
Message-ID: <CACT4Y+bec8x8AZOneZ57bnxei=gBGGKG2_VUiqyMaa1OPzov2g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KASan for arm
To: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"afzal.mohd.ma@gmail.com" <afzal.mohd.ma@gmail.com>,
	"alexander.levin@verizon.com" <alexander.levin@verizon.com>, "glider@google.com" <glider@google.com>,
	"christoffer.dall@linaro.org" <christoffer.dall@linaro.org>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"mawilcox@microsoft.com" <mawilcox@microsoft.com>, "pombredanne@nexb.com" <pombredanne@nexb.com>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
	"nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"thgarnie@google.com" <thgarnie@google.com>, "dhowells@redhat.com" <dhowells@redhat.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "tixy@linaro.org" <tixy@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"zhichao.huang@linaro.org" <zhichao.huang@linaro.org>, "jinb.park7@gmail.com" <jinb.park7@gmail.com>,
	"labbott@redhat.com" <labbott@redhat.com>, "philip@cog.systems" <philip@cog.systems>,
	"grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "opendmb@gmail.com" <opendmb@gmail.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	"kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281327886471398?=
X-GMAIL-MSGID: =?utf-8?q?1595354958570803298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 2:56 AM, Liuwenliang (Abbott Liu)
<liuwenliang@huawei.com> wrote:
> On 03/19/2018 09:23 AM, Florian Fainelli wrote:
>>On 03/18/2018 06:20 PM, Liuwenliang (Abbott Liu) wrote:
>>> On 03/19/2018 03:14 AM, Florian Fainelli wrote:
>>>> Thanks for posting these patches! Just FWIW, you cannot quite add
>>>> someone's Tested-by for a patch series that was just resubmitted given
>>>> the differences with v1. I just gave it a spin on a Cortex-A5 (no LPAE)
>>>> and it looks like test_kasan.ko is passing, great job!
>>>
>>> I'm sorry.
>>> Thanks for your testing very much!
>>> I forget to add Tested-by in cover letter patch file. But I have alreadly added
>>> Tested-by in some of following patch.
>>> In the next version I am going to add Tested-by in all patches.
>>
>>This is not exactly what I meant. When you submit a v2 of your patches,
>>you must wait for people to give you their test results. The Tested-by
>>applied to v1, and so much has changed it is no longer valid for v2
>>unless someone tells you they tested v2. Hope this is clearer.
>
> Ok, I understand now. thank you for your explanation.


Hi Abbott,

I've skimmed through the changes and they generally look good to me. I
am not an expect in arm, so I did not look too closely on these parts
(which is actually most of the changes).

FWIW
Acked-by: Dmitry Vyukov <dvyukov@google.com>

Please also update set of supported archs at the top of
Documentation/dev-tools/kasan.rst

Thanks for working on upstreaming this!
