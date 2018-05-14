Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeENLEx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:04:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:2609 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752101AbeENLEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:04:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="224052945"
Message-ID: <29a254ac8f40ef4127d998f25c29d24d4a4f611e.camel@linux.intel.com>
Subject: Re: [PATCH v2] x86/io: Define readq()/writeq() to use 64-bit type
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 14 May 2018 14:04:49 +0300
In-Reply-To: <alpine.DEB.2.21.1805140910480.1582@nanos.tec.linutronix.de>
References: <20180503102810.59657-1-andriy.shevchenko@linux.intel.com>
         <alpine.DEB.2.21.1805132007200.1582@nanos.tec.linutronix.de>
         <CAHp75Vc7uFDbHcf+mbaBxu2adiDD9CY7Z-fhn5E_3dZDZiTYoA@mail.gmail.com>
         <alpine.DEB.2.21.1805140910480.1582@nanos.tec.linutronix.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-14 at 09:12 +0200, Thomas Gleixner wrote:
> On Sun, 13 May 2018, Andy Shevchenko wrote:
> > On Sun, May 13, 2018 at 9:09 PM, Thomas Gleixner <tglx@linutronix.de
> > > wrote:
> > > On Thu, 3 May 2018, Andy Shevchenko wrote:
> > > >  #ifdef CONFIG_X86_64
> > > > 
> > > > -build_mmio_read(readq, "q", unsigned long, "=r", :"memory")
> > > > -build_mmio_read(__readq, "q", unsigned long, "=r", )
> > > > -build_mmio_write(writeq, "q", unsigned long, "r", :"memory")
> > > > -build_mmio_write(__writeq, "q", unsigned long, "r", )
> > > > +build_mmio_read(readq, "q", unsigned long long, "=r",
> > > > :"memory")
> > > > +build_mmio_read(__readq, "q", unsigned long long, "=r", )
> > > > +build_mmio_write(writeq, "q", unsigned long long, "r",
> > > > :"memory")
> > > > +build_mmio_write(__writeq, "q", unsigned long long, "r", )
> > > 
> > > What's wrong with u64 which we use for expressing io access to a
> > > 64bit wide
> > > resource?
> > 
> > Same answer as per v1, i.e. I would like to be consistent with other
> > types in this file (unsigned int for readl() and similar for the
> > rest).
> > If we would need them, we might change at once for all accessors.
> 
> I don;t think we need to fixup everything in one go. Having the patch
> which
> addresses the issue at hand first using u64 makes a lot of sense on
> its own.
> 
> Changing the other instances can be done as a follow up patch. Having
> explicit with types for such kind of accessors makes a lot of sense.

OK, I will re-do it this way.
Thanks for review!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
