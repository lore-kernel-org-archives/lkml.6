Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeB0KDz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:03:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:37354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751900AbeB0KDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:03:53 -0500
Date: Tue, 27 Feb 2018 11:03:51 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Dave Young <dyoung@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] printk: move dump stack related code to
 lib/dump_stack.c
Message-ID: <20180227100351.k7ijt7zvpf5hzk66@pathway.suse.cz>
References: <20180213072834.GA24784@dhcp-128-65.nay.redhat.com>
 <20180213083505.GA1953@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213083505.GA1953@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-02-13 17:35:05, Sergey Senozhatsky wrote:
> On (02/13/18 15:28), Dave Young wrote:
> > 
> > dump_stack related stuff should belong to lib/dump_stack.c thus move them
> > there. Also conditionally compile lib/dump_stack.c since dump_stack code
> > does not make sense if printk is disabled.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Looks OK to me as well.

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have pushed it into printk.git, branch for-4.17.


> The patch also saves us some additional memory on !PRINTK configs.
> For example things like this
> 
> 	if (kobj->state_initialized) {
> 		/* do not error out as sometimes we can recover */
> 		printk(KERN_ERR "kobject (%p): tried to init an initialized "
> 		       "object, something is seriously wrong.\n", kobj);
> 		dump_stack();
> 	}
> 
> now we won't have that dump_stack() call, which does not seems to be doing
> anything useful anyway when printk() is not available.

Yup.

Best Regards,
Petr
