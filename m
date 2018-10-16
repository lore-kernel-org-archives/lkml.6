Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65666C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292C32083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8BClnVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292C32083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeJPPf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:35:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36200 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeJPPf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:35:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so22064395wmf.1;
        Tue, 16 Oct 2018 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xv8gWVy3wd6+MpNgWaYlvfQsA9AhGYjwhXzQYX59txQ=;
        b=E8BClnVv02W1JldN1APp+pSQAZXVUI8VY5xjeFT2mB2J46l1sjTWhdef8etfWlmS3I
         Qolj7qkFn9sHEJ+/qSrBSpuunGd72XQXJT9dW4hc6/GNgamx9K60xD1/OuiNsGwLKoTu
         BFjvV9iq2Kct+iQSc1dHncjc6p4lkmTGOhG71/c/Y563PDQ8NzQEMKASG3KGpa/INc8U
         WQBwjIZsidZXM2JmwKLhmITX3yB4zn5U732ne80ymma/0kAoBGVB7MW8JdmV6WxoHeol
         2OySg/7w+tmX6LEVEaaZMHYkTxcXIVuM/6yDGZsP9WzbwBx4C1O4b52wJisHJIutdamj
         cwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xv8gWVy3wd6+MpNgWaYlvfQsA9AhGYjwhXzQYX59txQ=;
        b=n1DjBdgU0mEX9tv5NzV60KPzODqLUV+n9jWJGjuBFFELczz5w33m9z3aQ2bzTGlNNo
         KUoE8c5VfwjdYzELJOxpZl85aXE5pOkWdc/MDBhFGXFKAhw76kMu+VHBThxZIczjlLaG
         zzhFRpAMTvz9Q87bUHanoXA08BuLnQsd3X09c7+afBCtkXf4ONDh5X6aLbGWJX5pwywh
         +KIH2GYjq38rZI2uVkbecCoACUUWxK7AJVAoYtq+gLtc75dB3GMbuZtZ7h9zxWln8BJB
         aSpVH5yvht0UrrathRosbGRBM4sqAOqkrhxddTIp3BHtBbi9UO9Fv2jjSz9V6ohTXafv
         DlmA==
X-Gm-Message-State: ABuFfojViKkcTEopPVv4ukG7eWdHD1hOIZ6oTD1F2h2atKORWVoL6jzy
        jz7bIsyY4mprs5JNofXO7dCNlRP5
X-Google-Smtp-Source: ACcGV62KQRGUxRIYKkkSrKxWuHVKn3RTeQCuuMRrzF7dmNYtqeP97NTAsrkfNWC5KW9GbikxLHTXWA==
X-Received: by 2002:a1c:3c4:: with SMTP id 187-v6mr15450217wmd.90.1539676008291;
        Tue, 16 Oct 2018 00:46:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h78-v6sm13564906wmd.4.2018.10.16.00.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 00:46:47 -0700 (PDT)
Date:   Tue, 16 Oct 2018 09:46:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: linux-next: build failure after merge of the akpm tree
Message-ID: <20181016074645.GA41162@gmail.com>
References: <20181008190341.5e396491@canb.auug.org.au>
 <20181015181445.19448cbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015181445.19448cbc@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Mon, 8 Oct 2018 19:03:41 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the akpm tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > arch/x86/mm/kaslr.c:26:10: fatal error: linux/bootmem.h: No such file or directory
> >  #include <linux/bootmem.h>
> >           ^~~~~~~~~~~~~~~~~
> > 
> > Caused by patch
> > 
> >   "mm: remove include/linux/bootmem.h"
> > 
> > interacting with commit
> > 
> >   3a387c6d96e6 ("x86/kaslr, ACPI/NUMA: Fix KASLR build error")
> > 
> > from the tip tree.
> > 
> > I have added the following patch for today:
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 8 Oct 2018 18:57:00 +1100
> > Subject: [PATCH] x86/kaslr, ACPI/NUMA: fix for linux/bootmem.h removal
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  arch/x86/mm/kaslr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index b3471388288d..ad80bdc690c1 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -23,7 +23,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> >  #include <linux/random.h>
> > -#include <linux/bootmem.h>
> > +#include <linux/memblock.h>
> >  
> >  #include <asm/pgalloc.h>
> >  #include <asm/pgtable.h>
> > -- 
> 
> So the above tip tree patch no longer exists, so this one is also no
> longer needed and I have removed it from the akpm tree today.

Yeah, we are reworking this series in WIP.x86/boot, it probably won't 
make v4.20 so I removed it from -next.

Thanks,

	Ingo
