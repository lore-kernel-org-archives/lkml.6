Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeCEOxK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:53:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:58030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751830AbeCEOxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:53:08 -0500
Date: Mon, 5 Mar 2018 15:53:06 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
Message-ID: <20180305145306.5i643d2oqupc4rba@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
 <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
 <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
 <1519752950.10722.231.camel@linux.intel.com>
 <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
 <1519814544.10722.266.camel@linux.intel.com>
 <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
 <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
 <1520000254.10722.389.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520000254.10722.389.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-03-02 16:17:34, Andy Shevchenko wrote:
> On Fri, 2018-03-02 at 13:53 +0100, Petr Mladek wrote:
> > %p has many modifiers where the pointer is dereferenced. An invalid
> > pointer might cause kernel to crash silently.
> > 
> > Note that printk() formats the string under logbuf_lock. Any recursive
> > printks are redirected to the printk_safe implementation and the
> > messages
> > are stored into per-CPU buffers. These buffers might be eventually
> > flushed
> > in printk_safe_flush_on_panic() but it is not guaranteed.
> > 
> > In general, we should do our best to get useful message from printk().
> > All pointers to the first memory page must be invalid. Let's prevent
> > the dereference and print "(null)" in this case. This is already done
> > in many other situations, including "%s" format handling and many
> > page fault handlers.
> > 
> 
> 
> With such explanation it makes at least clear for the reader why it's
> done.
> 
> Thanks!
> 
> Would you be okay if I take this one as a first in my series and
> resubmit the series based on it?

Makes sense. Feel free to go on.

Best Regards,
Petr
