Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C8420657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbfANOpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:45:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:59734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726552AbfANOpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:45:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E035AE72;
        Mon, 14 Jan 2019 14:45:29 +0000 (UTC)
Date:   Mon, 14 Jan 2019 15:45:28 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sysrq: Remove duplicated sysrq message
Message-ID: <20190114144528.2afzfyl4ayridsd6@pathway.suse.cz>
References: <20190111162038.19771-1-pmladek@suse.com>
 <20190111162038.19771-3-pmladek@suse.com>
 <20190114055127.GB7417@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114055127.GB7417@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-01-14 14:51:27, Sergey Senozhatsky wrote:
> On (01/11/19 17:20), Petr Mladek wrote:
> > The commit 97f5f0cd8cd0a0544 ("Input: implement SysRq as a separate input
> > handler") added pr_fmt() definition. It caused a duplicated message
> > prefix in the sysrq header messages, for example:
> > 
> > [  177.053931] sysrq: SysRq : Show backtrace of all active CPUs
> > [  742.864776] sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c)
> > 
> > Fixes: 97f5f0cd8cd0a05 ("Input: implement SysRq as a separate input handler")
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Thanks.


> A side note:
> 
> > -			pr_cont("This sysrq operation is disabled.\n");
> > +			pr_info("This sysrq operation is disabled.\n");
> 
> I wouldn't mind this messages to become more informative.
> 
> +	pr_info("sysrq 0x%x operation is disabled.\n", key);
> ?

It might be better to use the op_p->action_msg or op_p->help_msg
strings instead of the key number.


> A bunch of "This sysrq operation is disabled" in serial0 log file
> (post mortem) is not very helpful.

The line is printed with the increased loglevel. It is primary
an immediate feedback on the console for the user pressing
the sysrq key.

Well, a more descriptive message would not hurt. Anyway, it
should be a separate patch.

Best Regards,
Petr
