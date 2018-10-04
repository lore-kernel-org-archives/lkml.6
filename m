Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C349DC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D9E2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D9E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeJDICV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 04:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeJDICV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 04:02:21 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B29A2098A;
        Thu,  4 Oct 2018 01:11:30 +0000 (UTC)
Date:   Wed, 3 Oct 2018 21:11:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [ftrace/kprobes PATCH 3/3] tracing/kprobes: Allow kprobe-events
 to record module symbol
Message-ID: <20181003211128.58c7a15e@vmware.local.home>
In-Reply-To: <20181003151227.4a730dcb@gandalf.local.home>
References: <153547303754.26502.5265242979168613920.stgit@devbox>
        <153547312336.26502.11432902826345374463.stgit@devbox>
        <20181003151227.4a730dcb@gandalf.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 15:12:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 29 Aug 2018 01:18:43 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Allow kprobe-events to record module symbols.
> > 
> > Since data symbols in a non-loaded module doesn't exist, it fails to
> > define such symbol as an argument of kprobe-event. But if the kprobe
> > event is defined on that module, we can defer to resolve the symbol
> > address.
> > 
> > Note that if given symbol is not found, the event is kept unavailable.
> > User can enable it but the event is not recorded.
> > 
> >  
> 
> Hi Masami,
> 
> The first two patches look like they should be applied now and marked
> for stable, as they are fixes. This patch looks like an added feature,
> and will go into the next merge window.
> 
> Is that what you think too?
>

Heh, I just realized that this is on my kprobes branch. I was looking
at it as if they were in mainline. Nevermind about the "stable"
comment ;-) 

-- Steve
