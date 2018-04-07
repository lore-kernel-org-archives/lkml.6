Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeDGOIX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 10:08:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:36393 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751512AbeDGOIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 10:08:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,419,1517904000";
   d="scan'208";a="218460563"
Message-ID: <1523110098.21176.409.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/9] vsprintf: Consistent %pK handling for
 kptr_restrict == 0
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Date: Sat, 07 Apr 2018 17:08:18 +0300
In-Reply-To: <20180405144602.qnpwoxinepgnjhds@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-3-pmladek@suse.com>
         <1522933485.21176.353.camel@linux.intel.com>
         <20180405144602.qnpwoxinepgnjhds@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-05 at 16:46 +0200, Petr Mladek wrote:
> On Thu 2018-04-05 16:04:45, Andy Shevchenko wrote:
> > On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> > > restricted_pointer() pretends that it prints the address when
> > > kptr_restrict
> > > is set to zero. But it is never called in this situation. Instead,
> > > pointer() falls back to ptr_to_id() and hashes the pointer.
> > > 
> > > This patch removes the potential confusion. klp_restrict is
> > > checked
> > > only
> > > in restricted_pointer().
> > > 
> > 
> > 
> > >  /* Maps a pointer to a 32 bit unique identifier. */
> > > -static char *ptr_to_id(char *buf, char *end, void *ptr, struct
> > > printf_spec spec)
> > > +static char *ptr_to_id(char *buf, char *end,
> > > +		       const void *ptr, struct printf_spec spec)
> > 
> > I don't think this change belongs to the patch.
> 
> The const should have been there from the beginning. I have found it
> because this patch added a call to ptr_to_id() which had the const
> and compiler warned about cast problems.

So, why not to do a separate patch with clear intention?

> IMHO, it is rather cosmetic change.

>From my experience I'm afraid of cosmetic changes in the patches which
might focus out attention on real fix.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
