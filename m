Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeDCN53 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:57:29 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:44417 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeDCN52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:57:28 -0400
X-Google-Smtp-Source: AIpwx4+4jACwZr9zRihWP0ZZ+NI7PlCt+xexb4viF59Fk4Ys3L6EBVvEuxBwM5q6kaTrDxe/zBjylA==
Date: Tue, 3 Apr 2018 22:57:23 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180403135723.GA7593@tigerII.localdomain>
References: <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <1521119343.10722.665.camel@linux.intel.com>
 <20180315152607.xgzjmj5as6lg42dy@pathway.suse.cz>
 <1521224375.23017.41.camel@linux.intel.com>
 <20180329145312.4uqygrjqy3fqyl26@pathway.suse.cz>
 <1522678523.21176.178.camel@linux.intel.com>
 <20180403011237.GA7129@jagdpanzerIV>
 <20180403115216.mgq3omvl4up24uic@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403115216.mgq3omvl4up24uic@pathway.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/03/18 13:52), Petr Mladek wrote:
> On Tue 2018-04-03 10:12:37, Sergey Senozhatsky wrote:
> > On (04/02/18 17:15), Andy Shevchenko wrote:
> > > > 
> > > > Hmm, I have never seen the error code in this form.
> > > 
> > > We have limited space to print it and error numbers currently can be up
> > > to 0xfff (4095). So, I have no better idea how to squeeze them while
> > > thinking that "(efault)" is much harder to parse in case of error
> > 
> > 'efault' looks to me like a misspelled 'default', for some reason.
> 
> I wonder if (-efault) would help a bit.

Dunno. If the pointer is invalid and -EFAULTS then I guess we are not
leaking anything critical and may be can just print it out. May be I'm
wrong.

	-ss
