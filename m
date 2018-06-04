Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeFDVdq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751568AbeFDVdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:33:45 -0400
Date: Mon, 4 Jun 2018 17:33:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Maninder Singh <maninder1.s@samsung.com>, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 1/2] printk: remove unused flag LOG_NOCONS
Message-ID: <20180604173342.0b7a78e6@gandalf.local.home>
In-Reply-To: <20180531121633.acuffu2b66q24c5c@pathway.suse.cz>
References: <CGME20180531102133epcas5p2e8d47887c1708836c9b70964983093e2@epcas5p2.samsung.com>
        <20180531102133epcas5p2e8d47887c1708836c9b70964983093e2~zs4eTmEuv0380103801epcas5p2U@epcas5p2.samsung.com>
        <20180531121633.acuffu2b66q24c5c@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 14:16:33 +0200
Petr Mladek <pmladek@suse.com> wrote:

> >  enum log_flags {
> > -	LOG_NOCONS	= 1,	/* already flushed, do not print to console */
> > -	LOG_NEWLINE	= 2,	/* text ended with a newline */
> > -	LOG_PREFIX	= 4,	/* text started with a prefix */
> > -	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
> > +	LOG_NEWLINE	= 1,	/* text ended with a newline */
> > +	LOG_PREFIX	= 2,	/* text started with a prefix */
> > +	LOG_CONT	= 4,	/* text is a fragment of a continuation line */
> >  };  
> 
> Please, do not renumber the bits if there is no real need for it.
> The format of the log buffer is read also by external tool like
> "crash". It seems that "crash" ignores these flags but...

Then what's the problem for renumbering? I've renumbered internal flags
before. No one complained about it.

-- Steve
