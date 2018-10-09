Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72EBC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2FD2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvwUgA8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2FD2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJIV2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:28:12 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44273 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeJIV2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:28:12 -0400
Received: by mail-yb1-f195.google.com with SMTP id x5-v6so670917ybl.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raC50H3i6Rq/gAHAxqx/HZulacRGFaQbhcZ8FwelmBA=;
        b=PvwUgA8hjzgwUOXWCcgbPsVl9pWZA9gZV8ulJi7VJNLX6dhl7qaXUw0WbwO11kla+w
         ixjfYfvtW7rOXT3lMEkPiH0Q37rAtD7yqJGHv8eQOwnD031i60qQWdeZOlWqJnKay/tL
         pobTNJzxRqalWXHPOhRTuWVAf8Om8JmBgdoHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raC50H3i6Rq/gAHAxqx/HZulacRGFaQbhcZ8FwelmBA=;
        b=B87M4Ofa49v5Aqo7Bbi87y0eNr3O2DzZVjwqm8r26zP9gfaH1y5p+rOXDTJIZsrVvY
         inC/JpX1W9icgU0PrY3/VfOup2OkkQwXvMeFBqubuI3wtM6Z2WxR4kpnd7dvHgHTJVur
         VqGQmQrmZqusDAqtkER3f+p0wKVrlffiaxgj9WtuKRV3bMy9zkGNIMahj3vbB1pxH8B7
         G4XwbsM2zFbNHcRaNLXdWTdpb5/G5yzDRoQw019NzK3ikpt6uHp6fzByxr6KpB7R99ix
         a21gxi/3IzLu3Nifyr7fgwQZL397R9eGLugCYPuXtLQ6eOm3//pq/1IGjwMbpF53aeHU
         hl2w==
X-Gm-Message-State: ABuFfojrl8pRVBY/f0JUdE1RrwA920ycE58dWbWjoYTbXH6/WcuyZ6sV
        sktQ3GqLUDCYkMPGO52fFUVo8vP/sqRWKLPSEkyylA==
X-Google-Smtp-Source: ACcGV60v7/w3eB+kQ97g4LWUsNzubSOQT0n1AQig+LFYRFwSxy9T/2jff56+8CmyJ17jG8NVjdUGDL0uXJR1c04ao0c=
X-Received: by 2002:a25:b127:: with SMTP id g39-v6mr7812921ybj.483.1539094262749;
 Tue, 09 Oct 2018 07:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-4-git-send-email-firoz.khan@linaro.org> <CALxhOnj4r_MUuAa2zvkvxvhQttEvCZ98n2dA9d6CYyvVf2rB3g@mail.gmail.com>
 <20181008130301.GM32759@asgard.redhat.com> <CAK8P3a0eoCVBVOZs0VwybAnUw0OUoW4Z=NJYi8686EHKj076_Q@mail.gmail.com>
 <CALxhOniJZGNCP+Xw_9EF8hnUEG_AWwrnQ86Gbh7vAW6SrE8ykQ@mail.gmail.com>
 <CAK8P3a0D+GUzza--ETrT1NHGduTfFGVoCcSEn5LxvKTtMYisbA@mail.gmail.com>
 <CALxhOnhCRWsuz-2G-SovjfqkXpsRdTrG5Atz2X8s+T8u=GbUcA@mail.gmail.com> <CAK8P3a343PoH9WNH5ZYkNDTy=-ybGGsmvH9PbaSMmNo0Yob5eA@mail.gmail.com>
In-Reply-To: <CAK8P3a343PoH9WNH5ZYkNDTy=-ybGGsmvH9PbaSMmNo0Yob5eA@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 9 Oct 2018 19:40:46 +0530
Message-ID: <CALxhOnip15ztzMed59M3eKOdqdLJ2y8Yi5OGF3v__zApHzJkBQ@mail.gmail.com>
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

On Tue, 9 Oct 2018 at 16:58, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 9, 2018 at 11:36 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Tue, 9 Oct 2018 at 13:18, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Oct 9, 2018 at 7:35 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > > On Mon, 8 Oct 2018 at 19:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > Let me bring another example from powerpc:
> >
> > syscall_32.tbl,
> > 136     common  personality                     sys_personality
> >          ppc64_personality   ---> 32-bit, compat (this is the current
> > model which I implemented)
> > syscall_64.tbl
> > 136     common  personality                     ppc64_personality
> >                                        ---> 64-bit
> >
> > I was wondering if the above table is right, how to arrange like parisc model?
>
> I think this should simply be
>
> 136    32 personality sys_personality      ppc64_personality
> 136    64 personality ppc64_personality
>
> Keeping the contents exactly the same as you have them
> in the separate .tbl files, just merging the two files, and
> splitting out the differences as 32/64 ABI.
>
> > FYI, there are some implement missing for SPU in powerpc
> >
> > For your reference:
> > SYSX_SPU(sys_newfstatat,sys_fstatat64,sys_fstatat64)
> > SYSX_SPU(ppc64_personality,ppc64_personality,sys_personality)
>
> This is a good question. The only difference between SPU and
> native 64-bit is that some syscalls are not part of the SPU table
> because those syscalls are impossible to implement on SPU.
>
> Maybe we can solve this by allowing multiple comma-separated
> ABIs in the table. On powerpc, 'common' would then mean
> '32-bit, 64-bit and spu', while you could have various other
> combinations:
>
> /* always:32, 64 and SPU */
> 1 common exit sys_exit
>
> /* 32-bit only call */
> 76  32    getrlimit      sys_old_getrlimit     compat_sys_old_getrlimit
>
> /* 64-bit only, no SPU */
> 363 64 switch_endian  sys_switch_endian
>
> /* 32-bit and 64-bit, no SPU */
> 198 32,64 pciconfig_read  sys_pciconfig_read
>
> /* different pointers */
> 136    32 personality sys_personality      ppc64_personality
> 136    64,spu personality ppc64_personality
>
> Would that work for you?

At this point, yes. V2 patches for powerpc on my pipeline. I can bring
the above points when I start creating those patches.

Thanks
Firoz
>
>        Arnd
