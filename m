Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC794C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880E820880
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg+1AiPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfA3CkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:40:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34421 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfA3CkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:40:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so9687543pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 18:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLOcDqFhOlGdCjEtJGjlkRWiUM5TQDzU+PN+xuu7AQQ=;
        b=gg+1AiPVDWSxv1CT89tyRfhywYqPstGuKxcoFv/nxfLLg5HRQ3rewk2YnDobzIjorP
         IUjAaRZlWG7CR4UWTkoy8zVVJusNGPi1pMx8YKR8TfvuEH89QCSr/nMyQXpndInHX1ot
         0hvcDPw35yokKBLbw/7cuutiMjEWSpA61N53A3A+9T8KIXfPjcWkHl9kXeUy1znWzeqx
         yv/wIt4E4g5xPLvQWpXLEgF9f6Gc+2EUaGgbMva/1ELKFKbxX3Y+2UzXEwpJbyKF+Jo/
         WJu1aozRaK1nQjtHv7kkAvkzJ/U34/J0s+fQaYxeNcRcs5GxIx5c5PccLE3AiQS4cako
         vlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLOcDqFhOlGdCjEtJGjlkRWiUM5TQDzU+PN+xuu7AQQ=;
        b=lGjb+meWD7yXIBsFUKqQOYrj7OzpFkjZ+TFkZaEvfzID4tNpes21R5l/bPZKLkDeM3
         /saDju5rlYrdEumxbCh+eBTAYHGSbiIqRthQNucq9lwmRLSIwAKKqdea8VQm7wcHp/0a
         S5R3d9w9wr3bENLw+zDqNHTsKVNpTEe7md1MtJP6SgjiEStiHecS71ZL12WnSr2qwikM
         ofOgqPIcNUwHCW2MclBYi8oq7BQikBUQ7N25SyVRnLpF7bllTvO/9JJM+u7EnTaKYPiA
         B2qLvdo04DnCB5G1sXz1jqbQ2gU1qYE3BLHRARNUQW1rT+5l8HuJU/QzH8ZM93F/awt8
         0Ifg==
X-Gm-Message-State: AJcUukdJPZBq9wgv/VE04TTvXO5hEN2mU4I/X1v1IyUDQHEDmBvWHDKK
        REUCYqffWqqQ2oeCo8WBDQTCZt5EWd6Q6VJDk7w=
X-Google-Smtp-Source: ALg8bN6x1ZR3gulClm4Ox1Ttscq/nqrfGIgh15aOlEKNnnuMq2X1AmnNjniRdSJEaiXKodR/4GBsYdS4xa83XcwN6YE=
X-Received: by 2002:a63:5153:: with SMTP id r19mr25806573pgl.281.1548816022812;
 Tue, 29 Jan 2019 18:40:22 -0800 (PST)
MIME-Version: 1.0
References: <5c40aafc.1c69fb81.a0ba0.67a7@mx.google.com> <CAFqt6zZPXcX+Qk_CMNaBhs9=dTJuzv4nQzoj09xWLbMuT6NvDQ@mail.gmail.com>
In-Reply-To: <CAFqt6zZPXcX+Qk_CMNaBhs9=dTJuzv4nQzoj09xWLbMuT6NvDQ@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 30 Jan 2019 08:10:11 +0530
Message-ID: <CAJr6mf3SEpHofW_jr5tne=SGEH=dMwb2yKSxsT-2BPV9HLCnMQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/cell: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:13 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Jan 17, 2019 at 9:49 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Remove linux/syscalls.h which is included more than once
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
>
If no further comment, can we get this patch in queue for 5.1 ?

> > ---
> >  arch/powerpc/platforms/cell/spu_syscalls.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
> > index 263413a..b95d6af 100644
> > --- a/arch/powerpc/platforms/cell/spu_syscalls.c
> > +++ b/arch/powerpc/platforms/cell/spu_syscalls.c
> > @@ -26,7 +26,6 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/binfmts.h>
> > -#include <linux/syscalls.h>
> >
> >  #include <asm/spu.h>
> >
> > --
> > 2.7.4
> >
