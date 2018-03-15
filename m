Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeCOP0L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:26:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:54252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752216AbeCOP0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:26:10 -0400
Date: Thu, 15 Mar 2018 16:26:07 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180315152607.xgzjmj5as6lg42dy@pathway.suse.cz>
References: <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
 <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
 <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
 <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <1521119343.10722.665.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521119343.10722.665.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-03-15 15:09:03, Andy Shevchenko wrote:
> On Wed, 2018-03-14 at 15:09 +0100, Petr Mladek wrote:
> > We already prevent crash when dereferencing some obviously broken
> > pointers. But the handling is not consistent. Sometimes we print
> > "(null)"
> > only for pure NULL pointer, sometimes for pointers in the first
> > page and 
> 
> 
> > sometimes also for pointers in the last page (error codes).
> 
> I still think that printing a hex value of the error code is much better
> than some odd "(efault)".

Do you mean (err:0e)? Google gives rather confusing answers for this.

I am not super excited about (efault). But it seems to be less
cryptic and the style is more similar to (null).

Best Regards,
Petr
