Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D043DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7995B20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7995B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937832AbeFSNXI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755203AbeFSNXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:23:07 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1E620652;
        Tue, 19 Jun 2018 13:23:05 +0000 (UTC)
Date:   Tue, 19 Jun 2018 09:23:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180619092304.6b6ba390@gandalf.local.home>
In-Reply-To: <20180619082716.GD405@jagdpanzerIV>
References: <20180517143903.19339-1-pmladek@suse.com>
        <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
        <20180606051029.GA19211@tigerII.localdomain>
        <20180606103356.GB19211@tigerII.localdomain>
        <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
        <20180618063738.GC27996@jagdpanzerIV>
        <20180618093917.qeaatnlqh5if6t3r@pathway.suse.cz>
        <20180618100718.GA555@jagdpanzerIV>
        <20180619075219.iq7ztwu43bn4uua7@pathway.suse.cz>
        <20180619082716.GD405@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 17:27:16 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (06/19/18 09:52), Petr Mladek wrote:
> > On Mon 2018-06-18 19:07:18, Sergey Senozhatsky wrote:  
> > > On (06/18/18 11:39), Petr Mladek wrote:
> > > [..]
> > > 
> > > Hmm. Can't answer right now :)  
> > 
> > Please, let me know what name you would like ;-)  
> 
> :) Wow, it's hard. Maybe we can derive some bits from the ftrace_dump()
> function name? Dunno... Does printk_dump_nmi_enter() sound terrible?
> 
> Maybe Steven has some opinions on this?
> 

What exactly is the question?

Also, from a previous email in this thread, if you have to risk
interleaved output to solve a deadlock, then just do that.

-- Steve
