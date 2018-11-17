Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ABFC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE5F20869
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="UC8/H4si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE5F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbeKQNYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:24:52 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40658 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:24:51 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so162317ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 19:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdXTma+heCG1NQmiQLpbKj/0h295HXhNL04xMwtD4/c=;
        b=UC8/H4si50DBfyCs4w0RGJGkRQl6Le9lijQ/wVvOHmGtV3/nBrKrlwKWPO5GNaGClO
         snFE9Dcqcy3Hj1HsmWd/gsGSiM3IJvmvgwz8ur+GQ4gGS9g9PC3zNSrR3+dzzNRN6q0V
         AZ/NL1beNAqFom/oeCzh7eNBS7DIX0XrqpfKaNcDlOQtCfsst3Oet+SyL0DC0VL+YXV4
         X73R8b6+QHzj6kYpFoJC2ELmdLl1Rn7KazVd0ysigqK0pAoFSB5rDCi65C/i5ty3NggY
         5OAXXq2rnY4UlmT5n+sDR8ryRsOOiONoB7X/idKXofo3bJhkEw/FlEXxRa+HICN1KIuz
         grUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdXTma+heCG1NQmiQLpbKj/0h295HXhNL04xMwtD4/c=;
        b=HgSIj/usfXVOjjHzouQD3PSAmOJ1puqnH1vms6YiBOq/aQPXyU96wWDqzW0RdW5eO3
         YQIeJFw8dOkEnd4tEN7o0d1INZGs1uHDsetW7sbnnjfmxHI4IUvcQal4cHJf9zX+7Iz7
         TiEJ6uYlum2aUSHflu87BuRXYI+n7IyyNZhpzDKZIGA2PkFVxFW49SjZ9/i/dBsfyjnf
         lG2FI0GouoS2+tBbXDdEyFt0oVABY0hMfWqrSkz+Y+5YAqGAm5PJpHXRlhKQknvatgpY
         tNVhqkdil8I6a5TvzATLvrKA5KkDc7e7pWuo6+DJYKjWp5+DeiW6rJkqdYVYre+C2Iir
         KfxQ==
X-Gm-Message-State: AA+aEWai3M1VD6Z2E46gKg71UA3UNQ8jbZnTLkKMRL4nqgj8qyzR2h5u
        17nLsT8KazhQQU3PgVPQlCicfzzSAh4g0aycjBYQLJLI8y8=
X-Google-Smtp-Source: AFSGD/Xq0iwm/01B4NFxTy4/HI6+AgjJf1B0cgGQlsE4dxnx3ujDZwrNl1JmsaC3hdQAoQu6ewxB1+OJr4wajvhWnGg=
X-Received: by 2002:a24:70ca:: with SMTP id f193-v6mr732552itc.59.1542424186888;
 Fri, 16 Nov 2018 19:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20181108190700.30825-1-david.abdurachmanov@gmail.com> <mhng-1888c072-5274-457c-aa26-b9fa9cb246dd@palmer-si-x1c4>
In-Reply-To: <mhng-1888c072-5274-457c-aa26-b9fa9cb246dd@palmer-si-x1c4>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 16 Nov 2018 19:09:36 -0800
Message-ID: <CAOesGMjzOkPNv7v_uMMsCw=20NuebPvkLBS5b5eaS9Z6=p1qKg@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix warning in arch/riscv/include/asm/module.h
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 11:32 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 08 Nov 2018 11:07:00 PST (-0800), david.abdurachmanov@gmail.com wrote:
> > Fixes warning: 'struct module' declared inside parameter list will not be
> > visible outside of this definition or declaration
> >
> > Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> > ---
> >  arch/riscv/include/asm/module.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
> > index 349df33808c4..cd2af4b013e3 100644
> > --- a/arch/riscv/include/asm/module.h
> > +++ b/arch/riscv/include/asm/module.h
> > @@ -8,6 +8,7 @@
> >
> >  #define MODULE_ARCH_VERMAGIC    "riscv"
> >
> > +struct module;
> >  u64 module_emit_got_entry(struct module *mod, u64 val);
> >  u64 module_emit_plt_entry(struct module *mod, u64 val);
>
> Works for me.  Looks like arm64 might have exactly the same issue.  I'll roll
> it up into the next RC.

Looks like it's still here in -next. So, patch:

Acked-by: Olof Johansson <olof@lixom.net>

(and it'd be great to pickup together with the 32-bit build fix).


-Olof
