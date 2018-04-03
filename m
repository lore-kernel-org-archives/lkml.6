Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755505AbeDCL4b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:56:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:4692 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755300AbeDCL43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:56:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,400,1517904000";
   d="scan'208";a="42999881"
Message-ID: <1522756585.21176.316.camel@linux.intel.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 03 Apr 2018 14:56:25 +0300
In-Reply-To: <20180403115216.mgq3omvl4up24uic@pathway.suse.cz>
References: <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
         <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
         <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
         <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
         <1521119343.10722.665.camel@linux.intel.com>
         <20180315152607.xgzjmj5as6lg42dy@pathway.suse.cz>
         <1521224375.23017.41.camel@linux.intel.com>
         <20180329145312.4uqygrjqy3fqyl26@pathway.suse.cz>
         <1522678523.21176.178.camel@linux.intel.com>
         <20180403011237.GA7129@jagdpanzerIV>
         <20180403115216.mgq3omvl4up24uic@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-03 at 13:52 +0200, Petr Mladek wrote:
> On Tue 2018-04-03 10:12:37, Sergey Senozhatsky wrote:
> > On (04/02/18 17:15), Andy Shevchenko wrote:
> > > > 
> > > > Hmm, I have never seen the error code in this form.
> > > 
> > > We have limited space to print it and error numbers currently can
> > > be up
> > > to 0xfff (4095). So, I have no better idea how to squeeze them
> > > while
> > > thinking that "(efault)" is much harder to parse in case of error
> > 
> > 'efault' looks to me like a misspelled 'default', for some reason.
> 
> I wonder if (-efault) would help a bit.

It's 9 characters, not going to satisfy sizeof(void *) * 2 on 32-bit
systems.

> Even better might be (-EFAULT). But then it would be better to use
> (NULL). It already was but it was explicitly changed to the lowercase
> variant by the commit 0f4f81dce93774a447da3c ("vsprintf: factorize
> "(null)" string").

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
