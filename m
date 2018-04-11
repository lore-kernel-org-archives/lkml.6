Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeDKJlv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:41:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33947 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbeDKJlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:41:50 -0400
Date: Wed, 11 Apr 2018 11:41:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/9] lib/test_printf: Mark big constant with ULL
Message-ID: <20180411094147.6zmq5h46men6g74t@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
 <20180218125802.lu5abzydm2hwxj5p@ltop.local>
 <1519053862.22495.396.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519053862.22495.396.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-02-19 17:24:22, Andy Shevchenko wrote:
> On Sun, 2018-02-18 at 13:58 +0100, Luc Van Oostenryck wrote:
> > On Fri, Feb 16, 2018 at 11:07:03PM +0200, Andy Shevchenko wrote:
> > > Sparse complains that constant is so bit for unsigned long on 64-bit
> > > architecture.
> > > 
> > > lib/test_printf.c:217:54: warning: constant 0xffff0123456789ab is so
> > > big it is unsigned long
> > > lib/test_printf.c:246:54: warning: constant 0xffff0123456789ab is so
> > > big it is unsigned long
> > > 
> > > To satisfy everyone, mark the constant with ULL.
> > 
> > It should be 'UL' not 'ULL' since for architectures a pointer and
> > a unsigned long have the ame size while on 32bit archs, long long
> > are (or may?) 64bit.
> 
> Yes, UL works as well.

I have updated the patch and pushed it into printk.git,
branch for-4.18-vsprintf-cleanup.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
