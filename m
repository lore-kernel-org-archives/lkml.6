Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC07C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CA520882
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CA520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeGZC2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbeGZC2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:28:17 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C0FB20846;
        Thu, 26 Jul 2018 01:13:58 +0000 (UTC)
Date:   Wed, 25 Jul 2018 21:13:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: kprobes: Prohibit probing on notrace
 functions
Message-ID: <20180725211356.725079e1@vmware.local.home>
In-Reply-To: <20180726094106.1e8db6e2df788de20e696566@kernel.org>
References: <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <1531418053-21414-1-git-send-email-francis.deslauriers@efficios.com>
        <1531418053-21414-2-git-send-email-francis.deslauriers@efficios.com>
        <20180713115301.532ab1484e8b0befd90782d0@kernel.org>
        <20180713081803.1b78ebbc@gandalf.local.home>
        <20180726094106.1e8db6e2df788de20e696566@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 09:41:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 13 Jul 2018 08:18:03 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 13 Jul 2018 11:53:01 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > On Thu, 12 Jul 2018 13:54:12 -0400
> > > Francis Deslauriers <francis.deslauriers@efficios.com> wrote:
> > >   
> > > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > > 
> > > > Prohibit kprobe-events probing on notrace function.
> > > > Since probing on the notrace function can cause recursive
> > > > event call. In most case those are just skipped, but
> > > > in some case it falls into infinite recursive call.    
> > > 
> > > BTW, I'm considering to add an option to allow putting
> > > kprobes on notrace function - just for debugging 
> > > ftrace by kprobes. That is "developer only" option
> > > so generally it should be disabled, but for debugging
> > > the ftrace, we still need it. Or should I introduce
> > > another kprobes module for debugging it?  
> > 
> > No, I think the former is better (to add an option to allow putting
> > kprobes on notrace functions). By default we let people protect
> > themselves. But if then provide a switch that lets you do things that
> > might let you shoot yourself in the foot.  
> 
> I'm adding CONFIG_KPROBE_EVENTS_ON_NOTRACE kconfig which allows
> kprobes on notrace function. I think we don't need to make it
> online switchable, since it is only good for ftrace developers.
> 

Works for me.

Thanks!

-- Steve
