Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeDJKF3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:05:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:24752 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752472AbeDJKF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:05:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="190266198"
Message-ID: <1523354722.21176.431.camel@linux.intel.com>
Subject: Re: [PATCH v4 3/9] vsprintf: Do not check address of well-known
 strings
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 13:05:22 +0300
In-Reply-To: <20180409121933.ftvmhhr37fmngfu3@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-4-pmladek@suse.com>
         <0ff89c4e-e20d-467e-de36-61e3a5557c7d@rasmusvillemoes.dk>
         <20180406091543.sh6efp24kflluxco@pathway.suse.cz>
         <1523110355.21176.412.camel@linux.intel.com>
         <20180409121933.ftvmhhr37fmngfu3@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-09 at 14:19 +0200, Petr Mladek wrote:
> On Sat 2018-04-07 17:12:35, Andy Shevchenko wrote:
> > On Fri, 2018-04-06 at 11:15 +0200, Petr Mladek wrote:
> > > On Thu 2018-04-05 15:30:51, Rasmus Villemoes wrote:
> > > > On 2018-04-04 10:58, Petr Mladek wrote:

> > > > > 
> > > > Please leave string() alone, except for moving the < PAGE_SIZE
> > > > check
> > > > to
> > > > a new helper checked_string (feel free to find a better name),
> > > > and
> > > > use
> > > > checked_string for handling %s and possibly the few other cases
> > > > where
> > > > we're passing a user-supplied pointer. That avoids cluttering
> > > > the
> > > > entire
> > > > file with double-underscore calls, and e.g. in the %pO case,
> > > > it's
> > > > easier
> > > > to understand why one uses two different *string() helpers if
> > > > the
> > > > name
> > > > of one somehow conveys how it is different from the other.
> > > 
> > > I understand your reasoning. I thought about exactly this as well.
> > > My problem is that string() will then be unsafe. It might be
> > > dangerous
> > > when porting patches.
> > 
> > I agree with Rasmus, and your argument here from my point of view
> > kinda
> > weak. Are we really going to backport this patches? Why? We lived
> > w/o
> > them for a long time. What's changed now?
> 
> Someone might have out-of-tree patch that adds yet another format
> specifier. It might call string() that checks for (null) now but
> it it won't if we rename it as you suggest. People used to safe
> string() might miss this when the patch is send upstream for
> inclusion, ...

This is even weaker argument. Sorry, but I don't care about out-of-tree
core patches. If they have them, they are doing completely wrong, or the
patches are crappy.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
