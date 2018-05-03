Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeECIlZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:41:25 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38173 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeECIlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:41:20 -0400
X-Google-Smtp-Source: AB8JxZpC3CODpYdc9BJLP9Q69unSzTRQNTa/QdLgjtTRmsY4s2ElmDA3E7MAkTa1vrPRBssbgOHie80RJwtz8VJ2kbo=
MIME-Version: 1.0
In-Reply-To: <1e0bc2e2-a0d8-16b7-b6a4-cf97ecd99cef@infradead.org>
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
 <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
 <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
 <20180430124135.0cce92e3@gandalf.local.home> <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
 <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com> <1e0bc2e2-a0d8-16b7-b6a4-cf97ecd99cef@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 May 2018 10:41:19 +0200
X-Google-Sender-Auth: lWeT19IkRcF57JFka-10LKUh3g4
Message-ID: <CAMuHMdWuJJ93ToDVX6Jg0mV8azr1vXmXHCtEbDhBXw6esevLug@mail.gmail.com>
Subject: Re: Hashed pointer issues
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tcharding <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 7:06 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 04/30/2018 10:01 AM, Linus Torvalds wrote:
>> On Mon, Apr 30, 2018 at 9:57 AM Linus Torvalds <
>> torvalds@linux-foundation.org> wrote:
>>
>>> Although in *practice* we'd have tons of entropy on any modern development
>>> CPU too, since any new hardware will have the hardware random number
>>> generation. Some overly cautious person might not trust it, of course.
>>
>> In fact, maybe that's the right policy. Avoid a boot-time parameter by just
>> saying
>>
>>   "if you have hardware random number generation, we can fill entropy
>> immediately"
>>
>> No kernel command line needed in practice any more. That's assuming any
>> kernel developer will have an IvyBridge or newer.
>
> any paid kernel developer :)

Developing for x86...

It takes several seconds to have collected sufficient entropy on e.g. some
ARM/ARM64 systems.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
