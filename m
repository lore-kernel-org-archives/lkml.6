Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0097C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469BA2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yYqbeDmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfADPEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:04:06 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:37699 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfADPEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:04:05 -0500
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x04F3v0a003806
        for <linux-kernel@vger.kernel.org>; Sat, 5 Jan 2019 00:03:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x04F3v0a003806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546614238;
        bh=m6SQ7ZRHH4zUiD1zcnYJ8J1KFForbdgtEfeYHhvMokc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yYqbeDmnozxypadHJWUIJ08nGVgF1/nuEx8pkUtD0TFbqXu/peudn3enU5HynLmHG
         uIzAa+2BdMpOci+b8WzjYk8COQY8Jw4cMjQkbdTBlhGx2/TDkFOgeQcZLvcT21GHk1
         0WegYJGBbkGjG0q1V6otzYeMxcC6g0TxqYxnuntTBM6fyvbTVRTmuuApEAMzHC+uvd
         nHM6ww20m9mup4RcZcKJYBs159CiTj8SLEf/QYqY9Fvob4lmPsZ2AMzP1InsDHG4B2
         o954xd0eegSG3GNVWoVkVe+jfvvGNW//qw8oIeqr4W8Xy7s1wcUV9OiybbdL55HdVo
         cfh8ypOXNLQsg==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id t127so7989437vke.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 07:03:57 -0800 (PST)
X-Gm-Message-State: AJcUukcdDkNDab/jhGvWKVxIr3OKNqKTAulGOd7uRBLrupirpcQAitMg
        uKhzn+8a6KjAXZHj3C0MEjxvNrVMOHcomGOYXYU=
X-Google-Smtp-Source: ALg8bN4K8/0n0rDc9db+1yRHR6NvjNuMRhv73RzZBLeXcdRT9vMrW6gViV4hhh/xD9I8zvirbPimJklFmXTqUbkqG8I=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr17846428vkd.64.1546614236306;
 Fri, 04 Jan 2019 07:03:56 -0800 (PST)
MIME-Version: 1.0
References: <1544969471-14224-1-git-send-email-yamada.masahiro@socionext.com> <mhng-029a5523-f3c5-4e90-b679-4e10f1ba4c0f@palmer-si-x1c4>
In-Reply-To: <mhng-029a5523-f3c5-4e90-b679-4e10f1ba4c0f@palmer-si-x1c4>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 5 Jan 2019 00:03:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+5eOFc64SG2SKCOThVVsz6S2NPBpemdcjCcZX_zds2Q@mail.gmail.com>
Message-ID: <CAK7LNAT+5eOFc64SG2SKCOThVVsz6S2NPBpemdcjCcZX_zds2Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: remove redundant kernel-space generic-y
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        alankao@andestech.com, deepa.kernel@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Wilson <jimw@sifive.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 11:16 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Sun, 16 Dec 2018 06:11:11 PST (-0800), yamada.masahiro@socionext.com wrote:
> > This commit removes redundant generic-y defines in
> > arch/riscv/include/asm/Kbuild.
> >
> > [1] It is redundant to define the same generic-y in both
> >     arch/$(ARCH)/include/asm/Kbuild and
> >     arch/$(ARCH)/include/uapi/asm/Kbuild.
> >
> >     Remove the following generic-y:
> >
> >       errno.h
> >       fcntl.h
> >       ioctl.h
> >       ioctls.h
> >       ipcbuf.h
> >       mman.h
> >       msgbuf.h
> >       param.h
> >       poll.h
> >       posix_types.h
> >       resource.h
> >       sembuf.h
> >       setup.h
> >       shmbuf.h
> >       signal.h
> >       socket.h
> >       sockios.h
> >       stat.h
> >       statfs.h
> >       swab.h
> >       termbits.h
> >       termios.h
> >       types.h
> >
> > [2] It is redundant to define generic-y when arch-specific
> >     implementation exists in arch/$(ARCH)/include/asm/*.h
> >
> >     Remove the following generic-y:
> >
> >       cacheflush.h
> >       dma-mapping.h
> >       module.h
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/riscv/include/asm/Kbuild | 26 --------------------------
> >  1 file changed, 26 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> > index 6a646d9..f7068f3 100644
> > --- a/arch/riscv/include/asm/Kbuild
> > +++ b/arch/riscv/include/asm/Kbuild
> > @@ -1,5 +1,4 @@
> >  generic-y += bugs.h
> > -generic-y += cacheflush.h
> >  generic-y += checksum.h
> >  generic-y += compat.h
> >  generic-y += cputime.h
> > @@ -7,18 +6,12 @@ generic-y += device.h
> >  generic-y += div64.h
> >  generic-y += dma.h
> >  generic-y += dma-contiguous.h
> > -generic-y += dma-mapping.h
> >  generic-y += emergency-restart.h
> > -generic-y += errno.h
> >  generic-y += exec.h
> >  generic-y += fb.h
> > -generic-y += fcntl.h
> >  generic-y += hardirq.h
> >  generic-y += hash.h
> >  generic-y += hw_irq.h
> > -generic-y += ioctl.h
> > -generic-y += ioctls.h
> > -generic-y += ipcbuf.h
> >  generic-y += irq_regs.h
> >  generic-y += irq_work.h
> >  generic-y += kdebug.h
> > @@ -27,34 +20,15 @@ generic-y += kvm_para.h
> >  generic-y += local.h
> >  generic-y += local64.h
> >  generic-y += mm-arch-hooks.h
> > -generic-y += mman.h
> > -generic-y += module.h
> > -generic-y += msgbuf.h
> >  generic-y += mutex.h
> > -generic-y += param.h
> >  generic-y += percpu.h
> > -generic-y += poll.h
> > -generic-y += posix_types.h
> >  generic-y += preempt.h
> > -generic-y += resource.h
> >  generic-y += scatterlist.h
> >  generic-y += sections.h
> > -generic-y += sembuf.h
> >  generic-y += serial.h
> > -generic-y += setup.h
> > -generic-y += shmbuf.h
> >  generic-y += shmparam.h
> > -generic-y += signal.h
> > -generic-y += socket.h
> > -generic-y += sockios.h
> > -generic-y += stat.h
> > -generic-y += statfs.h
> > -generic-y += swab.h
> > -generic-y += termbits.h
> > -generic-y += termios.h
> >  generic-y += topology.h
> >  generic-y += trace_clock.h
> > -generic-y += types.h
> >  generic-y += unaligned.h
> >  generic-y += user.h
> >  generic-y += vga.h
>
> Thanks.  These just sort of collected there because I hadn't trimmed them.  Is
> there a script that checks these?


No script is available for now, but
I'd like to turn on warnings to catch some cases:
https://patchwork.kernel.org/patch/10746823/


BTW, can I apply this to my tree
along with other cleanups?



-- 
Best Regards
Masahiro Yamada
