Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeFEM7p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:59:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41657 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbeFEM7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:59:44 -0400
Date: Tue, 5 Jun 2018 14:59:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Perches <joe@perches.com>
Cc: Maninder Singh <maninder1.s@samsung.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 1/2] printk: remove unused flag LOG_NOCONS
Message-ID: <20180605125943.i3ly72liuqyopuqm@pathway.suse.cz>
References: <CGME20180531102133epcas5p2e8d47887c1708836c9b70964983093e2@epcas5p2.samsung.com>
 <20180531102133epcas5p2e8d47887c1708836c9b70964983093e2~zs4eTmEuv0380103801epcas5p2U@epcas5p2.samsung.com>
 <20180531121633.acuffu2b66q24c5c@pathway.suse.cz>
 <f42f8c4aeceb9025bc63716ec43e3a07a36dca8d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f42f8c4aeceb9025bc63716ec43e3a07a36dca8d.camel@perches.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-05-31 08:12:23, Joe Perches wrote:
> On Thu, 2018-05-31 at 14:16 +0200, Petr Mladek wrote:
> > On Thu 2018-05-31 15:47:51, Maninder Singh wrote:
> > > This patch removes unused flag LOG_NOCONS for printk.
> > > usage of this flag is removed long back with below commit.
> > 
> > Make sense.
> > 
> > > "5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb"
> > > printk: remove console flushing special cases for
> > >  partial buffered lines
> []
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> []
> > > @@ -349,10 +349,9 @@ enum con_msg_format_flags {
> > >   */
> > >  
> > >  enum log_flags {
> > > -	LOG_NOCONS	= 1,	/* already flushed, do not print to console */
> > > -	LOG_NEWLINE	= 2,	/* text ended with a newline */
> > > -	LOG_PREFIX	= 4,	/* text started with a prefix */
> > > -	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
> > > +	LOG_NEWLINE	= 1,	/* text ended with a newline */
> > > +	LOG_PREFIX	= 2,	/* text started with a prefix */
> > > +	LOG_CONT	= 4,	/* text is a fragment of a continuation line */
> > >  };
> > 
> > Please, do not renumber the bits if there is no real need for it.
> > The format of the log buffer is read also by external tool like
> > "crash". It seems that "crash" ignores these flags but...
> 
> Hmm, if it's not an internal interface, then these
> definitions should probably be removed from this file
> and exposed in a uapi file.

"crash" is not a typical userspace tool. We break it regularly.
We do not need to put the API into the stone because of "crash".
On the other hand, we also need not break it if it can be avoided
easily.

Best Regards,
Petr
