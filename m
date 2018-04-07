Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeDGOXX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 10:23:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:43151 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751849AbeDGOXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 10:23:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,419,1517904000";
   d="scan'208";a="35164931"
Message-ID: <1523110998.21176.414.camel@linux.intel.com>
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown
 pointer specifiers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Sat, 07 Apr 2018 17:23:18 +0300
In-Reply-To: <741c7f99-e39e-296c-1b91-3df7113ee71c@rasmusvillemoes.dk>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-5-pmladek@suse.com>
         <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
         <1522971908.11185.46.camel@perches.com>
         <1522972535.11185.49.camel@perches.com>
         <20180406114333.gblf4znpasmkc2wl@pathway.suse.cz>
         <741c7f99-e39e-296c-1b91-3df7113ee71c@rasmusvillemoes.dk>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-06 at 15:17 +0200, Rasmus Villemoes wrote:
> On 2018-04-06 13:43, Petr Mladek wrote:
> > On Thu 2018-04-05 16:55:35, Joe Perches wrote:
> > > On Thu, 2018-04-05 at 16:45 -0700, Joe Perches wrote:
> > > > On Thu, 2018-04-05 at 16:25 +0200, Rasmus Villemoes wrote:
> > > > > Even just git grep -1 -E '%p"$' finds %pt and %po
> > > > > which should get fixed before somebody claims those
> > > > > extensions.
> > > > 
> > > > Neither %pt nor %po is used in a vsprintf
> > > > in the kernel.
> > > 
> > > Nope, you are right, both are defectively used in the
> > > kernel via string concatenation.
> > 
> > Ah, I see.
> 
> Yes, that was the point of that particular grep pattern with context.
> I
> sent patches three years ago and several pings, but despite an email
> telling me it would be picked up "for the next release" nothing has
> happened, so I've just been waiting for someone to implement a %po.

It used to be for SCSI subsystem until Martin gets involved.
My record is 6 years for the patch made the upstream.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
