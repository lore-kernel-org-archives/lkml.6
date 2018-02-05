Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeBEUTN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:19:13 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42445 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750855AbeBEUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:19:05 -0500
X-ME-Sender: <xms:OLx4Wmy9F_BdLSKfJPiX3fit2yhjAGy-Y_dTwVcQX1gFekB3sRNInA>
Date: Tue, 6 Feb 2018 07:19:01 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Adam Borowski <kilobyte@angband.pl>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
Message-ID: <20180205201901.GR29988@eros>
References: <20180204174521.21383-1-kilobyte@angband.pl>
 <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
 <20180205100305.GO29988@eros>
 <20180205152218.hxgozi67zka4hgkf@angband.pl>
 <20180205114952.6af99dff@gandalf.local.home>
 <49fbcc8b-9522-f19c-d51c-d0059445abdc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49fbcc8b-9522-f19c-d51c-d0059445abdc@infradead.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 09:36:03AM -0800, Randy Dunlap wrote:
> On 02/05/2018 08:49 AM, Steven Rostedt wrote:
> > On Mon, 5 Feb 2018 16:22:19 +0100
> > Adam Borowski <kilobyte@angband.pl> wrote:
> > 
> >> My change touches %px only, where your concern doesn't apply.
> >>
> >> You're right, though, when it comes to %pK:
> >>     printk("%%pK: %pK, %%px: %px\n", 0, 0);
> >> says
> >>     %pK: 00000000ba8bdc0a, %px: 0000000000000000
> >>
> >> So what should we do?  Avoid hashing 0?  Print a special value?
> > 
> > My personal opinion is that NULL should stay NULL and not be hashed.
> > What security issue could be leaked by a NULL? I'm not a security
> > person, that's a real question.
> 
> Agree.

While these views seem valid I don't think we are going to get much
love trying to change %pK to give a smidgen more information when %pK is
arguably out of favour :)

	Tobin
