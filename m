Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeFAP2M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:28:12 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44532 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeFAP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:28:07 -0400
X-Google-Smtp-Source: ADUXVKJ8QglhZa2krHTzWUSE10EhatOrRBtzrOw442dGDzLvqZ9DHSEuxkSkvmRg2wnGHG2wHM27xDNRPMvgE1jw4g4=
MIME-Version: 1.0
In-Reply-To: <20180601151905.yilldc6vbachfw4k@pathway.suse.cz>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <CA+55aFxHHSRnDbbNGq6SwNAwEt0EhX15n_pNqon3MzGYJgMJmA@mail.gmail.com>
 <20180601114738.kdoggkha2yosjgbv@pathway.suse.cz> <20180601151905.yilldc6vbachfw4k@pathway.suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Jun 2018 17:28:06 +0200
X-Google-Sender-Auth: Xdlh3-YqFEqGlbeDSSaCnKtFotQ
Message-ID: <CAMuHMdX6ACCiEs=EEbQV3=Ah7BZT1RJ1G0kZKeYKi_KzWoKZgQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] lib/vsprintf: Remove atomic-unsafe support for printk
 format %pCr
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Fri, Jun 1, 2018 at 5:19 PM, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2018-06-01 13:47:38, Petr Mladek wrote:
>> On Fri 2018-06-01 06:00:47, Linus Torvalds wrote:
>> > On Fri, Jun 1, 2018 at 4:29 AM Geert Uytterhoeven
>> > <geert+renesas@glider.be> wrote:
>> > >
>> > > This patch series:
>> > >   - Changes all existing users of "%pCr" to print the result of
>> > >     clk_get_rate() directly, which is safe as they all do this in task
>> > >     context only,
>> > >   - Removes support for the "%pCr" printk format.
>> >
>> > Looks good to me.
>> >
>> > What tree will this go through? The normal printk one? Just checking
>> > that this doesn't end up falling through the cracks because nobody
>> > knows who would take it...
>>
>> I will take it via printk.git. There already is bunch of vsprintf
>> changes for-4.18.
>
> It is in printk.git, branch for-4.18-vsprintf-pcr-removal now.

Thank you.

> Also I have added Cc: stable@vger.kernel.org into the commit messages.

I can confirm all stable version references ("v4.x+") match.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
