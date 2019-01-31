Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760BFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420E1218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYlUc6mT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbfAaKsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:48:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37644 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaKsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:48:45 -0500
Received: by mail-io1-f65.google.com with SMTP id g8so2255609iok.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOWeD1lffQFlCDDwymLyvgtIZYcUMxhiK45aZewETI0=;
        b=gYlUc6mT6/fz5ZR8zRy9afeJLjc3P0BjczdHkHsuU2Ql12EWvXneLRBOtjlUqbPkcb
         FvTnHMuLn0Dl/whbwfBObs0FuW0ju1/UancNiU88GxKHXw63UsO6Ogebr31/TRWigL2b
         goHFSF1iJoSVwNj9XzkpE7GGLfLax5tpSH0QIjqVzbspfSkERGS+QDqrYsnlNTHg0q9N
         rVVkfmnv0jJVvaI6KgpKT+/4KLik1BiAs/SVMwYT7uJxhzlnFYoqBH+7+1JN2Z11fmqa
         8cluw2V2ZaJgZeRfh0J8XY+h+tD6can6KnUdMhvYztOUjRAC2chPCDi8cFZ9OG1Ottt1
         kYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOWeD1lffQFlCDDwymLyvgtIZYcUMxhiK45aZewETI0=;
        b=heDiZeh4wHqV8KPlcsaf4GNkDbrGTNLNo+n8unO1STBf6vV9wHG9cT5a3ACT1F1oFe
         QUvSGWrxwhMpjgTFd6Sg7PHmh2i/k8pzQCIw9ZT8Laye1qxPghsrZRRW9xPBHNg02Yeg
         N4GFERmHeg3VayBAlitOkBlFPrOabUBCc+AwNLoyJ+DY0uXwVJUhYhFSZUYWitVbN+N6
         e5mQBWeSC8SqCLGrOjAuuDFPulK4HgfLFjCkFcvXzIyclRXoackOJM8klc0VvFsEzuh7
         LX7mRh9dtqgowe5NGtRZIHmpLcSCI7xFE+POncuOpkMRiqThFlZHj0UY8wT7S+a8+aIo
         l5Wg==
X-Gm-Message-State: AHQUAuZbZLQYel1g11ys9w6eNBkf/ddKyNmhbHCzpLWUESaGr2y+AyX7
        /1kbH7utrRgGdyLgR+cuW25wJfhULR0Rjbs6Okc=
X-Google-Smtp-Source: AHgI3IaDtS2D+NlBqxxsH/R7SYrIurjsjCV9HsXNkZMTcxatVFVszy6KGK+L4JCE2WpcqxEFfLOx3rlIDW5cesD3r2g=
X-Received: by 2002:a6b:14c6:: with SMTP id 189mr19651365iou.179.1548931724154;
 Thu, 31 Jan 2019 02:48:44 -0800 (PST)
MIME-Version: 1.0
References: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
 <1528987172-19810-3-git-send-email-yamada.masahiro@socionext.com> <20180615004704.u5gofft7k6ehmhwi@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20180615004704.u5gofft7k6ehmhwi@ast-mbp.dhcp.thefacebook.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 31 Jan 2019 12:48:33 +0200
Message-ID: <CAE=NcramE=kqqfq78aXtKLmFSctk7vo-P-478092Lt2c0op_aQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] bpfilter: include bpfilter_umh in assembly instead
 of using objcopy
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hmm, does this approach work if the code is not in a kernel module? I
tried to use it as part of the kernel image and looks to me the
bounding symbols _start and _end are not correctly relocated?

--
Janne

On Fri, Jun 15, 2018 at 3:48 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 14, 2018 at 11:39:31PM +0900, Masahiro Yamada wrote:
> > What we want here is to embed a user-space program into the kernel.
> > Instead of the complex ELF magic, let's simply wrap it in the assembly
> > with the '.incbin' directive.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Changes in v2:
> >   - Rebase
> >
> >  net/bpfilter/Makefile            | 15 ++-------------
> >  net/bpfilter/bpfilter_kern.c     | 11 +++++------
> >  net/bpfilter/bpfilter_umh_blob.S |  7 +++++++
> >  3 files changed, 14 insertions(+), 19 deletions(-)
> >  create mode 100644 net/bpfilter/bpfilter_umh_blob.S
> >
> > diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> > index e0bbe75..39c6980 100644
> > --- a/net/bpfilter/Makefile
> > +++ b/net/bpfilter/Makefile
> > @@ -15,18 +15,7 @@ ifeq ($(CONFIG_BPFILTER_UMH), y)
> >  HOSTLDFLAGS += -static
> >  endif
> >
> > -# a bit of elf magic to convert bpfilter_umh binary into a binary blob
> > -# inside bpfilter_umh.o elf file referenced by
> > -# _binary_net_bpfilter_bpfilter_umh_start symbol
> > -# which bpfilter_kern.c passes further into umh blob loader at run-time
> > -quiet_cmd_copy_umh = GEN $@
> > -      cmd_copy_umh = echo ':' > $(obj)/.bpfilter_umh.o.cmd; \
> > -      $(OBJCOPY) -I binary -O `$(OBJDUMP) -f $<|grep format|cut -d' ' -f8` \
> > -      -B `$(OBJDUMP) -f $<|grep architecture|cut -d, -f1|cut -d' ' -f2` \
> > -      --rename-section .data=.init.rodata $< $@
> > -
> > -$(obj)/bpfilter_umh.o: $(obj)/bpfilter_umh
> > -     $(call cmd,copy_umh)
> > +$(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
> >
> >  obj-$(CONFIG_BPFILTER_UMH) += bpfilter.o
> > -bpfilter-objs += bpfilter_kern.o bpfilter_umh.o
> > +bpfilter-objs += bpfilter_kern.o bpfilter_umh_blob.o
> > diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
> > index 0952257..6de3ae5 100644
> > --- a/net/bpfilter/bpfilter_kern.c
> > +++ b/net/bpfilter/bpfilter_kern.c
> > @@ -10,11 +10,8 @@
> >  #include <linux/file.h>
> >  #include "msgfmt.h"
> >
> > -#define UMH_start _binary_net_bpfilter_bpfilter_umh_start
> > -#define UMH_end _binary_net_bpfilter_bpfilter_umh_end
> > -
> > -extern char UMH_start;
> > -extern char UMH_end;
> > +extern char bpfilter_umh_start;
> > +extern char bpfilter_umh_end;
> >
> >  static struct umh_info info;
> >  /* since ip_getsockopt() can run in parallel, serialize access to umh */
> > @@ -93,7 +90,9 @@ static int __init load_umh(void)
> >       int err;
> >
> >       /* fork usermode process */
> > -     err = fork_usermode_blob(&UMH_start, &UMH_end - &UMH_start, &info);
> > +     err = fork_usermode_blob(&bpfilter_umh_end,
> > +                              &bpfilter_umh_end - &bpfilter_umh_start,
> > +                              &info);
> >       if (err)
> >               return err;
> >       pr_info("Loaded bpfilter_umh pid %d\n", info.pid);
> > diff --git a/net/bpfilter/bpfilter_umh_blob.S b/net/bpfilter/bpfilter_umh_blob.S
> > new file mode 100644
> > index 0000000..40311d1
> > --- /dev/null
> > +++ b/net/bpfilter/bpfilter_umh_blob.S
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +     .section .init.rodata, "a"
> > +     .global bpfilter_umh_start
> > +bpfilter_umh_start:
> > +     .incbin "net/bpfilter/bpfilter_umh"
> > +     .global bpfilter_umh_end
> > +bpfilter_umh_end:
>
> for some reason it doesn't work.
> fork_usermode_blob() returns ENOEXEC
> You should be able to test it simply running 'iptables -L'.
> Without this patch you should see:
> [   12.696937] bpfilter: Loaded bpfilter_umh pid 225
> Started bpfilter
>
> where first line comes from kernel module and second from umh.
>
>
