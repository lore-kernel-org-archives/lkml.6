Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54DEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC7120862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTjpEyPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC7120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeKFNoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:44:38 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38402 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeKFNoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:44:37 -0500
Received: by mail-it1-f194.google.com with SMTP id k141-v6so14137018itk.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 20:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1Ju3WnpAGSkq5nj5+rrfGeGgDJ9/WIEnjPGnU+mlrc=;
        b=dTjpEyPGJ5FaXu6CHkRhoCMIMBJ76xRDhpEUTix0KXCwPFSK3DaQ7gJlxES3LA8cmW
         2TtKyENb30bBXdOBs591VJmR/emIcunQjqmfmRipeilLUVst3rPzcgY9vISDVFd/pBD0
         itGWrEesXbAJhpgoCMkF5WcJ4pjt46Z3TAiK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1Ju3WnpAGSkq5nj5+rrfGeGgDJ9/WIEnjPGnU+mlrc=;
        b=qGr4fW2YiNW0zEULLCPoYiQyK1Mj+m32kWh8SCUUNLv/qBMjlnrsUabRBPV0KIKnjQ
         aBRhECJw/9NV6LQICKVmNilCjynCZ6OpKDsb+FM6o4KmCTRr2GEN3QSgL3zqtyuc15HK
         iBWAjpd/SFn5aWSPFIN1CcyRYajoTgU//3L4tohJSm9C1BdDkXEswgakI2u7XysOtnTo
         jPTyGtl9lZeO6X57hes5ZQLEqTV1W77nQ51BO//vyfQ+OJkLYe8gb/YbPSftsHgcfnzi
         1TXZfLRmcXa7o2cWNyg+65gyBDanIDS1U5CroLTJCKUgzmFn9IfuikkyY1wEh5jTTnhB
         uCnw==
X-Gm-Message-State: AGRZ1gIAAbP8xnMRDa3JnHzUV/8CBGFNyXY5l9qJys/PVAUcWnE7mVyb
        z0PQO2pRkvP7Ylw/w+L6oY5N/5FyGB9pjBzEx+7Elw==
X-Google-Smtp-Source: AJdET5dKlDmWgoopCt/RZddvhZBlupIjyh3TvlErPcsg/M1TTP9VMcxzozsrHUyW6Vxh0d7EcnG15NZUsxnf32Pe/rM=
X-Received: by 2002:a02:966e:: with SMTP id c101-v6mr10818274jai.58.1541478082931;
 Mon, 05 Nov 2018 20:21:22 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-5-git-send-email-firoz.khan@linaro.org> <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
In-Reply-To: <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 6 Nov 2018 09:51:11 +0530
Message-ID: <CALxhOnh3RQNw7zArOpsBqOi82_JpTP1pG9tDmrp1PyRER8eGzg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
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

Hi Max,

On Tue, 6 Nov 2018 at 03:14, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Nov 1, 2018 at 6:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > System call table generation script must be run to gener-
> > ate unistd_32.h and syscall_table.h files. This patch will
> > have changes which will invokes the script.
> >
> > This patch will generate unistd_32.h and syscall_table.h
> > files by the syscall table generation script invoked by
> > xtensa/Makefile and the generated files against the removed
> > files must be identical.
> >
> > The generated uapi header file will be included in uapi/-
> > asm/unistd.h and generated system call table header file
> > will be included by kernel/syscall.c file.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/xtensa/Makefile                  |   3 +
> >  arch/xtensa/include/asm/Kbuild        |   1 +
> >  arch/xtensa/include/uapi/asm/Kbuild   |   1 +
> >  arch/xtensa/include/uapi/asm/unistd.h | 782 +---------------------------------
> >  arch/xtensa/kernel/syscall.c          |   5 +-
> >  5 files changed, 10 insertions(+), 782 deletions(-)
> >
> > diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
> > index d67e30fa..1e7b179 100644
> > --- a/arch/xtensa/Makefile
> > +++ b/arch/xtensa/Makefile
> > @@ -99,6 +99,9 @@ all Image zImage uImage: vmlinux
> >  dtbs: scripts
> >         $(Q)$(MAKE) $(build)=$(boot)/dts
> >
> > +archheaders:
> > +       $(Q)$(MAKE) $(build)=arch/xtensa/kernel/syscalls all
> > +
> >  define archhelp
> >    @echo '* Image       - Kernel ELF image with reset vector'
> >    @echo '* zImage      - Compressed kernel image (arch/xtensa/boot/images/zImage.*)'
> > diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
> > index 82c75643..b35d2e6 100644
> > --- a/arch/xtensa/include/asm/Kbuild
> > +++ b/arch/xtensa/include/asm/Kbuild
> > @@ -28,3 +28,4 @@ generic-y += topology.h
> >  generic-y += trace_clock.h
> >  generic-y += word-at-a-time.h
> >  generic-y += xor.h
> > +generic-y += syscall_table.h
>
> This doesn't look right: syscall_table.h is not asm-generic header.

If I remove Kbuild entries, the generated file get removed in build time.

SYSTBL  arch/xtensa/include/generated/asm/syscall_table.h
SYSHDR  arch/xtensa/include/generated/uapi/asm/unistd_32.h
REMOVE  arch/xtensa/include/generated/uapi/asm/unistd_32.h
REMOVE  arch/xtensa/include/generated/asm/syscall_table.h

Firoz

>
> > diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
> > index 837d4dd..f826d52 100644
> > --- a/arch/xtensa/include/uapi/asm/Kbuild
> > +++ b/arch/xtensa/include/uapi/asm/Kbuild
> > @@ -11,3 +11,4 @@ generic-y += resource.h
> >  generic-y += siginfo.h
> >  generic-y += statfs.h
> >  generic-y += termios.h
> > +generic-y += unistd_32.h
>
> Ditto: unistd32_.h is not asm-generic header.
>
> --
> Thanks.
> -- Max
