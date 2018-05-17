Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeEQQjD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:39:03 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39082 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbeEQQjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:39:01 -0400
X-Google-Smtp-Source: AB8JxZoWA83MTYAXJfYOWkIGglETs2dN32TImq4VY2Js6LeAyVJ1DDchzXyLUsezVt/qwxJAuMdVUFlvi6N/QRoO6v0=
MIME-Version: 1.0
In-Reply-To: <20180517135621.GJ98604@atomide.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de> <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de> <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
 <20180517135621.GJ98604@atomide.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 17 May 2018 19:38:59 +0300
Message-ID: <CAHp75VfqAK6+dPWWkQXjy0V-AFSGLSDJ9CmnUv=ba0F66TDTVg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
To: Tony Lindgren <tony@atomide.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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

On Thu, May 17, 2018 at 4:56 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180516 13:12]:
>> On Wed, 2018-05-16 at 12:47 +0200, Sebastian Andrzej Siewior wrote:
>> > But since I am on it. You have to enable runtime-PM for the UART. So
>> > what is the problem if you simply don't enable it for the UART which
>> > used as the kernel console?
>>
>> How do I know at the ->probe() time that device in question is going to
>> be kernel console? Maybe I missed simple way of it.
>
> Hmm parse the kernel cmdline maybe? :)
>
> BTW, kernel already has earlycon doing exactly what you're trying to do.

I'm sorry, I didn't follow. What exactly earlycon does?

The problem is in 8250 driver. The issue with runtime PM used in atomic context.
So, I can, of course just remove callbacks from the console ->write().
Though it will prevent to use kernel console anyway.

-- 
With Best Regards,
Andy Shevchenko
