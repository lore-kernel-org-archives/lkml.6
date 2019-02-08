Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2B2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FAB218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfBHVnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:43:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43235 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfBHVnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:43:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id y4so5658262qtc.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sz315qPOQWUotsNF3IiPAYDvo4I7ne+rHsaOVwZntq8=;
        b=XFQp2rGmuAYsO8Hk3QRM4BGBTF5JWv4KwRWtUnkItQGztNoxCLlMFqbRU1Eb012qNC
         r2fWyNvLkYGiCRKBGu8Oe9JDMr54KUkOD0EKSac0I9FL4EFZzFV3sWq5N7wqp2Jqb4nB
         KqR2QnyF76UAJ1yQbFhZsG2q7/JJfbSzpPGNMShH5D0dDmA3dJxGE2xPtmTZhrp7kzzC
         VKLgRSRvSTv6tLBYXsAa2d0uGZQhUt+N+KvoukY/9yO6IETYsA8/sIy4N7YRI2nC7WuU
         LukGLKjKEDTpO2qbqYe1mKXe0Fs6gOwFmaLaM3es2QyqwJfubysrVB+MsNfA7fNUgFW5
         /e5w==
X-Gm-Message-State: AHQUAuZ6S6cZBrHdFP9TcVh3laZfxN5L3bzCIcunuL55GDIk0l/lmcT/
        CNiSathlSMTr153NFD/z8C2m9g==
X-Google-Smtp-Source: AHgI3Iay2g023XCns8+rGrFFOpUj+s5qZ7rle2bSWxex/3uujrd9wzIrVQS5XfrcqMeih3a41U5SAQ==
X-Received: by 2002:a0c:a144:: with SMTP id d62mr18483043qva.50.1549662220242;
        Fri, 08 Feb 2019 13:43:40 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id x1sm2677484qts.40.2019.02.08.13.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 13:43:39 -0800 (PST)
Date:   Fri, 8 Feb 2019 16:43:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 1/3] x86/mpx: tweak header name
Message-ID: <20190208164206-mutt-send-email-mst@kernel.org>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-2-mst@redhat.com>
 <20190208154239.GI674@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208154239.GI674@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:42:39PM +0100, Borislav Petkov wrote:
> On Fri, Feb 08, 2019 at 01:02:53AM -0500, Michael S. Tsirkin wrote:
> > Use linux/mman.h to make sure we get all mmap flags we need.
> 
> Why, asm/mman.h is not enough or is this fixing a build issue or what is that
> patch supposed to address?

Coding style violation: if a linux/foo.h exists then it must
be included in preference to asm/foo.h

And the specific issue is that a follow-up patch moves code from
asm/mman.h to linux/mman.h so if any one was indirectly using
this header it will now miss the symbols that are being moved.





> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  arch/x86/mm/mpx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
> > index de1851d15699..c805db6236b4 100644
> > --- a/arch/x86/mm/mpx.c
> > +++ b/arch/x86/mm/mpx.c
> > @@ -9,12 +9,12 @@
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/mm_types.h>
> > +#include <linux/mman.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/sched/sysctl.h>
> >  
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> > -#include <asm/mman.h>
> >  #include <asm/mmu_context.h>
> >  #include <asm/mpx.h>
> >  #include <asm/processor.h>
> > -- 
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
