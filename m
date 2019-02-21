Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A705FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D43C20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfBUJcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:32:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:51992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfBUJco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:32:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E10BAB7D;
        Thu, 21 Feb 2019 09:32:43 +0000 (UTC)
Date:   Thu, 21 Feb 2019 10:32:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Pass caller information to log_store().
Message-ID: <20190221093242.bhilzd6z54wukx4q@pathway.suse.cz>
References: <1550314773-8607-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190221022257.GA15012@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221022257.GA15012@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-02-21 11:22:57, Sergey Senozhatsky wrote:
> On (02/16/19 19:59), Tetsuo Handa wrote:
> >  /* insert record into the buffer, discard old ones, update heads */
> > -static int log_store(int facility, int level,
> > +static int log_store(u32 caller_id, int facility, int level,
> >  		     enum log_flags flags, u64 ts_nsec,
> >  		     const char *dict, u16 dict_len,
> >  		     const char *text, u16 text_len)
> 
> I counted nine.
> 
> Dunno, we might want to just create a dummy struct and pass it
> around, instead of doing
> 
> 	vprintk_emit			(6 params)
> 	 vprintk_store			(6 params)
> 	  log_output			(7 params)
> 	   log_store			(9 params)

Yeah, it would make sense. I still dream about a bigger printk
code clean up. But let's see what comes from the realtime-related
patchset first.

Anyway, thanks for review.

Best Regards,
Petr
