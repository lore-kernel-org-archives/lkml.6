Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeEQTsl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:48:41 -0400
Received: from muru.com ([72.249.23.125]:42850 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbeEQTsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:48:39 -0400
Date: Thu, 17 May 2018 12:48:34 -0700
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Message-ID: <20180517194834.GW25808@atomide.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de>
 <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de>
 <20180517134820.GI98604@atomide.com>
 <CAHp75Veb+zBfh=44qmMevvrfCSRYhfUMJUMArsDBtgM-F_FknQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Veb+zBfh=44qmMevvrfCSRYhfUMJUMArsDBtgM-F_FknQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andy.shevchenko@gmail.com> [180517 16:38]:
> On Thu, May 17, 2018 at 4:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [180516 10:49]:
> >> On 2018-05-16 13:17:36 [+0300], Andy Shevchenko wrote:
> >> > > The output is usually short so there
> >> > > shouldn't be much benefit from using it.
> >> >
> >> > > I remember Tony wanted runtime-pm on the kernel console, too. And he
> >> > > told me explicit how to test it so that it works. Once the UART goes
> >> > > into PM (down), the whole IP block can go into power save mode. The
> >> > > board can be woken up by sending a character via the UART. The first few
> >> > > (incoming / read) characters are lost until the IP block is up again the
> >> > > frequency stable. This is known / expected.
> >> >
> >> > Don't consider world the OMAP only. The things more complicated if we
> >> > go out of it. Which I tried to explain in the commit message of patch
> >> > 2.
> >>
> >> I am not saying the world is OMAP only. I just tried to explain how any
> >> why it got there and its purpose. I haven't NACKed it. I would believe
> >> that with that information and Tony not defending his use case or
> >> possible change it somehow so it is not standing in your way, Greg would
> >> have enough information to go your way.
> >
> > The idea breaking PM seems silly to me considering that we've had
> > it working for years already.
> 
> Same question  / note. World is much more complex than just being OMAP.

Sorry but you are making assumptions about hardware being powered on
all the time.

It may have been a safe assumption up to mid-90's and might still be
valid assumption for hardware providing on MS-DOS boot floppy
compability.

But that is not a safe assumption for Linux kernel at all. Especially
for console TX where there's no need to keep it powered unless there
is actually something to write.

If there are runtime PM issues for consoles, let's just fix them.

Then for really seeing console messages on next reboot from a hung
system, CONFIG_PSTORE_CONSOLE option seems to do a very good job.
With a warm reset after triggered by watchdog the console messages
are readable most of the time even when using DDR as the back end.

Regards,

Tony
