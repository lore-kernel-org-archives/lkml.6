Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DA8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3C820896
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koOAXpcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3C820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbeKNMVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:21:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43128 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeKNMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:21:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id g59-v6so6973662plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 18:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Nn8Ur6IMqBLARyk5azxZGBBPdC2BvYXrwANo9dQnAM=;
        b=koOAXpcKULybhGOSXLzvVz9kv5p2UfZ5tgfQjRpNm8XrJuyOiavkeOLqS/4rgZbJ4o
         Ey/40JA7GtsAnVIhP2aW43YCzFr0h4Cf0XNjBtReWVXKo4AkPaoPtryEk7IAVFpXcpir
         tnwZfomCRADFHW9ivlc97GqUTUAWe2i3E8v1638YAh6LluzN9KAv+PyJj2y/TN+rM8Bv
         3tnvOdmOHhbNCLfXgyLKvYwEtwGkzNGqUJp+QV8/7uWgNPapBbQ1WVp8d89FSjJElVXH
         HmYd48Ar38rgj7bxQ9/wB4T1vT8DiWbP3JQiEZ1PKtPOz/FBV/GPOAVMbKpEV3lv4y46
         ntcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Nn8Ur6IMqBLARyk5azxZGBBPdC2BvYXrwANo9dQnAM=;
        b=sL/A76BG2LCin8HAGLOqss8/mL4uE7468L01rBIWI7wVjLy2lydm9Tn9nrQWTWDgC2
         a8EY+AsiBwoaqLEYSDxoEW74sUxmbHl7VAVYFJG+2zZtu2rwytxm0ke3xJrVzh8PMVaB
         ZCytMzBqfcutbXkzKMSYZSOnomumSdD+yq2JXm55X6BggKyuREU5L4z/N0KlZ3UEm8JY
         uCnYoQKfSiO5PDEo1zClOuB9Hh7sCEnBck9RkQbp2K9V76zbXDs4tfPgLEoG44Vr3IYW
         Paz+7Hn4xs8hxNON7cJJ+kWtbuhNCr8IhE5vRcqGnOhiY/XpDeAeOy8rioUahRjKUyp9
         4Szw==
X-Gm-Message-State: AGRZ1gJ2GtKYqrqsT9Bb/WPuonI/z945lPnlI/YzeFl7zj+pQzAqG+9R
        MIlr/+G7lnhKeZtV4sBdtfg=
X-Google-Smtp-Source: AJdET5e+Oo2qy+7TmtA2Yk0p1knWH44DFMPtNAcYZMOQYOo/Fv/mep5nneD+lOe1wDaE6+RP7GEV5g==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1-v6mr75651plt.34.1542161995765;
        Tue, 13 Nov 2018 18:19:55 -0800 (PST)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id s2-v6sm44776271pfk.133.2018.11.13.18.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 18:19:55 -0800 (PST)
Date:   Wed, 14 Nov 2018 02:19:53 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] openrisc: make function cache_loop() inline
Message-ID: <20181114021952.r4wvjrvgy6hb24xh@mail.google.com>
References: <20181112155544.7230-1-changbin.du@gmail.com>
 <20181113204953.GF2718@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113204953.GF2718@lianli.shorne-pla.net>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 05:49:53AM +0900, Stafford Horne wrote:
> On Mon, Nov 12, 2018 at 11:55:44PM +0800, Changbin Du wrote:
> > The third operand of mtspr instruction must be a constraint. To guarantee
> > this condition, function cache_loop() which uses macro mtspr() must be
> > inlined. So let's force it as 'inline'. This is to fix compiling error with
> > new option CONFIG_NO_AUTO_INLINE.
> 
> Thanks for looking at this.
> 
> Do you mean, must be a 'constant'?
>
yes, it is 'constant'.  sorry for the misstake.
> I think this fix is fine for now.  Can you add it to your 'kernel hacking: GCC
> optimization for better debug experience' series?
> 
hi Yamada, could you add this patch to your kbuild tree? thanks!

> > In file included from arch/openrisc/mm/cache.c:17:0:
> > arch/openrisc/mm/cache.c: In function 'cache_loop':
> > arch/openrisc/include/asm/spr.h:20:27: warning: asm operand 0 probably doesn't match constraints
> >                               ^
> > arch/openrisc/mm/cache.c:29:3: note: in expansion of macro 'mtspr'
> >       mtspr(reg, line);
> >       ^~~~~
> > arch/openrisc/include/asm/spr.h:20:27: error: impossible constraint in 'asm'
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> Acked-by: Stafford Horne <shorne@gmail.com>
> 
> > ---
> >  arch/openrisc/mm/cache.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
> > index b747bf1fc1b6..4a4b2b6e006b 100644
> > --- a/arch/openrisc/mm/cache.c
> > +++ b/arch/openrisc/mm/cache.c
> > @@ -20,7 +20,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/tlbflush.h>
> >  
> > -static void cache_loop(struct page *page, const unsigned int reg)
> > +static inline void cache_loop(struct page *page, const unsigned int reg)
> >  {
> >  	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
> >  	unsigned long line = paddr & ~(L1_CACHE_BYTES - 1);
> > -- 
> > 2.17.1
> > 

-- 
Thanks,
Changbin Du
