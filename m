Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17395C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4417208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTgNjadp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4417208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeHWG6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 02:58:48 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45022 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeHWG6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 02:58:47 -0400
Received: by mail-pl0-f68.google.com with SMTP id ba4-v6so1744758plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 20:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/1BsvEUo1b++R1hETUWaJYtB0D2SA2Etepv0PD46TFs=;
        b=fTgNjadpfW94/FUlrlfvUAVCCKwSHLWrT3seLMtW9L7bIOk5cN7HxKLiDKfQrsBRs6
         clMrQxVS5548oj+DovaC7jkVYZDkKzIGEFwv0TOgrf77Q0SRdXnEIbj2KwOMW0wfWmbS
         rTOH/ZGJXBewbbnUkJkd9yHBcUhdGjpvv2EredknzHbV0tpk/azsXPrC5akUOzso0sCE
         g91EDWxxWzU5pcm6FTe6JvXUqdCcUaAdh0TdMeDgPYBQvuFMzO4QXMqcno5QpuydRLQ3
         UrTB122UXzS9gt7M0h5K5N/dKBsBupAqtiFBd6cxweqWEggt8VHHZNnoshwWGVEvhSNo
         yKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1BsvEUo1b++R1hETUWaJYtB0D2SA2Etepv0PD46TFs=;
        b=ARpKf5/KDJiCGPMLipBIuiAh7eFyNx0HfS+YpqYTkTfcDUT68F/b7GupzOkG5PxXbG
         Y+XxaKV9+TALA3IhnnyY+acQLJNE/6PkP2Zy3E8qcgh89TvdErWnPhkTtiKsuMvNPTy1
         fmowx7J1OXvtdofAdskSmMURbG0gMiqe5ctUhQGkdoSDryNLf8pcSCv801XLdp23gJDN
         o4PdTjaZ5mKfdcBKMPuSup5JBVjrr4TJGqCWh57uGX5BjrgrG20v9bMRMeV+BaZl90MZ
         BN+dXTAu1pMPQrgjKVW4A8SK9Tk+Up00SVoJb3XULgo4F5OVqzU1ZZ7PsWZY2xyocm08
         P+NA==
X-Gm-Message-State: APzg51D0RmF10i65yNDbBinpC040vqkDvTnRQUPLw4IcuZsU7icVRs4q
        qs6u7Qkq3KoakyASu8g3OjwOIppI
X-Google-Smtp-Source: ANB0VdbZ7/jtoi8UVfCEmhwEIb/e+L5x51bPXt5VAV/WjjiRSm/B7lc8BEJuTP+0FwzCrmd/DAbVHw==
X-Received: by 2002:a17:902:8bcc:: with SMTP id r12-v6mr4296560plo.113.1534995074533;
        Wed, 22 Aug 2018 20:31:14 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id g20-v6sm4363684pfo.94.2018.08.22.20.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 20:31:13 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:31:03 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, will.deacon@arm.com, riel@surriel.com,
        jannh@google.com, ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/4] mm/tlb: Remove tlb_remove_table() non-concurrent
 condition
Message-ID: <20180823133103.30d6a16b@roar.ozlabs.ibm.com>
In-Reply-To: <20180822154046.772017055@infradead.org>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.772017055@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 17:30:14 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Will noted that only checking mm_users is incorrect; we should also
> check mm_count in order to cover CPUs that have a lazy reference to
> this mm (and could do speculative TLB operations).

Why is that incorrect?

This shortcut has nothing to do with no TLBs -- not sure about x86, but
other CPUs can certainly have remaining TLBs here, speculative
operations or not (even if they don't have an mm_count ref they can
have TLBs here).

So that leaves speculative operations. I don't see where the problem is
with those either -- this shortcut needs to ensure there are no other
*non speculative* operations. mm_users is correct for that.

If there is a speculation security problem here it should be carefully
documented otherwise it's going to be re-introduced...

I actually have a patch to extend this optimisation further that I'm
going to send out again today. It's nice to avoid the double handling
of the pages.

Thanks,
Nick

> 
> If removing this turns out to be a performance issue, we can
> re-instate a more complete check, but in tlb_table_flush() eliding the
> call_rcu_sched().
> 
> Cc: stable@kernel.org
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 267239116987 ("mm, powerpc: move the RCU page-table freeing into generic code")
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  mm/memory.c |    9 ---------
>  1 file changed, 9 deletions(-)
> 
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -375,15 +375,6 @@ void tlb_remove_table(struct mmu_gather
>  {
>  	struct mmu_table_batch **batch = &tlb->batch;
>  
> -	/*
> -	 * When there's less then two users of this mm there cannot be a
> -	 * concurrent page-table walk.
> -	 */
> -	if (atomic_read(&tlb->mm->mm_users) < 2) {
> -		__tlb_remove_table(table);
> -		return;
> -	}
> -
>  	if (*batch == NULL) {
>  		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
>  		if (*batch == NULL) {
> 
> 

