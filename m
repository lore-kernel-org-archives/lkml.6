Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeDIMMG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:12:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:16108 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbeDIMMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:12:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,427,1517904000";
   d="scan'208";a="32811762"
Message-ID: <1523275919.21176.429.camel@linux.intel.com>
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
Date: Mon, 09 Apr 2018 15:11:59 +0300
In-Reply-To: <20180409120526.66ubl3by4cvaaprq@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-3-pmladek@suse.com>
         <1522933485.21176.353.camel@linux.intel.com>
         <20180405144602.qnpwoxinepgnjhds@pathway.suse.cz>
         <1523110098.21176.409.camel@linux.intel.com>
         <20180409120526.66ubl3by4cvaaprq@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-09 at 14:05 +0200, Petr Mladek wrote:
> On Sat 2018-04-07 17:08:18, Andy Shevchenko wrote:
> > On Thu, 2018-04-05 at 16:46 +0200, Petr Mladek wrote:
> > > On Thu 2018-04-05 16:04:45, Andy Shevchenko wrote:
> > > > On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:

> > > > >  /* Maps a pointer to a 32 bit unique identifier. */
> > > > > -static char *ptr_to_id(char *buf, char *end, void *ptr,
> > > > > struct
> > > > > printf_spec spec)
> > > > > +static char *ptr_to_id(char *buf, char *end,
> > > > > +		       const void *ptr, struct printf_spec
> > > > > spec)
> > > > 
> > > > I don't think this change belongs to the patch.
> > > 
> > > The const should have been there from the beginning. I have found
> > > it
> > > because this patch added a call to ptr_to_id() which had the const
> > > and compiler warned about cast problems.
> > 
> > So, why not to do a separate patch with clear intention?
> 
> If you insist I could do it as separate patch.

I believe, that logical changes are easier to review and understand when
it's not mixed with other changes.

> > > IMHO, it is rather cosmetic change.
> > > From my experience I'm afraid of cosmetic changes in the patches
> > > which
> > 
> > might focus out attention on real fix.
> 
> I would understand this if it was part of a large patch that changed
> complex chain of functions. But this patch touched 5 lines. The const
> is added into static function that is almost leaf and was called
> only from a single location.

But it's up to you.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
