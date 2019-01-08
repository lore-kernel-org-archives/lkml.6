Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ACEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA6220675
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ccoBiJs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfAHURW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:17:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44644 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfAHURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:17:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so2442083pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 12:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=NHq73EOC6P/EZP1zXEp3GS6Y59Bi8cZdKMfq30ztJos=;
        b=ccoBiJs8wGFBxd3eVhWoT4x7W5UbDJzMJjhybyEKr3HV1C9N5aoNa+32WD/aAozvRY
         HUhoWeV5zUkRnhZQujj3dHj/700AzDITCf91nEy9Pet1C+UOkZUuUPa52DfRyW78wKEq
         bIZK8K3yaNa9ZqBhmdwnUSrZ95OUhnGWjl7RmWodjmb8sDMNvloCJqrVbFuuYFeDeN6n
         wvUY85xIaj7QieU9Qchaj1J1Kkr2R219UI/gxiSw3CcHxyg1pNjpdiWcrwugg2feZi8g
         MjWJ+Jaq9Uh9NpShSUAAAmYeD7NlnPxAbnVUqHcahXYE2vnuzjfQjcX6uwy7C+bDOb0c
         4+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=NHq73EOC6P/EZP1zXEp3GS6Y59Bi8cZdKMfq30ztJos=;
        b=sydqWqEVJMj2tRnRDuRUKZoS3IxNkP+PdhjpfGbAN9ficBzeZlTFLUWDB43CgzG9Wg
         eSs3YB6EgV+Bsrq9VW/EcI2t/pbzkjJdyrGwOwP9+zkRznpKXHUxBA9wMIlhxm+J3MQ/
         RrSDVSapPRJgZw2XQgDlThoiBSY0IhzG/wBm9GDWn5TodSIvAU/npS061o0yxRfgGciX
         Dx6KiCedN2l9Xst7cO53pbazTWkLXREUuNAEZbxPyQ36vDfuDoJbmPDh0aVSXnvpPFC/
         cqOjrV/gqwG84zJ1AIMihoZREMvmolpxHJ7gpPlGu9QeBt7X5bDapvurIOVU4nUB+n3q
         plqQ==
X-Gm-Message-State: AJcUukeqoLwCRwkd6IdIFZgxN1sLOPTAuNhh4cWWkeMBeZmknl64kRaC
        7OxjrVgEoXIvVa1zz3/je/iwIw==
X-Google-Smtp-Source: ALg8bN72u4US66UDBZ4SNoRsySPsovguRSvPDE066b/Oi8EEF/GdrakryNTJZhCRogu2wmpDuElM3g==
X-Received: by 2002:a63:5455:: with SMTP id e21mr2814758pgm.316.1546978640863;
        Tue, 08 Jan 2019 12:17:20 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i72sm104704585pfe.181.2019.01.08.12.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 12:17:19 -0800 (PST)
Date:   Tue, 08 Jan 2019 12:17:19 -0800 (PST)
X-Google-Original-Date: Tue, 08 Jan 2019 12:16:42 PST (-0800)
Subject:     Re: [PATCH] riscv: remove redundant kernel-space generic-y
In-Reply-To: <CAK7LNAT+5eOFc64SG2SKCOThVVsz6S2NPBpemdcjCcZX_zds2Q@mail.gmail.com>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        alankao@andestech.com, deepa.kernel@gmail.com,
        linux-kernel@vger.kernel.org, Jim Wilson <jimw@sifive.com>,
        geert@linux-m68k.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     yamada.masahiro@socionext.com
Message-ID: <mhng-aacb9594-f17b-4728-91f7-e2804e6a3dbc@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jan 2019 07:03:20 PST (-0800), yamada.masahiro@socionext.com wrote:
> On Fri, Jan 4, 2019 at 11:16 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Sun, 16 Dec 2018 06:11:11 PST (-0800), yamada.masahiro@socionext.com wrote:
>> > This commit removes redundant generic-y defines in
>> > arch/riscv/include/asm/Kbuild.
>> >
>> > [1] It is redundant to define the same generic-y in both
>> >     arch/$(ARCH)/include/asm/Kbuild and
>> >     arch/$(ARCH)/include/uapi/asm/Kbuild.
>> >
>> >     Remove the following generic-y:
>> >
>> >       errno.h
>> >       fcntl.h
>> >       ioctl.h
>> >       ioctls.h
>> >       ipcbuf.h
>> >       mman.h
>> >       msgbuf.h
>> >       param.h
>> >       poll.h
>> >       posix_types.h
>> >       resource.h
>> >       sembuf.h
>> >       setup.h
>> >       shmbuf.h
>> >       signal.h
>> >       socket.h
>> >       sockios.h
>> >       stat.h
>> >       statfs.h
>> >       swab.h
>> >       termbits.h
>> >       termios.h
>> >       types.h
>> >
>> > [2] It is redundant to define generic-y when arch-specific
>> >     implementation exists in arch/$(ARCH)/include/asm/*.h
>> >
>> >     Remove the following generic-y:
>> >
>> >       cacheflush.h
>> >       dma-mapping.h
>> >       module.h
>> >
>> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > ---
>> >
>> >  arch/riscv/include/asm/Kbuild | 26 --------------------------
>> >  1 file changed, 26 deletions(-)
>> >
>> > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
>> > index 6a646d9..f7068f3 100644
>> > --- a/arch/riscv/include/asm/Kbuild
>> > +++ b/arch/riscv/include/asm/Kbuild
>> > @@ -1,5 +1,4 @@
>> >  generic-y += bugs.h
>> > -generic-y += cacheflush.h
>> >  generic-y += checksum.h
>> >  generic-y += compat.h
>> >  generic-y += cputime.h
>> > @@ -7,18 +6,12 @@ generic-y += device.h
>> >  generic-y += div64.h
>> >  generic-y += dma.h
>> >  generic-y += dma-contiguous.h
>> > -generic-y += dma-mapping.h
>> >  generic-y += emergency-restart.h
>> > -generic-y += errno.h
>> >  generic-y += exec.h
>> >  generic-y += fb.h
>> > -generic-y += fcntl.h
>> >  generic-y += hardirq.h
>> >  generic-y += hash.h
>> >  generic-y += hw_irq.h
>> > -generic-y += ioctl.h
>> > -generic-y += ioctls.h
>> > -generic-y += ipcbuf.h
>> >  generic-y += irq_regs.h
>> >  generic-y += irq_work.h
>> >  generic-y += kdebug.h
>> > @@ -27,34 +20,15 @@ generic-y += kvm_para.h
>> >  generic-y += local.h
>> >  generic-y += local64.h
>> >  generic-y += mm-arch-hooks.h
>> > -generic-y += mman.h
>> > -generic-y += module.h
>> > -generic-y += msgbuf.h
>> >  generic-y += mutex.h
>> > -generic-y += param.h
>> >  generic-y += percpu.h
>> > -generic-y += poll.h
>> > -generic-y += posix_types.h
>> >  generic-y += preempt.h
>> > -generic-y += resource.h
>> >  generic-y += scatterlist.h
>> >  generic-y += sections.h
>> > -generic-y += sembuf.h
>> >  generic-y += serial.h
>> > -generic-y += setup.h
>> > -generic-y += shmbuf.h
>> >  generic-y += shmparam.h
>> > -generic-y += signal.h
>> > -generic-y += socket.h
>> > -generic-y += sockios.h
>> > -generic-y += stat.h
>> > -generic-y += statfs.h
>> > -generic-y += swab.h
>> > -generic-y += termbits.h
>> > -generic-y += termios.h
>> >  generic-y += topology.h
>> >  generic-y += trace_clock.h
>> > -generic-y += types.h
>> >  generic-y += unaligned.h
>> >  generic-y += user.h
>> >  generic-y += vga.h
>>
>> Thanks.  These just sort of collected there because I hadn't trimmed them.  Is
>> there a script that checks these?
>
>
> No script is available for now, but
> I'd like to turn on warnings to catch some cases:
> https://patchwork.kernel.org/patch/10746823/
>
>
> BTW, can I apply this to my tree
> along with other cleanups?

Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
