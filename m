Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C4BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9228D20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYukNOP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9228D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeJCLzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 07:55:38 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36917 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 07:55:37 -0400
Received: by mail-yb1-f194.google.com with SMTP id h1-v6so1858211ybm.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SlzELRGUMHI+Tf9HAdiN/T0+FB1AKo6USVzO00wFO10=;
        b=BYukNOP6IbnWUhoWIl1YUgFJvQPBSAt0ltxYRUBEty7gJqOq0PfS1JawGL7o2P8wZP
         dNx8vsSOz67nvtcjBScKPVIHlkI2nSOiOl73WJrJCjE0OjwTvpy1HghKAwT+eI3lwtdM
         AcIA39ri1bamHmZsXqtO4okeo+Ih2XreJb5XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlzELRGUMHI+Tf9HAdiN/T0+FB1AKo6USVzO00wFO10=;
        b=jS1F498ZqkZX5v86PjtCgQElAHrg41kzHKS4MH/npCUSL51upwupYJrLIBgXQndAnX
         eBSOY90bFcc/N4SgkyU8frRPY0bylkTj3ADsAKUT7kzNsJAVnBrFlveGdlC64xgJeTTB
         UDNw4HeS8W/1RafwJ+E2hRymPbnE9BbL+IjCwkAEOHQee36pRg1sfIekCBB0YatdoQRm
         FTZK8ZAqFVKnH9pd0sdPbjFLxGXuqptZT4ft6uCl4MmHhJ2rlPNOOmHYFlePln6D/qXG
         wB2UvloX4b77PHbMBLRP/po7Udfxm8a8zBNdwmhGki8ljMsWWo2PwY4YffEQudm0HJBk
         3srw==
X-Gm-Message-State: ABuFfoi9eYTD0ONWhQAHBYOgq73MdDCLX3VTVbNBBjigqZu2MDnF5wCn
        nogMAkxLRaz+keLqGVqm3MPoNtYYx7qjgAejOGSz+w==
X-Google-Smtp-Source: ACcGV61C5rmhtUh+2JmgwYSqLN2VvyiMrdYc5OtNr4gfV7GmMVTAk3On25RxfHuLxmXdEAK8kkI2OjvdVsjUuFpqBAg=
X-Received: by 2002:a25:8242:: with SMTP id d2-v6mr10629553ybn.166.1538543331485;
 Tue, 02 Oct 2018 22:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
 <1538397784-4214-4-git-send-email-firoz.khan@linaro.org> <0741f810-58c9-dcf3-8c1c-93860c08e428@xilinx.com>
In-Reply-To: <0741f810-58c9-dcf3-8c1c-93860c08e428@xilinx.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Wed, 3 Oct 2018 10:38:40 +0530
Message-ID: <CALxhOnh4__SMm93Lpr13eHxBTvDnocHzdh3YDxtuogEKg355Vw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] microblaze: uapi header and system call table file generation
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, 2 Oct 2018 at 19:37, Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 1.10.2018 14:43, Firoz Khan wrote:
> > System call table generation script must be run to generate
> > unistd_32.h and syscall_table.h files. This patch will have
> > changes which will invokes the script.
> >
> > This patch will generate unistd_32.h and syscall_table.h
> > files by the syscall table generation script invoked by
> > arch/microblaze/Makefile and the generated files against the
> > removed files will be identical.
> >
> > The generated uapi header file will be included in
> > uapi/asm/unistd.h and generated system call table support
> > file will be included by kernel/syscall_table.S file.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/microblaze/Makefile                  |   3 +
> >  arch/microblaze/include/asm/Kbuild        |   1 +
> >  arch/microblaze/include/uapi/asm/Kbuild   |   1 +
> >  arch/microblaze/include/uapi/asm/unistd.h | 411 +-----------------------------
> >  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
> >  5 files changed, 10 insertions(+), 812 deletions(-)
> >
> > diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> > index 4f3ab57..cda5e03 100644
> > --- a/arch/microblaze/Makefile
> > +++ b/arch/microblaze/Makefile
> > @@ -81,6 +81,9 @@ all: linux.bin
> >  archclean:
> >       $(Q)$(MAKE) $(clean)=$(boot)
> >
> > +archheaders:
> > +     $(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
> > +
> >  linux.bin linux.bin.gz linux.bin.ub: vmlinux
> >       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> >
> > diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
> > index 569ba9e..d64f5e7 100644
> > --- a/arch/microblaze/include/asm/Kbuild
> > +++ b/arch/microblaze/include/asm/Kbuild
> > @@ -31,3 +31,4 @@ generic-y += trace_clock.h
> >  generic-y += vga.h
> >  generic-y += word-at-a-time.h
> >  generic-y += xor.h
> > +generic-y += syscall_table.h
> > \ No newline at end of file
>
> Still the problem with "No newline at end of file"
>
> > diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
> > index 2c6a6bf..3a40659 100644
> > --- a/arch/microblaze/include/uapi/asm/Kbuild
> > +++ b/arch/microblaze/include/uapi/asm/Kbuild
> > @@ -28,3 +28,4 @@ generic-y += termbits.h
> >  generic-y += termios.h
> >  generic-y += types.h
> >  generic-y += ucontext.h
> > +generic-y += unistd_32.h
> > \ No newline at end of file
>
> and here too.

Thanks for your comment. checkpatch script didn't warn this one:(
Hopefully, I can fix this one in the next version.

I would appreciate if you can perform the boot test on the actual
platform and share the result with me.

Thanks,
Firoz
>
> M
