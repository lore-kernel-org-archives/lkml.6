Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C71C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475AD218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmFE2gQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfAaLJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:09:48 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51431 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfAaLJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:09:48 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so3134234ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/a5PEZ4jb8RCGabdztmwVXWnQq+OV4s98oQlZgjXNUk=;
        b=rmFE2gQCRCfgyRJo5eZ/jt6RPIWMjZVbHXnrLbMVX6D8oJddtooDXGgB3H/L7BODBU
         ViwTWdo3EieDKmpPsF6BqlUQFoq6qKZ6XNPzW2nHmhacTfhoY9+x/QJz8MzVtE+imiCM
         UU7NHmbdZk6pwrrLUlGGs7LuoC3O6GhRt7xR3PRNLvaPEifu5KB62BsnPh5OE6Nems4e
         VBUS8R02Jfcu8zmty0A8jNizFOfcWfJAtWzk1kJefdo4Zulb6VJbuKGg2CDJ3Gi8nAPQ
         w3P7s1Io/DtuFEU2kLCN6JzN5u2QJWYQi0HO7J5c8u9UlnrCiYqHf5aJwpbPTeCDXjtE
         pWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/a5PEZ4jb8RCGabdztmwVXWnQq+OV4s98oQlZgjXNUk=;
        b=fWMkyL9kAE0pu9pHVxv1kdjulCvirh/jDKuVfcwt9nDrt2u4a1Jnr6if/3GX9Rsjo4
         tqbmOr1GPIT0yQcOOvoCKjXMYewttp9ag1cBH3h88b5nrOYRgxGyTcDhDJmpkm/sbD9L
         e0SndU6HkAuVJK37OAYLg0oCsqX9KleSnSE05Fnm4NRMoyIshsHgX3g0V6S7VJQSYKUv
         rw2RNMn1beIB7xb8MDsTWwZrtn3jUrtixUtg7vO1NIZSaS4VElXjk9kOeEYUbfz4/hx3
         RmpqiGO5CoDGG0C3CZL5t2eN3njiz+ccPQk/CO7smRo7x9sCfQ5MWh9JWhw3/9LSCbbE
         7W4g==
X-Gm-Message-State: AJcUukfuy7WJWKM7BvS/opvT/PyrrT8LIcW63LCF6yP+mxZA0RRskpfS
        960H2tyCzGd5ntMZf8EGEjNZhHPnww2sUKu6PsCHck9l
X-Google-Smtp-Source: ALg8bN4Geu/O7a8YIq+ZKV6UuIi8T3UfHCubNSpik2za6mgqPHErolfj86bpOsWGpAD5YZR/4JObWdjtbcVouC8t5rQ=
X-Received: by 2002:a24:4641:: with SMTP id j62mr17641679itb.57.1548932986669;
 Thu, 31 Jan 2019 03:09:46 -0800 (PST)
MIME-Version: 1.0
References: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
 <1528987172-19810-3-git-send-email-yamada.masahiro@socionext.com>
 <20180615004704.u5gofft7k6ehmhwi@ast-mbp.dhcp.thefacebook.com> <CAE=NcramE=kqqfq78aXtKLmFSctk7vo-P-478092Lt2c0op_aQ@mail.gmail.com>
In-Reply-To: <CAE=NcramE=kqqfq78aXtKLmFSctk7vo-P-478092Lt2c0op_aQ@mail.gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 31 Jan 2019 13:09:35 +0200
Message-ID: <CAE=NcrZ2iRX6XQj1X6FZag8QK93a467eiyKsd5CEkGkQeMQERg@mail.gmail.com>
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

Never mind, not enough coffee for the morning. Looks good addressing
wise, but something goes haywire with the copy. Some size limitation?

[   84.402647] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1ubuntu1 04/01/2014
[   84.403899] RIP: 0010:__memcpy+0x12/0x20
[   84.404441] Code: c1 e2 20 48 09 d0 48 31 c3 e9 76 ff ff ff 90 90
90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 89 f8 48 89 d1 48 c1 e9 03
83 e2 07 <f3> 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1
f3 a4
[   84.407004] RSP: 0018:ffffc90000ac39c0 EFLAGS: 00010246
[   84.407714] RAX: ffff888041709000 RBX: 0000000000001000 RCX: 0000000000000200
[   84.408667] RDX: 0000000000000000 RSI: ffffffff82a7cb4d RDI: ffff888041709000
[   84.409668] RBP: ffffc90000ac3a08 R08: ffff888041709000 R09: 0000000000000000
[   84.410621] R10: 0000000000000000 R11: 000015fffefa3dbf R12: 0000000000001000
[   84.411710] R13: 0000000000001000 R14: ffffc90000ac3b28 R15: 0000000000001000
[   84.412675] FS:  00007f6cd3a35740(0000) GS:ffff88807da00000(0000)
knlGS:0000000000000000
[   84.413805] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.414655] CR2: ffffffff82a7cb4d CR3: 0000000031344000 CR4: 00000000000006f0
[   84.415656] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.416647] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.417619] Call Trace:
[   84.417996]  ? iov_iter_copy_from_user_atomic+0x21b/0x360
[   84.418754]  ? shmem_write_begin+0x4a/0x80
[   84.419396]  generic_perform_write+0xdd/0x1b0
[   84.419897]  __generic_file_write_iter+0x1ab/0x1d0
[   84.420453]  ? apparmor_file_alloc_security+0x4c/0x230
[   84.421082]  ? kmem_cache_alloc+0x1b5/0x1d0
[   84.421677]  generic_file_write_iter+0xb3/0x150
[   84.422353]  __vfs_write+0x145/0x1d0
[   84.422907]  vfs_write+0xae/0x1a0
[   84.423435]  kernel_write+0x55/0x70
[   84.423996]  fork_usermode_blob+0x85/0x11b
..

ret = fork_usermode_blob(&test_umh_start,
&test_umh_end - &test_umh_start, &um_info);

Addresses indeed seem ok and the '-fpic -fpie -fPIE -static' compiled
user mode blob sits in between those symbols correctly. Hummm ?


--
Janne

On Thu, Jan 31, 2019 at 12:48 PM Janne Karhunen
<janne.karhunen@gmail.com> wrote:
>
> Hi,
>
> Hmm, does this approach work if the code is not in a kernel module? I
> tried to use it as part of the kernel image and looks to me the
> bounding symbols _start and _end are not correctly relocated?
>
> --
> Janne
>
> On Fri, Jun 15, 2018 at 3:48 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jun 14, 2018 at 11:39:31PM +0900, Masahiro Yamada wrote:
> > > What we want here is to embed a user-space program into the kernel.
> > > Instead of the complex ELF magic, let's simply wrap it in the assembly
> > > with the '.incbin' directive.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > > Changes in v2:
> > >   - Rebase
> > >
> > >  net/bpfilter/Makefile            | 15 ++-------------
> > >  net/bpfilter/bpfilter_kern.c     | 11 +++++------
> > >  net/bpfilter/bpfilter_umh_blob.S |  7 +++++++
> > >  3 files changed, 14 insertions(+), 19 deletions(-)
> > >  create mode 100644 net/bpfilter/bpfilter_umh_blob.S
> > >
> > > diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> > > index e0bbe75..39c6980 100644
> > > --- a/net/bpfilter/Makefile
> > > +++ b/net/bpfilter/Makefile
> > > @@ -15,18 +15,7 @@ ifeq ($(CONFIG_BPFILTER_UMH), y)
> > >  HOSTLDFLAGS += -static
> > >  endif
> > >
> > > -# a bit of elf magic to convert bpfilter_umh binary into a binary blob
> > > -# inside bpfilter_umh.o elf file referenced by
> > > -# _binary_net_bpfilter_bpfilter_umh_start symbol
> > > -# which bpfilter_kern.c passes further into umh blob loader at run-time
> > > -quiet_cmd_copy_umh = GEN $@
> > > -      cmd_copy_umh = echo ':' > $(obj)/.bpfilter_umh.o.cmd; \
> > > -      $(OBJCOPY) -I binary -O `$(OBJDUMP) -f $<|grep format|cut -d' ' -f8` \
> > > -      -B `$(OBJDUMP) -f $<|grep architecture|cut -d, -f1|cut -d' ' -f2` \
> > > -      --rename-section .data=.init.rodata $< $@
> > > -
> > > -$(obj)/bpfilter_umh.o: $(obj)/bpfilter_umh
> > > -     $(call cmd,copy_umh)
> > > +$(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
> > >
> > >  obj-$(CONFIG_BPFILTER_UMH) += bpfilter.o
> > > -bpfilter-objs += bpfilter_kern.o bpfilter_umh.o
> > > +bpfilter-objs += bpfilter_kern.o bpfilter_umh_blob.o
> > > diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
> > > index 0952257..6de3ae5 100644
> > > --- a/net/bpfilter/bpfilter_kern.c
> > > +++ b/net/bpfilter/bpfilter_kern.c
> > > @@ -10,11 +10,8 @@
> > >  #include <linux/file.h>
> > >  #include "msgfmt.h"
> > >
> > > -#define UMH_start _binary_net_bpfilter_bpfilter_umh_start
> > > -#define UMH_end _binary_net_bpfilter_bpfilter_umh_end
> > > -
> > > -extern char UMH_start;
> > > -extern char UMH_end;
> > > +extern char bpfilter_umh_start;
> > > +extern char bpfilter_umh_end;
> > >
> > >  static struct umh_info info;
> > >  /* since ip_getsockopt() can run in parallel, serialize access to umh */
> > > @@ -93,7 +90,9 @@ static int __init load_umh(void)
> > >       int err;
> > >
> > >       /* fork usermode process */
> > > -     err = fork_usermode_blob(&UMH_start, &UMH_end - &UMH_start, &info);
> > > +     err = fork_usermode_blob(&bpfilter_umh_end,
> > > +                              &bpfilter_umh_end - &bpfilter_umh_start,
> > > +                              &info);
> > >       if (err)
> > >               return err;
> > >       pr_info("Loaded bpfilter_umh pid %d\n", info.pid);
> > > diff --git a/net/bpfilter/bpfilter_umh_blob.S b/net/bpfilter/bpfilter_umh_blob.S
> > > new file mode 100644
> > > index 0000000..40311d1
> > > --- /dev/null
> > > +++ b/net/bpfilter/bpfilter_umh_blob.S
> > > @@ -0,0 +1,7 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +     .section .init.rodata, "a"
> > > +     .global bpfilter_umh_start
> > > +bpfilter_umh_start:
> > > +     .incbin "net/bpfilter/bpfilter_umh"
> > > +     .global bpfilter_umh_end
> > > +bpfilter_umh_end:
> >
> > for some reason it doesn't work.
> > fork_usermode_blob() returns ENOEXEC
> > You should be able to test it simply running 'iptables -L'.
> > Without this patch you should see:
> > [   12.696937] bpfilter: Loaded bpfilter_umh pid 225
> > Started bpfilter
> >
> > where first line comes from kernel module and second from umh.
> >
> >
