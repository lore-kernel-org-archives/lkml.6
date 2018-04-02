Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeDBOP2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:15:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:51543 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbeDBOP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:15:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,395,1517904000";
   d="scan'208";a="44229961"
Message-ID: <1522678523.21176.178.camel@linux.intel.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Mon, 02 Apr 2018 17:15:23 +0300
In-Reply-To: <20180329145312.4uqygrjqy3fqyl26@pathway.suse.cz>
References: <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
         <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
         <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
         <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
         <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
         <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
         <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
         <1521119343.10722.665.camel@linux.intel.com>
         <20180315152607.xgzjmj5as6lg42dy@pathway.suse.cz>
         <1521224375.23017.41.camel@linux.intel.com>
         <20180329145312.4uqygrjqy3fqyl26@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-29 at 16:53 +0200, Petr Mladek wrote:
> On Fri 2018-03-16 20:19:35, Andy Shevchenko wrote:
> > On Thu, 2018-03-15 at 16:26 +0100, Petr Mladek wrote:
> > > On Thu 2018-03-15 15:09:03, Andy Shevchenko wrote:

> > > > I still think that printing a hex value of the error code is
> > > > much
> > > > better
> > > > than some odd "(efault)".
> > > 
> > > Do you mean (err:0e)? Google gives rather confusing answers for
> > > this.
> > 
> > More like "(0xHHHH)" (we have already more than 512 error code
> > numbers.
> 
> Hmm, I have never seen the error code in this form.

We have limited space to print it and error numbers currently can be up
to 0xfff (4095). So, I have no better idea how to squeeze them while
thinking that "(efault)" is much harder to parse in case of error
pointer.

>  Also google gives
> rather confusing results when searching, for example for "(0x000E)".

It's not primarily for google, though yeah, people would google for
error messages...

Another question is what the format: decimal versus hex for errors.
Maybe just "(-DDDDD)"?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
