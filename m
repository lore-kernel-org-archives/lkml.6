Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442C9C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AF42082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AF42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeJ2VMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:12:40 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34633 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbeJ2VMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:12:40 -0400
Received: by mail-ua1-f68.google.com with SMTP id e16so2908738uam.1;
        Mon, 29 Oct 2018 05:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLYcpoC4AzznivyKU+Pgr0Yx8LvLUD2kYSJW99fFSi4=;
        b=TjcO7LAkDyaZIUmtHcIdz4k3OIWEFoz3YLJakW4YXE1Dj8fQdUEhE3LQf5pdnIjQCn
         tRrdW/hIrI6V5oYPnC26T/yr8hWUTXIvW9nY0/avWuLKB6W5Cj6flNbZvkGNgEqAsNFp
         jVTleZcuXY2962zhQ3jVnh1m9fLUkmo+3eloIoWb2oTBSbq6suV7oedfEk2IXRfVYgHv
         eg0kcf8Qi7QOlhkyVdxZ9mn3RU8pGJ/CRn7LjEgv7XdWJEDPbcKvnkojXqz4ec4rTlrI
         IWiv0Mo2u6G2USe2pOWBoDp4QsSN+3ugxCB5Yq+SgbWJlnxAnuX14ayy55UdeK9G67p2
         6zSA==
X-Gm-Message-State: AGRZ1gJcNA7WUV7bxnAqoUVbZahQ8K9hUFwbGlamcxt6Fo9u6Z+9InzE
        FETcq/2bByd56F36mFjCOt+gygeczHPSs1ahCq8=
X-Google-Smtp-Source: AJdET5fkeegReK1F7HNTUqClapA2/2rlP1fqdt8v4GoN8iOOlqh2YPWgq2Jxz+D1yJ3BWIfV5a0tyq2dQB0LpNtV3XY=
X-Received: by 2002:a9f:308a:: with SMTP id j10mr6155683uab.28.1540815852216;
 Mon, 29 Oct 2018 05:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
 <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
 <CAMuHMdU6e8vu_Kak2Avzn2WeTkmc-mjagR5tzX8BxgdH_UcYUA@mail.gmail.com> <CAK8P3a1mnNbMA+qRLKkhwwW_+KzkSfeNA5Nn_zVS1z8OWU+uGg@mail.gmail.com>
In-Reply-To: <CAK8P3a1mnNbMA+qRLKkhwwW_+KzkSfeNA5Nn_zVS1z8OWU+uGg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Oct 2018 13:24:00 +0100
Message-ID: <CAMuHMdU-Vm_iwaY7hO54n+NuqRgfEmyBx8+HM6m0XtoqoG+AXw@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Guo Ren <ren_guo@c-sky.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com,
        Marta Rybczynska <mrybczyn@kalray.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Oct 29, 2018 at 12:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Oct 29, 2018 at 11:26 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Oct 29, 2018 at 10:45 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > One more general comment: I think this may well be the last new CPU
> > > architecture we ever add to the kernel. Both nds32 and c-sky are made
> > > by companies that also work on risc-v, and generally speaking risc-v
> > > seems to be killing off any of the minor licensable instruction set projects,
> > > just like ARM has mostly killed off the custom vendor-specific instruction
> > > sets already. If we add another architecture in the future, it may instead
> > > be something like the LLVM bitcode or WebAssembly, who knows?
> >
> > Kalray MPPA?
> >
>
> Ok, I stand corrected. I found the sources at [1], which look like they
> are getting ready for an initial submission.
>
>        Arnd
>
> [1] https://github.com/kalray/linux_coolidge/commits/kalray-v4.19-rc8

Cool, I didn't know they were that close ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
