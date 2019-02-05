Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63148C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2572220821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxLyhbOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfBEBq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 20:46:26 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45003 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfBEBq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 20:46:26 -0500
Received: by mail-yw1-f66.google.com with SMTP id b63so1086630ywc.11;
        Mon, 04 Feb 2019 17:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oLat4kKsYAs9f6tSiRP1Q2vmCfy3SQU/QqVTyJwEWuE=;
        b=nxLyhbOSMNesI5jxMBXmsm3OwtoSF+Q6zWpzt1aa6tB4yZK8a6quRQKhZ2db7oH2tz
         p1t9AuG2XWLLwksHknEjR4nqKq1kZUlKwwKhFwUlqKJchdUNcnDcGhcpiB60NbxY+Ogw
         xpPaAgmqt+tzs3OIFzJaCAJ+5bYKMeUJS26mZ1udAs3L3StxDkObLaQAVWdJVVaHsxsg
         R5qASgdZBfHnsZ0uL++jgrrH3KmSsN+K2CoiVpFMpbg4vg3skxmshA2jqTcef8BLHPEo
         TlN6fnIXQU7d3Sp5NF57UJIbXxP3y9yvY34jdj23U+QWLkhdWRwR+IbIWaR8q0D9Buh7
         8pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oLat4kKsYAs9f6tSiRP1Q2vmCfy3SQU/QqVTyJwEWuE=;
        b=r7sj3GKWRO7ugxbiJ+cIq4w3ItUbk5u//wvRSfknTrXSsDu0q8Z6wwslENfE/JhIkl
         SdV2DjeGOhaNeWzHBP7HZoWRhdMKYsDF9PIM2NAmHGaUzuv8JYLvRj5yZ2jQ0IBhAmQ/
         DPTqEPypzHukXyMjIvGBwQMWJOOJx4W6487k+idwFhqqL3zjdBYynocyfaaLRqyAVJ1/
         Jj9y7ctaOuIRqK40JG+AYJvqduou6Rl8V+qYoEiqLVIizL2M4Du7QMRXXpdwi+ze3g7N
         gPZfC/86mvQ1IgNlihhq/jR8z447xONA5d+v+wT0c83rEaRzOwUUz1zfOiCT9suMI8Pm
         b36g==
X-Gm-Message-State: AHQUAuY06D8Fc6esJ6H5jgVrTiWzelTBgxEZql9GSv4q9cldWnVbvqo+
        CF1hPrjBZ162hfS3kLIDEvs=
X-Google-Smtp-Source: AHgI3IayqcTMnrSQae8Hm8QfaM6nFKNXmkxCxrk1ujq7ltGY1oGtpvVPL9P8yYZp04LAppWVqZxT8w==
X-Received: by 2002:a81:77c2:: with SMTP id s185mr1925067ywc.399.1549331184937;
        Mon, 04 Feb 2019 17:46:24 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id k142sm587599ywa.67.2019.02.04.17.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 17:46:24 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH 3/4] kvm: Add guest side support for free memory hints
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAKgT0UevPXAG7xGzEur731-EJ0tOSGeg+AwugnRt6ugmfEKeLw@mail.gmail.com>
Date:   Mon, 4 Feb 2019 17:46:22 -0800
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D108194F-DEBE-43B7-BE61-7D5C52BDAAD3@gmail.com>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
 <20190204181552.12095.46287.stgit@localhost.localdomain>
 <4E64E8CA-6741-47DF-87DE-88D01B01B15D@gmail.com>
 <c24dc2351f3dc2f0e0bdf552c6504851e6fa6c06.camel@linux.intel.com>
 <4DFBB378-8E7A-4905-A94D-D56B5FF6D42B@gmail.com>
 <CAKgT0UevPXAG7xGzEur731-EJ0tOSGeg+AwugnRt6ugmfEKeLw@mail.gmail.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 4, 2019, at 4:16 PM, Alexander Duyck =
<alexander.duyck@gmail.com> wrote:
>=20
> On Mon, Feb 4, 2019 at 4:03 PM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>> On Feb 4, 2019, at 3:37 PM, Alexander Duyck =
<alexander.h.duyck@linux.intel.com> wrote:
>>>=20
>>> On Mon, 2019-02-04 at 15:00 -0800, Nadav Amit wrote:
>>>>> On Feb 4, 2019, at 10:15 AM, Alexander Duyck =
<alexander.duyck@gmail.com> wrote:
>>>>>=20
>>>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>=20
>>>>> Add guest support for providing free memory hints to the KVM =
hypervisor for
>>>>> freed pages huge TLB size or larger. I am restricting the size to
>>>>> huge TLB order and larger because the hypercalls are too expensive =
to be
>>>>> performing one per 4K page. Using the huge TLB order became the =
obvious
>>>>> choice for the order to use as it allows us to avoid fragmentation =
of higher
>>>>> order memory on the host.
>>>>>=20
>>>>> I have limited the functionality so that it doesn't work when page
>>>>> poisoning is enabled. I did this because a write to the page after =
doing an
>>>>> MADV_DONTNEED would effectively negate the hint, so it would be =
wasting
>>>>> cycles to do so.
>>>>>=20
>>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>> ---
>>>>> arch/x86/include/asm/page.h |   13 +++++++++++++
>>>>> arch/x86/kernel/kvm.c       |   23 +++++++++++++++++++++++
>>>>> 2 files changed, 36 insertions(+)
>>>>>=20
>>>>> diff --git a/arch/x86/include/asm/page.h =
b/arch/x86/include/asm/page.h
>>>>> index 7555b48803a8..4487ad7a3385 100644
>>>>> --- a/arch/x86/include/asm/page.h
>>>>> +++ b/arch/x86/include/asm/page.h
>>>>> @@ -18,6 +18,19 @@
>>>>>=20
>>>>> struct page;
>>>>>=20
>>>>> +#ifdef CONFIG_KVM_GUEST
>>>>> +#include <linux/jump_label.h>
>>>>> +extern struct static_key_false pv_free_page_hint_enabled;
>>>>> +
>>>>> +#define HAVE_ARCH_FREE_PAGE
>>>>> +void __arch_free_page(struct page *page, unsigned int order);
>>>>> +static inline void arch_free_page(struct page *page, unsigned int =
order)
>>>>> +{
>>>>> +   if (static_branch_unlikely(&pv_free_page_hint_enabled))
>>>>> +           __arch_free_page(page, order);
>>>>> +}
>>>>> +#endif
>>>>=20
>>>> This patch and the following one assume that only KVM should be =
able to hook
>>>> to these events. I do not think it is appropriate for =
__arch_free_page() to
>>>> effectively mean =E2=80=9Ckvm_guest_free_page()=E2=80=9D.
>>>>=20
>>>> Is it possible to use the paravirt infrastructure for this feature,
>>>> similarly to other PV features? It is not the best infrastructure, =
but at least
>>>> it is hypervisor-neutral.
>>>=20
>>> I could probably tie this into the paravirt infrastructure, but if I
>>> did so I would probably want to pull the checks for the page order =
out
>>> of the KVM specific bits and make it something we handle in the =
inline.
>>> Doing that I would probably make it a paravirtual hint that only
>>> operates at the PMD level. That way we wouldn't incur the cost of =
the
>>> paravirt infrastructure at the per 4K page level.
>>=20
>> If I understand you correctly, you =E2=80=9Ccomplain=E2=80=9D that =
this would affect
>> performance.
>=20
> It wasn't so much a "complaint" as an "observation". What I was
> getting at is that if I am going to make it a PV operation I might set
> a hard limit on it so that it will specifically only apply to huge
> pages and larger. By doing that I can justify performing the screening
> based on page order in the inline path and avoid any PV infrastructure
> overhead unless I have to incur it.

I understood. I guess my use of =E2=80=9Cdouble quotes=E2=80=9D was lost =
in translation. ;-)

One more point regarding [2/4] - you may want to consider using =
madvise_free
instead of madvise_dontneed to avoid unnecessary EPT violations.

