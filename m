Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C857C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354E22183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="rkiHpKAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfAGVxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:53:24 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41077 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfAGVxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:53:23 -0500
Received: by mail-yb1-f194.google.com with SMTP id j10so776790ybj.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ihpYysV7r1UoHl/0ejXOEq8g6731AzB2PM1+Cvg2Kk=;
        b=rkiHpKAKAHcU+nls5ju49i6OLK/vbHYaVlbCwFjsmuPmDAhaVcSUtRcXQWKfA//7tB
         +LbLFCGQyVS7/lIXQ2NVXi9Y7Zff35J13dN54XQ3vP8parrz+pYdb1gYW/OPEhGR/byH
         IQ6JlrxLKcQJOXG1zNn98FIiZAQsWDv/+jeEFMkNSQzzdvr8rkOORbm4kTogZN3F8TAk
         FoWyUptbk6M1d9UUY3SNMHMtdM2AUijH69aMGHKv30HJCySy4R8Cd/liVoXKvdc0SpoJ
         1JvyOeyW8Uq6o7XvMefHfMXv7YJWBMu08YXGejFknDmSjL0ii864nRub85IXDllV8mbU
         peQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ihpYysV7r1UoHl/0ejXOEq8g6731AzB2PM1+Cvg2Kk=;
        b=HwqXri4bjt0+L0zMvfNkOWjlu0rJE1cmlH905QKjQm/tCNqA+//UGQiqHJ+8xZtPJZ
         hSNzoiwkoXoN5V6EVTEj1LO4jLDjzIXE2MDa0m8H2jRUXL6uLEgTDJio/CYt52tPDtbJ
         CgZiW0c9XJyFb9B8hk8kigaC/0lamS883a947+E+dc7rmWQDjcNpPvnPxXn+x5n4QftA
         ubhW96UHzVqWtamZeE90KzDT7TjdYX2tU0Orqm5aRRep25cPyW/Xw0XZUMA1zgXxRTz2
         ZhPRm/DZx3Lwj8Egw1ZmhQ5vXmOEBMduuJw2KM1PRfNNTUJSWTif3+kERfeqvy1GQrn0
         3U9Q==
X-Gm-Message-State: AJcUukdkT9XbSghXZzE4tqksu5I5RGyZfznIBsDgXwgKin+gJdRsxPYr
        SBxWU0sai+tRj4FGPlnFPHb3hg==
X-Google-Smtp-Source: ALg8bN5rs5dGvgTewKZIDsveH6E3785I3EEZnSneWEsZDvSGWc4MSDVQBl4HQ7jbTKnqPqBXPdu4bg==
X-Received: by 2002:a25:3a84:: with SMTP id h126mr26846169yba.87.1546898001731;
        Mon, 07 Jan 2019 13:53:21 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:c092:9114:ac14:211f])
        by smtp.gmail.com with ESMTPSA id h145sm26469437ywc.72.2019.01.07.13.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:53:21 -0800 (PST)
Date:   Mon, 7 Jan 2019 14:53:19 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>, James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] security: seccomp changes for v4.21
Message-ID: <20190107215319.GD29009@cisco>
References: <alpine.LRH.2.21.1812311511360.1435@namei.org>
 <20190107101540.GA87402@gmail.com>
 <CAGXu5jLYe_H_BF5SK2GWjYL9P7RJ9t0oadjDNnDL7UTXfb_Jfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLYe_H_BF5SK2GWjYL9P7RJ9t0oadjDNnDL7UTXfb_Jfw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 07, 2019 at 01:09:09PM -0800, Kees Cook wrote:
> On Mon, Jan 7, 2019 at 2:15 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * James Morris <jmorris@namei.org> wrote:
> >
> > > From Kees:
> > >
> > > "- Add SECCOMP_RET_USER_NOTIF
> > >
> > > - seccomp fixes for sparse warnings and s390 build (Tycho)"
> > >
> > >
> > >
> > > The following changes since commit 1072bd678547f8663cfb81a22fdb50c589e4976e:
> > >
> > >   security: fs: make inode explicitly non-modular (2018-12-12 14:58:51 -0800)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-seccomp
> > >
> > > for you to fetch changes up to 55b8cbe470d103b44104c64dbf89e5cad525d4e0:
> > >
> > >   Merge tag 'seccomp-next-part2' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-seccomp (2018-12-17 11:36:26 -0800)
> > >
> > > ----------------------------------------------------------------
> > > James Morris (2):
> > >       Merge tag 'seccomp-next' of https://git.kernel.org/.../kees/linux into next-seccomp
> > >       Merge tag 'seccomp-next-part2' of https://git.kernel.org/.../kees/linux into next-seccomp
> > >
> > > Tycho Andersen (6):
> > >       seccomp: hoist struct seccomp_data recalculation higher
> > >       seccomp: switch system call argument type to void *
> > >       seccomp: add a return code to trap to userspace
> > >       samples: add an example of seccomp user trap
> > >       seccomp: fix poor type promotion
> > >       seccomp, s390: fix build for syscall type change
> > >
> > >  Documentation/ioctl/ioctl-number.txt           |   1 +
> > >  Documentation/userspace-api/seccomp_filter.rst |  84 +++++
> > >  arch/s390/kernel/compat_wrapper.c              |   2 +-
> > >  include/linux/seccomp.h                        |   9 +-
> > >  include/linux/syscalls.h                       |   2 +-
> > >  include/uapi/linux/seccomp.h                   |  40 ++-
> > >  kernel/seccomp.c                               | 467 ++++++++++++++++++++++++-
> > >  samples/seccomp/.gitignore                     |   1 +
> > >  samples/seccomp/Makefile                       |   7 +-
> > >  samples/seccomp/user-trap.c                    | 375 ++++++++++++++++++++
> > >  tools/testing/selftests/seccomp/seccomp_bpf.c  | 447 ++++++++++++++++++++++-
> > >  11 files changed, 1411 insertions(+), 24 deletions(-)
> > >  create mode 100644 samples/seccomp/user-trap.c
> >
> > 32-bit x86 allyesconfig doesn't build:
> >
> >  /usr/bin/ld: i386:x86-64 architecture of input file `samples/seccomp/user-trap.o' is incompatible with i386 output
> >  /usr/bin/ld: samples/seccomp/user-trap.o: file class ELFCLASS64 incompatible with ELFCLASS32
> >  /usr/bin/ld: final link failed: File in wrong format
> >  collect2: error: ld returned 1 exit status
> >  scripts/Makefile.host:99: recipe for target 'samples/seccomp/user-trap' failed
> >  make[2]: *** [samples/seccomp/user-trap] Error 1
> >
> > Is this a known regression?
> 
> That looks like something is busted in the samples Makefile? Tycho,
> are you able to reproduce this?

Given that the samples build only happens when CROSS_COMPILE is not
set, I'll see about digging up a 32-bit box. But I think the patch
below should fix it, I'll send it out when I actually get it tested.

Sorry for the breakage!

Tycho


From b53b390ab554ef6e5b995ac050718fd62ed0803e Mon Sep 17 00:00:00 2001
From: Tycho Andersen <tycho@tycho.ws>
Date: Mon, 7 Jan 2019 14:46:34 -0700
Subject: [PATCH] samples/seccomp: fix 32-bit build

Both the .o and the actual executable need to be built with -m32 in order
to link correctly.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Reported-by: Ingo Molnar <mingo@kernel.org>
---
 samples/seccomp/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 4920903c8009..a5607668a5c7 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -37,6 +37,7 @@ HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
 HOSTLDLIBS_bpf-direct += $(MFLAG)
 HOSTLDLIBS_bpf-fancy += $(MFLAG)
 HOSTLDLIBS_dropper += $(MFLAG)
+HOSTLDLIBS_user-trap.o += $(MFLAG)
 HOSTLDLIBS_user-trap += $(MFLAG)
 endif
 always := $(hostprogs-m)
-- 
2.19.1

