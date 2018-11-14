Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060D8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA09208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v44xs3mJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA09208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeKOGLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:11:03 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42664 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOGLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:11:03 -0500
Received: by mail-io1-f67.google.com with SMTP id h19-v6so12662085iog.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 12:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VAK8tufN587uGxrvNnsBxqoIyx6U9HTPgbZuLmuBDYs=;
        b=v44xs3mJadjWvHWVb4l0Al+2/kr7nCT3il/Fdal6PCu/M+Rs1W04tmYH+lgC9DSkk1
         lsPj1AgL81m+/5iZ94xP6GJ2SatdUekrILjNviklESn9bYA9HmdLcAJakmDyE+dsdqSh
         aZ8cEzcMxIgOYVls1DmsAxpV33LXIw3D38fVoi5+qcnONwAH9rwtb0whUMC30JyNgpUL
         VNPDIXZJm+PfE7Jj5b+I8l8p/yTt7JOzVFVEADcRE+958W3f130D4FcKOg2emdcNd49J
         pebrBn/wfIvZeQgIhodyStQb/u3pACjf7RosLB2/3VShO624T9av6jxUKAwan9ldgF3V
         JlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VAK8tufN587uGxrvNnsBxqoIyx6U9HTPgbZuLmuBDYs=;
        b=t1Sojize1iu2WirxVsbVR8/psKOlMHctSAmv06K1uxhDfsQQ7YYBFSxZYSO+eQN4cN
         n9a9M4FuOAflTcUfu2uallyuft1w8/+cOUZf/9fOs3ARQsef7thsnGOVHeD2qf0jzC0i
         /yNEk+oxsH9FsofbLArMGadR1u6Z8wOQLaBQQ3lVO9AKm04sSRnpVqBfn0WAAhsQq8CA
         wHBgww4KEBzRlrRXhgpJhK9sOsvanwHryMCfin25VasOgBm9udrMSrBx/xhB8cjHocav
         j56idjhbGxypM5/YLJq6Xhftd+CRW6MJkGBa3JQzJlthA6ZsIThIzUlXFAPxdLKQeLF+
         MmNA==
X-Gm-Message-State: AA+aEWbgMn3shUBqy0QvbeDRGQD7grj2iaU7h1SZeLK+IpHROnIWCWpB
        q8x8VwnOGXA8XeukhhWO414jM/ENbD+r57Jjq8Eb6A==
X-Google-Smtp-Source: AFSGD/WCuAd1Fjd8ZXHyqK7I8BfEs6yqQM7P52bCSlaeuxHMAhiv0OGNvWzn+HGr2Il1bKDd1fqQah31ekwtISk9uMY=
X-Received: by 2002:a6b:c0c6:: with SMTP id q189-v6mr2855187iof.31.1542225984227;
 Wed, 14 Nov 2018 12:06:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:7050:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 12:06:23
 -0800 (PST)
In-Reply-To: <20181113220728.2h3kz67b2bz36wty@blommer>
References: <cover.1541525354.git.andreyknvl@google.com> <4891a504adf61c0daf1e83642b6f7519328dfd5f.1541525354.git.andreyknvl@google.com>
 <20181108122228.xqwhpkjritrvqneq@lakrids.cambridge.arm.com>
 <CAAeHK+xPkbg_9P9oCkS-iB8S81vTxD3p5SbyWHy-vrp2ybkKmg@mail.gmail.com> <20181113220728.2h3kz67b2bz36wty@blommer>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 14 Nov 2018 21:06:23 +0100
Message-ID: <CAAeHK+xe5LqbyWnYSDv2+QrLR=GK0JMzniAZBfL8kjXRwJravA@mail.gmail.com>
Subject: Re: [PATCH v10 12/22] kasan, arm64: fix up fault handling logic
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:07 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Nov 13, 2018 at 04:01:27PM +0100, Andrey Konovalov wrote:
>> On Thu, Nov 8, 2018 at 1:22 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Tue, Nov 06, 2018 at 06:30:27PM +0100, Andrey Konovalov wrote:
>> >> show_pte in arm64 fault handling relies on the fact that the top byte of
>> >> a kernel pointer is 0xff, which isn't always the case with tag-based
>> >> KASAN.
>> >
>> > That's for the TTBR1 check, right?
>> >
>> > i.e. for the following to work:
>> >
>> >         if (addr >= VA_START)
>> >
>> > ... we need the tag bits to be an extension of bit 55...
>> >
>> >>
>> >> This patch resets the top byte in show_pte.
>> >>
>> >> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> >> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>> >> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> >> ---
>> >>  arch/arm64/mm/fault.c | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> >> index 7d9571f4ae3d..d9a84d6f3343 100644
>> >> --- a/arch/arm64/mm/fault.c
>> >> +++ b/arch/arm64/mm/fault.c
>> >> @@ -32,6 +32,7 @@
>> >>  #include <linux/perf_event.h>
>> >>  #include <linux/preempt.h>
>> >>  #include <linux/hugetlb.h>
>> >> +#include <linux/kasan.h>
>> >>
>> >>  #include <asm/bug.h>
>> >>  #include <asm/cmpxchg.h>
>> >> @@ -141,6 +142,8 @@ void show_pte(unsigned long addr)
>> >>       pgd_t *pgdp;
>> >>       pgd_t pgd;
>> >>
>> >> +     addr = (unsigned long)kasan_reset_tag((void *)addr);
>> >
>> > ... but this ORs in (0xffUL << 56), which is not correct for addresses
>> > which aren't TTBR1 addresses to begin with, where bit 55 is clear, and
>> > throws away useful information.
>> >
>> > We could use untagged_addr() here, but that wouldn't be right for
>> > kernels which don't use TBI1, and we'd erroneously report addresses
>> > under the TTBR1 range as being in the TTBR1 range.
>> >
>> > I also see that the entry assembly for el{1,0}_{da,ia} clears the tag
>> > for EL0 addresses.
>> >
>> > So we could have:
>> >
>> > static inline bool is_ttbr0_addr(unsigned long addr)
>> > {
>> >         /* entry assembly clears tags for TTBR0 addrs */
>> >         return addr < TASK_SIZE_64;
>> > }
>> >
>> > static inline bool is_ttbr1_addr(unsigned long addr)
>> > {
>> >         /* TTBR1 addresses may have a tag if HWKASAN is in use */
>> >         return arch_kasan_reset_tag(addr) >= VA_START;
>> > }
>> >
>> > ... and use those in the conditionals, leaving the addr as-is for
>> > reporting purposes.
>>
>> Actually it looks like 276e9327 ("arm64: entry: improve data abort
>> handling of tagged pointers") already takes care of both user and
>> kernel fault addresses and correctly removes tags from them. So I
>> think we need to drop this patch.
>
> The clear_address_tag macro added in that commit only removes tags from TTBR0
> addresses, so that's not sufficient if the kernel is used tagged addresses
> (which will be in the TTBR1 range).

Do I understand correctly that TTBR0 means user space addresses and
TTBR1 means kernel addresses? In that commit I see that the
clear_address_tag() macro is used in el0_da and in el1_da, which means
that it untags both user and kernel addresses (on data aborts). Do I
misunderstand something?
