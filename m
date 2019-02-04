Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29081C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C6F2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnZmV+ME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfBDXAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:00:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40621 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBDXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:00:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so584496pgp.7;
        Mon, 04 Feb 2019 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kH0IHrJSoQFyAx4iofM5iGBNHAzEokQMp3CgcnSLWMU=;
        b=GnZmV+MEm33hkAkY9eB1nN1X3/jXo/QLCfEDhSJHU8vzSX1HEogQumQfMPy7HPxobt
         T+aXfqW8AFccomMTEPS6w8U7z/QcF3pLVNJ5o18VlhjMLaxIW4hh67KUXdGfX2hld2uA
         YbgK+lOK7MkPlmhe9On64hl1wtmvQgt0A0xOrTP/WOPA6U9ShU++WofSNfFfldPvhRGp
         GkI4vrJ3suckIBPSHSiBgWqfUVn5DMulWpeEuhs/SwVOx2HF8HkjtrCBKyZ3CFLyZBoJ
         PjDVle8X6etbJLIULNived/+VwIgGz9z/NiXGw8mInO8NvfUxIlnbP5tdVMg0ZnSPW76
         /cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kH0IHrJSoQFyAx4iofM5iGBNHAzEokQMp3CgcnSLWMU=;
        b=pxjJJWxGEdeN6dyIyQaeNX44iBPCBkydug4Z1Gv9kQlNPV11OQMgetGKM38zlcUjdB
         8LAxD+Rm7koaGpJiC0lq2NqoApR7tdUYN8ZfQx6D1hoNrVrf87w6tz9e+kUEX2qf0+aS
         Lt5+2vxzwtjHq8d8XmtxMMHi0UUF5qOqAr9bUZL6ImhBtWugawuYS2Pxrr7RT/Le/V3T
         nFdYJtkMbEDxh6xynXE//o1yoiSSe52Z5kjx8gBO/S2yU15OFM/ZXu4RnkRCjTGC2J1/
         rrnA1QuKCKw0iN6dGLZ/nBj5zyyvQUEKRsHKZ99/9q1sb/1CIQdNmN2+RGsZxbe6Xik3
         ufHA==
X-Gm-Message-State: AHQUAubz1MAJlx+L9tJyyc9TXeoc6pMK45yvKJlvbYZlNhOw8uLyR4iF
        XO0t/czJtRGUk9dCfKASwuw=
X-Google-Smtp-Source: AHgI3IbxieJuU8CAP3+p4ZFwdqqvo1bB729g6OoR3vk4fJ4zW7+3UdY/IEHwMwKmNkmuVu4fxAp8ZA==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr1802977pfg.183.1549321221419;
        Mon, 04 Feb 2019 15:00:21 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id u70sm1579632pfa.176.2019.02.04.15.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 15:00:20 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH 3/4] kvm: Add guest side support for free memory hints
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190204181552.12095.46287.stgit@localhost.localdomain>
Date:   Mon, 4 Feb 2019 15:00:18 -0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com,
        tglx@linutronix.de, akpm@linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E64E8CA-6741-47DF-87DE-88D01B01B15D@gmail.com>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
 <20190204181552.12095.46287.stgit@localhost.localdomain>
To:     Alexander Duyck <alexander.duyck@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 4, 2019, at 10:15 AM, Alexander Duyck =
<alexander.duyck@gmail.com> wrote:
>=20
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> Add guest support for providing free memory hints to the KVM =
hypervisor for
> freed pages huge TLB size or larger. I am restricting the size to
> huge TLB order and larger because the hypercalls are too expensive to =
be
> performing one per 4K page. Using the huge TLB order became the =
obvious
> choice for the order to use as it allows us to avoid fragmentation of =
higher
> order memory on the host.
>=20
> I have limited the functionality so that it doesn't work when page
> poisoning is enabled. I did this because a write to the page after =
doing an
> MADV_DONTNEED would effectively negate the hint, so it would be =
wasting
> cycles to do so.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
> arch/x86/include/asm/page.h |   13 +++++++++++++
> arch/x86/kernel/kvm.c       |   23 +++++++++++++++++++++++
> 2 files changed, 36 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> index 7555b48803a8..4487ad7a3385 100644
> --- a/arch/x86/include/asm/page.h
> +++ b/arch/x86/include/asm/page.h
> @@ -18,6 +18,19 @@
>=20
> struct page;
>=20
> +#ifdef CONFIG_KVM_GUEST
> +#include <linux/jump_label.h>
> +extern struct static_key_false pv_free_page_hint_enabled;
> +
> +#define HAVE_ARCH_FREE_PAGE
> +void __arch_free_page(struct page *page, unsigned int order);
> +static inline void arch_free_page(struct page *page, unsigned int =
order)
> +{
> +	if (static_branch_unlikely(&pv_free_page_hint_enabled))
> +		__arch_free_page(page, order);
> +}
> +#endif

This patch and the following one assume that only KVM should be able to =
hook
to these events. I do not think it is appropriate for __arch_free_page() =
to
effectively mean =E2=80=9Ckvm_guest_free_page()=E2=80=9D.

Is it possible to use the paravirt infrastructure for this feature,
similarly to other PV features? It is not the best infrastructure, but =
at least
it is hypervisor-neutral.

