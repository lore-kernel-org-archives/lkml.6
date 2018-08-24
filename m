Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C0BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737812151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9aRkP82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737812151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeHXR3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:29:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44210 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeHXR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:29:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so4576767pff.11;
        Fri, 24 Aug 2018 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qg8MYUxwg7ZKRW3TCO1k3xR6047kd3Jfof2GaXsebXg=;
        b=P9aRkP82c2VaEdlf/MPWZGrW9L+RGov5MVG1DT5ZAjqBlQa+frF9cXAJiozMzN3tXE
         2zVZEu78hrxONno6AKUNUC4zcGrfv+UUnzJ99qQN5aPJxv25TZElzylkKXC2f4fWlTj3
         ed928/xak+sMj/i37qq5pgUCqY1KVfc3dKAkcsajJXnXf3fXyLiZHGLSU+c3ZeeNsG1u
         Bn1gs6eBfbU60Z1vMgKsjvlP+xfK4L0HKxuqlIVazIFnnD/Adwp/qvVjwPONHxplTqCs
         8BoqiGMPRYnUXZvCDz9DC4zzv3kko55hKHvzlczY4cQYIvls7vGM1drUhasrIy/7+4I1
         67oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qg8MYUxwg7ZKRW3TCO1k3xR6047kd3Jfof2GaXsebXg=;
        b=a1Ltid0XLfjU75fjdDjkPA+ygqNxo9YKwRT3klPczrwCSLIUav1Gs40nWayUT+9lNp
         oE8BZHlRCqkCcsdn8FyESgpwJgT5MsQq5X5Vzth+RER01P7FgTa9w4B7H+dS7fgLxpkO
         nAixYdY4exzG+K1jCY8jV+XBhF3v0DwrF7Z4F1BdBY6JHz8Ys6768ZmqplLdK8vFUee3
         jnUNvpzLhEJQEEMIqmx1VKsd98BdDj/UzOGCyWZPfoD8YnVAp739snQR/LmfYQEijyKH
         A8MlzhSP2HGkdDO0VE0RRDzAK9N13EUsDxk1uSfQQW4j3llNUHP+geBo47qNVM2M3qMb
         chNA==
X-Gm-Message-State: APzg51BT3ps261Ymkx4t46uoio+XFlDj0NVPPteBG2qR+kwmhkKqni7O
        I6amI+JJvbzdnEeoNDOJJlE=
X-Google-Smtp-Source: ANB0Vdb9stfSxykkYT8blX9/odaPR+rIN3sfJd7xY/J8knZfPdBgh20ZGF+wyIMxl++Hbq8t+x+Q1A==
X-Received: by 2002:a62:1089:: with SMTP id 9-v6mr2170517pfq.30.1535118900219;
        Fri, 24 Aug 2018 06:55:00 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h82-v6sm17921657pfa.173.2018.08.24.06.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 06:54:59 -0700 (PDT)
Date:   Fri, 24 Aug 2018 06:54:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, riel@surriel.com, jannh@google.com,
        ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma (build
 failures)
Message-ID: <20180824135458.GA30345@roeck-us.net>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-3-npiggin@gmail.com>
 <20180824130722.GA31409@roeck-us.net>
 <20180824131026.GB11868@brain-police>
 <20180824132419.GA9983@roeck-us.net>
 <20180824133427.GC11868@brain-police>
 <20180824135048.GF11868@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824135048.GF11868@brain-police>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:50:48PM +0100, Will Deacon wrote:
> > 
> > Sorry, I was a bit quick of the mark there. You'll need a forward
> > declaration for the paramater type. Here it is with a commit message,
> > although still untested because I haven't got round to setting up a riscv
> > toolchain yet.
> > 

Still doesn't work.

CC      mm/memory.o
In file included from ./arch/riscv/include/asm/pgtable.h:26:0,
                 from ./include/linux/memremap.h:7,
		 from ./include/linux/mm.h:27,
		 from arch/riscv/mm/fault.c:23:
./arch/riscv/include/asm/tlb.h: In function ‘tlb_flush’:
./arch/riscv/include/asm/tlb.h:21:18: error:
	dereferencing pointer to incomplete type ‘struct mmu_gather’ flush_tlb_mm(tlb->mm);

Problem is that struct mmu_gather is dereferenced in tlb_flush().

Guenter

> > Will
> > 
> > --->8
> > 
> > From adb9be33d68320edcda80d540a97a647792894d2 Mon Sep 17 00:00:00 2001
> > From: Will Deacon <will.deacon@arm.com>
> > Date: Fri, 24 Aug 2018 14:33:48 +0100
> > Subject: [PATCH] riscv: tlb: Provide definition of tlb_flush() before
> >  including tlb.h
> > 
> > As of commit fd1102f0aade ("mm: mmu_notifier fix for tlb_end_vma"),
> > asm-generic/tlb.h now calls tlb_flush() from a static inline function,
> > so we need to make sure that it's declared before #including the
> > asm-generic header in the arch header.
> > 
> > Since tlb_flush() is a one-liner for riscv, we can define it before
> > including asm-generic/tlb.h as long as we provide a forward declaration
> > of struct mmu_gather.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/riscv/include/asm/tlb.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
> > index c229509288ea..a3d1380ad970 100644
> > --- a/arch/riscv/include/asm/tlb.h
> > +++ b/arch/riscv/include/asm/tlb.h
> > @@ -14,11 +14,13 @@
> >  #ifndef _ASM_RISCV_TLB_H
> >  #define _ASM_RISCV_TLB_H
> >  
> > -#include <asm-generic/tlb.h>
> > +struct mmu_gather;
> >  
> >  static inline void tlb_flush(struct mmu_gather *tlb)
> >  {
> >  	flush_tlb_mm(tlb->mm);
> 
> Bah, didn't spot the dereference so this won't work either. You basically
> just need to copy what I did for arm64 in d475fac95779.
> 
> Will
