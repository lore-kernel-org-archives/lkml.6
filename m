Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C9C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3751E2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546929972;
	bh=s9Y+vON5n3XJuO1ua+CzxoGW6MpI6RaNzinuVQo44nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1RfAJxdSTi/BCrwYB4SOU1ruoA4UJMQNZVYv+U0zPU/fC+BqoZRj86bRYKED55yIq
	 bt3LpNpMxHWIoOH1RrPFqeuqG8ydtJJytrHNR9V5GByDUePNwcbPus/PNq6cu5KnLX
	 3Xmj8G+tReojuzM3SDu3Kh9zwJ2TFctRC4a0ZO6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfAHGqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:46:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46767 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHGqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:46:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so2824044wrt.13;
        Mon, 07 Jan 2019 22:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zuK6HkvO3B0uEU3KzgvHIbJGzGat93NWoCNGd01DmDs=;
        b=oXLZTAeg2YzwMHECCqZHhGhTr4qBcxNkv6/MWZZdmQX/sidNu6juGKb55DcgOeP4V8
         0v02Oc/XczilCxkJ384z7TGkXIBbyXdzI1m9TTrZ24c6ieyjvtIxuFgp46F/jyrkMGKJ
         JTpmVt1i+bM4YI0BdlXjtcPOKnT0WNdxm4b8FtXPd30RfJ4iTFvlx9O94sM0Ivra17HI
         23WNVdU01z0N4QPM/ReZs1pt3ivYAQnD47v5esrOJ+rqTO2o4pVEo9d9BXp8ic/UxEnQ
         w2TjWpQUSgO/SYGmIKTCLLpOWbFekl9gdYsUtBCKtRx4GzTfj/7Vy6wwvQYgVsxvMiUD
         S5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zuK6HkvO3B0uEU3KzgvHIbJGzGat93NWoCNGd01DmDs=;
        b=nuHPlDtgiuZq2mwHJIGFe529KfrrckD4PJawnKF2+J5WSIIjcZ5B5odBFD5X0vEDV1
         m83AficLc3CMJ02ZuDPLLmEVo1zJ0IGSHiWYAuRiy4hp1d68Gmxh1aYARO9JEYqyLnD2
         qr4nACCpMmyDeh/aI0r4C6Jkeis5mq9ZY7dcHVPcYS/QSawNconPjkd5x461dmLcI+pU
         ZblTYWhUCU7JNUFzhSaxuuJ16CNcMthkWfgxuMnho29+nadsSV+TslC4d7NfR44Gb+8K
         lNikPnZ29a125pv9TZKwZ3AHj/YbsiLIwvpTRtPTd3BWKRD2hHK2zw+lGgPZKwrgA5rn
         k6Cw==
X-Gm-Message-State: AJcUukcNZ0XkixHqTNXTc/pHVxQnVoBwS8t+KmLnmfjNALZXZy6GiH8T
        8FcozwtGjKeAm4P7FkV/Ry0=
X-Google-Smtp-Source: ALg8bN6LNBIYg8x94z43YyepipvGoic7Zru/DSjJOLz3gvv38gGN9EV1SUa2Qz17hltcc9KV40ZPgQ==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr401487wrw.311.1546929968407;
        Mon, 07 Jan 2019 22:46:08 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 3sm9292758wmw.46.2019.01.07.22.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 22:46:07 -0800 (PST)
Date:   Tue, 8 Jan 2019 07:46:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] security: seccomp changes for v4.21
Message-ID: <20190108064605.GB102319@gmail.com>
References: <alpine.LRH.2.21.1812311511360.1435@namei.org>
 <20190107101540.GA87402@gmail.com>
 <CAGXu5jLYe_H_BF5SK2GWjYL9P7RJ9t0oadjDNnDL7UTXfb_Jfw@mail.gmail.com>
 <20190107215319.GD29009@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107215319.GD29009@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tycho Andersen <tycho@tycho.ws> wrote:

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

That did the trick - thanks!

	Ingo
