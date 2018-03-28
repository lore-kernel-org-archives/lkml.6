Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeC1MXx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 08:23:53 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43981 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeC1MXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 08:23:48 -0400
X-Google-Smtp-Source: AIpwx4+85M1xSt9RMsqc6BAqcnXZW4SBZBKhhmoVdfGhMtnIBN7gcB4LVMcA4zajKJ9vr8R1Oy7cKUGDJIwTS86dDyw=
MIME-Version: 1.0
In-Reply-To: <20180328120440.GB1838@infradead.org>
References: <20180324174458.26423-1-shea@shealevy.com> <20180324174458.26423-2-shea@shealevy.com>
 <20180328120440.GB1838@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Mar 2018 14:23:47 +0200
X-Google-Sender-Auth: YPB-fm2qaR066Y_xUJn7hHxFXxM
Message-ID: <CAMuHMdXwEL-gLxiVJwuxwRtkyhR=vEm3GP4dzJMpc1nS8AKxKQ@mail.gmail.com>
Subject: Re: [PATCH 01/16] initrd: Add generic code path for common initrd
 unloading logic.
To: Christoph Hellwig <hch@infradead.org>
Cc: Shea Levy <shea@shealevy.com>, alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE"
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 2:04 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
>> +void free_initrd_mem(unsigned long start, unsigned long end)
>> +{
>> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> +}
>> +#endif
>
> Given how trivial this is and how many architectures can use it I'd
> reverse the polarity and add a CONFIG_HAVE_ARCH_FREE_INITRD_MEM
> instead.

And while adding "special" functionality to the generic version, more and more
users of CONFIG_HAVE_ARCH_FREE_INITRD_MEM will be removed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
