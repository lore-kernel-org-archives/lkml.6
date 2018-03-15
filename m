Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeCONJH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:09:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:23950 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbeCONJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:09:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="24296830"
Message-ID: <1521119343.10722.665.camel@linux.intel.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Thu, 15 Mar 2018 15:09:03 +0200
In-Reply-To: <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
References: <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
         <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
         <1520330185.10722.401.camel@linux.intel.com>
         <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
         <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
         <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
         <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
         <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
         <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
         <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
         <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-14 at 15:09 +0100, Petr Mladek wrote:
> We already prevent crash when dereferencing some obviously broken
> pointers. But the handling is not consistent. Sometimes we print
> "(null)"
> only for pure NULL pointer, sometimes for pointers in the first
> page and 


> sometimes also for pointers in the last page (error codes).

I still think that printing a hex value of the error code is much better
than some odd "(efault)".


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
