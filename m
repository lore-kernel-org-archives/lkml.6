Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF9FC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166B620665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7sdtj+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166B620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJ1Vay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:30:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35872 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1Vay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:30:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id z17-v6so2584215pgv.3;
        Sun, 28 Oct 2018 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mgLnnM9dgsbh5RM0dMMhXSQBDfIYDiAf2cu8Hc3JC+w=;
        b=e7sdtj+S11jR/QOz3MfyeGjIan9LusQ5i5DNh718jWTn0nmu8r2GDw8wLCi7WYDnRZ
         w9Jgyu3S0u5pfcPcT37kPqvk81F1AhR12vfNcP14teZJr007lJcG+ijiJaBPhQwmUTX8
         hI/3XSjCoVsn9TlcQ4gmqrLMkcevale42od9I0MzwtGDdy5DUzCMJjiojDz7gohw3zYa
         AK1cML6mSop1+4rLHyzxA5VE1jq+fZhlF9+G4J+kUuEJbugZXIN5knj6JFwVn/WdgQuY
         iptvHlFCfBY8pRN15jRb1pEeacVs/rl5994b5wUQn3au9WFDv3L2tN3q9jdOfKhNUcA9
         1amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mgLnnM9dgsbh5RM0dMMhXSQBDfIYDiAf2cu8Hc3JC+w=;
        b=r0mLFrkRx5acSc8I1CMpMrZSMpgaJ0b3zL2dG1n97I/D0jUi2evuC53L7R5GNqGduN
         v84vyeKXRbL//oU5RMVP1xUmrpkuY+DNaUTMmikOOfS+rE/K8xDMG1yCkhoGmuwNd62F
         MVdV1QcXtIcG27IvkYbnKtI3a5ig3ASW7xgi39cuO/1lczlJkPruwA7cDE5yw6rJcRWw
         cgLW+DLJb7I2dtosz+tGQ0SSQHtWcrayH4S/1lWiUTIEQH3AMO7o4AJqqtbUG337miKS
         HrkgdRBfF+NpaMzdvQPgnngyBfA/gbq8X1KlIf/kGFYsE4srQ0tBbRvdHdJbpYuRkKgX
         EdsQ==
X-Gm-Message-State: AGRZ1gJZ0g6L36Dxyqhwm8pLaMPawlH1fcXj+0DFjlmnE/WN3YK0TR3W
        HdQPx9OxtkffqfGT2pRPt7A=
X-Google-Smtp-Source: AJdET5fcoJfYiCf4BbiU2IhDyjRmxQF92k9ZxIDaQz2MT5f8QeLYb6TyLKjUycqXEMQGNyBZ/qD1Sg==
X-Received: by 2002:a65:5a89:: with SMTP id c9-v6mr9832862pgt.216.1540730780552;
        Sun, 28 Oct 2018 05:46:20 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id p13-v6sm6261422pgg.94.2018.10.28.05.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 05:46:20 -0700 (PDT)
Date:   Sun, 28 Oct 2018 12:46:18 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     changbin.du@gmail.com, Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/4] x86/mm: surround level4_kernel_pgt with #ifdef
 CONFIG_X86_5LEVEL...#endif
Message-ID: <20181028124507.4n2sfkm7iteyoud5@mail.google.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
 <20181019124921.13780-2-changbin.du@gmail.com>
 <CAK7LNAQJxVDWU5GPY4O6x+z_Pkmh4KuHiTpkY_LDJwNYO-eCBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQJxVDWU5GPY4O6x+z_Pkmh4KuHiTpkY_LDJwNYO-eCBw@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 10:44:46AM +0900, Masahiro Yamada wrote:
> On Fri, Oct 19, 2018 at 9:50 PM Du Changbin <changbin.du@gmail.com> wrote:
> >
> > The level4_kernel_pgt is only defined when X86_5LEVEL is enabled. So
> > surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif to
> > make code correct.
> 
> For clarification, is it better to mention
> that this is a preparation for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING ?
>
yes, I will update the commit msg.

> 
> > Signed-off-by: Du Changbin <changbin.du@gmail.com>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/x86/include/asm/pgtable_64.h |  2 ++
> >  arch/x86/kernel/head64.c          | 13 ++++++-------
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
> > index 9c85b54bf03c..9333f7fa5bdb 100644
> > --- a/arch/x86/include/asm/pgtable_64.h
> > +++ b/arch/x86/include/asm/pgtable_64.h
> > @@ -16,7 +16,9 @@
> >  #include <linux/threads.h>
> >  #include <asm/fixmap.h>
> >
> > +#ifdef CONFIG_X86_5LEVEL
> >  extern p4d_t level4_kernel_pgt[512];
> > +#endif
> 
> 
> Is this #ifdef  necessary?
> 
> It is harmless to declaring unused stuff.
> 
> 
> 
> >  extern p4d_t level4_ident_pgt[512];
> >  extern pud_t level3_kernel_pgt[512];
> >  extern pud_t level3_ident_pgt[512];
> > diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> > index ddee1f0870c4..4a59ef93c258 100644
> > --- a/arch/x86/kernel/head64.c
> > +++ b/arch/x86/kernel/head64.c
> > @@ -151,16 +151,15 @@ unsigned long __head __startup_64(unsigned long physaddr,
> >
> >         pgd = fixup_pointer(&early_top_pgt, physaddr);
> >         p = pgd + pgd_index(__START_KERNEL_map);
> > -       if (la57)
> > -               *p = (unsigned long)level4_kernel_pgt;
> > -       else
> > -               *p = (unsigned long)level3_kernel_pgt;
> > -       *p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
> > -
> > +#ifdef CONFIG_X86_5LEVEL
> >         if (la57) {
> > +               *p = (unsigned long)level4_kernel_pgt;
> >                 p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
> >                 p4d[511] += load_delta;
> > -       }
> > +       } else
> > +#endif
> > +               *p = (unsigned long)level3_kernel_pgt;
> > +       *p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
> >
> >         pud = fixup_pointer(&level3_kernel_pgt, physaddr);
> >         pud[510] += load_delta;
> > --
> > 2.17.1
> >
> 
> 
> Hmm, this code looks a bit ugly...
> 
> Does the following one liner work with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING ?
> 
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 8047379..579847f 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -97,7 +97,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>         return true;
>  }
>  #else
> -static bool __head check_la57_support(unsigned long physaddr)
> +static __always_inline bool __head check_la57_support(unsigned long physaddr)
>  {
>         return false;
>  }
> 
This is much better. I just declared it as 'inline'. Thanks for your suggestion.

> 
> 
> 
> --
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
