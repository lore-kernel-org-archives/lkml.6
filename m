Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F61EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02E5208D6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma0MTVDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02E5208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeHXQ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:59:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34427 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeHXQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:59:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id f6-v6so1100625plo.1;
        Fri, 24 Aug 2018 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MEN261RyY8I4ejLe/rQi+xRf9nkBpoD1hYeHJGm5BTg=;
        b=ma0MTVDJzK5x10t6qvh2IjB1kSMG0TH3UBlNXTpCe3dRTAdX64djkSBLGHWpVK3SM3
         Zd20AiH3FnSNzZJLf6EbhiVaKR1iB/8obv6UuivrcHQZp9oPAgybi5nyFw1vhZC9Qv+0
         8qoKXn2y20NGg9z08I6fl+3VZTkGKwRN1J7da7trffRmHTEbsR091pLw/iNm8gMC8TSf
         Te87lpUBgxurWsXV11SfdFS+uQG+ed/JN2oCx3XpgA0fQvgNBYhl8QaumcID8yTHeQN/
         x20XwkeZ0xdyv6weRqZxfCkt1FnAwVkpuybiSptG0K+UvSOF9SmNmT4h/C1mUlYqBvts
         0Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MEN261RyY8I4ejLe/rQi+xRf9nkBpoD1hYeHJGm5BTg=;
        b=MqIR1HWTJWzoNT87JtpVkF3/Lcsn7R0cRS+ZmBl5o8TRYGZElcCNd+kHYjquvT2Dm5
         UuVAO4JVWQi18l+pqxtJPRfBYMoxPSaAuNkKncTb1aVNueyxjTDiWdh3x0wx8yN9gmvr
         VSjV0nxzxlZ8DyLPtKH5rThqWYGvrXR1oJZ67nSLNrXYVn7Js1IvrQmilhaITz/Q6NZ4
         17GtrvM3lJx2U3NHV7hqhZE0XQiP+UYA99xU5HA0ZZUw9l5JlWn5pCqCEjQfzZEnmih6
         b0DQJBLmJq2pH9B2gvOtnoqxi1aUiJb2Kwwz9H9BOCCJhWnNeYk1HpZDggQJUYvgNBAe
         A1vQ==
X-Gm-Message-State: APzg51A4eNh2g3QIqx+YBRn9dstFVRiNK0vFuFMxIZNp4tFp9Vt/JeP7
        2rI/Rj5Yf15BshnLPFMNFek=
X-Google-Smtp-Source: ANB0VdY5ZymbWKo5o6dx5S57UnoDbm4aFbEDeh922A4Wtd3ejGo6c3occ0bJKViaYpMiG1GoqgHXKw==
X-Received: by 2002:a17:902:28c7:: with SMTP id f65-v6mr1715101plb.240.1535117060917;
        Fri, 24 Aug 2018 06:24:20 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j15-v6sm9223217pfn.52.2018.08.24.06.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 06:24:20 -0700 (PDT)
Date:   Fri, 24 Aug 2018 06:24:19 -0700
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
Message-ID: <20180824132419.GA9983@roeck-us.net>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-3-npiggin@gmail.com>
 <20180824130722.GA31409@roeck-us.net>
 <20180824131026.GB11868@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824131026.GB11868@brain-police>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:10:27PM +0100, Will Deacon wrote:
> On Fri, Aug 24, 2018 at 06:07:22AM -0700, Guenter Roeck wrote:
> > On Thu, Aug 23, 2018 at 06:47:09PM +1000, Nicholas Piggin wrote:
> > > The generic tlb_end_vma does not call invalidate_range mmu notifier,
> > > and it resets resets the mmu_gather range, which means the notifier
> > > won't be called on part of the range in case of an unmap that spans
> > > multiple vmas.
> > > 
> > > ARM64 seems to be the only arch I could see that has notifiers and
> > > uses the generic tlb_end_vma. I have not actually tested it.
> > > 
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > This patch breaks riscv builds in mainline.
> 
> Looks very similar to the breakage we hit on arm64. diff below should fix
> it.
> 

Unfortunately it doesn't.

In file included from ./arch/riscv/include/asm/pgtable.h:26:0,
                 from ./include/linux/memremap.h:7,
                 from ./include/linux/mm.h:27,
                 from arch/riscv/mm/fault.c:23:
./arch/riscv/include/asm/tlb.h: In function ‘tlb_flush’:
./arch/riscv/include/asm/tlb.h:19:18: error: dereferencing pointer to incomplete type ‘struct mmu_gather’
  flush_tlb_mm(tlb->mm);
                  ^
./arch/riscv/include/asm/tlbflush.h:58:35: note: in definition of macro ‘flush_tlb_mm’
  sbi_remote_sfence_vma(mm_cpumask(mm)->bits, 0, -1)

Note that reverting the offending patch does fix the problem,
so there is no secondary problem lurking around.

Guenter
