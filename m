Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8B3C46467
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776A12173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnQpcTff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776A12173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbeHCLZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:25:23 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38184 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbeHCLZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:25:22 -0400
Received: by mail-it0-f50.google.com with SMTP id v71-v6so7509110itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=asIJduDDXCfiOl2yGV6miJRUGVm+XJYipxt+oOZ4CyY=;
        b=OnQpcTffTNkCDh+lDE4SQgC7VaIsT7hJ9GN8/WdOoYhFvud9ml8mpyFQIF9Lxm2bg1
         y1Gthq6i7bPVfgzTGigYlwu6PZ3QpLvVVcxJ52KY8XXlZY00lHXdU3mKWvnqe2ahSKE5
         ccEdnL0apozY1qM7Eml8LBDDvEagKjNHXY0vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=asIJduDDXCfiOl2yGV6miJRUGVm+XJYipxt+oOZ4CyY=;
        b=rcDTGyj5qCoxw1vTglhWAcgRPTRaCDbBf0M2LkijCKpdm+jeQWMOwHHGGKjKIl5Blr
         cuUZCp8/d0iVnG3oxdHKB09M0eHx+FE23Xsft1cc/I1IBawnpd7NvIozA1FwJ9Lwr2fA
         XtSNsFBY5BMS/fW/IB70iimh6QdSX7csJ5c10WDgxGYPAGtnj86MA2i8TETeTsH84/hd
         yL9SXX2H/f2Js7cMaKHbT9LPzdjKDBfa8IxnuluvrKRPnVj/Pj2FBAqn+KxjRIEyNfKn
         2ohBvyvymbX4aeJBn0fb9CMXgDlNmjaryLGtfffdYUgQucy7bBP0hZ+swltHYlLHcYo3
         aaPw==
X-Gm-Message-State: AOUpUlEf0w/zSU0pZMccRx8PCFkENxBXKnBWQtQ1dn3fIZ9UoNx7adNg
        FUoKQcsPlAC6rRPoZc6FhmqyyfHFsAcHt+DY+saH3Q==
X-Google-Smtp-Source: AAOMgpcqGUKuLZ4hdWVG0iI1DgATj0Qe4Ua2FC4RIp+JSQLzNFFFS3UVe+P59gqhZ1Hjoi0Bu88ZVEN5otcl7XF1Qhc=
X-Received: by 2002:a02:a1d9:: with SMTP id o25-v6mr2697819jah.86.1533288594748;
 Fri, 03 Aug 2018 02:29:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 02:29:54 -0700 (PDT)
In-Reply-To: <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 3 Aug 2018 11:29:54 +0200
Message-ID: <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Ramana Radhakrishnan <ramana.gcc@googlemail.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Andrew Pinski <pinskia@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 August 2018 at 11:15, Ramana Radhakrishnan
<ramana.gcc@googlemail.com> wrote:
> On Fri, Aug 3, 2018 at 8:53 AM, Florian Weimer <fweimer@redhat.com> wrote:
>> On 08/03/2018 09:11 AM, Andrew Pinski wrote:
>>>
>>> Yes fix Links not to use memcpy on the framebuffer.
>>> It is undefined behavior to use device memory with memcpy.
>>
>>
>> Some (de facto) ABIs require that it is supported, though.  For example, the
>> POWER string functions avoid unaligned loads and stores for this reason
>> because the platform has the same issue with device memory.  And yes, GCC
>> will expand memcpy on POWER to something that is incompatible with device
>> memory. 8-(
>
> GCC for AArch64 - use -mstrict-align
> GCC for AArch32 - use -mno-unaligned-access.
>
> If you see unaligned accesses coming out of the compiler for well
> defined programs then that's a bug. Frequently we see undefined
> programs that get the compiler to produce traps - atleast one or 2
> bugs a year  in  GCC .
>
>
>>
>> If we don't want people to use memcpy, we probably need to provide a
>> credible alternative.
>
> I believe a number of packages have rolled their own to take these
> constraints into account
> for AArch32, perhaps it needs to be expanded for AArch64 as well.
>

I guess the semantics of a framebuffer are not strictly defined, but
the current reality is that it is expected to have memory semantics
(by Linux/glibc)

Matt is saying fundamental properties of the underlying interconnects
(AMBA) make that impossible on ARM, but I'd like to understand better
if that is universally the case, and whether such a system is still
PCIe compliant.

The discussion about whether memcpy() should rely on unaligned
accesses, and whether you should use it on device memory is orthogonal
to that, and not the heart of the matter IMO
