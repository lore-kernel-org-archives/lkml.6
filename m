Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeFFByo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 21:54:44 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:41175 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeFFByn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 21:54:43 -0400
X-Google-Smtp-Source: ADUXVKLomKxGeDDL72d+FPhLnoOI05h6Oyvm8GNZoZB8SBwxQvYj9dLcKZATIJtWbnUFsO2FbECbljLwwS+ojgTFXTk=
MIME-Version: 1.0
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org> <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
 <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org> <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
 <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org> <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
 <CAK7LNAS=PvYVrLczeJT0utq3UHNL5YtSE_w=RjJYJ3SD9ALrYA@mail.gmail.com>
In-Reply-To: <CAK7LNAS=PvYVrLczeJT0utq3UHNL5YtSE_w=RjJYJ3SD9ALrYA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 18:54:31 -0700
Message-ID: <CA+55aFzNCQZHEz9P2a4ZSyWB0RxZcTkh5TVfwTmup-Y-6b8qjw@mail.gmail.com>
Subject: Re: building in 32bit chroot on x86_64 host broken
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: tmb@mageia.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 6:38 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Was the v4.16 behavior intentional,
> or just something people found to work?

I don't think all the _details_ may be intentional, but the fact that

   make oldconfig

"just works" is definitely a good thing.

> "make ARCH=i386 allnoconfig" hides the prompt
> of 64BIT.
>
> Then, "make oldconfig" makes the prompt newly visible,
> so it is asking for user input.

The "hides the prompt for 64BIT" is just a technical detail.

It could equally well be a pre-determined Kconfig fragment that is
used to generate a particular Kconfig.

But once you *have* that particular Kconfig, I do think that "make
oldconfig" should just work. And it apparently used to.

So I think this is a behavioral regression.

           Linus
