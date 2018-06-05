Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeFEM4M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:56:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41275 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbeFEM4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:56:11 -0400
Date: Tue, 5 Jun 2018 14:56:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Maninder Singh <maninder1.s@samsung.com>, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 1/2] printk: remove unused flag LOG_NOCONS
Message-ID: <20180605125609.wfvzjh7ph73pzgta@pathway.suse.cz>
References: <CGME20180531102133epcas5p2e8d47887c1708836c9b70964983093e2@epcas5p2.samsung.com>
 <20180531102133epcas5p2e8d47887c1708836c9b70964983093e2~zs4eTmEuv0380103801epcas5p2U@epcas5p2.samsung.com>
 <20180531121633.acuffu2b66q24c5c@pathway.suse.cz>
 <20180604173342.0b7a78e6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604173342.0b7a78e6@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-06-04 17:33:42, Steven Rostedt wrote:
> On Thu, 31 May 2018 14:16:33 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
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
> Then what's the problem for renumbering? I've renumbered internal flags
> before. No one complained about it.

Steven, did you renumber enum log_flags or flags in a different
subsystem?

Note that struct printk_log is a bit special because it is used by
the "crash" tool to implement the dmesg/log command. While "crash"
tool does not have special handling for most other internal
structures.

I have double checked "crash" sources and it ignores these flags
at the moment but it might change in the future => I suggest to
do not renumber them if there is not a real need.

Best Regards,
Petr
