Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeEPKRm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:17:42 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38505 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbeEPKRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:17:38 -0400
X-Google-Smtp-Source: AB8JxZoKRB2BrFx5KsPo9gJ7xO+zXz1LR00FbpKGqNyGSOIyOLcDQ2YtqcYH5Rx48yf7K9rH/LvlIxrHDQZkw+J0ptk=
MIME-Version: 1.0
In-Reply-To: <20180516100842.xuma7b3e727w7bpz@linutronix.de>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com> <20180516100842.xuma7b3e727w7bpz@linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 13:17:36 +0300
Message-ID: <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 1:08 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-05-15 21:37:18 [+0300], Andy Shevchenko wrote:
>> On Tue, 2018-05-15 at 21:34 +0300, Andy Shevchenko wrote:
>> > Kernel console is sensitive to any kind of complex work needed to
>> > print
>> > out anything on it. One such case is emergency print during Oops.
>> >
>> > This series proposes to disable runtime PM and DMA operations on 8250
>> > serial console.
>> >
>> > More detailed explanation why is provided in patch 2.
>> >
>> > The series has been in our internal trees for years already with no
>> > problems observed.
>>
>> +Cc: Tony.
>>
>> You might have some thoughts / test means for this.
>
> I haven't look at the patches, just your cover letter. Disabling DMA on
> kernel-console should be fine.

Would you mind to give an Ack for it?

> The output is usually short so there
> shouldn't be much benefit from using it.

> I remember Tony wanted runtime-pm on the kernel console, too. And he
> told me explicit how to test it so that it works. Once the UART goes
> into PM (down), the whole IP block can go into power save mode. The
> board can be woken up by sending a character via the UART. The first few
> (incoming / read) characters are lost until the IP block is up again the
> frequency stable. This is known / expected.

Don't consider world the OMAP only. The things more complicated if we
go out of it. Which I tried to explain in the commit message of patch
2.

> In order to achieve the same thing you would have to disable the kernel
> console on that UART. I leave this to Tony.

Precisely the point of the series.


-- 
With Best Regards,
Andy Shevchenko
