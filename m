Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C12C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA2B21526
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neWtuNUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA2B21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeHQQcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:32:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44006 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeHQQcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:32:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id j21-v6so4526009edp.10;
        Fri, 17 Aug 2018 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zCSnO0M4h0FhU/ufSkUnB2MXdID/A1SGYw/WqSchpJ4=;
        b=neWtuNUJGhBF9V5xFXxzYfJbIG/cm1TgqerKd7Fhub4WuCyTSpplqAtjRewBddP2Oz
         vBAgOctDUg6lY6kxGAu89sXMjeFwK2kt+hL0R6vAWCkollfiYbQ1Qywz9nnFtdo2IPTF
         l6QXEOAj2VMNRRsX0qrRT1vM4FbyoKlNvOR/merl6Ga69TTgKiwIheOCp1cXgXkXVek8
         DvN+S0vFhCZCP1Sczd95lo9HhuC8xUmLTCJdVsU3YM6HH2KvkDl+hrLwxdzgGJX3Hf2r
         VGt7ddlRMVPsL+l3ooOW2NwZlBd7bUCoNbcSl0uSpgtdM+oaq/QecpI6ZApXMbgLZieA
         wXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zCSnO0M4h0FhU/ufSkUnB2MXdID/A1SGYw/WqSchpJ4=;
        b=G0bxJcWwe8aQpP7Hqv0s0JgSvoqQG1syy+32MFDL06nMnk0dWlYXWdvqkAxgrZpQJc
         znoN7Lmx8VrT9J8vuxr84UXvpHARu8qXov8vl4LiKIgdZBr2Rkz7auTAatB/dhg1vz3l
         FRy50ftLLWqApseAue/CMsMLFJFKMnpgbamhjk+Zs9eDf/jl2dVp5eE2waMBZjnQsuyA
         6Svh8cYmWmks7V4G110aysRyxgVU2F2lbVxkUnGkDSk4EOk6GRKYqfKJazTwO8q7ablg
         GyZe5HLTSMtsnGxRcMHZSZpw9u0XSveS7C1+cn03Cwt9LTO4lAsZPGWfodzqB6QIywOs
         TSDw==
X-Gm-Message-State: AOUpUlG7QfV/9ISEtTxZ6qIR+adFWBUJNcZod1R/oipoLWcsOe9SQnDw
        I6Kn46Ol29s7PoJcWJbVxA==
X-Google-Smtp-Source: AA+uWPxdkzXVms+R4lqjFCRQR0db+tqoKPCuEggm17S1iOBM/TFkKC9h3JS0OylbEp/AvNdNQkPIwQ==
X-Received: by 2002:a50:ed8a:: with SMTP id h10-v6mr41942786edr.117.1534512519719;
        Fri, 17 Aug 2018 06:28:39 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id b9-v6sm2664206edk.62.2018.08.17.06.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 06:28:39 -0700 (PDT)
Date:   Fri, 17 Aug 2018 16:28:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc: fixup PDE allocation bloat
Message-ID: <20180817132836.GA18921@avx2>
References: <20180614200956.GB7137@avx2>
 <15003.1529008242@warthog.procyon.org.uk>
 <20180617215732.GA24688@avx2>
 <CALvZod7HXbR1hQ-cZ1=n8as7wBkNMC6T0TbRhpgXNTKviJxgCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod7HXbR1hQ-cZ1=n8as7wBkNMC6T0TbRhpgXNTKviJxgCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 05:06:55PM -0700, Shakeel Butt wrote:
> On Sun, Jun 17, 2018 at 2:57 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > commit 24074a35c5c975c94cd9691ae962855333aac47f
> > ("proc: Make inline name size calculation automatic")
> > started to put PDE allocations into kmalloc-256 which is unnecessary as
> > ~40 character names are very rare.
> >
> > Put allocation back into kmalloc-192 cache for 64-bit non-debug builds.
> >
> > Put BUILD_BUG_ON to know when PDE size is gotten out of control.
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >
> >  fs/proc/inode.c    |    6 ++++--
> >  fs/proc/internal.h |   17 +++++++----------
> >  2 files changed, 11 insertions(+), 12 deletions(-)
> >
> > --- a/fs/proc/inode.c
> > +++ b/fs/proc/inode.c
> > @@ -105,8 +105,10 @@ void __init proc_init_kmemcache(void)
> >                 kmem_cache_create("pde_opener", sizeof(struct pde_opener), 0,
> >                                   SLAB_ACCOUNT|SLAB_PANIC, NULL);
> >         proc_dir_entry_cache = kmem_cache_create_usercopy(
> > -               "proc_dir_entry", SIZEOF_PDE_SLOT, 0, SLAB_PANIC,
> > -               OFFSETOF_PDE_NAME, SIZEOF_PDE_INLINE_NAME, NULL);
> > +               "proc_dir_entry", SIZEOF_PDE, 0, SLAB_PANIC,
> 
> Hi Alexey, can you comment if proc_dir_entry_cache should or shouldn't
> have SLAB_ACCOUNT flag?

It should not (but see below):

SLAB_ACCOUNT is for allocations which can be done by userspace directly:
open(2) directly allocates "struct file".

But /proc entries aren't like that: say, /proc/cpuinfo is created by kernel
and userspace can't do anything about it.

Some subsystems create /proc entries based on userspace actions and
those aren't related to hardware (example: xt_hashlimit.c) but those are
few so kernel doesn't bother accounting those.

Or in other words: user can't mkdir(1) and touch(1) and ln(1) inside /proc
at will and therefore PDEs aren't accounted.
