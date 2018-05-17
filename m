Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEQQgg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:36:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42126 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeEQQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:36:33 -0400
X-Google-Smtp-Source: AB8JxZpTOXX6H/uUWYru4Kx1V4027EIS4CVtpXfBCcdp0CRUuys2q4X8KjMV7jQ+/+itObN7eXRlmuiXX4UYlwUcxb0=
MIME-Version: 1.0
In-Reply-To: <20180517134820.GI98604@atomide.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de> <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de> <20180517134820.GI98604@atomide.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 17 May 2018 19:36:30 +0300
Message-ID: <CAHp75Veb+zBfh=44qmMevvrfCSRYhfUMJUMArsDBtgM-F_FknQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 4:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [180516 10:49]:
>> On 2018-05-16 13:17:36 [+0300], Andy Shevchenko wrote:
>> > > The output is usually short so there
>> > > shouldn't be much benefit from using it.
>> >
>> > > I remember Tony wanted runtime-pm on the kernel console, too. And he
>> > > told me explicit how to test it so that it works. Once the UART goes
>> > > into PM (down), the whole IP block can go into power save mode. The
>> > > board can be woken up by sending a character via the UART. The first few
>> > > (incoming / read) characters are lost until the IP block is up again the
>> > > frequency stable. This is known / expected.
>> >
>> > Don't consider world the OMAP only. The things more complicated if we
>> > go out of it. Which I tried to explain in the commit message of patch
>> > 2.
>>
>> I am not saying the world is OMAP only. I just tried to explain how any
>> why it got there and its purpose. I haven't NACKed it. I would believe
>> that with that information and Tony not defending his use case or
>> possible change it somehow so it is not standing in your way, Greg would
>> have enough information to go your way.
>
> The idea breaking PM seems silly to me considering that we've had
> it working for years already.

Same question  / note. World is much more complex than just being OMAP.

-- 
With Best Regards,
Andy Shevchenko
