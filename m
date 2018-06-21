Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47872C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA60320652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWo/2kkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA60320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeFUJ3z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:29:55 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54452 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932534AbeFUJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:29:53 -0400
Received: by mail-it0-f66.google.com with SMTP id 76-v6so3702387itx.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dC8DNJaqPwhJQ7xfiFD6iJvkx6tGtJNjBiI9Ip9ri+I=;
        b=WWo/2kkx9xCPWvRokPs29r0W3rmZnE+h3gmaIUtygN12rgto6geNYWWrKheBG3zjdn
         9bCGbmUzW0Qc99wwmHCJR7mtCeUxKUoMRKAzXaoLSSdguF4GqBYDTF3CNlWjgV9bw486
         aPLOcsmLTc45DkjOmydK2oM1Fh6kCd447s0/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dC8DNJaqPwhJQ7xfiFD6iJvkx6tGtJNjBiI9Ip9ri+I=;
        b=jxwqm+Gy+Y0i96JQw0WZ6CsMFEJg6KYIi5xfiDJrVCNtEewhd3g7YC4SnVaHqbKX3D
         eb/fRiTKIEtO1SzUCJp62RSlz4IddeCs6qjl0DzVFIrOKXEuxZhFNJnhvZjAaS5RK9rS
         UO6o3mN9l2BKmgXqcXbjhwzx57hOjdZJ2bhhebC3lp+ld5JxKIgo1csIYaGcNBrrkn2K
         RfxoLxzu4LmHcVm+v9cZP5mJ23UEKksikx2tvmsloyU7pXTsbrAhn+u0CLyjT9onjTvi
         fqznW/e0VJ5npurKc20WHGJNpNlCe+V0jSpa6gNdpYBnaVLdXs/3zzjVUswgBGLYQcnA
         kTEw==
X-Gm-Message-State: APt69E2KuIxSgtwgNnOa0D8VyZt55XUX5Eg515nubGVUmY8L13h8leCY
        X77EeYd83KNnWMkfS/Pnpkejhbhnehqs2ZMOBCqg0Q==
X-Google-Smtp-Source: ADUXVKLN+mn858Vcau9zVAtsj/W+bE51xnNO5+kNfzGPXFSo2Izg3kgbEYBIzYPALH8LKEXYOOVkpunB/7kiwHQLBGI=
X-Received: by 2002:a02:6001:: with SMTP id i1-v6mr20558209jac.5.1529573393042;
 Thu, 21 Jun 2018 02:29:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 02:29:52
 -0700 (PDT)
In-Reply-To: <70ebe6d7-0745-5606-ae89-8a7b2fb62008@arm.com>
References: <20180620085755.20045-1-yaojun8558363@gmail.com>
 <20180620085755.20045-2-yaojun8558363@gmail.com> <CAKv+Gu8_=uTJFDXr0GpGMc=9WZ9tbz305CE6i=qbnqRB=suRVA@mail.gmail.com>
 <20180621025141.GB11276@toy> <CAKv+Gu_3Cfuq-qQuRHkYCB2uTPOK=KVeVh4OKmtu2MDYwfOtTA@mail.gmail.com>
 <70ebe6d7-0745-5606-ae89-8a7b2fb62008@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 21 Jun 2018 11:29:52 +0200
Message-ID: <CAKv+Gu-t5ErL89J=sxeVRYzDNrB1Ejdj+XOggAMWk-gY7ewsOg@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64/mm: move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir}
 to .rodata section
To:     James Morse <james.morse@arm.com>
Cc:     Jun Yao <yaojun8558363@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 June 2018 at 10:59, James Morse <james.morse@arm.com> wrote:
> Hi guys,
>
> On 21/06/18 07:39, Ard Biesheuvel wrote:
>> On 21 June 2018 at 04:51, Jun Yao <yaojun8558363@gmail.com> wrote:
>>> On Wed, Jun 20, 2018 at 12:09:49PM +0200, Ard Biesheuvel wrote:
>>>> On 20 June 2018 at 10:57, Jun Yao <yaojun8558363@gmail.com> wrote:
>>>>> Move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata
>>>>> section. And update the swapper_pg_dir by fixmap.
>>>>>
>>>>
>>>> I think we may be able to get away with not mapping idmap_pg_dir and
>>>> tramp_pg_dir at all.
>>>
>>> I think we need to move tramp_pg_dir to .rodata. The attacker can write
>>> a block-mapping(AP=01) to tramp_pg_dir and then he can access kernel
>>> memory.
>
>> Why does it need to be mapped at all? When do we ever access it from the code?
>
> (We would want to make its fixmap entry read-only too)
>

It already is.

>
>>>> As for swapper_pg_dir, it would indeed be nice if we could keep those
>>>> mappings read-only most of the time, but I'm not sure how useful this
>>>> is if we apply it to the root level only.
>>>
>>> The purpose of it is to make 'KSMA' harder, where an single arbitrary
>>> write is used to add a block mapping to the page-tables, giving the
>>> attacker full access to kernel memory. That's why we just apply it to
>>> the root level only. If the attacker can arbitrary write multiple times,
>>> I think it's hard to defend.
>>>
>>
>> So the assumption is that the root level is more easy to find?
>> Otherwise, I'm not sure I understand why being able to write a level 0
>> entry is so harmful, given that we don't have block mappings at that
>> level.
>
> I think this thing assumes 3-level page tables with 39bit VA.
>

The attack, you mean? Because this code is unlikely to build with that
configuration, given that __pgd_populate() BUILD_BUG()s in that case.

>
>>>>> @@ -417,12 +421,22 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
>>>>>
>>>>>  void __init mark_linear_text_alias_ro(void)
>>>>>  {
>
>>>>> +       size = (unsigned long)__init_begin - (unsigned long)swapper_pg_end;
>>>>> +       update_mapping_prot(__pa_symbol(swapper_pg_end),
>>>>> +                           (unsigned long)lm_alias(swapper_pg_end),
>>>>> +                           size, PAGE_KERNEL_RO);
>>>>
>>>> I don't think this is necessary. Even if some pages are freed, it
>>>> doesn't harm to keep a read-only alias of them here since the new
>>>> owner won't access them via this mapping anyway. So we can keep
>>>> .rodata as a single region.
>>>
>>> To be honest, I didn't think of this issue at first. I later found a
>>> problem when testing the code on qemu:
>>
>> OK, you're right. I missed the fact that this operates on the linear
>> alias, not the kernel mapping itself.
>>
>> What I don't like is that we lose the ability to use block mappings
>> for the entire .rodata section this way. Isn't it possible to move
>> these pgdirs to the end of the .rodata segment, perhaps by using a
>> separate input section name and placing that explicitly? We could even
>> simply forget about freeing those pages, given that [on 4k pages] the
>> benefit of freeing 12 KB of space is likely to get lost in the
>> rounding noise anyway [segments are rounded up to 64 KB in size]
>
> I assumed that to move swapper_pg_dir into the .rodata section we would need to
> break it up. Today its ~3 levels, which we setup in head.S, then do a dance in
> paging_init() so that swapper_pg_dir is always the top level.
>
> We could generate all leves of the 'init_pg_dir' in the __initdata section, then
> copy only the top level into swapper_pg_dir into the rodata section during
> paging_init().
>

Is that complexity truly justified for a security sensitive piece of
code? Can't we just drop the memblock_free() and be done with it?
