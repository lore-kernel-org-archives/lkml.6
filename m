Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbeEOShX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:37:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:43027 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeEOShW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:37:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="42034960"
Message-ID: <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>
Date: Tue, 15 May 2018 21:37:18 +0300
In-Reply-To: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-15 at 21:34 +0300, Andy Shevchenko wrote:
> Kernel console is sensitive to any kind of complex work needed to
> print
> out anything on it. One such case is emergency print during Oops.
> 
> This series proposes to disable runtime PM and DMA operations on 8250
> serial console.
> 
> More detailed explanation why is provided in patch 2.
> 
> The series has been in our internal trees for years already with no
> problems observed.

+Cc: Tony.

You might have some thoughts / test means for this.

> 
> Andy Shevchenko (3):
>   console: introduce ->exit() callback
>   serial: 8250_port: Don't use power management for kernel console
>   serial: 8250_port: Disable DMA operations for kernel console
> 
>  drivers/tty/serial/8250/8250_core.c |  9 +++++++++
>  drivers/tty/serial/8250/8250_port.c | 27 ++++++++++++++++++++++-----
>  include/linux/console.h             |  1 +
>  include/linux/serial_8250.h         |  1 +
>  kernel/printk/printk.c              |  3 +++
>  5 files changed, 36 insertions(+), 5 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
