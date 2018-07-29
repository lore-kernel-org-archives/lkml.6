Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAECC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75BA20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pUo03la4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75BA20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbeG2U06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:26:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34637 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeG2U05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:26:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so3538207pfi.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mxG8PF3ivFqhhpbhu4VGpFD6o3v5tUesaJ2RyZ87YpI=;
        b=pUo03la42RFFoXo6t5zkrHhAt94CxtkJGJtxb0F8q8Rxgoc3HOrYS52ltPSpHmwgDE
         eWMnvgzzCfLVraUOllhYnO85STZx+SOVsZDyowfhZzeBgXcVcDbOb0NqXKU/WlF399NW
         OAf51+MmGZs4NDYY2NCjt2y4C0JxGysyy6dPsdCkp01a2IeWTOXRmvD0yEIIUbIo2nLs
         fX4KsmRAEzo3MtQIV7Aj+/ZcgXL3MQQfBYB7OTtEUqmVEbr03S5Wfa4MJiTiiy1XH0+q
         5e5ZZbSutD8XUW+JAE89LkCSHcD2mHjciK3ARrk44al/Mb414U9/Sh6XRG6jd1LVQXEJ
         Jz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mxG8PF3ivFqhhpbhu4VGpFD6o3v5tUesaJ2RyZ87YpI=;
        b=lzFSVBj923uRHPtrsbAHyoJFZrrxGbSrS0tvhIkKahZaioKQ247Y+R8uysQewZvLqQ
         MD7A5Uira/6AyqyYXdBolhaiIQ/J0e2+1pEkVI1Pl0D/7uBjiyjZ6JAsSGkj88NgmG1M
         MH6nTOUkdSxP73t3/LbJ4DOy+xdaGbhIh+0d7Xdtnndry8gqVurwZMzMy5JhLtRdxV8T
         RIVhENA2N6/fkfzMbldqS8oakLt6NRwlnMv3OsNJ1kuz19+AIFkqMFMGPMj13Gw5Hs4z
         qf/O5Vl3Rm4m2nYMv6daqGsfPNOfmftxYaMrnUT/RbHAbCWBDWf3wIkHhqESa3EO7a/n
         TNjg==
X-Gm-Message-State: AOUpUlFy5eEQJH6e8IZtNHSEu2V/b7rnvKybChMFL3GbvqjtyDHEzDq0
        iJJ3Pk1F/NSfppkiyWqCgAnBsw==
X-Google-Smtp-Source: AAOMgpel3XKA1iR9iXWwguhDy0CBBkjrbrQT2l5TUU1lw2mK+Ev4DN8jPsLMhCvelrB8QAfs2k1Jyg==
X-Received: by 2002:a62:d8c:: with SMTP id 12-v6mr15007408pfn.202.1532890533290;
        Sun, 29 Jul 2018 11:55:33 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:6c1c:6e0:41f7:badc? ([2601:646:c200:7429:6c1c:6e0:41f7:badc])
        by smtp.gmail.com with ESMTPSA id l185-v6sm16808066pga.65.2018.07.29.11.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:55:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 03/10] smp,cpumask: introduce on_each_cpu_cond_mask
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <1532886673.28585.24.camel@surriel.com>
Date:   Sun, 29 Jul 2018 11:55:30 -0700
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>, will.daecon@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A3221EE-0D94-487E-B53D-885A555634BD@amacapital.net>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-4-riel@surriel.com> <CALCETrUipqat-78++E8fL7d2=77Cbj72jCTZMO=yNF8nX9HhCA@mail.gmail.com> <1532865634.28585.2.camel@surriel.com> <E710FBA5-CC5E-4941-ACBF-4AB3424F1F68@amacapital.net> <1532886673.28585.24.camel@surriel.com>
To:     Rik van Riel <riel@surriel.com>, torvalds@linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 29, 2018, at 10:51 AM, Rik van Riel <riel@surriel.com> wrote:
>=20
>> On Sun, 2018-07-29 at 08:36 -0700, Andy Lutomirski wrote:
>>> On Jul 29, 2018, at 5:00 AM, Rik van Riel <riel@surriel.com> wrote:
>>>=20
>>>> On Sat, 2018-07-28 at 19:57 -0700, Andy Lutomirski wrote:
>>>> On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com>
>>>> wrote:
>>>>> Introduce a variant of on_each_cpu_cond that iterates only over
>>>>> the
>>>>> CPUs in a cpumask, in order to avoid making callbacks for every
>>>>> single
>>>>> CPU in the system when we only need to test a subset.
>>>> Nice.
>>>> Although, if you want to be really fancy, you could optimize this
>>>> (or
>>>> add a variant) that does the callback on the local CPU in
>>>> parallel
>>>> with the remote ones.  That would give a small boost to TLB
>>>> flushes.
>>>=20
>>> The test_func callbacks are not run remotely, but on
>>> the local CPU, before deciding who to send callbacks
>>> to.
>>>=20
>>> The actual IPIs are sent in parallel, if the cpumask
>>> allocation succeeds (it always should in many kernel
>>> configurations, and almost always in the rest).
>>>=20
>>=20
>> What I meant is that on_each_cpu_mask does:
>>=20
>> smp_call_function_many(mask, func, info, wait);
>> if (cpumask_test_cpu(cpu, mask)) {
>>   unsigned long flags;
>>   local_irq_save(flags); func(info);
>>   local_irq_restore(flags);
>> }
>>=20
>> So it IPIs all the remote CPUs in parallel, then waits, then does the
>> local work.  In principle, the local flush could be done after
>> triggering the IPIs but before they all finish.
>=20
> Grepping around the code, I found a few examples where the
> calling code appears to expect that smp_call_function_many
> also calls "func" on the local CPU.
>=20
> For example, kvm_emulate_wbinvd_noskip has this:
>=20
>        if (kvm_x86_ops->has_wbinvd_exit()) {
>                int cpu =3D get_cpu();
>=20
>                cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
>                smp_call_function_many(vcpu->arch.wbinvd_dirty_mask,
>                                wbinvd_ipi, NULL, 1);
>                put_cpu();
>                cpumask_clear(vcpu->arch.wbinvd_dirty_mask);
>        } else
>                wbinvd();
>=20
> This seems to result in systems with ->has_wbinvd_exit
> only calling wbinvd_ipi on OTHER CPUs, and not on the
> CPU where the guest exited with wbinvd?
>=20
> This seems unintended.
>=20
> I guess looking into on_each_cpu_mask might be a little
> higher priority than waiting until the next Outreachy
> season :)
>=20

The right approach might be a tree wise rename from smp_call_... to on_other=
_cpus_mask() it similar. The current naming and semantics are extremely conf=
using.

Linus, this is the kind of thing you seem to like taking outside the merge w=
indow. What do you think about a straight-up search_and_replace to make rena=
me the smp_call_... functions to exactly match the corresponding on_each_cpu=
 functions except with =E2=80=9Ceach=E2=80=9D replaced with =E2=80=9Cother=E2=
=80=9D?=
