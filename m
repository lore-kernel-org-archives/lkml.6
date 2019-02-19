Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C75208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfBSU3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:29:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37503 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfBSU3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:29:23 -0500
Received: by mail-qk1-f196.google.com with SMTP id m9so541237qkl.4;
        Tue, 19 Feb 2019 12:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPY1f5W3M3S0pVQ+klaobPrfxSm2NF3tA5R2/oioi8Y=;
        b=JcKq7wNNxISl2PALLURO0ODawwNNsL0AgKXIT4A1XX+56bTNbWyCADyLjwZgko+0bB
         fp9JSC0ILhBWTuDHVVMdOtQfp/aMRFNxRuSXQEK/apcES2TxPgqaabmjtw4+8Zm2Lg6l
         c8SyxhqCMHnpK4bw1rWOWNg5yiwF2y6Q5DpXbIQo9HDui6iiessG+wbafTRaybHTQyni
         GziSiIjPfq3dx8SAn6WDmwnHvNx3is8/XpuXPfdfvf4g9LlA9le28+omxM6R9M6FZ3/N
         8PtaraOfFs+na4znOWDc1OdAzMJ4D3JkE9WNpDLh7HCI9BuBj45tXqFmPidjkCkFdpHh
         dECw==
X-Gm-Message-State: AHQUAuY35A7IO9nwvEhIIUiambaCUO/OvVidxwZU+bOeyTm/tX2badga
        8RtgDwZAdGJqTsOYHdp4spocYT6udP9FQ6BpVgU=
X-Google-Smtp-Source: AHgI3IZWyX/lVaQAvClHL38keads40kOoUMMxm2i4x66H1BX9+lk6NC00fUlkEoemnqJp2fXcbm2Hb1h0YEdHgBZwpY=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr22351671qki.291.1550608158219;
 Tue, 19 Feb 2019 12:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20190218210712.3503891-1-arnd@arndb.de> <20190218210712.3503891-5-arnd@arndb.de>
 <CAMuHMdVbz=_GFMnKx4PuxpmG9jpdA=Do2XnR3bY5wRZPM3G+Gw@mail.gmail.com>
In-Reply-To: <CAMuHMdVbz=_GFMnKx4PuxpmG9jpdA=Do2XnR3bY5wRZPM3G+Gw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Feb 2019 21:29:01 +0100
Message-ID: <CAK8P3a0UD7_omc4=o7VLaLKUX4Z1eWXU15TeqgvjXfhyv+7xCA@mail.gmail.com>
Subject: Re: [PATCH 4/8] asm-generic: Make time32 syscall numbers optional
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
        linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 9:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On Tue, Feb 19, 2019 at 3:34 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > We don't want new architectures to even provide the old 32-bit time_t
> > based system calls any more, or define the syscall number macros.
> >
> > Add a new __ARCH_WANT_TIME32_SYSCALLS macro that gets enabled for all
> > existing 32-bit architectures so we don't change any current behavior.
>
> ... (only) 32-bit architectures using the generic syscall list, right?

Correct, I've added a clarification in the commit text in my git tree now,
thanks for the proofreading!

       Arnd
