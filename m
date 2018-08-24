Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A566AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2EF21567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKx1wf4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2EF21567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeHXQl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:41:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34306 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHXQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:41:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so4543286pfi.1;
        Fri, 24 Aug 2018 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3EMoyNX/5f5lpmU8VZqWdYQSs5wC3Zeb8Y3baPcMIOY=;
        b=bKx1wf4Nylp2Ka06Vh+/O44lGi5Ui8LuzDFQ4zdnGks9GvavqwqWQyM6tA//i77HoX
         pHDijkF7oD0wrpbRzEAuXshViJzpfZcDdnGa1mPdvAWUkcM3JgR8/g3/Cfx9t1k8+F98
         Wmm6oCq4zp9nXQ+RbIWFnjnOrLelMZeccMczM0Dmr6PoopzxzMphKJCLrt5ed0q39SUt
         n2VzcGOgc2ChXXqcAsU7U0Ecb6v+PQFWinznaSA1H5YqTFwjWPtlVslomnn8qzX+hQ/1
         ID9p23+d93ifXfaapvAAtBj6xUjSqifHlZcVM8wy5KxZiCsJrz2bfZvf4QUxpPX5A7r9
         meeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3EMoyNX/5f5lpmU8VZqWdYQSs5wC3Zeb8Y3baPcMIOY=;
        b=uJXw9uVBPUxqy8Wlb9ChyRL9FeQ1OI9e95DYyhtU91Y08zlOl0QrFQls1czL88frVR
         EMnXx9/eE0/B2Xxo8mQvw9VKwwjZiEfDM5oHqMQlcEAbOs/nKBxo2kG0fwmiS+eSef3K
         tqyLiLf5DGXnP5/9zztLXJy0MLfG5s9qwXdPquPrlOxulIcPFg6GBVH29eCcINtN2nGK
         jLLFX3GGXHrokgPPg5YWYAO+ULobamCYX1wc8Bts8IuMDCZ8gDROL+9gQhHTfQH4qlS2
         InsMnEw8V3fU5BhCd7IwI1bACc/XHNM9DWDzu6bYtc7uhR7V1j6EgUNRIJxfFN3ttVve
         OuWg==
X-Gm-Message-State: APzg51B8rzBOWnTBomnaiQdG/MZF56bW8iFaTHZLPPJi0dpldhr9GkuN
        WdpdUDR+Kz3Jo3JDn6oYD54=
X-Google-Smtp-Source: ANB0Vdb/rhZer3b0HizlNcvcvhIPzS7tCz/KaL1tda28C13h4oePg7jv+hCc1klEvZrVNBpdQv+V4w==
X-Received: by 2002:a63:bd41:: with SMTP id d1-v6mr1669721pgp.309.1535116044034;
        Fri, 24 Aug 2018 06:07:24 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x2-v6sm13296901pfi.166.2018.08.24.06.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 06:07:23 -0700 (PDT)
Date:   Fri, 24 Aug 2018 06:07:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, will.deacon@arm.com, riel@surriel.com,
        jannh@google.com, ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma (build
 failures)
Message-ID: <20180824130722.GA31409@roeck-us.net>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823084709.19717-3-npiggin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 06:47:09PM +1000, Nicholas Piggin wrote:
> The generic tlb_end_vma does not call invalidate_range mmu notifier,
> and it resets resets the mmu_gather range, which means the notifier
> won't be called on part of the range in case of an unmap that spans
> multiple vmas.
> 
> ARM64 seems to be the only arch I could see that has notifiers and
> uses the generic tlb_end_vma. I have not actually tested it.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

This patch breaks riscv builds in mainline.

Building riscv:defconfig ... failed
--------------
Error log:
In file included from riscv/include/asm/tlb.h:17:0,
                 from arch/riscv/include/asm/pgalloc.h:19,
                 from riscv/mm/fault.c:30:
include/asm-generic/tlb.h: In function 'tlb_flush_mmu_tlbonly':
include/asm-generic/tlb.h:147:2: error: implicit declaration of function 'tlb_flush'

In file included from arch/riscv/include/asm/pgalloc.h:19:0,
		from arch/riscv/mm/fault.c:30:
arch/riscv/include/asm/tlb.h: At top level:
arch/riscv/include/asm/tlb.h:19:20: warning: conflicting types for 'tlb_flush'

Guenter
