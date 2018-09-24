Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A52ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD818208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdyPlpyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD818208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeIXNyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:54:33 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42905 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeIXNyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:54:32 -0400
Received: by mail-yw1-f66.google.com with SMTP id h134-v6so4367403ywc.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLL1gOj9lTyJrGiM53C6pWgcW3LyE6rweAcQE3Q5+Wc=;
        b=KdyPlpyUO0Y48dzFlmmH9mfbC9POY7q9eWvwd3HKZhpUKZweQDCuJ5F08ykqTf/au3
         oyXaQXRe7PV7RLIWFvt8A+6loeq5mESkLvfl25YBXz0XGDoRLmIZuPPPh6oUGFvA5qfc
         TyDh3bYD+6UKUUSI2s0OeuIN0HiOvx2WdMQ2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLL1gOj9lTyJrGiM53C6pWgcW3LyE6rweAcQE3Q5+Wc=;
        b=EaIAAkCO90jkjeZrZkfGMEbA+gLvPBTvqG3/kbhnMuhbJ/1PSEMA4wwsStW+jdmPXe
         agIXBgJR5hb6lAPxRWpgJ6unMmBhcSEPPuyxlz4h0YH+QNFqIwAwBUhqEXvZhM05yvGy
         vW12VIYTnWEVxH5qPDxr05mEY3e6CV3bKq3KLSAup8c2K27MXsifIOmm1NBMfIWfwkwT
         61BuxIDA778Ll9xy9M4l+XWeezyuPA1WjxIO5no7E48zdyyR6mRqX6XtJ+YWe0z70CJI
         PHjFiRNiHPHzgaaPYJuZ5uynsEEMUxDLp0nAcwhFCYAtLZIi3dUvdEvzcjFueGb933ex
         HEag==
X-Gm-Message-State: ABuFfojRrgTBw/6ITuXW5dRUmtZmg2TcJVK4X3dj62WWdJBfaH6nEuyZ
        B8Ab4NSfuJNfbnlwKI2fpNU27T86K59II4/b+WlW+A==
X-Google-Smtp-Source: ACcGV62j60TA+cgypv1eKDZtwjHJsVa7bQLUf7UFVdZRNIhumhT72pPVYz3oQXvMpukP3zXmYKuNrfNzE9LneXzGzfg=
X-Received: by 2002:a81:25c4:: with SMTP id l187-v6mr4090311ywl.236.1537775622843;
 Mon, 24 Sep 2018 00:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
 <1537455973-12468-4-git-send-email-firoz.khan@linaro.org> <CAMuHMdUPKh+6ocdH38=46veyOFUE2o_Hj=xodyLDCQ3s8J9ADQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUPKh+6ocdH38=46veyOFUE2o_Hj=xodyLDCQ3s8J9ADQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 24 Sep 2018 13:23:31 +0530
Message-ID: <CALxhOnipc=-fxG6o1_2ygpprjunfe3d6XPdraeRJNKnUwwzk5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] m68k: Added system call table generation support
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

On Mon, 24 Sep 2018 at 12:33, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On Thu, Sep 20, 2018 at 5:07 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> > The system call tables are in different format in all
> > architecture and it will be difficult to manually add or
> > modify the system calls in the respective files. To make
> > it easy by keeping a script and which'll generate the
> > header file and syscall table file so this change will
> > unify them across all architectures.
> >
> > The system call table generation script is added in
> > syscalls directory which contain the script to generate
> > both uapi header file system call table generation file
> > and syscall.tbl file which'll be the input for the scripts.
> >
> > syscall.tbl contains the list of available system calls
> > along with system call number and corresponding entry point.
> > Add a new system call in this architecture will be possible
> > by adding new entry in the syscall.tbl file.
> >
> > Adding a new table entry consisting of:
> >         - System call number.
> >         - ABI.
> >         - System call name.
> >         - Entry point name.
> >
> > syscallhdr.sh and syscalltbl.sh will generate uapi header-
> > unistd.h and syscall_table.h files respectively. File
> > syscall_table.h is included by syscall_table.S - the real
> > system call table. Both .sh files will parse the content
> > syscall.tbl to generate the header and table files.
> >
> > ARM, s390 and x86 architecuture does have the similar support.
> > I leverage their implementation to come up with a generic
> > solution. And this is the ground work for y2038 issue. We need
> > to change two dozons of system call implementation and this
> > work will reduce the effort by simply modify two dozon entries
> > in syscall.tbl.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> > @@ -0,0 +1,369 @@
> > +#
> > +# Linux system call numbers and entry vectors
> > +#
> > +# The format is:
> > +# <number> <abi> <name> <entry point>
> > +#
> > +# The abi is always common for this file.
> > +#
> > +0       common   restart_syscall          sys_restart_syscall
>
> Why the indentation by an "odd" number of spaces, instead of TABs?

I'll check and fix ASAP. Hopefully I can post a clean (almost) patch series
within couple of days!

- Firoz

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
