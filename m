Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D4AC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB5524C99
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB5524C99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934525AbeF0OeW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:34:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:44161 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932907AbeF0OeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:34:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EC341AE35;
        Wed, 27 Jun 2018 14:34:19 +0000 (UTC)
Date:   Wed, 27 Jun 2018 16:34:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] printk: Deadlock in NMI regression
Message-ID: <20180627143419.r75lat5cwzw3hns2@pathway.suse.cz>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627141612.GA477@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627141612.GA477@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-27 23:16:12, Sergey Senozhatsky wrote:
> On (06/27/18 16:08), Petr Mladek wrote:
> > The commit 719f6a7040f1bdaf96 ("printk: Use the main logbuf in NMI
> > when logbuf_lock is available") brought back the possible deadlocks
> > in printk() and NMI.
> > 
> > This is rework of the proposed fix, see
> > https://lkml.kernel.org/r/20180606111557.xzs6l3lkvg7lq3ts@pathway.suse.cz

Grr, the right link is
https://lkml.kernel.org/r/20180608104825.e7xoxteelaxnwx66@pathway.suse.cz


> > I realized that we could rather easily move the check to vprintk_func()
> > and still avoid any race. I believe that this is a win-win solution.
> > 
> > 
> > Changes against v1:
> > 
> >   + Move the check from vprintk_emit() to vprintk_func()
> >   + More straightforward commit message
> >   + Fix build with CONFIG_PRINTK_NMI disabled
> 
> Did I miss out V1?

It is the above fixed link. I am sorry for the confusion.


> > Petr Mladek (3):
> >   printk: Split the code for storing a message into the log buffer
> >   printk: Create helper function to queue deferred console handling
> >   printk/nmi: Prevent deadlock when accessing the main log buffer in NMI
> 
> Patch 3/3 is not in my mailbox, somehow [I checked the spam folder].
> I'm not Cc-ed or the message got lost somewhere before it reached my
> gmail?

Ah, the following line somehow confused git send-mail and the message
had broken list of recipients:

Cc: stable@vger.kernel.org # 4.13+

I have sent it once again as you have already noticed.

Best Regards,
Petr
