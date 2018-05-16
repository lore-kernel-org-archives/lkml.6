Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEPSUp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:20:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeEPSUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:20:43 -0400
Date: Wed, 16 May 2018 20:20:37 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 3/3] serial: 8250_port: Disable DMA operations for
 kernel console
Message-ID: <20180516182037.uvjqe2gyqtf3r24b@linutronix.de>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <20180515183409.78046-4-andriy.shevchenko@linux.intel.com>
 <20180516105553.h7e2buanqfxxya4e@linutronix.de>
 <171c11a999e2d9580d3783588d20b58e753c89ef.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <171c11a999e2d9580d3783588d20b58e753c89ef.camel@linux.intel.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-16 15:58:10 [+0300], Andy Shevchenko wrote:
> > > It will be too tricky and error prone to allow DMA operations on
> > > kernel
> > > console.
> > 
> > Why is it tricky and error prone? I had it working…
> 
> On OMAP only? Had you tested this on let's say Intel Cherrytrail where
> DMA controller is a separate PCI device which needs to be handled
> separately from UART IP.

My point was simply to clarify if this entirely broken and requires
backports or if this makes things more complicated and could be avoided.

> > But I don't mind dropping the DMA on the kernel console because I
> > doubt
> > that we lose something here by disabling it. I would even imagine that
> > it gets "simpler" (maybe what you tried to say by "error prone") to
> > print something in the NMI case by writing directly to the FIFO
> > register
> > instead setting up a DMA transfer and so on.
> 
> "error prone" mostly refers to patch 2 commit message. Here it seems I
> need to put something like above to explain why DMA case tricky _as
> well_.

Yes, full context is helpful :)

Sebastian
