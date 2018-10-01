Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F0FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEC1208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEC1208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJBApH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeJBApH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:45:07 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930192089A;
        Mon,  1 Oct 2018 18:06:07 +0000 (UTC)
Date:   Mon, 1 Oct 2018 14:06:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20181001140606.6fa35061@gandalf.local.home>
In-Reply-To: <20180929111317.GB1392@tigerII.localdomain>
References: <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
        <20180913142802.GB517@tigerII.localdomain>
        <20180914065728.GA515@jagdpanzerIV>
        <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
        <20180914115028.GB20572@tigerII.localdomain>
        <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
        <20180914122217.GA518@tigerII.localdomain>
        <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
        <20180928085648.GC1160@jagdpanzerIV>
        <802130a3-b8c1-3973-933b-d6dc5ff2930d@i-love.sakura.ne.jp>
        <20180929111317.GB1392@tigerII.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2018 20:13:17 +0900
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> On (09/28/18 20:21), Tetsuo Handa wrote:
> > On 2018/09/28 17:56, Sergey Senozhatsky wrote:  
> > > The good thing about cont buffer is that we flush it on panic. E.g.
> > > core/arch early boot stage can do:
> > > 
> > > 	pr_cont("going to call early_init_foo()...");
> > > 	early_init_foo();
> > > 	pr_cont("OK\n");
> > >   
> > 
> > Is printing
> > 
> >   going to call early_init_foo()...OK
> > 
> > in one line so critically important?  
> 

Yes. My testing infrastructure tests for this on boot up for the ftrace
self tests.

-- Steve
