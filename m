Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A69C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74D520870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfAVLoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:44:32 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45961 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfAVLoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:44:32 -0500
Received: by mail-ua1-f66.google.com with SMTP id e16so7919205uam.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 03:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lJPu7bpT/1PNwCJ/j5pXR1jqXKDyNk3ysV82+ANdvc=;
        b=OUZ7ERURuGF+zt593aQI3dAERW2Vk1npVT5S7zfUSoFfdG7ZiwHIk/guW9r9ziimWF
         6CV+UvpjFS3wkuSRRfxevUOjexu0yLlSv6AUu8VyWhZuF3vxvycRMDmCj4RmRHkExp/8
         LySTLeCnQp+WREveg79BlXMawMJE3ZGWK0QpZVlMp3ecvWw9YQnMv+JPQCdsXsKW4JYP
         TkCd58YX9nSLhFn5P9FvW09oAj/R+QqY1GEEzu0dfYArUl22gge+vKdTLZZ9U+vba1Nw
         fjgXLF+TT0IQt/iVP+OflFFZA78I0vRNb6omtGc1xQEDNDe+dlAJu8wksCGaLVwv72KQ
         97AA==
X-Gm-Message-State: AJcUukc2+fEo7N6Tj4/9GEf5nluapW1/1l6gl7IO/f6a7wVtluB2ltr5
        nc8bx6/pG+4RC+Q06YzCpY9x6z+eyUNwijixeJY=
X-Google-Smtp-Source: ALg8bN6kEAyZCPeJXOQkTE0oVhVe5pcPCVd3/jd3cZIbw17YM8fxtLV++i7mVEEaWQn/GafXa9ismBorXXNW794gau4=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr12786635uad.78.1548157470847;
 Tue, 22 Jan 2019 03:44:30 -0800 (PST)
MIME-Version: 1.0
References: <201901221835.KyE294P1%fengguang.wu@intel.com>
In-Reply-To: <201901221835.KyE294P1%fengguang.wu@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Jan 2019 12:44:18 +0100
Message-ID: <CAMuHMdXmMM8xgGn23YkVHbrYe5108yqfM1Rrx8PJ9RmFNjOqTg@mail.gmail.com>
Subject: Re: proc.c:undefined reference to `strcmp'
To:     kbuild test robot <lkp@intel.com>
Cc:     Olof Johansson <olof@lixom.net>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:11 AM kbuild test robot <lkp@intel.com> wrote:
> It's probably a bug fix that unveils the link errors.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   47bfa6d9dc8c060bf56554a465c9031e286d2f80
> commit: 35004f2e55807a1a1491db24ab512dd2f770a130 lib/genalloc.c: include vmalloc.h
> date:   2 weeks ago
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 35004f2e55807a1a1491db24ab512dd2f770a130
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.2.0 make.cross ARCH=m68k
>
> All errors (new ones prefixed by >>):
>
>    m68k-linux-gnu-ld: block/partitions/ldm.o: in function `ldm_partition':
>    ldm.c:(.text+0x1900): undefined reference to `strcmp'
>    m68k-linux-gnu-ld: ldm.c:(.text+0x1964): undefined reference to `strcmp'
>    m68k-linux-gnu-ld: drivers/rtc/proc.o: in function `is_rtc_hctosys':
> >> proc.c:(.text+0x18c): undefined reference to `strcmp'
>    m68k-linux-gnu-ld: drivers/watchdog/watchdog_pretimeout.o: in function `watchdog_register_governor':
>    watchdog_pretimeout.c:(.text+0x142): undefined reference to `strcmp'
>    m68k-linux-gnu-ld: drivers/devfreq/devfreq.o: in function `try_then_request_governor':
>    devfreq.c:(.text+0x9c6): undefined reference to `strcmp'

I guess this bisection is a false positive. Have you just upgraded to gcc 8?
Gcc 8 replaces the strncmp() in is_rtc_hctosys() to strcmp().
Will be fixed in v5.1 by
https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/commit/?h=for-v5.1&id=28713169d879b67be2ef2f84dcf54905de238294

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
