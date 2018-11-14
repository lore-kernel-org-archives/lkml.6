Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36483C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22DB22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvuFWsBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22DB22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbeKNRGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:06:21 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40070 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbeKNRGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:06:21 -0500
Received: by mail-io1-f66.google.com with SMTP id r7-v6so10812178iog.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 23:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4koGIcAw+B/ziApmx424ndj0vl+idesonoWxQhheIY=;
        b=AvuFWsBuTWt1lr1HUMAwT6ahFdgQip7U9+gaFaj9siKgYVLwzrvgnHa0N2eIo0Jlhn
         JF/IzIc99APO91Rqgoq3S/HL9MrSOR0iPHTmkOpsW9DoFpxvI1Xwo2OIhi1UiRJ42XwC
         djKE0l0l9igepI+R4+kuSFwtcvs3/qhgrtxXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4koGIcAw+B/ziApmx424ndj0vl+idesonoWxQhheIY=;
        b=bmUuM+LW6O3GplHVniXvcy7uyA2dQ3yLf/LrrvW4dtEbzRqK2kw1TY39DeXkUfL7CA
         V6457E/fxxNjBHznqWWYLSu2tchUFJ2L7Sa3bQOVlgsbhcJQITrAQ92UZTkyxOr1D6nT
         MdO6HeqcQnfR7Y1MIqrx/DS0NJ5/g6t7FvMSsdfYgXt/jlOWfZI1vhvg1pRBG4iWHRHu
         SwPGQGhm+9jn4VrZr704somceeNOob7gDogDnLLf5A4QoO1Fps1EgHKQOjiHxSpfQ3Aj
         GgusEDMYBrY7Sdyu/f014BrQHmiPYlrKerfdmeGAEOqXv5xZW9V5xNNXYTazPIp1P3Wm
         wFTw==
X-Gm-Message-State: AA+aEWYd+KEvO2rejAVwogeV0EuBhtSLBN5wT5Ba+t5j1l+10Uc6gcxM
        hTgpot+pBodk4v7RcYcU9me4oSNuqL9p4bpk3CRN2w==
X-Google-Smtp-Source: AJdET5dmppDw2twubdJZn2uSPlTMfDFIG+KEWjNkp8iZDac6Yhmm4d6eMnStt0mc93rRDC3nvRv8ivrUVr+cpV6syjA=
X-Received: by 2002:a6b:cc05:: with SMTP id c5-v6mr536147iog.171.1542179064764;
 Tue, 13 Nov 2018 23:04:24 -0800 (PST)
MIME-Version: 1.0
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org> <CAOMdWSJ1NiMTThftBysvsntPdRBHN7gq_w19gtzi6KmBKAdz+Q@mail.gmail.com>
In-Reply-To: <CAOMdWSJ1NiMTThftBysvsntPdRBHN7gq_w19gtzi6KmBKAdz+Q@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Wed, 14 Nov 2018 12:34:13 +0530
Message-ID: <CALxhOngcKwEGRQPu0qmK0ytDwfgoo0UHCHJSQsfacZ6XDrW8Ww@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
To:     allen.lkml@gmail.com
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

Hi Allen,

On Wed, 14 Nov 2018 at 12:14, Allen <allen.lkml@gmail.com> wrote:
>
> > Changes since v2:
> >  - changed from generic-y to generated-y in Kbuild.
> >  - added io_pgetevents entry in the syscall.tbl.
> >  - updated the compat system call table.
> >
> > Changes since v1:
> >  - optimized/updated the syscall table generation
> >    scripts.
> >  - fixed all mixed indentation issues in syscall.tbl.
> >  - added "comments" in syscall.tbl.
> >
> > Firoz Khan (4):
> >   sparc: move __IGNORE* entries to non uapi header
> >   sparc: add __NR_syscalls along with NR_syscalls
> >   sparc: add system call table generation support
> >   sparc: generate uapi header and system call table files
>
> Tested and looks fine.

Great, thanks!

Firoz

>
> Tested-by: Allen Pais <allen.lkml@gmail.com>
>
> >  arch/sparc/Makefile                      |   3 +
> >  arch/sparc/include/asm/Kbuild            |   4 +-
> >  arch/sparc/include/asm/unistd.h          |  18 ++
> >  arch/sparc/include/uapi/asm/Kbuild       |   2 +
> >  arch/sparc/include/uapi/asm/unistd.h     | 426 +------------------------------
> >  arch/sparc/kernel/syscalls/Makefile      |  55 ++++
> >  arch/sparc/kernel/syscalls/syscall.tbl   | 409 +++++++++++++++++++++++++++++
> >  arch/sparc/kernel/syscalls/syscallhdr.sh |  36 +++
> >  arch/sparc/kernel/syscalls/syscalltbl.sh |  36 +++
> >  arch/sparc/kernel/systbls_32.S           |  81 +-----
> >  arch/sparc/kernel/systbls_64.S           | 157 +-----------
> >  11 files changed, 572 insertions(+), 655 deletions(-)
> >  create mode 100644 arch/sparc/kernel/syscalls/Makefile
> >  create mode 100644 arch/sparc/kernel/syscalls/syscall.tbl
> >  create mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
> >  create mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh
> >
> > --
> > 1.9.1
> >
>
>
> --
>        - Allen
