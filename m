Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87033C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355C82087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgyJQiSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355C82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJIQxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:53:00 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43367 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbeJIQxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:53:00 -0400
Received: by mail-yb1-f196.google.com with SMTP id w80-v6so342804ybe.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17zqaui5EBajVfTVdgoLVDFkHiFX1468HNSXBzbCARg=;
        b=HgyJQiSLcbkd2etsoVBlYQEZQ3Os0ovcBhdrmLy8pGNaCido+e1Puon1JAUTs2p0VT
         RBwQOGT+S6rIZsO0c1M3v8hb2z4R89J2WLfg5TU7pZnYAORibVOAvHZXcm5NT+L3Jf+R
         BttPG1P7n0X0bu14MnyDverDibOWG9mVNlZjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17zqaui5EBajVfTVdgoLVDFkHiFX1468HNSXBzbCARg=;
        b=q75diD/QHqR4uBtYy5OgrnUwEpXy2AIYA+FzRgjDH0671TO8o+WB17+69cYCV7Rbg4
         m+XIQ0BziuhJZpHEMI9NM0YvfY8dI7IF75TVByFPc3cr0KuuRbApbPx133NlcsLItszg
         zPeuLfwXUgVbpga5jABUhNdv7XIeWaOCdzcwq1nn8icfhCVeMUIL78Ym5zYYciKM53gw
         fvi5CJVO4lY7SzzJuCARodYC47S4eBbarAlVtugrtYVzydBZl6AF2eb11LiNAE+T1Ek0
         YV03mXGf2lrS5qDzPGHDzk2wim0q1YYdJNqrwGEtpL/ET+pjJ2sERl4NiCHsDZ/fuExa
         xZUg==
X-Gm-Message-State: ABuFfojNe884jwqq2/RFyZmjb4c6Y1ivnwH914uErztXEbZzTVuWID6L
        ipNWzj6sJLxuLpRMGtkevXW1gP9a1HnLB+o5TCpZpg==
X-Google-Smtp-Source: ACcGV62Irh51Jbq1cfzAA278VHf8AUDsn2x3SOD6O8Ytb9FqtCp/BMh/wu4sRBFt5j5MB57+PL345o++xJUVOa7q2VM=
X-Received: by 2002:a25:16d5:: with SMTP id 204-v6mr12675014ybw.223.1539077817547;
 Tue, 09 Oct 2018 02:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-4-git-send-email-firoz.khan@linaro.org> <CALxhOnj4r_MUuAa2zvkvxvhQttEvCZ98n2dA9d6CYyvVf2rB3g@mail.gmail.com>
 <20181008130301.GM32759@asgard.redhat.com> <CAK8P3a0eoCVBVOZs0VwybAnUw0OUoW4Z=NJYi8686EHKj076_Q@mail.gmail.com>
 <CALxhOniJZGNCP+Xw_9EF8hnUEG_AWwrnQ86Gbh7vAW6SrE8ykQ@mail.gmail.com> <CAK8P3a0D+GUzza--ETrT1NHGduTfFGVoCcSEn5LxvKTtMYisbA@mail.gmail.com>
In-Reply-To: <CAK8P3a0D+GUzza--ETrT1NHGduTfFGVoCcSEn5LxvKTtMYisbA@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 9 Oct 2018 15:06:46 +0530
Message-ID: <CALxhOnhCRWsuz-2G-SovjfqkXpsRdTrG5Atz2X8s+T8u=GbUcA@mail.gmail.com>
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

Hi Arnd,

On Tue, 9 Oct 2018 at 13:18, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 9, 2018 at 7:35 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Mon, 8 Oct 2018 at 19:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Oct 8, 2018 at 3:02 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
> > > > > > +87      common  swapon                          sys_swapon
> > > > > > +88      common  reboot                          sys_reboot
> > > > > > +89      common  mmap2                           sys_mmap2
> > > > > > +90      common  mmap                            sys_mmap
> > > > > > +91      common  munmap                          sys_munmap
> > > > > > +92      common  truncate                        sys_truncate                    compat_sys_truncate
> > > > > > +93      common  ftruncate                       sys_ftruncate                   compat_sys_ftruncate
> > > > > > +94      common  fchmod                          sys_fchmod
> > > > > > +95      common  fchown                          sys_fchown
> > > > > > +96      common  getpriority                     sys_getpriority
> > > > > > +97      common  setpriority                     sys_setpriority
> > > > > > +98      common  recv                            sys_recv
> > > > > > +99      common  statfs                          sys_statfs                      compat_sys_statfs
> > > > > > +100     common  fstatfs                         sys_fstatfs                     compat_sys_fstatfs
> > > > > > +101     common  stat64                          sys_stat64
> > > >
> > > > It is probably worth adding a comment here that syscall 102 was
> > > > socketcall, in order to make reason for this jump in syscall numeration
> > > > self-evident.
> > >
> > > +1
> > >
> > > In general, I'd argue we want to keep all the nontrivial comments that
> > > were present in either unistd.h or syscall_table.S.
> >
> > unistd_32.h, unistd_64.h, syscall_table_32.h, syscall_table_64.h and
> > syscall_table_c32.h
> > are generated files. unistd.h and syscall_table.S file include
> > generated files. I had the
> > support to keep the comments in the generated files.
> >
> > Eg:- from github
> > https://github.com/frzkhn/system_call_table_generator/blob/5fe5fb5a3ad457b234e7600d8a4b61b2e3629acd/ia64/syscall.tbl#L105
> >
> > But I got to know the generated file don't carry any license info and
> > comment section. That's
> > why I removed it from all architecture.
> >
> > I'm ok to keep this support for all architecture. Please feel free to
> > comment here.
>
> I meant just have the comments in the .tbl file, but not act on them.
> One way to do this would be to let the script ignore everything
> past the first '#' character in a line by passing it through 'sed -e "s:#.*$::"'
> or a similar step (there is probably a nicer way to do this with
> shell built-ins).

Sure, I can keep the comments in the .tbl file for all architecture. But
generated file doesn't have the comments.

>
> > > I think this makes more sense, in particular on the other architectures
> > > that have different macro names in some cases. When we do this,
> > > the entries could get compressed to
> > >
> > > 108     32      pread64                         parisc_pread64
> > > 108     64      pread64                         sys_pread64
> > >
> >
> > Sure. I can do this thing. The above one may be applicable for parisc not other
> > architecture. So the scripts might be slightly different. If we keep a
> > standard way,
> > the script will be unique. So the only difference will be Makefile and
> > .tbl files for all
> > architecture; I think that is our one of the goal.
>
> I would expect the above to actually be more important on other
> architectures. E.g. on powerpc:
>
> 291     32    fstatat64        sys_fstatat64      sys_fstatat64
> 291     64    newfstatat     newfstatat
>
> or (simplified)
>
> 291     32    fstatat64        sys_fstatat64
> 291     64    newfstatat     sys_newfstatat

In parisc, I'll go with the above model.

Let me bring another example from powerpc:

syscall_32.tbl,
136     common  personality                     sys_personality
         ppc64_personality   ---> 32-bit, compat (this is the current
model which I implemented)
syscall_64.tbl
136     common  personality                     ppc64_personality
                                       ---> 64-bit

I was wondering if the above table is right, how to arrange like parisc model?
FYI, there are some implement missing for SPU in powerpc

For your reference:
SYSX_SPU(sys_newfstatat,sys_fstatat64,sys_fstatat64)
SYSX_SPU(ppc64_personality,ppc64_personality,sys_personality)

Thanks
Firoz
>
> makes much more sense than
>
> 291     32    fstatat64        sys_fstatat64
> 291     64    newfstatat     newfstatat           sys_fstatat64
>
>         Arnd
