Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C39C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83D12152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfhnk7OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83D12152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeHXDO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 23:14:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39928 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeHXDO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 23:14:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3-v6so2494591pgp.6;
        Thu, 23 Aug 2018 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3MgpXJ0tEgWaIBlP6Yio9nmxEHq9CVJWKgbe1GKI54=;
        b=dfhnk7OEVDY8HOZqm5+42Cy2aCsIGUGTplhcn29f8lSzloNVsYcvFI3j8SDnCU8jR2
         hjWZofFwSk6qmH5U6p4OBHScMnYsNcAE+q9ULmICYyrpGrmR2j+TZdAMTaW3/4ToqqQV
         Z+0BAIiZl1RzRvCluyzHWQlJ9YLKJnA3N0Vxv3B6QXVtqtcaoCw/ehPHbjeL45/aC/C8
         Ivps95NgN0aehpu221LqvxNjYMv9XT3aIYTvRVnekUCcHJLjnjkqyIxh8FgI97umMT1M
         hGmJGz7YV1Rx7EpzVgxve29H4vv4mSOBYf0M5drdShYyjMjAiQoIr17wx3S4FgLGJggq
         PRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3MgpXJ0tEgWaIBlP6Yio9nmxEHq9CVJWKgbe1GKI54=;
        b=Q00IlHp+8N9jaZ0AbP6AsPpYpvVR+lAz9EAYCfUFl6fBq6TiPu8hH2x4NYMX3X7Gwu
         EOUVdbsL9Ik8raKaLicOlRA6AFKQAr84ixPobbuIrAWc+CgdrXqZf+97CFnWptlhYFi9
         jz5Rkz38MthfMtF9z9RTIgJgcmRxqGdU4hbL+OBDgx7O+LoajSgBGpR6dNM0r/WtWAtg
         52IxI9U96n7C1YII5oW+Sl2acMBr8R4ZHqSpMdBpMAjNsYaVb/4E6slTpVVvEWtHAJPD
         E7KtjS9Wu+wO+I7e7cdK9a6HiyFGzKZrJU0XLj20IGOU3JBX4DYsx4EHVVJ3fOs7SKfr
         sB4w==
X-Gm-Message-State: AOUpUlFMgJE/cXNS5dcwRCOncg8nhlA0rJnNBuqjNcrMh2MqAIiAJS8u
        sAUFCM19SDO8SfoU+F0LHw4=
X-Google-Smtp-Source: AA+uWPz6Ag5Nnv/65hdLIOdq5Wn7qy5zb7RZezfCq4TgCKk0zZCWa1FKmg1BsEK9KrY4yip6PwW7SA==
X-Received: by 2002:a62:411a:: with SMTP id o26-v6mr64884286pfa.111.1535067748841;
        Thu, 23 Aug 2018 16:42:28 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id v23-v6sm7111592pfm.80.2018.08.23.16.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 16:42:28 -0700 (PDT)
Date:   Fri, 24 Aug 2018 09:42:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] minor mmu_gather patches
Message-ID: <20180824094220.3ac18168@roar.ozlabs.ibm.com>
In-Reply-To: <20180823232704.GA4487@brain-police>
References: <20180823084709.19717-1-npiggin@gmail.com>
        <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
        <CA+55aFwEZftzAd9k-kjiaXonP2XeTDYshjY56jmd1CFBaXmGHA@mail.gmail.com>
        <20180823232704.GA4487@brain-police>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 00:27:05 +0100
Will Deacon <will.deacon@arm.com> wrote:

> Hi Linus,
> 
> On Thu, Aug 23, 2018 at 12:37:58PM -0700, Linus Torvalds wrote:
> > On Thu, Aug 23, 2018 at 12:15 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:  
> > >
> > > So right now my "tlb-fixes" branch looks like this:
> > > [..]
> > >
> > > I'll do a few more test builds and boots, but I think I'm going to
> > > merge it in this cleaned-up and re-ordered form.  
> > 
> > In the meantime, I decided to push out that branch in case anybody
> > wants to look at it.
> > 
> > I may rebase it if I - or anybody else - find anything bad there, so
> > consider it non-stable, but I think it's in its final shape modulo
> > issues.  
> 
> Unfortunately, that branch doesn't build for arm64 because of Nick's patch
> moving tlb_flush_mmu_tlbonly() into tlb.h (which I acked!). It's a static
> inline which calls tlb_flush(), which in our case is also a static inline
> but one that is defined in our asm/tlb.h after including asm-generic/tlb.h.
> 
> Ah, just noticed you've pushed this to master! Please could you take the
> arm64 patch below on top, in order to fix the build?

Sorry yeah I had the sign offs but should have clear I hadn't fully
build tested them. It's reasonable for reviewers to assume basic
diligence was done and concentrate on the logic rather than build
trivialities. So that's my bad. Thanks for the fix.

Thanks,
Nick

> 
> Cheers,
> 
> Will
> 
> --->8  
> 
> From 48ea452db90a91ff2b62a94277daf565e715a126 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Fri, 24 Aug 2018 00:23:04 +0100
> Subject: [PATCH] arm64: tlb: Provide forward declaration of tlb_flush() before
>  including tlb.h
> 
> As of commit fd1102f0aade ("mm: mmu_notifier fix for tlb_end_vma"),
> asm-generic/tlb.h now calls tlb_flush() from a static inline function,
> so we need to make sure that it's declared before #including the
> asm-generic header in the arch header.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/tlb.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index 0ad1cf233470..a3233167be60 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -33,6 +33,8 @@ static inline void __tlb_remove_table(void *_table)
>  #define tlb_remove_entry(tlb, entry)	tlb_remove_page(tlb, entry)
>  #endif /* CONFIG_HAVE_RCU_TABLE_FREE */
>  
> +static void tlb_flush(struct mmu_gather *tlb);
> +
>  #include <asm-generic/tlb.h>
>  
>  static inline void tlb_flush(struct mmu_gather *tlb)

