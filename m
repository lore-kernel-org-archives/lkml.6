Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE95C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C072089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DGHbVUV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfAGVJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:09:26 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45073 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfAGVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:09:25 -0500
Received: by mail-vs1-f67.google.com with SMTP id x28so1116296vsh.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=up1MW20yEfSNO6kjzw/ThzXsTljbPgzfQgz+1UwjdnE=;
        b=DGHbVUV5gdm2AAWcbnDV8PxQ4RIiu8swDmyjv91s2px9gLnuA3FBfLRxvCeRUdJCGJ
         W+vzMh7j9nH9Fy8aygdN+2jnPdv53t5st/PPWdH07USj4Z2uuLgAP8cn0BklFGmgSVBH
         AW2dWs+7HXWQDO0Qepk3M+lbzHEnPhyf/15ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=up1MW20yEfSNO6kjzw/ThzXsTljbPgzfQgz+1UwjdnE=;
        b=Y4v7snfnNGShPwWiE4mbOta8TqhZZpnTUVYqcB8p8QLfPDx5tCA5LBt0bBt1rPriFt
         aTRL/8FA40j989dBCmfIgUFlYy68AF8eMaZVzRNEkCtAnLhT+X9vBJBVUQgSegbgJmx3
         pFxTogGhZGzn4L+ewSJBRqWXHFfhyaVS7gUsvafBgmkwkf9puKicnXXFNJLIrN4C7xDX
         Df+eLuhiqyTJgRtN4PTFxKxbCqgvcGE6rjebQstnafI8TQsJE5sIfr6fSEw753x95nCF
         ZpBbybtR4AmITbgaGBWGtwsp0aOUUWRa9ElSLCelPgSSMIj4wONVYc3D0w2JFFAHt8ql
         DVgg==
X-Gm-Message-State: AJcUukeBPYy/i+T3K9mD8rwB0u3fZDvyUPYkQsEN0BVN4KJfx4/5zo2J
        mbiDNsc4aT8KzhoPVsM6graIt6W+3aM=
X-Google-Smtp-Source: AFSGD/VpuZboITigWJQQwoU40nZbcVeDQq6k2QcmHAQ34Uqnz3MXdDT0bwMuVJr66hBP7QVQgNEdRA==
X-Received: by 2002:a67:e983:: with SMTP id b3mr25504688vso.231.1546895364140;
        Mon, 07 Jan 2019 13:09:24 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 67sm19276572uas.1.2019.01.07.13.09.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 13:09:23 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id 197so417008vkf.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:09:22 -0800 (PST)
X-Received: by 2002:a1f:3d10:: with SMTP id k16mr23120881vka.13.1546895361430;
 Mon, 07 Jan 2019 13:09:21 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1812311511360.1435@namei.org> <20190107101540.GA87402@gmail.com>
In-Reply-To: <20190107101540.GA87402@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 7 Jan 2019 13:09:09 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLYe_H_BF5SK2GWjYL9P7RJ9t0oadjDNnDL7UTXfb_Jfw@mail.gmail.com>
Message-ID: <CAGXu5jLYe_H_BF5SK2GWjYL9P7RJ9t0oadjDNnDL7UTXfb_Jfw@mail.gmail.com>
Subject: Re: [GIT PULL] security: seccomp changes for v4.21
To:     Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 2:15 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * James Morris <jmorris@namei.org> wrote:
>
> > From Kees:
> >
> > "- Add SECCOMP_RET_USER_NOTIF
> >
> > - seccomp fixes for sparse warnings and s390 build (Tycho)"
> >
> >
> >
> > The following changes since commit 1072bd678547f8663cfb81a22fdb50c589e4976e:
> >
> >   security: fs: make inode explicitly non-modular (2018-12-12 14:58:51 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-seccomp
> >
> > for you to fetch changes up to 55b8cbe470d103b44104c64dbf89e5cad525d4e0:
> >
> >   Merge tag 'seccomp-next-part2' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-seccomp (2018-12-17 11:36:26 -0800)
> >
> > ----------------------------------------------------------------
> > James Morris (2):
> >       Merge tag 'seccomp-next' of https://git.kernel.org/.../kees/linux into next-seccomp
> >       Merge tag 'seccomp-next-part2' of https://git.kernel.org/.../kees/linux into next-seccomp
> >
> > Tycho Andersen (6):
> >       seccomp: hoist struct seccomp_data recalculation higher
> >       seccomp: switch system call argument type to void *
> >       seccomp: add a return code to trap to userspace
> >       samples: add an example of seccomp user trap
> >       seccomp: fix poor type promotion
> >       seccomp, s390: fix build for syscall type change
> >
> >  Documentation/ioctl/ioctl-number.txt           |   1 +
> >  Documentation/userspace-api/seccomp_filter.rst |  84 +++++
> >  arch/s390/kernel/compat_wrapper.c              |   2 +-
> >  include/linux/seccomp.h                        |   9 +-
> >  include/linux/syscalls.h                       |   2 +-
> >  include/uapi/linux/seccomp.h                   |  40 ++-
> >  kernel/seccomp.c                               | 467 ++++++++++++++++++++++++-
> >  samples/seccomp/.gitignore                     |   1 +
> >  samples/seccomp/Makefile                       |   7 +-
> >  samples/seccomp/user-trap.c                    | 375 ++++++++++++++++++++
> >  tools/testing/selftests/seccomp/seccomp_bpf.c  | 447 ++++++++++++++++++++++-
> >  11 files changed, 1411 insertions(+), 24 deletions(-)
> >  create mode 100644 samples/seccomp/user-trap.c
>
> 32-bit x86 allyesconfig doesn't build:
>
>  /usr/bin/ld: i386:x86-64 architecture of input file `samples/seccomp/user-trap.o' is incompatible with i386 output
>  /usr/bin/ld: samples/seccomp/user-trap.o: file class ELFCLASS64 incompatible with ELFCLASS32
>  /usr/bin/ld: final link failed: File in wrong format
>  collect2: error: ld returned 1 exit status
>  scripts/Makefile.host:99: recipe for target 'samples/seccomp/user-trap' failed
>  make[2]: *** [samples/seccomp/user-trap] Error 1
>
> Is this a known regression?

That looks like something is busted in the samples Makefile? Tycho,
are you able to reproduce this?

-Kees

-- 
Kees Cook
