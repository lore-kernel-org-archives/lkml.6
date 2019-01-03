Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40EDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FB021871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="br0r8KL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfACMA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:00:59 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34612 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbfACMA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:00:58 -0500
Received: by mail-io1-f66.google.com with SMTP id b16so7165210ior.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 04:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZAv3KF7D6pjptcmCqrR1CLN2p/a/tM8QZcjz7U5zmU=;
        b=br0r8KL8Le7ZPgZWrNbd/ojlTnb1umMiJuhRL8bDiKlOWtfSHMyvepBD0E+bNNzsUr
         V5jfdS91C60aV3rcVeEz7A1aynorycaaY1oEl7n3yeIeAvmghAOyuTQZKtf3uA5Qbrif
         9kbK61pGZoarv1GSyt9NHAz8xtSnh8olxvoVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZAv3KF7D6pjptcmCqrR1CLN2p/a/tM8QZcjz7U5zmU=;
        b=IWdl8jxStHzpNFH4rFYqEv7LsHeZg6O5SCxl94E1R0gHc/wx4dbTc0rH4mKpSoxmm5
         g1kG+oUb3ofTMnlsrK7r21SfdZUX0blOtv0Zz3c1RQqJIt0zwOEhVpCS9ObFAkBYdVbN
         LO3SONi5R8eoV714sWrcrEoONv46vsdmwfqLuCVGC6y6rcP4g95DHaCa4ma/u91+nWW4
         E+SrIbrPBpZAzMcCu3WqROwrYqbAi8tj7mOoNNzq1lPVE0RJYh3GWaa6IZc90nmwx3Yy
         CGetgqnzU23xMuUQII1GTXKvDPTvjgMzE0uIPB+XRV+Xp2GvCbLCpFSAShO75FwefBjR
         c/Xw==
X-Gm-Message-State: AJcUukfTgvyE2R1TUS8vH+r88fhYT8gz+Ub+6QNnLgPlT8M70c9qkHb1
        GqdwZsItl8vBeiVevwPULOnh0yC0RG7/CqYTSziHzQ==
X-Google-Smtp-Source: ALg8bN7Zdf+cq2FVkoM2ffj6IaegaXFZY79X7o26MJDlvILnCxuYn6FOe5kWhZkOhFE2DtFGLUfqXE+fFoSSQLJLfdE=
X-Received: by 2002:a6b:8f8d:: with SMTP id r135mr33147073iod.5.1546516857378;
 Thu, 03 Jan 2019 04:00:57 -0800 (PST)
MIME-Version: 1.0
References: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org>
 <1546442319-20461-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdUT3B2JLkijM5Ofd3TUYa8TZJaj1NWaEJvU_19B-naF-w@mail.gmail.com>
In-Reply-To: <CAMuHMdUT3B2JLkijM5Ofd3TUYa8TZJaj1NWaEJvU_19B-naF-w@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 3 Jan 2019 17:30:46 +0530
Message-ID: <CALxhOnhhHy2ztRiCn4400UweHU_+O_t2Wf5862Rc_Dyh3NtNPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: generate uapi header and syscall table header files
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
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

Hi Geert,

Thanks for your feedback!

On Thu, 3 Jan 2019 at 17:13, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > The generated uapi header file will be included in uapi/-
> > asm/unistd.h and generated system call table header file
> > will be included by kernel/syscalltable.S file.
>
> This doesn't really describe what this patch is doing.
> This patch switches m68k over to use the common scripts for
> system call header file generation.

Sure. I'll compose new commit message.

> >  syscall := $(srctree)/$(src)/syscall.tbl
> > -syshdr := $(srctree)/$(src)/syscallhdr.sh
> > -systbl := $(srctree)/$(src)/syscalltbl.sh
> > +syshdr := $(srctree)/scripts/syscallhdr.sh
> > +sysnr := $(srctree)/scripts/syscallnr.sh
>
> What's the purpose of adding sysnr?

Yes. This is not really required here. I planned to change the
implementation in some other way, but didn't looks perfect and
this was left here unnoticed.

> >
> > +quiet_cmd_sysnr = SYSNR  $@
> > +      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'         \
> > +                 '$(sysnr_abis_$(basetarget))'                 \
> > +                 '$(sysnr_pfx_$(basetarget))'                  \
> > +                 '$(sysnr_offset_$(basetarget))'
> > +
>
> What's the purpose of adding this build rule, which is unused?

Sure.

Firoz
