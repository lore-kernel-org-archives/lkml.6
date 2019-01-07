Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DECC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00E02070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RFFacfrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfAGWEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:04:47 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41292 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfAGWEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:04:47 -0500
Received: by mail-ua1-f67.google.com with SMTP id z24so644236ual.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pJRR0Lx5a/hct1YAPadA585+eAcM5Q7wo9O4lxYJU4=;
        b=RFFacfrHTuT0aKxs9lEXDQEfF6R1q8IpVj4vDw2tuk3STYaWtKI1VCLysj1hui+Zln
         LiO+Ma5zkwsd9xJM24yVkgrdqQxU8CTZb0d1ENJMaRK2DzJqfazwkHuOBetx3rUAKo5O
         HTH5AqaFSS7Hw0DjXe+HsSAcq/2BPdYGkq/G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pJRR0Lx5a/hct1YAPadA585+eAcM5Q7wo9O4lxYJU4=;
        b=XjoWxWmeWNeaS4oQ6M5ho6wFljmMZQpBfnNwJsV8M/+aHJRc5iEFDV4IpZuw65Trvy
         3ARZvWR/hltaFkxC3LSlWnPMO6hUsLgouEHg4daGH+0Ce2QI1WBHAGlmGnfOAbH9kyCq
         paDxeqRhXJdf/ezliLEP/rjlSQ+pEN/5bPmIhG+4whzEFswprUBxoHrIs/YwehU0HdUR
         KgvgmsssV3azWmr44D+iWNugpCRL0pBXE+K1SKXdIapFQFlU5uvYKIrSpm8jRhuv3kUJ
         igy2/zJBT9K+OWFIlIcip0iJnjwWSQcW5ICUFTArNeXCQpIK5d50Zak2SOnKNMx5xTus
         grsA==
X-Gm-Message-State: AJcUukd9Ux95cduuelJhXumOrTzx3jSE2oW1PMMNAH11WWfb0DU6VPuj
        ObW9ORqEGLCWpHJNrnXxM3dURCGJ2hM=
X-Google-Smtp-Source: ALg8bN7CkXCszXApu/DAE7w6ciPeF6yvFM/rINBQ8XnyjViXGiqoDp8DED9KcHcQaar/EFmZdHnR8w==
X-Received: by 2002:ab0:5590:: with SMTP id v16mr22666381uaa.132.1546898685249;
        Mon, 07 Jan 2019 14:04:45 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id w83sm19011059vke.22.2019.01.07.14.04.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 14:04:44 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id j3so658122uap.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:04:43 -0800 (PST)
X-Received: by 2002:ab0:6151:: with SMTP id w17mr24124796uan.114.1546898683440;
 Mon, 07 Jan 2019 14:04:43 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1812311511360.1435@namei.org> <20190107101540.GA87402@gmail.com>
 <CAGXu5jLYe_H_BF5SK2GWjYL9P7RJ9t0oadjDNnDL7UTXfb_Jfw@mail.gmail.com> <20190107215319.GD29009@cisco>
In-Reply-To: <20190107215319.GD29009@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 7 Jan 2019 14:04:32 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKpTU2SeMO10xp3ysYECERuT-0-0TX0AG4+rFwOrvpvpg@mail.gmail.com>
Message-ID: <CAGXu5jKpTU2SeMO10xp3ysYECERuT-0-0TX0AG4+rFwOrvpvpg@mail.gmail.com>
Subject: Re: [GIT PULL] security: seccomp changes for v4.21
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Ingo Molnar <mingo@kernel.org>, James Morris <jmorris@namei.org>,
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

On Mon, Jan 7, 2019 at 1:53 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> Hi,
>
> On Mon, Jan 07, 2019 at 01:09:09PM -0800, Kees Cook wrote:
> > On Mon, Jan 7, 2019 at 2:15 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * James Morris <jmorris@namei.org> wrote:
> > >
> > > > From Kees:
> > > >
> > > > "- Add SECCOMP_RET_USER_NOTIF
> > > >
> > > > - seccomp fixes for sparse warnings and s390 build (Tycho)"
> > > >
> > > >
> > > >
> > > > The following changes since commit 1072bd678547f8663cfb81a22fdb50c589e4976e:
> > > >
> > > >   security: fs: make inode explicitly non-modular (2018-12-12 14:58:51 -0800)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-seccomp
> > > >
> > > > for you to fetch changes up to 55b8cbe470d103b44104c64dbf89e5cad525d4e0:
> > > >
> > > >   Merge tag 'seccomp-next-part2' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-seccomp (2018-12-17 11:36:26 -0800)
> > > >
> > > > ----------------------------------------------------------------
> > > > James Morris (2):
> > > >       Merge tag 'seccomp-next' of https://git.kernel.org/.../kees/linux into next-seccomp
> > > >       Merge tag 'seccomp-next-part2' of https://git.kernel.org/.../kees/linux into next-seccomp
> > > >
> > > > Tycho Andersen (6):
> > > >       seccomp: hoist struct seccomp_data recalculation higher
> > > >       seccomp: switch system call argument type to void *
> > > >       seccomp: add a return code to trap to userspace
> > > >       samples: add an example of seccomp user trap
> > > >       seccomp: fix poor type promotion
> > > >       seccomp, s390: fix build for syscall type change
> > > >
> > > >  Documentation/ioctl/ioctl-number.txt           |   1 +
> > > >  Documentation/userspace-api/seccomp_filter.rst |  84 +++++
> > > >  arch/s390/kernel/compat_wrapper.c              |   2 +-
> > > >  include/linux/seccomp.h                        |   9 +-
> > > >  include/linux/syscalls.h                       |   2 +-
> > > >  include/uapi/linux/seccomp.h                   |  40 ++-
> > > >  kernel/seccomp.c                               | 467 ++++++++++++++++++++++++-
> > > >  samples/seccomp/.gitignore                     |   1 +
> > > >  samples/seccomp/Makefile                       |   7 +-
> > > >  samples/seccomp/user-trap.c                    | 375 ++++++++++++++++++++
> > > >  tools/testing/selftests/seccomp/seccomp_bpf.c  | 447 ++++++++++++++++++++++-
> > > >  11 files changed, 1411 insertions(+), 24 deletions(-)
> > > >  create mode 100644 samples/seccomp/user-trap.c
> > >
> > > 32-bit x86 allyesconfig doesn't build:
> > >
> > >  /usr/bin/ld: i386:x86-64 architecture of input file `samples/seccomp/user-trap.o' is incompatible with i386 output
> > >  /usr/bin/ld: samples/seccomp/user-trap.o: file class ELFCLASS64 incompatible with ELFCLASS32
> > >  /usr/bin/ld: final link failed: File in wrong format
> > >  collect2: error: ld returned 1 exit status
> > >  scripts/Makefile.host:99: recipe for target 'samples/seccomp/user-trap' failed
> > >  make[2]: *** [samples/seccomp/user-trap] Error 1
> > >
> > > Is this a known regression?
> >
> > That looks like something is busted in the samples Makefile? Tycho,
> > are you able to reproduce this?
>
> Given that the samples build only happens when CROSS_COMPILE is not
> set, I'll see about digging up a 32-bit box. But I think the patch
> below should fix it, I'll send it out when I actually get it tested.

Cool, thanks for looking at it! :)

>
> Sorry for the breakage!
>
> Tycho
>
>
> From b53b390ab554ef6e5b995ac050718fd62ed0803e Mon Sep 17 00:00:00 2001
> From: Tycho Andersen <tycho@tycho.ws>
> Date: Mon, 7 Jan 2019 14:46:34 -0700
> Subject: [PATCH] samples/seccomp: fix 32-bit build
>
> Both the .o and the actual executable need to be built with -m32 in order
> to link correctly.
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

And just for tracking:

Fixes: fec7b6690541 ("samples: add an example of seccomp user trap")

Thanks!

-Kees

> Reported-by: Ingo Molnar <mingo@kernel.org>
> ---
>  samples/seccomp/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
> index 4920903c8009..a5607668a5c7 100644
> --- a/samples/seccomp/Makefile
> +++ b/samples/seccomp/Makefile
> @@ -37,6 +37,7 @@ HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
>  HOSTLDLIBS_bpf-direct += $(MFLAG)
>  HOSTLDLIBS_bpf-fancy += $(MFLAG)
>  HOSTLDLIBS_dropper += $(MFLAG)
> +HOSTLDLIBS_user-trap.o += $(MFLAG)
>  HOSTLDLIBS_user-trap += $(MFLAG)
>  endif
>  always := $(hostprogs-m)
> --
> 2.19.1
>


-- 
Kees Cook
