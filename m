Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeEVVwE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:52:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37927 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeEVVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:52:02 -0400
X-Google-Smtp-Source: ADUXVKJFtmk5TeyOxGWQoqox03nrM3dlt9HFjOgMIwr9U7XBcL4OnR5gctMcBhPAH3F2H1XcnN83H8JqGGCKNdgxWRk=
MIME-Version: 1.0
In-Reply-To: <20180517194834.GW25808@atomide.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de> <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de> <20180517134820.GI98604@atomide.com>
 <CAHp75Veb+zBfh=44qmMevvrfCSRYhfUMJUMArsDBtgM-F_FknQ@mail.gmail.com> <20180517194834.GW25808@atomide.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 May 2018 00:52:01 +0300
Message-ID: <CAHp75Vf7L3zsSgaj1vfoyNKdPo0w6Nu+mW5HuM97SKAK-1y2Pg@mail.gmail.com>
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

On Thu, May 17, 2018 at 10:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Andy Shevchenko <andy.shevchenko@gmail.com> [180517 16:38]:
>> On Thu, May 17, 2018 at 4:48 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [180516 10:49]:

>> > The idea breaking PM seems silly to me considering that we've had
>> > it working for years already.
>>
>> Same question  / note. World is much more complex than just being OMAP.
>
> Sorry but you are making assumptions about hardware being powered on
> all the time.

Nope, other way around. The so called "support" _prevents_ our
hardware to go to sleep.

So it's not breaking, it's fixing. It's pity that OMAP solution is just a hack.

> It may have been a safe assumption up to mid-90's and might still be
> valid assumption for hardware providing on MS-DOS boot floppy
> compability.
>
> But that is not a safe assumption for Linux kernel at all. Especially
> for console TX where there's no need to keep it powered unless there
> is actually something to write.
>
> If there are runtime PM issues for consoles, let's just fix them.

Yes, there is an issue to begin with, i.e. irq_safe hack.
Removal of that hack reveals the real issues with the code.

> Then for really seeing console messages on next reboot from a hung
> system, CONFIG_PSTORE_CONSOLE option seems to do a very good job.

How this helps to prevent a more serious system crashes during an
attempt to power UART on?

> With a warm reset after triggered by watchdog the console messages
> are readable most of the time even when using DDR as the back end.

Ditto.

-- 
With Best Regards,
Andy Shevchenko
