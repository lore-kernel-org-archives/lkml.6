Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755454AbeDCLqD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:46:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:58927 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755335AbeDCLqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:46:02 -0400
Date: Tue, 3 Apr 2018 13:46:00 +0200
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
Message-ID: <20180403114600.uc7sqeoqt7fmdd66@pathway.suse.cz>
References: <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
 <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <1521119343.10722.665.camel@linux.intel.com>
 <20180315152607.xgzjmj5as6lg42dy@pathway.suse.cz>
 <1521224375.23017.41.camel@linux.intel.com>
 <20180329145312.4uqygrjqy3fqyl26@pathway.suse.cz>
 <1522678523.21176.178.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522678523.21176.178.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-04-02 17:15:23, Andy Shevchenko wrote:
> On Thu, 2018-03-29 at 16:53 +0200, Petr Mladek wrote:
> > On Fri 2018-03-16 20:19:35, Andy Shevchenko wrote:
> > > On Thu, 2018-03-15 at 16:26 +0100, Petr Mladek wrote:
> > > > On Thu 2018-03-15 15:09:03, Andy Shevchenko wrote:
> 
> > > > > I still think that printing a hex value of the error code is
> > > > > much
> > > > > better
> > > > > than some odd "(efault)".
> > > > 
> > > > Do you mean (err:0e)? Google gives rather confusing answers for
> > > > this.
> > > 
> > > More like "(0xHHHH)" (we have already more than 512 error code
> > > numbers.
> > 
> > Hmm, I have never seen the error code in this form.
> 
> We have limited space to print it and error numbers currently can be up
> to 0xfff (4095). So, I have no better idea how to squeeze them while
> thinking that "(efault)" is much harder to parse in case of error
> pointer.

But this will not be used instead of address value. It is used in situations
where we print the information that is stored at the address, for example,
string, IP address, dentry name.

> >  Also google gives
> > rather confusing results when searching, for example for "(0x000E)".
> 
> It's not primarily for google, though yeah, people would google for
> error messages...
> 
> Another question is what the format: decimal versus hex for errors.
> Maybe just "(-DDDDD)"?

This still looks confusing and google does not help.

Best Regards,
Petr
