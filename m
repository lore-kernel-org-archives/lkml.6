Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501C1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAD021557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lKZUplrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAD021557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeHYDJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:09:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38957 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeHYDJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:09:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so5194947pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=oWSQtmoaOO/sMLR/Y1YUH8g0rwKYqMdXWLJhFyNzBoM=;
        b=lKZUplrtvMBoihY/7/U2tB/xeKp1nyxfs83wMx7Gah17x1hXDMGl5ft6JeZDd0CKuZ
         c0Jq6Sl4UkyFHgoX9KzojxYjpqTQGdbJkkAMHP+b+tdCZp+eMW7/QFs4ZsegS19BhEYL
         98e1J0YM5hqs55LRfhKWmR2azI+aREyMszM0NW6vH9xRXSFRD027IKcCR147NpSI1MFG
         7F2jUWgKYzuznXDkWLMxYlC397WYFEkvsLCgK46EeZ1+/3l34FpDHrtTCP8OeIsiBVEj
         aNIxtFunmMmVg2Sfujw7tySvaJsAIkqkWscGJpdWVp7wyCkT5mcMYvBBNsXCm64bSgcd
         wzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=oWSQtmoaOO/sMLR/Y1YUH8g0rwKYqMdXWLJhFyNzBoM=;
        b=J1czZzaeqcJ34lJBEyGYdEiD28IaJjSfXF5TKZC31qDXs1V5pqUvQFUWbXr2o7WuZg
         F5y+2MdeKqTabRSD7NFgQ1Ffq5OVim+nIsK5mu7+cPheGPMPlIEUk0GTNS3NoSmLZEe6
         N1CGyUJUK0L4sf1yRfWISVcFd5a6fUi4OdmDH/7Wk9L/s2AsEu0jhacYwJZtV1bU2Ygn
         d3zvwOMgaqP89lZbLCgzYzuvC/fZWDxeIYv+HVt0uKbOZOzzpnAvcf8TNHRzn0H2h9XC
         7kRFaO23vhGmdJMNmCnkw528t5EMXgeklLkdTKLPFeNZPzpLppa0Yu8JOaynpI1TPAre
         /iOw==
X-Gm-Message-State: APzg51DA9XJ2ERNjk0z/Yw/wD3gVixIbp2C3SC3dteCz7vIwwVirsKds
        oezuwREsKMti2aqclecI9PPp2g==
X-Google-Smtp-Source: ANB0Vdba/TJR9J88J6eCaaT1cgkRy29spVDOFQr7JsfyZU+VgpL1RgiGVEisGQ0s5s4QHhGvvb7Nfw==
X-Received: by 2002:a63:7343:: with SMTP id d3-v6mr3502823pgn.281.1535153533433;
        Fri, 24 Aug 2018 16:32:13 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b1-v6sm11399349pgi.91.2018.08.24.16.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 16:32:12 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:32:12 -0700 (PDT)
X-Google-Original-Date: Fri, 24 Aug 2018 16:32:10 PDT (-0700)
Subject:     Re: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma (build failures)
In-Reply-To: <20180824135048.GF11868@brain-police>
CC:     linux@roeck-us.net, npiggin@gmail.com, peterz@infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        luto@kernel.org, x86@kernel.org, bp@alien8.de, riel@surriel.com,
        jannh@google.com, ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        davem@davemloft.net, schwidefsky@de.ibm.com, mpe@ellerman.id.au,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Will Deacon <will.deacon@arm.com>
Message-ID: <mhng-86a3cd0c-c3dc-42a9-a955-01fbce9d2797@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 06:50:48 PDT (-0700), Will Deacon wrote:
> On Fri, Aug 24, 2018 at 02:34:27PM +0100, Will Deacon wrote:
>> On Fri, Aug 24, 2018 at 06:24:19AM -0700, Guenter Roeck wrote:
>> > On Fri, Aug 24, 2018 at 02:10:27PM +0100, Will Deacon wrote:
>> > > On Fri, Aug 24, 2018 at 06:07:22AM -0700, Guenter Roeck wrote:
>> > > > On Thu, Aug 23, 2018 at 06:47:09PM +1000, Nicholas Piggin wrote:
>> > > > > The generic tlb_end_vma does not call invalidate_range mmu notifier,
>> > > > > and it resets resets the mmu_gather range, which means the notifier
>> > > > > won't be called on part of the range in case of an unmap that spans
>> > > > > multiple vmas.
>> > > > >
>> > > > > ARM64 seems to be the only arch I could see that has notifiers and
>> > > > > uses the generic tlb_end_vma. I have not actually tested it.
>> > > > >
>> > > > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > > > > Acked-by: Will Deacon <will.deacon@arm.com>
>> > > >
>> > > > This patch breaks riscv builds in mainline.
>> > >
>> > > Looks very similar to the breakage we hit on arm64. diff below should fix
>> > > it.
>> > >
>> >
>> > Unfortunately it doesn't.
>> >
>> > In file included from ./arch/riscv/include/asm/pgtable.h:26:0,
>> >                  from ./include/linux/memremap.h:7,
>> >                  from ./include/linux/mm.h:27,
>> >                  from arch/riscv/mm/fault.c:23:
>> > ./arch/riscv/include/asm/tlb.h: In function ‘tlb_flush’:
>> > ./arch/riscv/include/asm/tlb.h:19:18: error: dereferencing pointer to incomplete type ‘struct mmu_gather’
>> >   flush_tlb_mm(tlb->mm);
>> >                   ^
>>
>> Sorry, I was a bit quick of the mark there. You'll need a forward
>> declaration for the paramater type. Here it is with a commit message,
>> although still untested because I haven't got round to setting up a riscv
>> toolchain yet.

FWIW, Arnd built them last time he updated the cross tools so you should be 
able to get GCC 8.1.0 for RISC-V from there.  I use this make.cross script that 
I stole from the Intel 0-day robot

    https://github.com/palmer-dabbelt/home/blob/master/.local/src/local-scripts/make.cross.bash

If I'm reading it correctly the tools come from here

    http://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-riscv64-linux.tar.gz

I use the make.cross script as it makes it super easy to test my 
across-the-tree patches on other people's ports.

>>
>> Will
>>
>> --->8
>>
>> From adb9be33d68320edcda80d540a97a647792894d2 Mon Sep 17 00:00:00 2001
>> From: Will Deacon <will.deacon@arm.com>
>> Date: Fri, 24 Aug 2018 14:33:48 +0100
>> Subject: [PATCH] riscv: tlb: Provide definition of tlb_flush() before
>>  including tlb.h
>>
>> As of commit fd1102f0aade ("mm: mmu_notifier fix for tlb_end_vma"),
>> asm-generic/tlb.h now calls tlb_flush() from a static inline function,
>> so we need to make sure that it's declared before #including the
>> asm-generic header in the arch header.
>>
>> Since tlb_flush() is a one-liner for riscv, we can define it before
>> including asm-generic/tlb.h as long as we provide a forward declaration
>> of struct mmu_gather.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/riscv/include/asm/tlb.h | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
>> index c229509288ea..a3d1380ad970 100644
>> --- a/arch/riscv/include/asm/tlb.h
>> +++ b/arch/riscv/include/asm/tlb.h
>> @@ -14,11 +14,13 @@
>>  #ifndef _ASM_RISCV_TLB_H
>>  #define _ASM_RISCV_TLB_H
>>
>> -#include <asm-generic/tlb.h>
>> +struct mmu_gather;
>>
>>  static inline void tlb_flush(struct mmu_gather *tlb)
>>  {
>>  	flush_tlb_mm(tlb->mm);
>
> Bah, didn't spot the dereference so this won't work either. You basically
> just need to copy what I did for arm64 in d475fac95779.
>
> Will
