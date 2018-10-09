Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39ECC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ABD20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdkTIMiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ABD20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJIMu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:50:59 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36091 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIMu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:50:58 -0400
Received: by mail-yb1-f195.google.com with SMTP id 5-v6so151077ybf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 22:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJXZ+n4IgkZxRAPBoWICtVIXq5V6GtuPdnhCHK1Q1XQ=;
        b=VdkTIMiP7AijPcbhy2qmmmhpgubd1RIdk5DA6zoHtUxUr8iqrMCMBeKInRVywSP23d
         qwg9hwZotznCLPpETsjmN7HhO72HQPzrKxY3j1RvFAD8yTcRWUNRHNbA3nriiMeWygL5
         ifg+sqQ04gwD/k6MPpKyveEG5rmNUv2hBPnnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJXZ+n4IgkZxRAPBoWICtVIXq5V6GtuPdnhCHK1Q1XQ=;
        b=blIx/fvl0P29+5Lzsgso1g4nrsH8kQYVMOjx6uvvt8VdcEonp07poxS21DtgBwTBeg
         nJDaw9UDOOvnOovUpQbvgdPpBEBZlPqE8kEdqbIpskMA+qt80MxMkewRAr4dkqtRMs5j
         eB7p69ubwGuGPnlgIqliZFrRqatnI6ezNwjdYo5nTUVo1p4cimdXf1kJHhKRyUfExWBi
         xdLX/gGhUuQWUhPP7rEsK+6B7x5nnHbbmUZSe4iDo5z05GcTmxC8uL0DNJsYMXmEpvUJ
         iKArd7I2DBsxNXmSn0Bdr5yXS/nogtY94L2caGFQUTt2s38Slfo9KFHe+/5CFt2dIJZm
         g0nQ==
X-Gm-Message-State: ABuFfohiODqmUKocOtUOxQJkmTeSD4XMPOrnGqQpWCXUSiCqqtACOTCB
        2uCestqotCNbNFukpYtmJfJYWasOlB9mIvxCCtGPwg==
X-Google-Smtp-Source: ACcGV60XRw/PII7v8J+U2PDGEx+8Jl0bSsGxY0Hz8bzUifia5vgo6iJ5/JrY0DfMhJ4mR+5AvojWc8nJqwwAPPvpsww=
X-Received: by 2002:a5b:850:: with SMTP id v16-v6mr14815258ybq.393.1539063347880;
 Mon, 08 Oct 2018 22:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-4-git-send-email-firoz.khan@linaro.org> <CALxhOnj4r_MUuAa2zvkvxvhQttEvCZ98n2dA9d6CYyvVf2rB3g@mail.gmail.com>
 <20181008130301.GM32759@asgard.redhat.com> <CAK8P3a0eoCVBVOZs0VwybAnUw0OUoW4Z=NJYi8686EHKj076_Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0eoCVBVOZs0VwybAnUw0OUoW4Z=NJYi8686EHKj076_Q@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 9 Oct 2018 11:05:36 +0530
Message-ID: <CALxhOniJZGNCP+Xw_9EF8hnUEG_AWwrnQ86Gbh7vAW6SrE8ykQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] parisc: add system call table generation support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     esyr@redhat.com, linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugene, Arnd,

On Mon, 8 Oct 2018 at 19:27, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 8, 2018 at 3:02 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
> > > On Mon, 8 Oct 2018 at 10:47, Firoz Khan <firoz.khan@linaro.org> wrote:
> > > > diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> >
> > > > +84      common  lstat                           sys_newlstat                    compat_sys_newlstat
> > > > +85      common  readlink                        sys_readlink
> > > > +86      common  uselib                          sys_ni_syscall
> >
> > Why uselib is declared, contrary to all the skipped syscalls below,
> > that were sys_ni_syscall previously? Only __NR_socketcall was explicitly
> > undefined in arch/parisc/include/uapi/asm/unistd.h.
>
> Good catch, I didn't see that in my earlier review. I agree we want the
> files to be identical to the version they replace, so the macros need to
> be there for now.
>
> We may later decide to clean this up and remove all __NR_* that have
> no entry point, but the conversion to the new table format needs to
> otherwise be a nop.
>
> > > > +87      common  swapon                          sys_swapon
> > > > +88      common  reboot                          sys_reboot
> > > > +89      common  mmap2                           sys_mmap2
> > > > +90      common  mmap                            sys_mmap
> > > > +91      common  munmap                          sys_munmap
> > > > +92      common  truncate                        sys_truncate                    compat_sys_truncate
> > > > +93      common  ftruncate                       sys_ftruncate                   compat_sys_ftruncate
> > > > +94      common  fchmod                          sys_fchmod
> > > > +95      common  fchown                          sys_fchown
> > > > +96      common  getpriority                     sys_getpriority
> > > > +97      common  setpriority                     sys_setpriority
> > > > +98      common  recv                            sys_recv
> > > > +99      common  statfs                          sys_statfs                      compat_sys_statfs
> > > > +100     common  fstatfs                         sys_fstatfs                     compat_sys_fstatfs
> > > > +101     common  stat64                          sys_stat64
> >
> > It is probably worth adding a comment here that syscall 102 was
> > socketcall, in order to make reason for this jump in syscall numeration
> > self-evident.
>
> +1
>
> In general, I'd argue we want to keep all the nontrivial comments that
> were present in either unistd.h or syscall_table.S.

unistd_32.h, unistd_64.h, syscall_table_32.h, syscall_table_64.h and
syscall_table_c32.h
are generated files. unistd.h and syscall_table.S file include
generated files. I had the
support to keep the comments in the generated files.

Eg:- from github
https://github.com/frzkhn/system_call_table_generator/blob/5fe5fb5a3ad457b234e7600d8a4b61b2e3629acd/ia64/syscall.tbl#L105

But I got to know the generated file don't carry any license info and
comment section. That's
why I removed it from all architecture.

I'm ok to keep this support for all architecture. Please feel free to
comment here.

>
> > > > +103     common  syslog                          sys_syslog
> > > > +104     common  setitimer                       sys_setitimer                   compat_sys_setitimer
> > > > +105     common  getitimer                       sys_getitimer                   compat_sys_getitimer
> > > > +106     common  capget                          sys_capget
> > > > +107     common  capset                          sys_capset
> >
> > > > +108     32      pread64                         parisc_pread64
> > > > +108     64      pread64                         sys_pread64                     parisc_pread64
> >
> > It would be probably nice to have some syntax that would allow avoid
> > this duplication (as compat handler on 64 bit and native on 32 bit are
> > the same).
>
> I think I would prefer to have the compat table be generated with the '32'
> abi rather than the '64' abi, so we end up with
>
> 108     32      pread64                         parisc_pread64
>    parisc_pread64
> 108     64      pread64                         sys_pread64
>
> I think this makes more sense, in particular on the other architectures
> that have different macro names in some cases. When we do this,
> the entries could get compressed to
>
> 108     32      pread64                         parisc_pread64
> 108     64      pread64                         sys_pread64
>

Sure. I can do this thing. The above one may be applicable for parisc not other
architecture. So the scripts might be slightly different. If we keep a
standard way,
the script will be unique. So the only difference will be Makefile and
.tbl files for all
architecture; I think that is our one of the goal.

> > > > +348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> > > > +349     common  statx                           sys_statx
> > > > +350    common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > > > \ No newline at end of file
>
> As others have commented several times, Firoz still needs to fix
> the missing newline.

Sure. I was wondering why the checkpatch script is not catching this one.
Where ever I came across I fixed it.

Thanks
Firoz

>
> Firoz, please fix all the newlines before you repost any further
> patches.
>
>       Arnd
