Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182F1C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE2B2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHpwlVW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfBEADu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:03:50 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37807 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBEADu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:03:50 -0500
Received: by mail-yb1-f194.google.com with SMTP id 2so355948ybw.4;
        Mon, 04 Feb 2019 16:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hng7Czl6ywQUfCuKZVxEyA+r1+h7+W4nv2EXp6tPdtg=;
        b=OHpwlVW+O0/eJQKfIA+SrsIsadEs6XRCTGOrnjTFK3xhL3orugJXHsXsmC2k7OBSTb
         dpAVaTHgPWqxXhVQqnaw4kJUuieNfGgyWwygzS9GTnQcAJi6qzDvaEAJL/Tu6gbRN88Z
         Y/o5Y1BZF8aCKNckZU6nPW46Q4xqIVaPznQR4TDfVRjmsalT9DURg0CpCnYFkGNMjl7f
         2QN6kN5GnpovhPYfnsiCUwnvVNTWxaDVxgKbOLoCGoRRd5Jqf/cJZxJR0ShimnwEOA/z
         sRCKU4BoG4qBByAR05i5+u38ozKeIUNDohrctMqCUo8RS+l9OmleMekhrWdy4HMdrniu
         BPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hng7Czl6ywQUfCuKZVxEyA+r1+h7+W4nv2EXp6tPdtg=;
        b=UF+qnMd3/Lmy2oH82RJE3cTTZoEtVNOo1WQF54z8DTz6+tiH7S/bfObuYKxFFHD2n4
         a1W9fLTe3mea5kZBfkO9ev28vQJUakQqjXI75yMNAMiZHC+1veXxAzm5a+lP7gFmX2Cy
         t5nUZrDOLQLxmPuLWtzwD5f1p44H0Ffn/EF083ndYJ8OXi1daEMd7gq4HNzAde+shZW7
         KSmkii647F3EZZ8M/IMtrbvuZyFagcdK2gb4UFrjPxB8/BhD+dE58EcV2ZRU06hd2XiE
         H8HOfZ6VsBpl26F+EkaJoSmf57MVmIwOufDi3ahC7cyMcfBQcWR3xXxH0DQ2DRJKP8Sb
         13VA==
X-Gm-Message-State: AHQUAuaQSy6cgciFmVnbO+jEgVkhsrgBSDsc26TlyIQmRYMqCgNnRSlD
        BsebDZVluguElcrwoALzCj8=
X-Google-Smtp-Source: AHgI3IZwkLgyckouxPcWglrdjoLIXvyur1X33/MNwXZZ3phMAJe/VhmPVda2cjWxzJBuJvbxtmnMeg==
X-Received: by 2002:a25:63c6:: with SMTP id x189mr1713907ybb.152.1549325028743;
        Mon, 04 Feb 2019 16:03:48 -0800 (PST)
Received: from [10.1.153.236] ([208.91.3.26])
        by smtp.gmail.com with ESMTPSA id i128sm482745ywb.82.2019.02.04.16.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 16:03:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH 3/4] kvm: Add guest side support for free memory hints
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <c24dc2351f3dc2f0e0bdf552c6504851e6fa6c06.camel@linux.intel.com>
Date:   Mon, 4 Feb 2019 16:03:45 -0800
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DFBB378-8E7A-4905-A94D-D56B5FF6D42B@gmail.com>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
 <20190204181552.12095.46287.stgit@localhost.localdomain>
 <4E64E8CA-6741-47DF-87DE-88D01B01B15D@gmail.com>
 <c24dc2351f3dc2f0e0bdf552c6504851e6fa6c06.camel@linux.intel.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 4, 2019, at 3:37 PM, Alexander Duyck =
<alexander.h.duyck@linux.intel.com> wrote:
>=20
> On Mon, 2019-02-04 at 15:00 -0800, Nadav Amit wrote:
>>> On Feb 4, 2019, at 10:15 AM, Alexander Duyck =
<alexander.duyck@gmail.com> wrote:
>>>=20
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>=20
>>> Add guest support for providing free memory hints to the KVM =
hypervisor for
>>> freed pages huge TLB size or larger. I am restricting the size to
>>> huge TLB order and larger because the hypercalls are too expensive =
to be
>>> performing one per 4K page. Using the huge TLB order became the =
obvious
>>> choice for the order to use as it allows us to avoid fragmentation =
of higher
>>> order memory on the host.
>>>=20
>>> I have limited the functionality so that it doesn't work when page
>>> poisoning is enabled. I did this because a write to the page after =
doing an
>>> MADV_DONTNEED would effectively negate the hint, so it would be =
wasting
>>> cycles to do so.
>>>=20
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> ---
>>> arch/x86/include/asm/page.h |   13 +++++++++++++
>>> arch/x86/kernel/kvm.c       |   23 +++++++++++++++++++++++
>>> 2 files changed, 36 insertions(+)
>>>=20
>>> diff --git a/arch/x86/include/asm/page.h =
b/arch/x86/include/asm/page.h
>>> index 7555b48803a8..4487ad7a3385 100644
>>> --- a/arch/x86/include/asm/page.h
>>> +++ b/arch/x86/include/asm/page.h
>>> @@ -18,6 +18,19 @@
>>>=20
>>> struct page;
>>>=20
>>> +#ifdef CONFIG_KVM_GUEST
>>> +#include <linux/jump_label.h>
>>> +extern struct static_key_false pv_free_page_hint_enabled;
>>> +
>>> +#define HAVE_ARCH_FREE_PAGE
>>> +void __arch_free_page(struct page *page, unsigned int order);
>>> +static inline void arch_free_page(struct page *page, unsigned int =
order)
>>> +{
>>> +	if (static_branch_unlikely(&pv_free_page_hint_enabled))
>>> +		__arch_free_page(page, order);
>>> +}
>>> +#endif
>>=20
>> This patch and the following one assume that only KVM should be able =
to hook
>> to these events. I do not think it is appropriate for =
__arch_free_page() to
>> effectively mean =E2=80=9Ckvm_guest_free_page()=E2=80=9D.
>>=20
>> Is it possible to use the paravirt infrastructure for this feature,
>> similarly to other PV features? It is not the best infrastructure, =
but at least
>> it is hypervisor-neutral.
>=20
> I could probably tie this into the paravirt infrastructure, but if I
> did so I would probably want to pull the checks for the page order out
> of the KVM specific bits and make it something we handle in the =
inline.
> Doing that I would probably make it a paravirtual hint that only
> operates at the PMD level. That way we wouldn't incur the cost of the
> paravirt infrastructure at the per 4K page level.

If I understand you correctly, you =E2=80=9Ccomplain=E2=80=9D that this =
would affect
performance.

While it might be, you may want to check whether the already available
tools can solve the problem:

1. You can use a combination of static-key and pv-ops - see for example
steal_account_process_time()

2. You can use callee-saved pv-ops.

The latter might anyhow be necessary since, IIUC, you change a very hot
path. So you may want have a look on the assembly code of =
free_pcp_prepare()
(or at least its code-size) before and after your changes. If they are =
too
big, a callee-saved function might be necessary.

