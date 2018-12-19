Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336382084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbeLSVBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbeLSVBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:01:41 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FC9020672;
        Wed, 19 Dec 2018 21:01:40 +0000 (UTC)
Date:   Wed, 19 Dec 2018 16:01:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Joe Perches <joe@perches.com>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org, vedang.patel@intel.com,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Message-ID: <20181219160138.447a4bb0@gandalf.local.home>
In-Reply-To: <1545251919.4161.4.camel@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219144047.49fabfa6@gandalf.local.home>
        <1545248809.2396.2.camel@kernel.org>
        <baf7e7af61873fc8bb3833d6bb0501d684a92bf2.camel@perches.com>
        <20181219153002.62ede7e9@gandalf.local.home>
        <1545251919.4161.4.camel@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 14:38:39 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> On Wed, 2018-12-19 at 15:30 -0500, Steven Rostedt wrote:
> > On Wed, 19 Dec 2018 12:20:19 -0800
> > Joe Perches <joe@perches.com> wrote:
> >   
> > > > Yeah, I had considered it but wasn't sure it was worth it.  Since
> > > > you're suggesting it is, I can send another patch on top of
> > > > these, or
> > > > feel free if you want to too.  ;-)    
> > > 
> > > I believe the 'strlen("foo") -> sizeof("foo") - 1'
> > > conversions do not change objects at all.
> > > 
> > > strlen("constant") is already optimized by gcc to a
> > > constant value when fed a constant string.  
> > 
> > If that's the case (and it probably is), then yeah, strlen is
> > probably
> > better. As it can handle the "not a constant" that you stated in
> > another email.
> >   
> 
> OK, so I guess that means we should just drop this patch ('[PATCH 2/7]
> tracing: Change strlen to sizeof for hist trigger static strings').
> 

No, that patch is fine, the macro was not. I've already applied your
patch set. Just need to run it through my tests.

-- Steve
